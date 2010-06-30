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
# A model run consists of 5 phases, all of which are optional except the first.
# 
# 1. load	Read in a model and set up the framework necessary to run it
# 2. init	Initialize the model's variables
# 3. spinup	Run the model long enough to establish a steady state, or 
#                 until some specified condition is reached
# 4. run	Run the model for a specified number of time steps, or until a 
#                 specified condition is reached
# 5. output	Display, write or otherwise make available the values of one
#                 or more of the model variables.
# 
# Flags, initial variable values, etc. can be set by the calling package, and
# thus the model can be parametrized.
# 
# 
# Here is an example of usage:
# 
#   $sim = new NBGC::Simulator;
#   
#   $sim->load(file => "model.txt");
#   
#   $sim->set_init_value(name => 'some_constant', value => 3);
#   $sim->init();
#   
#   $sim->spinup();
#   $sim->set_value(name => 'other_constant', value => 5.012);
#   
#   $sim->trace(interval => 1, variables => qw(var1 var2 var3));
#   $sim->run(start => 0, limit => 300);
#   
#   $sim->write_data(file => "output.txt");
#   $sim->plot_var(file => 'var1_plot.png', variable => 'var1');


package NBGC::Simulator;

use strict;
use warnings;
use Carp;

use Variable;
use Object::PurePerl;

our ($SIM_ID, $INPUT_NAME, $INPUT_LINE, $LOAD_LINE, 
     $OBJECT_METHOD, $INTEGRATION_METHOD); 

$SIM_ID = 0;			# Gives each Simulator a unique ID number
$INPUT_NAME = '<none>';	        # Name of the input file being currently read
$INPUT_LINE = 0;		# Current input line number
$LOAD_LINE = 0;			# Current input line number when loading
                                # individual statements

$INTEGRATION_METHOD = 'SIMPLE';	# Which method of numerical
                                # integration to use.

# Constructor, destructor and related methods
# ===========================================

# new ( )
# 
# Creates a new Simulator instance.

sub new {

    my $class = shift;
    my $self = {};
    bless $self, $class;
    
    my $id = $NBGC::SIM_ID++;
    $self->{id} = $id;
    $self->{runspace} = "NBGC_Run_$id";
    $self->{state} = 'CLEAR';	# States are:
    				#   CLEAR - empty, waiting for a model
				#   LOAD - a model is being loaded
				#   READY - the model is ready to run
				#   INIT - the vars are being initialized
				#   SPINUP - running in spinup mode
    				#   RUN - running in regular mode
    
    $self->{compiled} = undef;	# Which method was used to compile the code
    $self->{trace_compiled} = undef; # Have we compiled the trace list?
    $self->{vtable} = {};	# Table of variables
    $self->{vvector} = [];	# Vector of variables
    $self->{initlist} = [];	# List of initialization records (hashes)
    $self->{flowlist} = [];     # List of flow records (hashes)
    $self->{tracelist} = [];	# List of expressions to trace during a run
    $self->{initprog} = undef;	# code ref for initialization
    $self->{runprog} = undef;	# code ref for one run step
    $self->{tiprog} = undef; 	# code ref for trace initialization
    $self->{traceprog} = undef;	# code ref for one data trace step
    $self->{run_start} = undef; # at what value of t did the last run start?
    $self->{run_end} = undef;	# at what value of t did the last run end?
    
    return $self;
} 

# DESTROY ()
# 
# Empty destructor method

sub DESTROY {
}


# Methods for phase 1 -- load
# ===========================

# load ( stmt => @stmts )
# load ( file => filename or filehandle )
# 
# Load one or more statements in the Model Definition Language recognized by
# this project.  These are added to any that have already been loaded.  If it
# is desired to reload or redefine the model, clear() must be used.

sub load {
    
    my $self = shift;
    my $selector = shift;
    
    if ( $self->{state} ne 'CLEAR' && $self->{state} ne 'LOAD' ) {
	carp "Simulator must be cleared with the clear() method before loading another model";
	return 0;
    }
    
    $self->{state} = 'LOAD';
    
    if ( $selector eq 'file' ) {
	local($INPUT_NAME) = shift;
	local($INPUT_LINE) = 0;
	open(my $infile, $INPUT_NAME) || croak "Could not open file '$INPUT_NAME': $!";
	
	while (<$infile>) {
	    $INPUT_LINE++;
	    $self->process_line($_);
	}
    }
    
    elsif ( $selector eq 'stmt' ) {
	local($INPUT_NAME) = '<input>';
	local($INPUT_LINE) = $self->{load_line};
	
	foreach (@_) {
	    $INPUT_LINE++;
	    $self->{load_line}++;
	    $self->process_line($_);
	}
    }
    
    return 1;
}

# Handle one input line.  Any statement starting with "init" pertains to the
# initialization phase (2), while all other statements pertain to the spinup
# and run phases (3 and 4).

