#
# NBGC Project
# 
# Simulator::PDL - subclass of Simulator that uses PDL internally.
# 
# Author: Michael McClennen
# Copyright (c) 2010 University of Wisconsin-Madison

package NBGC::Simulator::PDL;
our (@ISA) = 'NBGC::Simulator';

use strict;
use warnings;
use Carp;
use PDL;
use PDL::NiceSlice;

# This subclass needs its own constructor method, which will call the base
# constructor method and then re-bless the object into our own class and add
# the additional fields we need.

sub new {

    my $class = shift;
    my $self = NBGC::Simulator->new($class);
    
    bless $self, $class;
    
    return $self;
}

    
# Compile the model that is currently loaded into the given Simulator object.
# The model state is kept as a piddle.  Variable values are all kept in
# the package NBGC::Run_$id where $id is a unique identifier assigned to this
# Simulator object.

sub compile_runprog {

    my $self = shift;
    
    # First, go through the variable/constant table to generate a vector of
    # actual variables.
    
    $vindex = 2;		# position 0 is for the time, and position 1
                                # is for the constant 1.
    
    my @vv = (undef, undef);
    
    foreach my $var (@{$self->{vsequence}}) {
	if ( $var->{type} eq 'variable' ) {
	    $var->{index} = $vindex;
	    $vv[$vindex++] = $var;
	}
    }
    
    $self->{vvector} = \@vv;
    my $vlen = scalar(@vv);
    
    # Now we generate code to create a piddle to hold the variable vector
    
    my $CODE = <<ENDCODE;
package $self->{runspace};
no strict 'vars';

our (\$STATE, \$LINTRAN);

\$STATE = zeros($vlen);			# state vector, first pos is time 
\$STATE(1) .= 1;			# second pos is constant 1
\$LINTRAN = zeros($vlen, $vlen);	# linear transformation matrix
\$LINTRAN->diagonal(0,1)++;
\$LINTRAN(0,1) .= 1;			# increment time by 1 each step
ENDCODE
    
    # Then we add initializers for each of the other variables
    
    foreach my $init (@{$self->{initlist}}) {
	my ($name, $expr) = ($init->{var}, $init->{expr});
	my $index = $self->{vtable}{$name}{index};
	$CODE .= "\$STATE($index) .= $expr;\n";
    }
    
    $CODE .= "\n";
    
    # and initializers for the linear transformation matrix based on
    # the flows
    
    foreach my $flow (@{$self->{flowlist}}) {
	my $source = $flow->{source};
	my $sink = $flow->{sink};
	if ( defined $flow->{rate_expr} ) {
	    croak "Arbitrary rate expressions not yet allowed with PDL.";
	}
	
	elsif ( $flow->{rate2} eq '1' ) {
	    $CODE .= "\$$source -= \$$flow->{rate1};\n" if $source ne '_';
	    $CODE .= "\$$sink += \$$flow->{rate1};\n" if $sink ne '_';
	}
	
	else {
	    my $rate1name = $flow->{rate1};
	    my $rate1var = $self->{vtable}{$rate1name};
	    my $rate1value = $self->{
	    $CODE .= "\$$source -= \$$flow->{rate1} * \$$flow->{rate2}; " if $source ne '_';
	    $CODE .= "\$$sink += \$$flow->{rate1} * \$$flow->{rate2}; " if $sink ne '_';
	    $CODE .= "\n";
	}
    }

    eval("\$self->{initprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in initialization program: $@";
    }
    
    
    
    # Next, compile the run step.
    
    $CODE = <<ENDCODE;
package $self->{runspace};
no strict 'vars';

our(\$STATE);
    
    
    eval("\$self->{runprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in run program: $@";
    }
    
    $self->{compiled} = 'PurePerl';
}


# Create a trace function for the current model.

sub compile_traceprog {

    my $self = shift;
    
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


# dump_trace ( ) - dump the trace data to the given file handle

sub dump_trace {

    my ($self, %args) = @_;
    
    my $vars = $args{"vars"} || "";
    my (@vars) = split(/\s*,\s*/, $vars);
    
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







1;
