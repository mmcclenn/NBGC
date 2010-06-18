#!/usr/local/bin/perl
#
# An ambitious project (so far unnamed) to create a general-purpose dynamic 
# systems simulation package using Perl and PDL.
# 
# 


use strict;
use feature "switch";

use TSIM.pm;
use TVAR.pm;


my $system = new TSIM;

while (<>)
{
    s/#.*//;			# take out comments
    next unless /\w/;		# ignore blank lines
    s/^\s*//;			# take out initial whitespace
    s/\s*$//;			# take out final whitespace
    
    my ($when, $what) = split /\s+/, $_, 2;
    
    given (uc $when)
    {
	when ('INIT') {
	    &parse_init_stmt($what);
	}

	when ('STEP') {
	    &parse_step_stmt($what);
	}
    }
}

my $a = 0;


    
sub parse_init_stmt {

    my ($what) = @_;
    
    given ($what) 
    {
	when ( /^ const (\w+) \s* = \s* (.*) $/xoi )
	{
	    $system->add_init_stmt(name => $1, expr => $2, const => 1);
	}
	
	when ( /^ (\w+) \s* = \s* (.*) $/xo )
	{
	    $system->add_init_stmt(name => $1, expr => $2);
	}
	
	when ( /^ const (\w+) $/xoi )
	{
	    $system->add_init_stmt(name => $1, const => 1);
	}
	
	when (/(\w+)\s*$/)
	{
	    $system->add_init_stmt(name => $1);
	}
    }
}


sub parse_step_stmt {
    
    my ($what) = @_;
    
    given ($what)
    {
	when ( /^ (\w+) \s* -> \s* \[(\w+)\] \s* (\w+) $/xo )
	{
	    $system->add_step_stmt(source => $1, rate => $2, sink => $3,
				   type => 'STRAIGHT');
	}
	
	when ( /^ (\w+) \s* \[(\w+)\] \s* -> \s* (\w+) $/xo )
	{
	    $system->add_step_stmt(source => $1, rate => $2, sink => $3,
				   type => 'STRAIGHT');	
	}
	
	when ( /^ (\w+) \s* -> \s* \((\w+)\) \s* (\w+) $/xo )
	{
	    $system->add_step_stmt(source => $1, rate => $2, sink => $3,
				   type => 'PROP');
	}
	
	when ( /^ (\w+) \s* \((\w+)\) \s* -> \s* (\w+) $/xo )
	{
	    $system->add_step_stmt(source => $1, rate => $2, sink => $3,
				   type => 'PROP');	
	}
	
	when ( /^ (\w+) \s* <- \s* \[(\w+)\] \s* (\w+) $/xo )
	{
	    $system->add_step_stmt(source => $3, flow => $2, sink => $1,
				   type => 'STRAIGHT');
	}
	
	when ( /^ (\w+) \s* \[(\w+)\] \s* <- \s* (\w+) $/xo )
	{
	    $system->add_step_stmt(source => $3, flow => $2, sink => $1, 
				   type => 'STRAIGHT');
	}
	
	when ( /^ (\w+) \s* <- \s* \((\w+)\) \s* (\w+) $/xo )
	{
	    $system->add_step_stmt(source => $3, flow => $2, sink => $1,
				   type => 'PROP');
	}
	
	when ( /^ (\w+) \s* \((\w+)\) \s* <- \s* (\w+) $/xo )
	{
	    $system->add_step_stmt(source => $3, flow => $2, sink => $1, 
				   type => 'PROP');
	}
	
	default
	{
	    die "Could not parse statement: $what\n";
	}
    }
}
