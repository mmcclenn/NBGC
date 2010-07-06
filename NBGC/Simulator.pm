#
# NBGC Project
# 
# Class Simulator - dynamic system simulator
# 
# Author: Michael McClennen
# Copyright (c) 2010 University of Wisconsin-Madison
# 
# Each instance of this class represents a dynamic system simulator.  It can
# be loaded with a model, i.e. a set of variables, flows and initial states
# that express a system of differential equations.  An approximate solution to
# this system of equations can then be generated by iteration over a series of
# time steps, using various methods of approximation.  This is referred to as
# "running" the model.
# 
# A model run consists of 4 phases:
# 
# 1. init	Initialize the model's variables
# 2. spinup	Run the model long enough to establish a steady state, or 
#                 until some specified condition is reached (optional)
# 3. run	Run the model for a specified number of time steps, or until a 
#                 specified condition is reached
# 4. output	Display, write or otherwise make available the values of one
#                 or more of the model variables.
# 
# Flags, initial variable values, etc. can be set at any time, in order to
# parametrize the model.
# 
# 
# Here is an example of usage:
# 
#   $model = new NBGC::Model;
#   $model->load(file => "model.txt");
#   
#   $sim = new NBGC::Simulator;
#   
#   $sim->load($model);
#   $sim->initial_value('some_constant', 3);
#   $sim->init();
#   
#   $sim->spinup();
#   $sim->set_value('other_constant', 5.012);
#   
#   $sim->trace('all');
#   $sim->run(start => 0, limit => 300);
#   
#   $sim->write_data(file => "output.txt");
#   $sim->plot_var(file => 'var1_plot.png', variable => 'var1');


package NBGC::Simulator;

use strict;
use warnings;
use Carp;
use Graphics::PLplot;

our ($SIM_ID, $INTEGRATION_METHOD); 

$SIM_ID = 0;			# Gives each Simulator a unique ID number
$INTEGRATION_METHOD = 'SIMPLE';	# Which method of numerical
                                # Integration to use.

# Constructor, destructor and related methods
# ===========================================

# new ( )
# 
# Creates a new Simulator instance.

sub new {

    my ($class, $model, $time_unit, $debug_level) = @_;
    
    # Create a new instance and bless into the proper class.
    
    my $self = {};    
    bless $self, $class;
    
    # Initialize the instance
    
    my $id = $NBGC::SIM_ID++;
    $self->{id} = $id;
    $self->{runspace} = "NBGC::Run_$id";
    $self->{state} = 'CLEAR';	# States are:
    				#   CLEAR - empty, waiting for a model
				#   READY - the model is ready to run
				#   INIT - the vars are being initialized
				#   SPINUP - running in spinup mode
    				#   RUN - running in regular mode
    $self->{debug_level} = $debug_level;   # how much debugging output to print
    
    $self->{model} = undef;     # The model.  Next few are model components
    $self->{stable} = undef;	#   symbol table
    $self->{sseq} = undef;	#   symbol sequence list
    $self->{initlist} = undef;	#   list of symbol initializations
    $self->{flowlist} = undef;  #   list of flows
    $self->{itable} = {};	# table of initial symbol value overrides
    $self->{initprog} = undef;	# code ref for initialization
    $self->{runprog} = undef;	# code ref for one run step
    $self->{traceprog} = undef;	# code ref for one data trace step
    $self->{trace} = {};	# object to record variable values for tracing
    $self->{run_start} = undef; # at what value of t did the last run start?
    $self->{run_end} = undef;	# at what value of t did the last run end?
    
    if ( defined $model ) {
	$self->load($model, $time_unit);
    }
    
    return $self;
}

# DESTROY ()
# 
# Empty destructor method

sub DESTROY {
}


# Methods for loading a model
# ===========================

# load ( model ) - load in a model

sub load {    

    my ($self, $model, $time_unit) = @_;
    
    $time_unit = 1 unless defined $time_unit;
    
    croak "Valid model required" unless ref $model eq 'NBGC::Model';
    croak "Time increment must be positive" if defined $time_unit and !($time_unit > 0);
    
    $self->{model} = $model;
    $self->{t_unit} = $time_unit || 1;
    $self->{stable} = $model->{stable};
    $self->{sseq} = $model->{sseq};
    $self->{initlist} = $model->{initlist};
    $self->{flowlist} = $model->{flowlist};
    
    $self->compile_runprog();
    $self->compile_traceprog();
    $self->init_runspace();
    $self->{state} = 'READY';
}


# reset ( ) - reset the simulator for another model run