sub process_line {

    my ($self, $line) = @_;
    
    return unless $line =~ /\S/;   # ignore blank lines
    s/^\s*//;			   # take out initial whitespace
    s/\s*$//;			   # take out final whitespace
    
    if ( $line =~ / ^ init \s+ (.*) /xoi )
    {
	$self->parse_init_stmt($1);
    }
    
    else
    {
	$self->parse_run_stmt($line);
    }
}


# Parse an "init" statement from the model.  If it specifies a constant,
# register that constant.  If it specifies an initialization expression, add
# that to the simulation's list of initialization statements.

sub parse_init_stmt {

    my ($self, $stmt) = @_;
    my ($const, $name, $expr);
    
    if ( ($const, $name, $expr) = 
	 $stmt =~ / ^ (const\s+)? \$ (\w+) (?: \s* = \s* (.*))/xoi )
    {
	# Check for the 'const' keyword, and register the
	# identifier $name as either a constant or a variable accordingly.
	
	if ( $const ) {
	    $self->register_variable($2, type => 'const');
	}
	else {
	    $self->register_variable($2);
	}
	
	# If an initialization expression was given, add it to the
	# initialization list for this simulation.
	
	if ( $expr ne '' ) {
	    $self->add_init({var => $2, expr => $3});
	}
    }
    
    else
    {
 	die "Invalid init statement '$stmt' at $INPUT_NAME, line $INPUT_LINE\n";
    }
}


# Parse a "run" statement from the model.  Currently, the only valid run
# statements are flow specifiers.

sub parse_run_stmt {
    
    my ($self, $stmt) = @_;
    
    if ( $stmt =~ / ^ \$ (\w+) \s* => \s* \$ (\w+) \s* : 
		    \s* \$ (\w+) \s* \* \s* \$ (\w+) $ /xo )
    {
	$self->add_flow({source => $1, sink => $2, rate1 => $3, rate2 => $4});
    }
	
    elsif ( $stmt =~ / ^ \$ (\w+) \s* => \s* \$ (\w+) \s* : \s* \$ (\w+) $ /xo )
    {
	$self->add_flow({source => $1, sink => $2, rate1 => $3, rate2 => 1});
    }
    
    elsif ( $stmt =~ / ^ \$ (\w+) \s* => \s* \$ (\w+) \s* : \s* (.+) /xo )
    {
	$self->add_flow({source => $1, sink => $2, rate_expr => $3});
    }
    
    elsif ( $stmt =~ / ^ \$ (\w+) \s* \* \s* \$ (\w+) \s* => \s* \$ (\w+) $ /xo )
    { 
	$self->add_flow({source => $1, sink => $3, rate1 => $1, rate2 => $2});
    }
    
    elsif ( $stmt =~ / ^ \$? (\w+) \s* => \s* \$ (\w+) \s* \* \s* \$ (\w+) $ /xo )
    {
	$self->add_flow({source => $1, sink => $2, rate1 => $2, rate2 => $3});
    }
	
    else
    {
	die "Invalid statement '$stmt' at $INPUT_NAME, line $INPUT_LINE\n";
    }
}


# Add an initialization record to the simulation.

sub add_init {

    my ($self, $init) = @_;
    
    push @{$self->{initlist}}, $init;
}


# Add a flow record to the simulation.

sub add_flow {
    
    my ($self, $flow) = @_;
    
    # First look at the source; "endless" and "growth" mean a limitless source
    
    if ( $flow->{source} =~ /endless|growth/i ) {
	$flow->{source} = "_";
    }
    else {
	$self->register_variable($flow->{source}, type => 'variable');
    }
    
    # Similarly, "endless" and "decay" mean a limitless sink
    
    if ( $flow->{sink} =~ /endless|decay/i ) {
	$flow->{sink} = "_";
    }
    else {
	$self->register_variable($flow->{sink}, type => 'variable');
    }
    
    # We need to expand the set of supported expressions
    
    if ( defined $flow->{rate_expr} ) {
	die "Arbtrary rate expressions are not yet supported. \
At $INPUT_NAME, line $INPUT_LINE\n";
    }
    
    # Limitless quantities are not valid as rates
    
    if ( $flow->{rate1} =~ /^(endless|growth|decay)$/i ) {
	die "Invalid rate coefficient: $flow->{rate1} at $INPUT_NAME, line $INPUT_LINE\n";
    }
    else {
	$self->register_variable($flow->{rate1});
    }
    
    if ( $flow->{rate2} =~ /^(endless|growth|decay)$/i ) {
	die "Invalid rate coefficient: $flow->{rate2} at $INPUT_NAME, line $INPUT_LINE\n";
    }
    else {
	$self->register_variable($flow->{rate2});
    }

    # Now that we've validated it, add the flow to the list.
    
    push @{$self->{flowlist}}, $flow;
}


