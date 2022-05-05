#!/usr/bin/perl

use strict;
use warnings;

my @array1 = (2,3,4,5,3,4,6,7,7,2, "key", "horse", "kite");


my @A = grep(/^k/ ,@array1);

print "@A";
print "\n" . scalar @A . "\n";

#my $key;

foreach my $key (sort  (keys %ENV)          ){

    print $key = $ENV{$key};


}
