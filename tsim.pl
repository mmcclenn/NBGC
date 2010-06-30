#!/usr/bin/perl
#
# An ambitious project (so far unnamed) to create a general-purpose dynamic 
# systems simulation package using Perl and PDL.
# 
# 


use strict;
use warnings;
use Getopt::Std;

use NBGC::Simulator;
use Graphics::PLplot;

our(%opts);

# Process options

getopts('v:o:', %opts);

# Create simulator and load the model

my $sim = new NBGC::Simulator;

while (<>)
{
    $sim->load(stmt => $_);
}

$sim->trace(vars => 'all');
$sim->init();
$sim->run(limit => 50);

#$sim->dump_trace(file => \*STDOUT);

my (@t) = $sim->get_values('T');
my ($tmin, $tmax) = $sim->minmax_values(@t);
my (@values);
my (@colors) = (1, 3, 9, 13, 8);
my $textcoord = 9;

plsdev ("aqt");
plinit ();
plscolbg (255, 255, 255);
plenv ($tmin, $tmax, 0, 100, 0, 2);

foreach my $var (sort $sim->trace_vars()) {
    @values = $sim->get_values($var);
    plcol0 (shift @colors);
    plline(\@t, \@values);
    my ($varname) = $var; $varname =~ s/^\$//;
    plptex(5, ($textcoord-- * 10) + 5, 1, 0, 0, $varname);
}

plend ();

