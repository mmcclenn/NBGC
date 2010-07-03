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
use PDL::Graphics::PLplot;

# This subclass needs its own constructor method, which will call the base
# constructor method and then re-bless the object into our own class and add
# the additional fields we need.

sub new {

    my $class = shift;
    my $self = NBGC::Simulator->new();
    
    bless $self, $class;
    return $self;
}


# Compile the model that is currently loaded into this Simulator object.
# The model state is kept as a piddle.  Variable values are all kept in
# the package NBGC::Run_$id where $id is a unique identifier assigned to this
# Simulator object.

sub compile_runprog {

    my $self = shift;
    
    # First, go through the symbol table to generate a vector of
    # actual variables (not constants).
    
    my $vindex = 2;		# position 0 is for the time, and position 1
                                # is for the constant 1.
    
    my @vv = (undef, undef);
    
    foreach my $sym (@{$self->{sseq}}) {
	if ( $sym->{type} eq 'var' ) {
	    $sym->{index} = $vindex;
	    $vv[$vindex++] = $sym;
	}
    }
    
    $self->{vvector} = \@vv;
    my $vlen = scalar(@vv);
    
    # Our generated code goes in the 'runspace' package.
    
    my $CODE = <<ENDCODE;
package $self->{runspace};
no strict 'vars';
use PDL;
PDL::import('zeros', 'diagonal');

ENDCODE
    
    # First generate code to evaluate the initialization expressions, possibly
    # overridden by user-set initial values stored in the 'itable'.
    
    foreach my $init (@{$self->{initlist}}) {
	my ($name, $expr) = ($init->{sym}{name}, $init->{expr});
	$CODE .= <<ENDCODE;
\$$name = (defined \$self->{itable}{'$name'} ? \$self->{itable}{'$name'} : $expr);
ENDCODE
    }
    
    # Then generate code to create the variable vector and initialize each of
    # the positions in it based on the results of these initialization
    # expressions. 
    
    $CODE .= <<ENDCODE;

our (\$STATE);

\$STATE = zeros($vlen);			# state vector, first pos is time
my \$tmp;
(\$tmp = \$STATE(1)) .= 1;			# second pos is constant 1
ENDCODE
    
    # Now initialize each of the other positions in the state vector according
    # to the corresponding variable in the 'runstate' package.
    
    foreach my $i (2..$#vv) {
	$CODE .= <<ENDCODE;
(\$tmp = \$STATE($i)) .= \$$vv[$i]{name};
ENDCODE
    }
    
    # Then create the linear transformation matrix and enter into it the
    # elements necessary for each of the flows.  This matrix will typically be
    # quite sparse.  Flows which are not linear will have to be taken care of
    # in the next step.

    $CODE .= <<ENDCODE;
    
\$LINTRAN = zeros($vlen, $vlen);	# start with an empty matrix
\$tmp = \$LINTRAN->diagonal(0,1); \$tmp++;		# add in the identity matrix
(\$tmp = \$LINTRAN(0,1)) .= 1;			# increment time by 1 each step
ENDCODE
    
    # Now, for each flow, set the necessary coefficients.
    
    foreach my $flow (@{$self->{flowlist}}) {
	
	my $rate = $flow->{rate};
	
	# Eventually we will be able to do this...
	
	if ( $flow->{rate}{type} eq 'expr' ) {
	    croak "Arbitrary rate expressions are not yet allowed with PDL.";
	}
	
	# Assuming it's not an arbitrary expression, find the order of the
	# rate.  For now, we only do linear flows.
	
	if ( $self->find_order($rate) > 1 ) {
	    croak "Higher order flows are not yet allowed with PDL.";
	}
	
	# So, we know that the rate is either a constant, a variable, or the
	# product of a constant and a variable.
	
	my ($rate_coeff, $rate_var_index);
	
	if ( $rate->{type} eq 'literal' ) {
	    $rate_coeff = $rate->{value};
	    $rate_var_index = 1; # index of constant 1 in state vector
	}
	
	elsif ( $rate->{type} eq 'const' ) {
	    $rate_coeff = '$' . $rate->{name};
	    $rate_var_index = 1; # index of constant 1 in state vector
	}
	
	elsif ( $rate->{type} eq 'var' ) {
	    $rate_coeff = '1';
	    $rate_var_index = $rate->{index};
	}
	
	elsif ( $rate->{type} eq 'prod' ) {
	    $rate_coeff = '1';
	    $rate_var_index = 1; # will be overridden if a child is of type 'var'
	    foreach my $child (@{$rate->{child}}) {
		if ( $child->{type} eq 'var' ) {
		    $rate_var_index = $child->{index};
		}
		
		elsif ( $child->{type} eq 'const' ) {
		    $rate_coeff .= " * \$$child->{name}";
		}
		
		elsif ( $child->{type} eq 'literal' ) {
		    $rate_coeff .= " * $child->{value}";
		}
	    }
	}
	
	# Now that we know the coefficient and variable index, add statements
	# that will put that information into the linear transformation matrix.
	
	$CODE .= <<ENDCODE unless $flow->{source}{type} eq 'flowlit';
(\$tmp = \$LINTRAN($flow->{source}{index},$rate_var_index)) -= $rate_coeff;
ENDCODE
	$CODE .= <<ENDCODE unless $flow->{sink}{type} eq 'flowlit';
(\$tmp = \$LINTRAN($flow->{sink}{index},$rate_var_index)) += $rate_coeff;

ENDCODE
    }
    
    eval("\$self->{initprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in initialization program: $@";
    }
    
    # Next, compile the run step.
    
    $CODE = <<ENDCODE;
package $self->{runspace};
no strict 'vars';
use PDL;

our(\$STATE, \$LINTRAN);
    
\$STATE = \$STATE x \$LINTRAN;

ENDCODE
    
    eval("\$self->{runprog} = sub {\n$CODE\n}");
    
    if ( $@ ) {
	croak "Error in run program: $@";
    }
    
    return 1;
}


