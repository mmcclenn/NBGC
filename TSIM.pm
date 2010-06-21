#
# Class TSIM : dynamic system simulation
# 
# Each instance of this class represents a dynamic system simulation.
# It is composed of a set of variables, a set of flows that change
# their values, etc. 

package TSIM;
use strict;

# How to use this package:
# 
# Running a model consists of 5 phases, all of which are optional except the first.
# 
# 1. load	read in the model and set up the framework necessary to run it
# 2. init	initialize the model's variables
# 3. spinup	run the model long enough to establish a steady state
# 4. run	run the model for a specified number of steps, or until a specified
#		condition is reached
# 5. output	write the data to disk
# 
# Here is an example:
# 
# $sim = TSIM->new('simvar');
# $simvar::some_variable = 3;
# $simvar::some_flag = 1;
# $sim->load_from("model.txt");
# $sim->init();
# $simvar::var2 = 5;
# $sim->spinup();
# $simvar::some_flag = 0;
# $sim->sample(1, qw(var1 var2 var3));
# $sim->run(300);
# $sim->write_data(OUTFILE);
# $sim->plot_var('var1_plot.png', 'var1');


# Constructor, destructor and related methods
# ===========================================

# new : Create a new simulation instance, with a given name space.

sub new {

    my $class = shift;
    my $self = {};
    bless $self, $class;
    
    my $namespace = shift || '__SIM';
    
    $self->{namespace} = $namespace;
    
    $self->{VTABLE} = {};
    $self->{ITABLE} = [];	# list of initialization statements in Perl
    $self->{STABLE} = [];
    
    $self->{VINDEX} = 0;
    
    return $self;
}    


# empty destructor

sub DESTROY {
}


# Routines for phase 1: load
# ===========================================================

# load : Load a list of statements that define a model.

sub load {

    foreach my $line (@_)
    {
	next unless $line =~ /\S/;     	# ignore blank lines
	s/^\s*//;			# take out initial whitespace
	s/\s*$//;			# take out final whitespace
	
	if ( $line =~ / ^ init \s+ (.*) /xoi )
	{
	    &parse_init_stmt($1);
	}
	
	else
	{
	    &parse_step_stmt($line);
	}
    }
}


# load_from : Load statements from a file or file handle.

sub load_from {

    my $arg = shift;
    
    # if $arg is a file handle, read from it.
    
    # otherwise, open the named file and read from that.
}



# parse_init_stmt : Parse an initialization statement, and add it to the
# model.  These are run (as Perl code) before the model is started up,
# to initialize variables.

sub parse_init_stmt {

    my ($self, $what) = @_;
    my $const;

    if ( $what =~ / ^ const \s+ (.*) /xoi )
    {
	$what = $1;
	$const = 1;
    }	

    if ( $what =~ / ^ \$(\w+) \s* = \s* (.*) /xoi )
    {
	$self->add_init_stmt(name => $1, expr => $2, const => $const);
    }
    
    elsif ( $what =~ / ^ \$(\w+) $ /xo )
    {
	$self->add_init_stmt(name => $1, const => $const);
    }
    
    else
    {
	die "Could not parse statement: $what\n";
    }
}

# add_init_stmt : Actually add the init code, and mark certain variables as constant.

sub add_init_stmt {

    my ($self, %args) = @_;
    
    if ($args{const})
    {
	$self->mark_constant($args{name});
    }
    
    if (defined $args{expr})
    {
	push @ITABLE, "$args{name} = $args{expr};\n";
    }
}


sub parse_step_stmt {
    
    my ($self, $what) = @_;
    
    given ($what)
    {
	when ( / ^ \$ (\w+) \s* -> \s* \$ (\w+) \s* : 
		 \s* \$ (\w+) \s* \* \s* \$ (\w+) $ /xo )
	{
	    $self->add_step_stmt(source => $1, sink => $2, rate1 => $3, rate2 => $4);
	}
	
	when ( / ^ \$ (\w+) \s* -> \s* \$ (\w+) \s* : \s* \$ (\w+) $ /xo )
	{
	    $self->add_step_stmt(source => $1, sink => $2, rate1 => $3, rate2 => 1);
	}
	
	when ( / ^ \$ (\w+) \s* -> \s* \$ (\w+) \s* : \s* (.*) /xo )
	{
	    $self->add_step_stmt(source => $1, sink => $2, rate_expr => $3);
	}
	
	when ( / ^ \$ (\w+) \s* \* \s* \$ (\w+) \s* -> \s* \$ (\w+) $ /xo )
	{
	    $self->add_step_stmt(source => $1, sink => $3, rate1 => $1, rate2 => $2);
	}
	
	when ( / ^ \$ (\w+) \s* -> \s* \$ (\w+) \s* \* \s* \$ (\w+) $ /xo )
	{
	    $self->add_step_stmt(source => $1, sink => $3, rate1 => $3, rate2 => $2);
	}	
	
	default
	{
	    die "Could not parse statement: $what\n";
	}
    }
}


# add_step_stmt : Parse a step statement, and add it to the model.  

sub add_step_stmt {

    my ($self, %args) = @_;
    
    my $source = $args{source};
    my $sink = $args{sink};
    my $rate1 = $args{rate1};
    my ($source_id, $sink_id);
    
    given ($source)
    {
	when ('ENDLESS') {
	    die "You cannot use a proportional flow from an endless source\n"
		if $args{type} eq 'PROP';
	} 
	
	when (/^\w+$/) {
	    $source_id = $self->lookup_var($_);
	    
	}
    }
}


# mark_constant : create a new record in the variable hash (unless one
# already exists for the given name) and mark it as a constant. 

sub mark_constant {

    my ($self, $variable_name) = @_;
    
    $self->VHASH{
