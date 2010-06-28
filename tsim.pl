#!/usr/bin/perl
#
# An ambitious project (so far unnamed) to create a general-purpose dynamic 
# systems simulation package using Perl and PDL.
# 
# 


use strict;
use Getopt::Std;


use Simulator;

our(%opts);

# Process options

getopts('v:o:', %opts);

# Create simulator and load the model

my $sim = new Simulator;

while (<>)
{
    $sim->load(stmt => $_);
}

$sim->trace(vars => 'all');
$sim->init();
$sim->run(limit => 50);

$sim->write_data(file => \*STDOUT);


