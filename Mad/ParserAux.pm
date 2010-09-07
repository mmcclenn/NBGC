#
# This file goes along with Parser.pm.  It completes the package Mad::Parser,
# keeping the latter file from being too large.
# 

package Mad::Parser;
use strict;

use Mad::Model qw(:vartypes :phases)


# Utility functions for parsing
# -----------------------------

# set_module ( $node )
# 
# From here to the end of the current block, all non-dynamic variable names
# will be evaluated in the context specified by $module_name.

sub set_module {

    my ($self, $name) = @_;
    $self->{cf}{module} = $name;
}


# push_frame ( %attributes )
# 
# Add a new context to the frame stack.  This context will be used to
# interpret all subsequent statements until the next call to push_frame or
# pop_frame.  All attributes not specified by %attributes are inherited from
# the previous frame, except for 'tag' which is used to match up pushes and
# pops in the presence of syntax errors.

sub push_frame {

    my ($self, %attrs) = @_;
  
    $self->{cf} = \%attrs;
    
    $attrs{phase} = $self->{frame}[0]{phase} unless defined $attrs{phase};
    $attrs{module} = $self->{frame}[0]{module} unless defined $attrs{module};
    
    if ( defined $attrs{dimlist} ) {
	$attrs{dimlist} = $self->merge_dimlist($self->{frame}[0]{dimlist},
					       $attrs{dimlist});
    }
    else {
	$attrs{dimlist} = $self->{frame}[0]{dimlist};
    }
    
    unshift @{$self->{frame}}, $self->{cf};
    
    if ( $attrs{tag} =~ /^(block|perlblock|function|perlfunc)$/ )
    {
	my $model = $self->{model};
	$model->open_block($attrs{phase});
    }
}


# pop_frame ( $tag )
# 
# Remove the top context from the frame stack.  If that context did not have
# the tag $tag, keep removing contexts until we find one that does.  The first
# of the remaining contexts now becomes the active one.

sub pop_frame {

    my ($self, $tag) = @_;
    
    while ( $self->{frame}[0]{tag} ne $tag ) {
	shift @{$self->{frame}};
    }

    if ( $tag =~ /^(block|perlblock|function|perlfunc)$/ )
    {
	my $model = $self->{model};
	$model->close_block($attrs{phase});
    }
}

# Functions for adding elements to the model
# ------------------------------------------

# declare_var ( $node, $disp )
# 
# A variable declaration has been encountered.  Declare the variable specified
# by $node, with disposition $disp (i.e. constant, variable, pool).

sub declare_var {

    my ($self, $node, $disp) = @_;
    
}


# see_var ( $node )

sub see_var {

    my ($self, $node) = @_;
    
    my $model = $self->{model};
    my $type = ref $node;
    
    my $name = $node->{attr};
    if ( $self->{cf}{module} ) {
	$name = $self->{cf}{module} . "::" . $name;
    }
    
    $model->see_var($name, $type, $self->{my_filename}, $self->{my_line});
    
    my $implicit_dimension = $self->{cf}{dimlist};
    
    if ( $implicit_dimension or @{$node->{children}} > 0 ) {
	$model->dimension_var($name, $implicit_dimension, $node->{children});
    }
}

# decare_units ( $node )
# 
# Declare all of the units given by the children of $node.

sub declare_units {
    my ($self, $node) = @_;
    my $model = $self->{model};
    
    foreach my $child (@{$node->{children}}) {
	
	# Make the declaration, and if something goes wrong then give the
	# appropriate error message.
	
	unless ( $model->declare_unit($child->{attr}) ) {
	    if ( $model->{err} eq 'UNIT_DECL_REPEATED' ) {
		$self->my_warning("Unit '$child->{attr}' was already defined");
	    }
	}
    }
}


# add_expr ( $expr )
# 
# Add an arbitrary expression (which could have side effects, i.e. could be an
# assignment statement) to the model, under the phase indicated by the active frame.

sub add_expr {
    
    my ($self, $expr) = @_;
    
    my $model = $self->{model};
    my $phase = $self->{cf}{phase};
    
    $model->add_expr($phase, $expr);
}


