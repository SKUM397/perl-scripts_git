#!/usr/bin/perl

use strict;
use warnings;

my %grades = (
Vijay => 96,
Rahul => 63,
Smita => 87,
Pranav => 96,
Sachin=> 79,
);
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

my @food = ('Mango','Apple','Pumpkin');
my @morefood = ('Guava', @food);

print "\n" . @morefood;
print "\n" . $#morefood;

foreach ( @morefood ){
  print "  .. $_";
}

print "\n numbers function ......................\n";

sub numbers{
    return (1,3,5);
}

foreach (numbers()){

  print "\n\n \$_ is $_";
}

  print "\n\n";

for(0..5){
  print "\$_ is $_";
}

  print "\n\n";

#for (my $i = 0 ; $i < 10 ; $i++){
#for ( my $i = 0; $i < 5; $i++ ) {
#    print "  $_";
#}

foreach (@food , @morefood){
  print "$_ .. ";
}

  print "\n\n";

my @numbers = (1,3,5,7);
my $number = "Orginal value";
foreach $number (@numbers){
  print "Number is $number .. ";
}

print "\nDefererence a array of hashes ......................\n";

my @mascots = (
	{
		type => 'camel',
		name => 'Amelia',
	},
	{
		type => 'butterfly',
		name => 'Camelia',
	},
	{
		type  => 'go',
		name  => 'Go Gopher',
	},
	{
		type  => 'python',
		name  => 'Monty',
	},
	);


  foreach my $hash(@mascots){
      print "\n".$hash->{'name'};
  }

  #You are required to replace a char in a string and store the number of replacements. How would you do that?

  my $scalar = "APerlAReplAFunction";
  my $count = ($scalar =~ tr/A//);

  #my $count = $scalar;

  print "\n".$count;
  print "\n".$scalar;

@food = ('Meat','beans','eggs','oats','grape','orange','apple');
my @removeditems = splice(@food ,2,2,"Ora","ban" );
print "\n @removeditems";

print "\n";
print keys %grades;
print "\n";
print values %grades;
print "\n";

$a = defined $grades{'Rahul'} ? 'True' : 'False';
print "\n $a";

$a = exists $grades{'Pranav'} ? 'True' : 'False';
print "\n ";

#swap 2 nums without a third variable

$a = 10;
$b = 20;

($a, $b) = ($b, $a);
print "\n $a  $b  \n";


print "\n movie?\n";
#my $ip = <>;
my $ip = "yes";
chomp $ip;

if ($ip eq "yes"){
   print "\n okay we can go \n";
}


#wap for fiding if num is odd or not
 
print "\n enter a num";
my $num = 10;
#my $num = <>;
chomp $num;
my $count = 0;

while ($count < 10){
  if ($num % 2 != 0){
    print "$num is odd";
    $num++;
  }
  else{
    $num++;
  }
$count++;
}

#iterate through a hash

foreach my $keys (keys %grades){
  print "\n corresponding value of $keys is $grades{$keys}";
}


#wap to assign values to empty hash

my %hash = ();

my @arr = (1,2,3,1,3);

foreach my $element(@arr){
  $hash{$element} = 1;
}
print "\n";
print keys %hash;
print "\n";

foreach my $keys (%hash){
  print "\n value for $keys is $hash{$keys}";
}

#check if the passed parameter is array or scalar

my @a = testWA();
my $b = testWA();

print $b;
sub testWA(){
  print "\n hellow to want array\n";
 my @array = (1,2,3,4,5);
return @array if wantarray();
return "scalar expected";
}

#prototyping a subroutine i.e how many and whaat all paramters is required

sub add($$);

my $a = 10;
my $b = 20;
my $c = add($a,$b);
print "\n \$c value is $c \n";
sub add(){
  return ($_[0] + $_[1]);
}