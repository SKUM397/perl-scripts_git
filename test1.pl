  use strict;
  use warnings;
  use diagnostics;

  use Log::Log4perl;
  use File::Basename;
  use File::Spec;
  

my $logFileHandle;


 my @arr = (1,2,3,4,5,1,4);

#transiterator operator
#replaces characters in a bunch

my $c = "aaaabbdddccaa";
$c =~ tr/ab/df/s;
print $c;

my $str = "There are proper XML handling libraries for Perl,There are proper XML handling libraries for PERL,
here are proper XmL handling libraries for PerL.There are proper xml handling libraries for Perl.";


$str =~ s/XML/Excel/s;
#$str =~ tr/perl/python/s;
print "\n". $str . "\n";

#convert below sentence to "The big bad wolf jumped over the lazy dog"
my $sentence = "The quick brown fox jumped over the lazy dog";
my $sub = "quick.*?fox";
$sentence =~ s/quick brown fox/big brown fox/g;

print "\n" . $sentence . "\n";


#reverse a list 

my @list = ("fruit" , "Vegetable" , "banana", "apple");
print join($" ,reverse @list);
print "\n\n";
print scalar reverse join($" , @list);

#create  a log file

my $logfilepath = 'C:\Strawberry\perl-scripts_git\logs';
my $logfilename = $logfilepath.'\log_for_squares.log';

open $logFileHandle, '+>', $logfilename or die "cannot create file";

#using a map function
# create squares of numbers and write to log_for_squares.log file.

my @numbers = (1..10);

my @squares = map{$_ * $_} @numbers;
#print "\n" . join($" , @squares);
print $logFileHandle join($", @squares);


my @squares = map{($_ % 2 == 0) ? $_ : () } @numbers;
print $logFileHandle "\n";
print  $logFileHandle join($", @squares);

close $logFileHandle;


#use grep to find all comments

my @arr = ( "Here are Perl's function",
"hings that look like functions, ",
" keywords and named ope",
"#arranged by category. Some",
"#ctions appear in more than one "
);

my @list1 = grep {!/^#/} @arr;

print "\n" . join($",@list1);


#split a sentence on a pattern

#this is wrong as we split and then join
my $str = "Red Green Blue YELLOW GREEN ORANGE RED PINK";
my @str = split(" ", "RED\tGREEN\tBLUE");
print "\n". join($" , @str);

#this works as we split on comma
my $str = "RED,GREEN,BLUE,YELLOW,GREEN,ORANGE,RED,PINK";
my @str = split(/,/, $str, 5);
foreach my $i (@str){
  print "\n".$i;

}
print "\n" . scalar @str; 


#works as we split on \d+
my $str = 'Geeks1for2GeeksGeeka Geeks';
my @spl = split(/\d+/, $str);
foreach my $i (@spl) 
{
    print "$i\n";
}