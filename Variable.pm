#
# NBGC Project
# 
# Class Variable - dynamic system variable
# 
# Author: Michael McClennen
# Copyright (c) 2010 University of Wisconsin-Madison
# 
# Each instance of this class represents a variable in a dynamic system
# simulation.  This class is used by Simulation.pm.

package NBGC::Variable;

use strict;
use warnings;
use Carp;

# Global variables
# ----------------
#  
# none

# Constructor, destructor and related methods
# -------------------------------------------
# 
# new ( name )
# 
# This method creates a new Variable, with a given name.

sub new {

    my ($class, $name) = @_;
    
    my $self = {};
    bless $self, $class;
    
    carp "Invalid variable name '$name'" unless $name =~ /^\w+$/;
    $self->{name} = $name;
    
    return $self;
}

# DESTROY ()
# 
# There is no need for anything but an empty destructor method.

sub DESTROY {
}

1;

=head1 NAME

NBGC::Variable - dynamic system variable

This module is part of the NBGC project.

=head1 SYNOPSIS

  use NBGC::Variable;

  $var = new NBGC::Variable $name;
  
=head1 REQUIRES

Perl 5.8

=head1 EXPORTS

Nothing

=head1 DESCRIPTION

Objects of class NBGC::Variable represent variables in a dynamic
system simulation.

=head1 AUTHOR

Author: Michael McClennen
Copyright (c) 2010 University of Wisconsin-Madison

=cut