# Create a trace function for the current model.

sub compile_traceprog {

    my $self = shift;
    
    my $CODE = <<ENDCODE;
package $self->{runspace};
no strict 'vars';

my \$n = \$STATE;
\$n->sever();
push \@_TRACE, \$n;
ENDCODE

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


# init_run_time ( time ) - set initial run time

sub init_run_time {

    my ($self, $start_time) = @_;
    
    eval ("my \$tmp = \$$self->{runspace}::STATE->slice(0); \$tmp = $start_time;");
    
    my $t_ref;
    eval("\$t_ref = \\\$$self->{runspace}::T");
    $$t_ref = $self->{run_start} = $start_time;
    
    return $t_ref;
}


sub increment_run_time {
    
    my ($self, $t_ref, $start_time) = @_;
    
    $$t_ref++;
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


# Find the order of the expression rooted at the given node.

sub find_order {
    
    my ($self, $node) = @_;
    
    return 0 if $node->{type} eq 'const' or $node->{type} eq 'literal';
    return 1 if $node->{type} eq 'var';
    
    if ( $node->{type} eq 'prod' ) {
	my $order = 0;
	foreach my $child (@{$node->{child}}) {
	    $order += $self->find_order($child);
	}
	return $order;
    }
    
    if ( $node->{type} eq 'sum' ) {
	my $order = 0;
	foreach my $child (@{$node->{child}}) {
	    my $neworder = $self->find_order($child);
	    $order = $neworder if $neworder > $order;
	}
	return $order;
    }
    
    else {
	die "Unknown node type: $node->{type}";
    }
}


# dump_trace ( ) - dump the trace data to the given file handle

sub dump_trace {

    my ($self, %args) = @_;
    
    my $fh = $args{file};
    my @vars = $self->variables();
    
    my $dataref;
    eval "\$dataref = \\\@$self->{runspace}::_TRACE";
    my $datacount = scalar @$dataref;
    
    foreach my $i (0..$datacount-1) {
	print $fh $dataref->[$i];
	print $fh "\n";
    }
}


1;
