#
# This file goes along with Parser.pm.  It completes the package Mad::Parser,
# keeping the latter file from being too large.
# 

package Mad::Parser;
use strict;

use Mad::Model qw(:vartypes :phases);


# Utility functions for parsing
# -----------------------------

# set_package ( $name )
# 
# From here to the end of the current block, all non-dynamic variable names
# will be evaluated in the context specified by $name.

sub set_package {

    my ($self, $name) = @_;
    $self->{cf}{package} = $name;
    $self->{model}->see_package($name);
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
    $attrs{package} = $self->{frame}[0]{package} unless defined $attrs{package};
    
    if ( defined $attrs{dimlist} ) {
	$attrs{dimlist} = $self->merge_dimlist($attrs{dimlist});
    }
    else {
	$attrs{dimlist} = $self->{frame}[0]{dimlist};
	$attrs{dimcount} = $self->{frame}[0]{dimcount};
    }
    
    unshift @{$self->{frame}}, $self->{cf};
}


# pop_frame ( $tag )
# 
# Remove the top context from the frame stack.  If that context did not have
# the tag $tag, keep removing contexts until we find one that does.  The first
# of the remaining contexts now becomes the active one.

sub pop_frame {

    my ($self, $tag) = @_;
    
    while ( $self->{frame}[0]{tag} ne $tag and $self->{frame}[0]{tag} ne 'PROGRAM' ) {
	$DB::single = 1;
	shift @{$self->{frame}};
    }
    
    if ( $self->{frame}[0]{$tag} eq 'PROGRAM' ) {
	$self->my_error("Frame Error (internal)");
    }
    else {
	shift @{$self->{frame}};
    }
}

# Functions for adding elements to the model
# ------------------------------------------

# see_var ( $node, $type )
# 
# The parser has parsed a variable, and we need to make sure that the model
# has a record for this variable so that when we are compiling code we will be
# able to make sure that what are supposed to be different uses of the same
# variable really are so.  If $type is not given, it is assumed to be
# PLAIN_VAR.  Otherwise, the allowable types are: CONST_VAR, indicating that a
# constant was just declared (so any later attempt to set it to a different
# value would be an error), ASSIGN_VAR, indicating that this variable is being
# set, and DYNAMIC_VAR, indicating that this variable was declared dynamic
# (i.e. with "my").  Note that an assignment statement will cause two calls to
# this routine for the left-hand variable, once to note that it is being seen
# (with empty $type) and once with $type ASSIGN_VAR to note that it is being set. 

sub see_var {

    my ($self, $node, $type) = @_;
    
    my $model = $self->{model};
    my $name = $node->{attr};
    my $pkg;
    
    # Determine the variable's package.  Was it specified explicitly?

    if ( $name =~ /([a-zA-Z0-9_:]*)::([a-zA-Z0-9_])/ ) {
	$pkg = $1 || 'main';
	$name = $2;
    }
    
    # Otherwise, we use the current package if one was specified.
    
    elsif ( $self->{cf}{package} ne '' ) {
	$pkg = $self->{cf}{package};
    }
    
    # Otherwise, use 'main'.
    
    else {
	$pkg = 'main';
    }
    
    # Calculate the variable's dimension, as the sum of the explicit dimension
    # (given by [...] after the variable name) and the implicit dimension
    # (given by surrounding "across [...]" constructs).
    
    my $explicit_dimension = scalar(@{$node->{children}});
    my $implicit_dimension = $self->{cf}{dimcount};
    
    # If this is a dynamic variable, its name gets stored in the current
    # frame, and the node is marked so that dynamic resolution will be used
    # when compiling it.
    
    if ( $type == DYN_VAR ) {
	$self->{cf}{dynamic}{$name} = 1;
	$node->{dynamic} = 1;
    }
    
    # Otherwise, we check to see if a dynamic variable was already declared in
    # the current frame.  If so, mark it dynamic and we're done.
    
    elsif ( $self->{cf}{dynamic}{$name} ) {
	$node->{dynamic} = 1;
    }
    
    # If not, then the variable is a static one.  If it's being declared as a
    # constant, make sure it wasn't already being set elsewhere.
    
    elsif ( $type eq CONST_VAR and $model->has_lvalue($name, $pkg) ) {
	my ($ofile, $oline) = $model->where_used($name, $pkg);
	$self->my_error("$name is also set at $ofile line $oline.");
	$self->YYError("abc");
    }
    
    # If it's being used as an lvalue (i.e. is being assigned a value), make
    # sure it wasn't already declared as a constant.
    
    elsif ( $type eq ASSIGN_VAR and $model->has_constant($name, $pkg) ) {
	my ($ofile, $oline) = $model->where_used($name, $pkg);
	$self->my_error("$name was declared as a constant at $ofile line $oline.");
	$self->YYError("def");
    }
    
    # Otherwise, we add a note to the model about this variable.
    
    else {
	$model->see_var($name, $pkg, $type, $explicit_dimension + $implicit_dimension,
			$node->{filename}, $node->{line});
	
	$node->{lvalue} = 1 if $type eq ASSIGN_VAR;
    }
    
    # Return the node as the value of this function, so that the parser
    # actions work properly.
    
    return $node;
}


# declare_function
# 
# 

sub declare_function {

    my ($self, $name, $args, $type) = @_;
    
    return undef;
}


# use_perl
# 
# 

sub use_perl {
    
    my ($self, $module) = @_;
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


# Functions for constructing parse trees
# --------------------------------------

# new_node ( $type, @children )
# 
# Create a new parse node, with children given by @children.  This will be
# part of the growing parse tree.  Each of @children should be a reference to
# another node.

sub new_node {
    my ($self, $type, @children) = @_;
    
    my $node = {children => [], filename => $self->{my_filename}, line => $self->{my_line}};
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
    my ($self, $type, $attr, @children) = @_;
    
    my $node = {children => [], filename => $self->{my_filename}, line => $self->{my_line}};
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

sub add_child {
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
    my ($self, $type, $old_node) = @_;
    
    my $node = Parse::Eyapp::Node->new($type);
    $node->{attr} = $old_node->{attr} if exists $old_node->{attr};
    $node->{units} = $old_node->{units} if exists $old_node->{units};
    $node->{children} = $old_node->{children} if exists $old_node->{children};
    $node->{filename} = $old_node->{filename} if exists $old_node->{filename};
    $node->{line} = $old_node->{line} if exists $old_node->{line};
    return $node;
}

1;
