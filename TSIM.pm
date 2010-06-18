#
# Class TSIM : dynamic system simulation
# 
# Each instance of this class represents a dynamic system simulation.
# It is composed of a set of variables, a set of flows that change
# their values, etc. 

package TSIM;
use strict;


# Constructor, destructor and related methods
# ===========================================

# new : Create a new instance.

sub new {

    my $class = shift;
    my $self = {};
    bless $self, $class;
    
    $self->initialize();
    
    return $self;
}


# initialize : Initialize a new instance

sub initialize {

    my $self = shift;
    
    $self->{VTABLE} = {};
    $self->{ITABLE} = [];	# list of initialization statements in Perl
    $self->{STABLE} = [];
    
    $self->{VINDEX} = 0;
}


# empty destructor

sub DESTROY {
}


# Now, routines for parsing statements that define the model.
# ===========================================================

# add_init_stmt : Parse an initialization statement, and add it to the
# model.  These are run (as Perl code) before the model is started up,
# to initialize variables.

sub add_init_stmt {

    my ($self, %args) = @_;
    
    if ($args{const})
    {
	$self->set_const($args{name});
    }
    
    if (defined $args{expr})
    {
	push @ITABLE, "$name = $expr;\n";
    }
    
}


# add_step_stmt : Parse a step statement, and add it to the model.  

sub add_step_stmt {

    my ($self, %args) = @_;
    
    my $source = $args{source};
    my $sink = $args{sink};
    my $flow = $args{flow};
    my ($source_id, $sink_id);
    
    given ($source)
    {
	where (/^\w+$/) {
	    $source_id = $self->lookup_var($_);
	    