# Note that a variable has been mentioned in the model.  Depending on how it
# is mentioned, it may have type 'const' or 'variable'.  This routine will be
# called more than once for most variables; it is an error to redefine one
# from 'const' to 'variable' or vice versa.

sub register_variable {

    my ($self, $name, undef, $type) = @_;
    
    # First make sure that we actually have a valid identifier
    
    unless ( $name =~ / ^ [a-zA-Z_] \w* $ /xoi ) {
	die "Invalid identifier '$name' at $INPUT_NAME, line $INPUT_LINE\n";
    }
    
    # Then create a new variable record and add it to the variable table.
    
    my $var = ($self->{vtable}{$name}) || 
              ($self->{vtable}{$name} = new NBGC::Variable $name);
    
    # It is not allowed to redefine a variable as a constant or vice
    # versa.  But if the given name was previously used but not
    # given a type, we can assign one now.
    
    if ( defined $type && defined $var->{type} && $var->{type} ne $type ) {
	die "Invalid redeclaration of variable $name to constant \
at $INPUT_NAME, line $INPUT_LINE.\n";
    }
    
    elsif ( defined $type ) {
	$var->{type} = $type;
    }
}


# clear ( ) - Clear the simulator completely, so that another model can be
# loaded. 

sub clear {    

    my $self = shift;
    
    $self->{state} = 'CLEAR';    
    $self->{compiled} = undef;
    $self->{vtable} = {};
    $self->{vvector} = [];
    $self->{initlist} = [];
    $self->{flowlist} = [];
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
    
    my $CODE = "package $pkgname; no strict 'vars';\n\n";
    $CODE .= "\$T = 0; *t = \\\$T; \$_TRACE{'T'} = [];\n";
    
    foreach my $expr (@{$self->{tracelist}}) {
	if ( $expr =~ /^\w/ ) { $expr = '$' . $expr; }
	$CODE .= "\$_TRACE{'$expr'} = [];\n";
    }
    
    eval $CODE;
    
    if ( $@ ) {
	croak "Error in runspace init: $@";
    }
    
    return 1;
}


# Methods for phase 2 -- init
# ===========================

# set_init_value ( name, value )
#
# Specifies an initial value for the given identifier (variable or constant),
# overriding any value specified in the model. This routine is only
# immediately effective if called before init(), or just after a reset(). An
# undefined value means to revert to the value specified in the model. The
# results of this call are persistent across model runs.

sub set_init_value {

    my ($self, %args) = @_;
    
    # First look up the identifier, and make sure that it is defined.
    
    my $var = $self->{vtable}{$args{name}};
    
    unless ( ref $var eq 'Variable' ) {
	carp "Unknown identifier '$args{name}'";
	return undef;
    }
    
    # Set the value and return true.
    
    $self->{vtable}{initial} = $args{value};
    return 1;
}


# set_run_value ( name, value )
# 
# Specifies a new value for the given identifier (variable or constant),
# overriding any value specified in the model.  This routine can be called at
# any point in the simulation, but its effects only last until the variable is
# changed by the model code or until the next reset() upon which time the
# variable or constant is reset to its initial value as specified in the model
# or overridden by set_init_value().

sub set_run_value {

    my ($self, %args) = @_;
    
    # First look up the identifier, and make sure that it is defined.
    
    my $var = $self->{vtable}{$args{name}};
    
    unless ( ref $var eq 'Variable' ) {
	carp "Unknown identifier '$args{name}'";
	return undef;
    }
    
    # Set the value.  Exactly how this is done depends on which method was
    # used to compile the model.
    
    if ( $self->{compiled} eq 'PERL' ) {
	eval "package $self->{runspace}; $args{name} = $args{value};";
    }
    
    elsif ( $self->{compiled} eq 'PDL' ) {
	# still have to write this one...
    }
    
    else {
	carp "Variables cannot be set until the model is compiled.";
	return undef;
    }
    
    $self->{vtable}{set} = $args{value};
    return 1;
}


# init ( )
# 
# If the model has not yet been compiled, do so.  Then initialize the
# model variables in order to start run.  Use the initial values
# specified in the model, unless these were overridden by calls to the
# set_value() method.  Throw an exception if any of the model
# variables are left without a value.

sub init {

    my ($self) = @_;
    
    # First check if we have a model loaded yet.
    
    if ( $self->{state} eq 'CLEAR' ) {
	carp "No model loaded.";
	return undef;
    }
    
    # If we have a model loaded but not compiled, do that now.  That will make
    # us ready to initialize.
    
    elsif ( $self->{state} eq 'LOAD' ) {
	$self->compile($OBJECT_METHOD) or return undef;
    }
    
    # Otherwise, if the state is anything but READY, reset the simulator
    # first.
    
    elsif ( $self->{state} ne 'READY' ) {
	$self->reset();
    }
    
    # Now, we are ready to initialize.  First initialize the namespace, then
    # the variables.
    
    $self->{state} = 'INIT';
    $self->init_runspace();
    &{$self->{initprog}};
    
    return 1;
}


