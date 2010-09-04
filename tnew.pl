#!/usr/local/bin/perl
#
# An ambitious project (so far unnamed) to create a general-purpose dynamic 
# systems simulation package using Perl and PDL, with the object of simulating
# the Biome-BGC model and its successors.
# 


use strict;
use warnings;
use Data::Dumper;

use madgrammar;

my ($outputname);

$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 1;

my $parser = madgrammar->new();
$parser->init_parser();

# take the input from the command line arguments
# or from STDIN

if ( @ARGV > 0 ) {
    $parser->use_input($ARGV[0]);
    ($outputname = $ARGV[0]) =~ s/.mad$//;
    $outputname .= ".output";
}
else {
    $parser->use_input();
}

# parse the input and get the AST

my $tree = $parser->YYParse();

if ( defined $tree ) {

    open OF, ">$outputname" or warn "Could not write output file: $!\n";
    print OF Dumper($tree);
    close OF;

    print $tree->str(), "\n";
}