# add_control ($type, @exprs)
# 
# Add a control structure to the model, under the phase indicated by the
# active frame.  Note that this only includes the conditional or loop-control
# syntax (i.e. "if ( ... )" or "while ( ... )" or "else".  The conditional or
# iterated code, plus delimiting brackets, are added by separate calls to
# push_frame(), pop_frame(), add_expr(), add_control(), etc.

sub add_control {
    
    my ($self, $type, @exprs) = @_;
    
    my $model = $self->{model};
    my $phase = $self->{cf}{phase};
    
    $model->add_control($phase, $type, @exprs);
}


# add_flow ( $source, $sink, $rate )
# 
# Add a flow to the model.

sub add_flow {
    
    my ($self, $source, $sink, $rate) = @_;
    
    my $model = $self->{model};
    my $phase = $self->{cf}{phase};
    
    if ( $phase ne CALC_PHASE ) {
	$self->my_error("attempt to define a flow in an invalid phase");
    }
    
    $model->add_flow($source, $sink, $rate);
}


# Functions for constructing parse trees
# --------------------------------------

# new_node ( $type, @children )
# 
# Create a new parse node, with children given by @children.  This will be
# part of the growing parse tree.  Each of @children should be a reference to
# another node.

sub new_node {
    my ($type, @children) = @_;
    
    my $node = {children => []};
    bless $node, $type;
    
    push @{$node->{children}}, @children if @children > 0;
    return $node;
}

# new_anode ( $type, $attr, @children )
# 
# Similar to new_node, but with the addition of the parameter $attr which is
# used to set the "attr" field of the new node.  This is used to record the
# value of a string or numeric literal, the name of a variable, etc.

sub new_anode {
    my ($type, $attr, @children) = @_;
    
    my $node = {children => []};
    bless $node, $type;
    
    $node->{attr} = $attr if defined $attr;
    
    push @{$node->{children}}, @children if @children > 0;
    return $node;
}

# right_child ( $node, $child )
# 
# Add $child to the children of an existing node in the parse tree,
# provided that $child is a reference to a node.  If it is not, do nothing.

sub right_child {
    my ($node, $child) = @_;
    
    push @{$node->{children}}, $child if ref $child;
    return $node;
}


# left_child ( $node, $child )
# 
# Add $child to the front of the existing list of children of $node.

sub left_child {
    my ($node, $child) = @_;
    
    unshift @{$node->{children}}, $child if ref $child;
    return $node;
}


# add_units ( $node, @units )
# 
# Modify the parse node $node by adding some units to it.  This is triggered
# by a unit expression such as "<mi/hr>".  This information will then be used
# to make sure that any equations involving the entity declared by $node are
# unit-balanced.

sub add_units {
    my ($node, @units) = @_;
    
    # Make sure that the field "units" exists and points to an array.
    
    unless ( ref $node->{units} eq 'ARRAY' ) {
	$node->{units} = [];
    }
    
    # Add the given units to the array.
    
    push @{$node->{units}}, @units;
    return $node;
}

# merge_units ( $node, $unitnode, $sort_flag )
# 
# Modify the node $node by copying to it the list of units already associated
# with $unitnode.  If $sort_flag is true, sort the units alphabetically first.

sub merge_units {
    my ($node, $unitnode, $sort_flag) = @_;
    
    if ( ref $unitnode ) {
	if ( $sort_flag ) {
	    $node->{units} = [ sort @{$unitnode->{units}} ];
	}
	else {
	    $node->{units} = $unitnode->{units};
	}
    }
    return $node;
}

# new_dnode ( $type, $old_node )
# 
# Create a new node from an existing one.  The new node will have type $type
# and its children, units, and attribute will be the same as those of $old_node.

sub new_dnode {
    my ($type, $old_node) = @_;
    
    my $node = Parse::Eyapp::Node->new($type);
    $node->{attr} = $old_node->{attr} if exists $old_node->{attr};
    $node->{units} = $old_node->{units} if exists $old_node->{units};
    $node->{children} = $old_node->{children} if exists $old_node->{children};
    return $node;
}

