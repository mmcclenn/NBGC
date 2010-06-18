#
# Class TVAR : dynamic system variable
# 
# Each instance of this class represents a variable in a dynamic system
# simulation.

package TVAR;
use strict;



# Constructor, destructor and related methods

sub recognize {
    my $class = shift;
    my $name = 
    
    
    my $self = {};
    bless $self, $class;
    
    $self->initialize();
    
    return $self;
}


sub DESTROY {
}


