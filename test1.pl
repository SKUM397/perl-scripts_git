  use strict;
  use warnings;
  use diagnostics;

  use Log::Log4perl;
  use File::Basename;
  use File::Spec;
  use DBI;
  use DBD::SQLite;
  

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


#delete 

my %hash = (foo => 11, bar => 22, baz => 33, stop => 44);
my $scalar = delete $hash{foo};
print "\n $scalar";

$scalar = delete @hash{qw(foo bar)};
print "\n $scalar";

#my @arr = delete @hash{qw(foo bar)};
#print "\n" . join($",@arr);

#if you want to delete everything from a hash or arrray then use foreach loop.

my %hash = (foo => 11, bar => 22, baz => 33, stop => 44);
my @str = ("RED","GREEN","BLUE","YELLOW","GREEN","ORANGE","RED","PINK");

foreach my $i (keys %hash){
  delete $hash{$i};
}

foreach my $i (0.. $#str){
  delete $arr[$i];
}

print "\n" . join($",@arr);

#or we can use 

#delete @hash[keys %hash];
#delete @arr[0..$#arr];

#or the fastest way to do it is to undefine it or assign it empty.

undef %hash;
%hash = ();

undef @arr;
@arr = ();

#rename a file

rename ($logfilename, 'C:\Strawberry\perl-scripts_git\logs\log_for_squares_renamed.log') or die "cannot rename file";


system ("cd ..");
system ("dir");

my $PATH = "This is shell var";

system ("echo $PATH");

#connect to db and fetch data and store in hash

my $dsn = "DBI:SQLite:dbname=MyTestDb.db";
my $userid = "";
my $password = "";

my $dbh = DBI->connect($dsn,$userid,$password,{AutoCommit => 0, RaiseError => 1}) or die "\n cannot connect to db" . DBI->errstr();

my $query = "Select EmployeeId, LastName from Employee;";
my ($id, $name);
my %nameIdHash = ();
my $sth = $dbh->prepare($query);
$sth->execute() or die DBI::errstr;
$sth->fetchrow_array();

while( my @row = $sth->fetchrow_array()){
  ($id, $name) = @row;
  print "\n Id for $name = $id";
  $nameIdHash{$id} = $name;
  #push %hash, $id => $name;
}
#$dbh->disconnect();

foreach my $keys (keys %nameIdHash){
  print "\n" . $keys . " is the key for " . $nameIdHash{$keys};
}

my $scal = %nameIdHash;
print "\n\n\nhash size = ".$scal;

#my @idList = ();
#my @nameList = ();
#while(my @row = $sth->fetchrow_array()){
#  ($id, $name) = @row;
#  push @idList, $id;
#  push @nameList, $name;
#}
#
#my %nameIdHash = map{$_ => @nameList} @idList;
#
#foreach my $keys (%nameIdHash){
#  print "\n" . $keys . " is the key for " . $nameIdHash{$keys};
#}
#
#my $scal = %nameIdHash;
#print "\n\n\nhash size = ".$scal;

$dbh->disconnect();



#remove duplicates from the following list

 my @arr = (1,2,3,4,5,1,4);
 my %seen = ();
 my @uniq ;

 @uniq = grep { ! $seen{$_}++   }@arr;
  print "\n\n\n" ;
foreach my $keys (sort keys %seen){
  print "\n" . $keys . " is the key for " . $seen{$keys};
}

#swap 2 numbers

my $a = 10;
my $b = 20;

($a, $b) = ($b, $a);

print "\n  $a , $b";

#print all environment variables

#foreach (sort keys %ENV) { 
#  print "$_  =  $ENV{$_}\n"; 
#}

#print all strings

my @list = ("foo",10,0,"bar",20);

my @has_list = grep { /\s+/ } @list;

print "\n\n\n". join($", @has_list);

#print all integers

my @list = ("foo",10,0,"bar",20);

@list = grep {/\d/} @list;

print "\n\n\n". join($", @list);

#hash in list context

my @list_context = %seen;
sort @list_context;
print "\n\n". join($" , @list_context);


my ($value) = @list_context;
print "\n" . $value;

my $value = @list_context;
print "\n" . $value;


#print all availabel data base driver names.

my @avl_driver = DBI->available_drivers;
print "\n available drivers " . join ( $" , @avl_driver);