#!/usr/local/bin/perl
#
# An ambitious project (so far unnamed) to create a general-purpose dynamic 
# systems simulation package using Perl and PDL, with the object of simulating
# the Biome-BGC model and its successors.
# 


use strict;
use warnings;
use Getopt::Std;
use Graphics::PLplot;

use NBGC::Model;
use NBGC::Simulator;

our($opt_D, $opt_i, $opt_s, $opt_l, $opt_p, $opt_V, $opt_P, $opt_t);

# Start by processing options.

getopts('Di:s:l:pV:P:t');
our($DEBUG_LEVEL) = 0;

# If -D is specified, print debugging messages.

$DEBUG_LEVEL = 1 if defined $opt_D;

# The options -s and -l and -i specify the starting time, ending time and time
# increment respectively.  If these are not specified, the corresponding
# values default to: 0, 50, 1.

my $start = 0;
my $limit = 50;
my $increment = 1;

if ( defined $opt_s && ($opt_s+0) >= 0 ) {
    $start = $opt_s + 0;
}

if ( defined $opt_l && ($opt_l+0) > 0 ) {
    $limit = $opt_l + 0;
}

if ( defined $opt_i && ($opt_i+0) > 0 ) {
    $increment = $opt_i + 0;
}


# Now, we actually start the work of this program.  Create a new model and
# initialize it using the remaining arguments.

my $model = new NBGC::Model;

while (<>)
{
    $model->load(stmt => $_);
}


# Create a new simulator and initialize it using the model.  If -p was
# specified, use the PDL version.  

my $sim;

if ( defined $opt_p && $opt_p ) {
    require("NBGC/PDL.pm");
    $sim = new NBGC::Simulator::PDL($model, $increment, $DEBUG_LEVEL);
}

else {
    $sim = new NBGC::Simulator($model, $increment, $DEBUG_LEVEL);
}


# Next, check for initial values of model variables.  If -V was specified, it
# should be followed by a series of 'var=value' expressions separated by
# commas.  Split this string up and use each one to set the initial value of
# one variable.

if ( defined $opt_V ) {
    my @ivs = split(/,/, $opt_V);
    foreach my $iv (@ivs) {
	if ( $iv =~ /^(\w+)=(.*)$/ ) {
	    $sim->initial_value($1, $2);
	}
    }
}


# Now we can run the model.

$sim->run(start => $start, limit => $limit);


# After the run completes, if -t was specified, output a quick trace of the
# variables over the course of the model run.

if ( defined $opt_t && $opt_t ) {
    $sim->dump_trace(file => \*STDOUT);
}


# If -P was specified, plot the indicated variables.

if ( defined $opt_P ) {

    if ( uc $opt_P eq 'ALL' ) {
	$sim->plot( $sim->variables() );
    }
    
    else {
	$sim->plot( split(/,/, $opt_P) );
    }
    
}