sub reset {
    
    my $self = shift;
    
    $self->init_runspace();
    $self->{state} = 'READY';
}


# Compile the model into pure Perl statements. Variable values are all kept
# in the package NBGC_Run_$id where $id is a unique identifier assigned to
# this Simulator object.

sub compile_runprog {

    my $self = shift;
    
    # First, compile the initialization step.
    
    my $CODE = "package $self->{runspace};\nno strict 'vars';\n\n";
    
    foreach my $init (@{$self->{initlist}}) {
	my ($sym, $expr) = ($init->{sym}, $init->{expr});
	my $name = $sym->{name};
	
	$CODE .= "\$$name = (defined \$self->{itable}{'$name'} ? \$self->{itable}{'$name'} : $expr);\n";
    }
    
    if ( $self->{debug_level} > 0 ) {
	print "=========== initprog ===========\n";
	print $CODE;
	print "=========== initprog ===========\n";
    }
    
    eval("\$self->{initprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in initialization program: $@";
    }
    
    # Next, compile the run step.
    
    $CODE = "package $self->{runspace};\nno strict 'vars';\n\n";
    
    foreach my $var ($self->variables()) {
	$CODE .= "\$tmp_$var = \$$var;\n";
    }
    
    foreach my $flow (@{$self->{flowlist}}) {
	my $source = $flow->{source};
	my $sink = $flow->{sink};
	$CODE .= "{\n  my \$tmp = " . $self->compile_node($flow->{rate});
	$CODE .= " * $self->{t_unit}" if $self->{t_unit} != 1;
	$CODE .= ";\n";
	if ( $source->{type} ne 'flowlit' ) {
	    $CODE .= "  \$$source->{name} -= \$tmp;\n";
	}
	if ( $sink->{type} ne 'flowlit' ) {
	    $CODE .= "  \$$sink->{name} += \$tmp;\n";
	}
	$CODE .= "}\n";
    }
    
    if ( $self->{debug_level} > 0 ) {
	print "=========== runprog ===========\n";
	print $CODE;
	print "=========== runprog ===========\n";
    }
    
    eval("\$self->{runprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in run program: $@";
    }
    
    return 1;
}


