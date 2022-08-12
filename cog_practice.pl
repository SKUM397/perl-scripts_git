#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

print "Hello world";

#iterate over a loop 
my @arr = (11,22,33,44,55,66);
my $len_arr = @arr;
my $a;

print "Length of array is $len_arr \n";

for (my $b = 0; $b < $len_arr ; $b++){

  print "\@arr[$b] = $arr[$b]\n";
}

foreach $a (@arr) {
  print "$a\n";
}

#Initialize hashes

my %Fruit_hash;

$Fruit_hash{Mango} = 10;
$Fruit_hash{Orange} = 20;
$Fruit_hash{Grape} = 30;


my %Fruit2 = ('mango' => 20 , 'Grape' => 40 , 'Orange' => 60, 'Pumpkin' => 80);
my %hash = (foo => 11, bar => 22, baz => 33, stop => 44);

#print Dumper(%Fruit_hash);
print "\n";
print "\%Fruit_hash{Mango} " . $Fruit_hash{Mango};

foreach my $j (keys %hash){

  print "\n$hash{$j}";
}

#delete element from hash
  print "\n\n";
delete $hash{foo};
foreach my $j (keys %hash){

  print "$hash{$j}";
}
print "\n Get keys and values in diff arrray\n";
my @keys_arr = keys %hash;
my @values_arr = values %hash;

print Dumper (@keys_arr);
print Dumper (@values_arr);
print "\n\n";

my %hash1 = ('MyVehicle' => 'Car', 
            'Model' => 1234, 
            'Speed' => 60.7, 
              
            # value type hash
            'Traffic' => {'Red' => 'Stop',             
                          'Yellow' => 'Look and move', 
                          'Green' => 'Go'},
                            
            # value type array
            'AllVehicles' => ['Car', 'Cycle', 
                              'Bus', 'Auto']);


#get all keys of hash
@keys_arr = keys %hash1;
print join(", ", @keys_arr);

#accessing individual vlaues of the keys
print "\n Yellow traffic light mean $hash1{Traffic}{Yellow}";
print "\n $hash1{AllVehicles}[3] is a tye of vehicle";

my %company = ('Sales' =>    {
                                'Brown' => 'Manager',
                                'Smith' => 'Salesman',
                                'Albert' => 'Salesman', 
                            }, 
            'Marketing' =>  {
                                'Penfold' => 'Designer',
                                'Evans' => 'Tea-person',
                                'Jurgens' => 'Manager', 
                            },
            'Production' => {
                                'Cotton' => 'Paste-up',
                                'Ridgeway' => 'Manager',
                                'Web' => 'Developer', 
                            },
            ); 
