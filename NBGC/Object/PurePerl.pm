#
# NBGC Project
# 
# Compile::PurePerl - backend for Simulator that compiles to pure Perl.  This can
# be used when PDL is not available.
# 
# Author: Michael McClennen
# Copyright (c) 2010 University of Wisconsin-Madison
# 
# This module is designed to be used by Simulator.pm.

package NBGC::Object::PurePerl;

our ($OBJECT_METHOD);

$OBJECT_METHOD = 'PERL';	# Which method to use for generating
                                # object code.  Options are: 'perl' and
                                # 'pdl'.


# Compile the model that is currently loaded into the given Simulator object
# using the PERL method -- the initialization and each step of the model
# become pure Perl functions.  Variable values are all kept in the package
# NBGC_Run_$id where $id is a unique identifier assigned to this Simulator object.

sub compile_PERL {

    my $self = shift;
    
    # First, compile the initialization step.
    
    my $CODE = "package $self->{runspace};\nno strict 'vars';\n\n";
    
    foreach my $init (@{$self->{initlist}}) {
	my ($name, $expr) = ($init->{var}, $init->{expr});
	
	$CODE .= "\$$name = $expr;\n";
    }
    
    eval("\$self->{initprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in initialization program: $@";
    }
    
    # Next, compile the run step.
    
    $CODE = "package $self->{runspace};\nno strict 'vars';\n\n";
    
    foreach my $flow (@{$self->{flowlist}}) {
	my $source = $flow->{source};
	my $sink = $flow->{sink};
	if ( defined $flow->{rate_expr} ) {
	    if ( $source eq '_' ) {
		$CODE .= "\$$sink += $flow->{rate_expr};\n";
	    }
	    elsif ( $sink eq '_' ) {
		$CODE .= "\$$source -= $flow->{rate_expr};\n";
	    }
	    else {
		$CODE .= "{\nmy \$val = $flow->{rate_expr};\n";
		$CODE .= "\$$source -= \$val; \$$sink += \$val;\n}\n";
	    }
	}
	
	elsif ( $flow->{rate2} eq '1' ) {
	    $CODE .= "\$$source -= \$$flow->{rate1};\n" if $source ne '_';
	    $CODE .= "\$$sink += \$$flow->{rate1};\n" if $sink ne '_';
	}
	
	else {
	    $CODE .= "\$$source -= \$$flow->{rate1} * \$$flow->{rate2}; " if $source ne '_';
	    $CODE .= "\$$sink += \$$flow->{rate1} * \$$flow->{rate2}; " if $sink ne '_';
	    $CODE .= "\n";
	}
    }
    
    eval("\$self->{runprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in run program: $@";
    }
    
    $self->init_runspace();
    $self->{state} = 'READY';
}








1;