# Compile the model, or re-compile it if it has already been compiled.

sub compile {

    my ($self, $method) = @_;
    
    # First check if we have a model loaded yet.
    
    if ( $self->{state} eq 'CLEAR' ) {
	carp "No model loaded.";
	return undef;
    }
    
    # Otherwise, if the state is anything but LOAD, reset the simulator
    # first.
    
    elsif ( $self->{state} ne 'LOAD' ) {
	$self->reset();
    }
    
    # Now we are ready to compile or re-complile.
    
    $method = $OBJECT_METHOD unless $method;   # If no method is specified, use default.
    
    if ( $method eq 'PERL' ) {
	$self->compile_PurePerl();
    }
    
    elsif ( $method eq 'PDL' ) {
	carp "PDL compilation not yet enabled.";
	return undef;
	# $self->compile_PDL();
    }
    
    else {
	carp "Inalid compilation method: $method.";
	return undef;
    }
    
    return 1;
}


# trace ( interval, exprlist )
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


# clear_trace ( )
# 
# Clear the trace list

sub clear_trace {
    
    my $self = shift;
    
    $self->{tracelist} = [];
    $self->{traceprog} = undef;
    $self->{trace_compiled} = 1;
}


# Compile the trace program.  There are actually two: the trace initialization
# program, which sets up the trace hash, and the trace program, which records
# the actual values.

sub compile_trace {

    my $self = shift;
    
    # Start setting up the code for both programs
    
    my $CODE = "package $self->{runspace};\nno strict 'vars';\n\n";
    $CODE .= "push \@{\$_TRACE{'T'}}, \$T;\n";
    
    foreach my $expr (@{$self->{tracelist}}) {
	if ( $expr =~ /^\w/ ) { $expr = '$' . $expr; }
	$CODE .= "push \@{\$_TRACE{'$expr'}}, \$T;\n";
	$CODE .= "push \@{\$_TRACE{'$expr'}}, $expr;\n";
    }
    
    eval("\$self->{traceprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in trace program: $@";
    }
    
    $self->{trace_compiled} = 1;
}


# Methods for phase 3 -- spinup
# ============================

# Methods for phase 4 -- run
# ==========================

# run ( start, limit, increment, continue )
# 
# Run the model.  The start parameter, if given, specifies the initial time.
# It defaults to 0, unless we are continuing a previous run in which case it
# defaults to the time at the end of the previous run. The limit, if given,
# specifies the ending time.  The increment, if given, specifies the time
# increment and defaults to 1.  If continue is given a true value, we will
# continue the run from where we previously left off.

sub run {

    my ($self, %args) = @_;
    
    my $start = $args{start} > 0 ? $args{start} : 0;
    
    if ( $args{continue} ) {
	if ( defined $self->{run_end} ) {
	    $start = $self->{run_end};
	}
	
	else {
	    croak "No run to continue from.";
	}
    }
    
    my $limit = $args{limit};
    
    my $increment = $args{increment} || 1;
    
    $self->{state} = 'RUN';
    
    # Make sure the trace program is compiled.
    
    $self->compile_trace() unless $self->{trace_compiled};
    
    # Find the time variable, and initialize it.
    
    my $T;
    
    eval("\$T = \\\$$self->{runspace}::T");
    $$T = $self->{run_start} = $start;
    
    # If we are just starting up, do an initial trace.
    
    unless ( defined $self->{run_end} && $self->{run_end} == $$T ) {
	&{$self->{traceprog}};
    }
    
    # Now, loop through run steps
    
    until ( $$T >= $limit ) {
	
	&{$self->{runprog}} if defined $self->{runprog};
	$$T++;
	&{$self->{traceprog}} if defined $self->{traceprog};
    }
    
    # Finish up
    
    $self->{run_end} = $$T;
    return 1;
}
    
# Methods for phase 5 -- output
# =============================

sub write_data {

    my ($self, %args) = @_;
    
    my (@vars) = split( /\*,\*/, $args{vars} );
    
    unless (@vars) {
	@vars = @{$self->{tracelist}};
    }
    
    my $fh = $args{file};
    
    my $dataref;
    eval "\$dataref = \\\%$self->{runspace}::_TRACE";
    my $datacount = scalar @{$dataref->{T}};
    
    foreach my $i (0..$datacount-1) {
	print $fh $dataref->{T}[$i], "\t";
	foreach my $var (@vars) {
	    print $fh $dataref->{$var}[2*$i+1], "\t";
	}
	print $fh "\n";
    }
}

	


# We have to end the module with a true value.

1;