sub compile_node {
    
    my ($self, $node) = @_;
    my $result;
    
    if ( $node->{type} eq 'expr' ) {
	$result = join ', ', @{$node->{child}};
    }
    
    elsif ( $node->{type} eq 'prod' ) {
	$result = join ' * ', map { $self->compile_node($node->{child}[$_] ) }
	    (0..$#{$node->{child}});
    }
    
    elsif ( $node->{type} eq 'sum' ) {
	$result =  join ' + ', map { $self->compile_node($node->{child}[$_] ) }
	    (0..$#{$node->{child}});
    }
    
    elsif ( $node->{type} eq 'literal' ) {
	$result = $node->{value};
    }
    
    elsif ( $node->{type} eq 'const' ) {
	$result = "\$$node->{name}";
    }
    
    elsif ( $node->{type} eq 'var' ) {
	$result = "\$tmp_$node->{name}";
    }
    
    return "($result)";
}


# List all of the model's variables

sub variables {

    my $self = shift;

    my @vars = map { $_->{name} } grep { $_->{type} eq 'var' } @{$self->{sseq}};
    return @vars;
}


# Create a trace program for the current model.  This will be run once at the
# beginning and once after each run step to record variable values.

sub compile_traceprog {

    my $self = shift;
    
    # First get a list of all of the variables
    
    my @vars = $self->variables();
    
    # Then generate code to trace them.  At the same time, create entries in
    # %{$self->{trace}} to hold an array of values for each variable.
    
    $self->{trace}{T} = [];
    
    my $CODE = "package $self->{runspace};\nno strict 'vars';\n\n";
    $CODE .= "push \@{\$self->{trace}{'T'}}, \$_[0]->{T};\n";
    
    foreach my $var (@vars) {
	$self->{trace}{"$var"} = [];
	$CODE .= "push \@{\$self->{trace}{$var}}, \$$var;\n";
    }
    
    if ( $self->{debug_level} > 0 ) {
	print "=========== traceprog ===========\n";
	print $CODE;
	print "=========== traceprog ===========\n";
    }

    eval("\$self->{traceprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in trace program: $@";
    }
    
    return 1;
}


# init_runspace ( ) - Make sure that the package used as the namespace for
# running the model is clear of everything except the necessary variables.
# This should be called once before every run, so that each run is done de novo.

sub init_runspace {

    my $self = shift;
    my $pkgname = $self->{runspace} . '::';
    
    no strict 'refs';
    my @vars = keys %$pkgname;
    
    foreach my $var (@vars) {
	undef $$pkgname{$var};
    }
    
    my $CODE = <<ENDCODE;
package $self->{runspace};
no strict 'vars';
our (\$T, \$t);

\$T = 0;
*t = \\\$T;
ENDCODE
    
    eval $CODE;
    
    if ( $@ ) {
	croak "Error in runspace init: $@";
    }
    
    return 1;
}


# initial_value ( name, value )
#
# Specifies an initial value for the given identifier (variable or constant),
# overriding any value specified in the model. This routine is only
# immediately effective if called before init(), or just after a reset(). An
# undefined value means to revert to the value specified in the model. The
# results of this call are persistent across model runs.

sub initial_value {

    my ($self, $name, $value) = @_;
    
    # First look up the identifier, and make sure that it is defined.
    
    my $sym = $self->{stable}{$name};
    
    unless ($sym) {
	carp "Unknown variable '$name'";
	return undef;
    }
    
    # Set the value and return true.
    
    $self->{itable}{$name} = $value;
    return 1;
}


# set_value ( name, value )
# 
# Specifies a new value for the given identifier (variable or constant),
# overriding any value specified in the model.  This routine can be called at
# any point in the simulation, but its effects only last until the variable is
# changed by the model code or until the next reset() upon which time the
# variable or constant is reset to its initial value as specified in the model
# or overridden by set_init_value().

sub set_value {

    my ($self, $name, $value) = @_;
    
    # First look up the identifier, and make sure that it is defined.
    
    my $sym = $self->{stable}{$name};
    
    unless ($sym) {
	carp "Unknown variable '$name'";
	return undef;
    }
    
    # Set the value.
    
    eval "package $self->{runspace}; no strict 'vars'; \$$name = $value;";
    
    return 1;
}


# init ( )
# 
# Reset the simulator (if necessary) and then initialize the model variables
# for a new run. Use the initial values specified in the model, unless these
# were overridden by calls to the initial_value() method.

sub init {

    my ($self) = @_;
    
    # First check if we have a model loaded yet.
    
    if ( $self->{state} eq 'CLEAR' ) {
	croak "No model loaded.";
	return undef;
    }
    
    # If the state is anything but READY, reset the simulator
    # first.
    
    elsif ( $self->{state} ne 'READY' ) {
	$self->reset();
    }
    
    # Now, we are ready to initialize the variables.
    
    $self->{state} = 'INIT';
    &{$self->{initprog}}($self);
    
    return 1;
}


# trace ( interval, exprlist ) - OBSOLETE
# 
# Add the given expressions to the trace list.

sub trace {
    
    my ($self, %args) = @_;
    
    my $interval = $args{interval} || 1;
    my $varcount = 0;
    
    my (@vars) = split /\s*,\s*/, $args{vars};
    if ( uc $vars[0] eq 'ALL' ) {
	@vars = grep { $self->{vtable}{$_}{type} eq 'variable' } keys %{$self->{vtable}};
    }
    
    foreach my $expr (@vars) {
	$varcount++;
	my $var = $self->{vtable}{$expr} or
	    carp "Warning: '$expr' is not a known variable";
	push @{$self->{tracelist}}, $expr;
    }
    
    $self->{trace_compiled} = undef;
}


# clear_trace ( ) - OBSOLETE
# 
# Clear the trace list

sub clear_trace {
    
    my $self = shift;
    
    $self->{tracelist} = [];
    $self->{traceprog} = undef;
    $self->{trace_compiled} = 1;
}


# run ( start, limit, increment, continue )
# 
# Run the model.  The start parameter, if given, specifies the initial time.
# It defaults to 0, unless we are continuing a previous run in which case it
# defaults to the time at the end of the previous run. The limit, if given,
# specifies the ending time.  If `continue' is given a true value, we will
# continue the run from where we previously left off.

sub run {

    my ($self, %args) = @_;
    
    my ($start, $limit);
    
    if ( defined $args{start} and defined $args{continue} ) {
	croak "Cannot specify both 'start' and 'continue' parameters";
    }
    
    if ( defined $args{start} ) {
	if ( $self->{state} ne 'INIT' ) {
	    $self->init();
	}
	$start = $args{start} + 0;
    }
    
    elsif ( defined $args{continue} ) {
	if ( defined $self->{run_end} ) {
	    $start = $self->{run_end};
	}
	
	else {
	    croak "No run to continue from.";
	}
    }
    
    if ( defined $args{limit} ) {
	$self->{oldlimit} = $self->{run_limit};
	$limit = $self->{run_limit} = $args{limit} + 0;
    }
    
    else {
	croak "A run limit must always be given.";
    }
    
    # Now set the state of the simulator to 'RUN'.
    
    $self->{state} = 'RUN';
    
    # Make sure the trace program is compiled.
    
    $self->compile_traceprog() unless $self->{trace_compiled};
    
    # Initialize the time variable.
    
    my $t = $self->init_run_time($start);
    
    # If we are just starting up, set up the trace & take the first snapshot
    
    unless ( defined $args{continue} ) {
	$self->init_trace(($self->{run_limit} - $self->{run_start} + 1) * 
			   $self->{t_unit});
	&{$self->{traceprog}}($self);
    }
    
    # Otherwise, increase the size of the trace buffer if necessary.
    
    else {
	my $adjustment = $self->{run_limit} - $self->{old_limit};
	if ( $adjustment > 0 ) {
	    $self->adjust_trace($adjustment * $self->{t_unit});
	}
    }
    
    # Loop through run steps until the limit is reached.
    
    until ( $self->{T} >= $limit ) {
	
	&{$self->{runprog}}($self);
	$self->increment_run_time();
	&{$self->{traceprog}}($self);
    }
    
    # Finish up
    
    $self->{run_end} = $self->{T};
    return 1;
}


# Set the initial time, and return it as the value of this function.

sub init_run_time {
    
    my ($self, $start_time) = @_;
    $start_time += 0;
    
    $self->{T} = $self->{run_start} = $start_time;
    eval("\\\$$self->{runspace}::T = $start_time;");
    
    return $start_time;
}


# Increment the time by one step, and return the new time as the value of this
# function.

sub increment_run_time {
    
    my ($self) = @_;
    
    $self->{T} += $self->{t_unit};
    eval("\\\$$self->{runspace}::T = $self->{T};");
}


# set up for the trace program.  This routine is not required to do anything
# for the Perl simulator.

sub init_trace {
    
    my ($self, $tracesize) = @_;
    
    return 1;
}


# trace_vars ( ) - return a list of variables being traced.  For now, that
# means all of them.

sub trace_vars { 

    my $self = shift;
    
    return $self->variables();
}


# dump_trace ( ) - dump the trace data to the given file handle

sub dump_trace {

    my ($self, %args) = @_;
    
    my $fh = $args{file};
    my @vars = $self->variables();
    
    my $datacount = scalar @{$self->{trace}{T}};
    
    foreach my $i (0..$datacount-1) {
	print $fh $self->{trace}{T}[$i], "\t";
	foreach my $var (@vars) {
	    print $fh $self->{trace}{$var}[$i], "\t";
	}
	print $fh "\n";
    }
}


# get_values ( variable ) - returns a list of the trace values of the
# given variable.  T returns time.

sub get_values {
    
    my ($self, $expr) = @_;
    
    my $datacount = scalar @{$self->{trace}{T}};
    
    if ( $expr eq 'T' ) {
	return @{$self->{trace}{T}};
    }
    
    else {
	my @vals;
	foreach my $i (0..$datacount-1) {
	    push @vals, $self->{trace}{$expr}[$i];
	}
	return @vals;
   }
}


# minmax_values ( @values ) - return the minimum and maximum of the list of values.

sub minmax_values {

    my $self = shift;
    my $min = shift;
    my $max = shift;
    
    foreach (@_) {
	$min = $_ if $_ < $min;
	$max = $_ if $_ > $max;
    }
    
    return ($min, $max);
}

# We have to end the module with a true value.


# plot ( @vars ) - plot the specified variables

sub plot {
    
    my ($self, @vars) = @_;

    my (@t) = $self->get_values('T');
    my ($tmin, $tmax) = $self->minmax_values(@t);
    my (@values);
    my (@colors) = (1, 3, 9, 13, 8);
    my $textcoord = 9;

    plsdev ("aqt");
    plinit ();
    plscolbg (255, 255, 255);
    plenv ($tmin, $tmax, 0, 100, 0, 2);
    
    foreach my $var (@vars) {
	print "PLOTTING VARIABLE: $var\n" if $self->{debug_level} > 0;
	@values = $self->get_values($var);
	plcol0 (shift @colors);
	plline(\@t, \@values);
	my ($varname) = $var;
	plptex(5, ($textcoord-- * 10) + 5, 1, 0, 0, $varname);
    }

    plend ();
}

1;
