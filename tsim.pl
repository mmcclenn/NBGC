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


my $sim = TSIM->new('simvar');

while (<>)
{
    $sim->load($_);
}


my $a = 0;



