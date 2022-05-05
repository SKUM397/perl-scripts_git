#!/usr/bin/perl

use strict;
use warnings;

#my %grades = (
#Vijay => 96,
#Rahul => 63,
#Smita => 87,
#Pranav => 96,
#Sachin=> 79,
#);
#
#
#
##my @keys_1 = keys %grades;
#my @values_1 = values %grades;
#
##print "@values_1";
#sort @values_1;
#print "@values_1";


#y $str = "There are proper XML handling libraries for Perl,There are proper XML handling libraries for PERL,
#here are proper XmL handling libraries for PerL.There are proper xml handling libraries for Perl.";
#
#
#str =~ s/xml/excel/g;
#str =~ s/perl/python/g;
#
#rint "$str";


my $sum = add(5,3);
print "$sum";

sub add{
 my $a = $_[0];
  my $b = $_[1];

my $c = $a + $b;
return $c;

}

