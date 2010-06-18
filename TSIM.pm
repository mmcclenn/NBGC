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
    $self->{ITABLE} = [];
    $self->{STABLE} = [];

    $self->{VINDEX} = 0;
}


# empty destructor

sub DESTROY {
}


# Now, routines for parsing statements that define the model.
# ===========================================================

# add_init_stmt : Parse an initialization statement, and add it to the
# model.

sub add_init_stmt {

    my ($self, %args) = @_;
    
    my $stmt = $args{stmt};
    
    my @vars = $what =~ /\$(\w+)/gm;
    
    for my $name (@vars) 
    {
	my $var = $self->recognize($name);
	

    
    
