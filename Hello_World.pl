#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use DateTime;
use DBI;
use Log::Log4perl;
use Data::Dumper;
use Getopt::Long qw(GetOptions);
use YAML::XS;
use YAML::AppConfig;
use File::Basename;
use File::Spec;
use DBD::SQLite;

#declare global variables\

use vars qw(
    $admin $name $roll @marks @subject %marks_at_subject $testpgm $account $dataDirectory $configDirectory $configFileName $logDirectory $logFileName $logFileName2 
    $yamlDetails $File1 $File2 $File3 $file1data $driver $dsn $userid $password $dbh $flag1
);

print "Beginning the program\n\n";
#subroutines to run
#dateTimeManipulation();
parse_cmd_line();
set_directory_path();
print_yaml_details();
create_directories_and_files();
copy_data_from_one_to_another();
connect_db();
query_TestDb();

open $File1, '+>>', $logFileName or die "cannot open log file";
print " \nEntered loop";
while (<$File1>){
    print "entering while loop file 1";
    #chomp ($_);
    my $file1info = $_;
    print "file info is $file1info";
    my @file1data = split('\|', $file1info);
    print "file first byte is" . $file1data[0];
        if($file1data[0] == 0 or $file1data ){
            my $str = InsertDB($file1info);
            #print $File1 $str;
        }
}
close $File1;



printmultiplelines();
#print "enter your name\n";
#$name = <STDIN>;
#chomp($name);
#print "welcome $name at my computer\n";
#print date

sub dateTimeManipulation{
    my $datetime = localtime();
    my $datetimemodule = DateTime->now(time_zone => 'local');

    print "$datetime\n\n";
    print "$datetimemodule\n\n";

    $datetime = DateTime->now();
    print $datetime -> strftime('%H-%Y') . "\n\n";
    print $datetime -> strftime('%H-%Y-%m-%d') . "\n\n";
}

sub parse_cmd_line{

    #removing as it is defined in global variable
    #my  $admin;  
    my $src_file = GetOptions( 'form=s' => \$admin );

    # if you want to declare any other scalars insde this sub routine then it should be declared as a global variable first
    ($account = "cb", $testpgm = "state");
    #print $admin . " and " . $src_file . "\n";

    if ($src_file){

        print "*************************************************************************\n";
        print "Parameters passed:\n";
        print "Parameter passed is              = $admin \n";
        print "Parameter present is     Account = ". $account."\n";
        print "                         Testpgm = ". $testpgm."\n";
        print "**************************************************************************\n";
    }
}

sub set_directory_path{

    my $dataDirectoryPrefix = 'C/'      ;
    my $dataDirectorySuffix = $account . '/' . $testpgm . '/' . $admin;
    my $filePrefix  = $account . '_' . $testpgm . '_' . $admin . '_';
    $dataDirectory = $dataDirectoryPrefix . '/data/' . $dataDirectorySuffix;
    $configDirectory = 'C:\Strawberry\perl scripts';
    $configFileName  = 'C:\Strawberry\perl scripts\cb_ss.yaml';
    $logDirectory   =  'C:\Strawberry\perl scripts\logs';
    $logFileName    =  $logDirectory.'\cb_inbound_logs.log';
    $logFileName2   =  $logDirectory.'\cb_inbound_logs_copy.log';
   #print "\n" . $dataDirectoryPrefix ;
   #print "\n" . $dataDirectorySuffix ;
   #print "\n" . $filePrefix ;
   #print "\n" . $dataDirectory ;
   #print "\n" . $configDirectory ;
   #print "\n" . $configFileName ;
   #print "\n" . $logDirectory ;
   #print "\n" . $logFileName . "\n";
}

sub print_yaml_details{
    $yamlDetails = YAML::AppConfig->new(file => $configFileName);
    print "\n\n*********************Fetching details from yaml file*******************\n\n";
    #print Dumper($yamlDetails);

    print $yamlDetails->get('emailName') . "\n";
    print $yamlDetails->get('emailAddress') . "\n";
    print $yamlDetails->get('credentials') . "\n";
    print "\n\n*******************************Complete********************************\n\n";

    #reading from a sequence
    my $firstEmail = $yamlDetails->get('emailAddress1')->{'first'};
    my $secondEmail = $yamlDetails->get('emailAddress1')->{'second'};
    my $thirdEmail = $yamlDetails->get('emailAddress1')->{'third'};

    #reading from a array of sequence
    my $username = $yamlDetails->get('credentials1')->{'UserNAme'};
    my $password = $yamlDetails->get('credentials1')->{'Password'};

   # print "\n" . $firstEmail ;
   # print "\n" . $secondEmail ;
   # print "\n" . $thirdEmail ;
   # print "\n" . $username ;
   # print "\n" . $password ;
}

sub create_directories_and_files{

    #create directory using mkdir function
    unless(-e $logDirectory){
        mkdir("$logDirectory") or die "Could not create ";
        print "\n\n************* Created directory**********";        
    }
    unless ( -e $logFileName){
        open $File1, '>>', $logFileName or die "Could not create or read file";
        print $File1 "First record in log file|hello/n";
        print "\nCreated file\n";
        close $File1;
    }
    #else{
        #open $File1, ">", $logFileName or die "could not open file";
    #    print "\nFile already exists\n";
        #close $File1;
    #}
    
    unless (-e $logFileName2){
        open $File2 , '>>' , $logFileName2 or die "cannot create or read second log file";
        print "Created second log file";
        close $File2;
    }

    open $File1, '>', $logFileName or die "Cannot open log file to write data";
    print $File1 "0|A|B|C|D|E|F|G|H|";
    close $File1
}

sub printmultiplelines{ print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";}


sub copy_data_from_one_to_another(){
    open $File1, '<', $logFileName or die "cannot open first log file to read";
    #single > clears and writes again. Double >> just appends
    open $File2, '>', $logFileName2 or die "cannot open second log file to write";
     print "Files opened";
    while(<$File1>){
        chomp($_);
        print "entering while loop";
        print $_;
        my $file1info = $_;
        my @file1data = split('\|', $file1info);
            foreach $file1data(@file1data){
                print $file1data;
                print $File2 $file1data."|";
            }
    }

    close $File1;
    close $File2;
}

sub connect_db{

    $driver = "SQLite";


    #$dsn = "DBI:SQLite:dbname=MyTestDb.db";
    $dsn = "DBI:SQLite:dbname=MyTestDb.db";
    $userid = "";
    $password = "";

    $dbh = DBI->connect($dsn,$userid,$password, { RaiseError => 1, AutoCommit => 0 }) or die "\ncannot connect to db\n";
    print "\n".$dbh;
    print "\nconnected to db";
}

sub query_TestDb{
    my $ReadDB = "Select EmployeeId, LastName from Employee";
    my $TestDbsql = "SELECT name FROM sqlite_schema WHERE type = 'table' AND name NOT LIKE 'sqlite_%'";
    my $InsertDB = "INSERT into Employee e ([EmployeeId], [LastName], [FirstName], [Title], [BirthDate], [HireDate], [Address], [City], [State], [Country], [PostalCode], [Phone], [Fax], [Email]) VALUES (15, 'Eve', 'Andrew', 'General Manager', '1962-02-18 00:00:00', '2002-08-14 00:00:00', '11120 Jasper Ave NW', 'Edmonton', 'AB', 'Canada', 'T5K 2N1', '+1 (780) 428-9482', '+1 (780) 428-3457', 'evechinookcorp.com');";

    my $sth = $dbh->prepare($ReadDB);
    $sth->execute() or die DBI::errstr;
    #$sth->fetchall_arrayref();
    $sth->fetchrow_array();
    #print "\nentering while loop";
    while(my @row = $sth->fetchrow_array()){
        #print "\nin while loop";
        my ($rowdat, $rowdata) = @row;
        print "\n  $rowdat  $rowdata  ";
    }
    #print $sth->rows;

    $sth->finish();
}

sub InsertDB{
    print "\n entering insert db";
    my $str = shift;
    my $InsertDB = "INSERT into Employee ([EmployeeId], [LastName], [FirstName], [Title], [BirthDate], [HireDate], [Address], [City], [State], [Country], [PostalCode], [Phone], [Fax], [Email]) VALUES (9, 'Eve', 'Andrew', 'General Manager', '1962-02-18 00:00:00', '2002-08-14 00:00:00', '11120 Jasper Ave NW', 'Edmonton', 'AB', 'Canada', 'T5K 2N1', '+1 (780) 428-9482', '+1 (780) 428-3457', 'evechinookcorp.com')";
    my $sth = $dbh->prepare($InsertDB);
    $sth->execute() or die DBI::errstr;
    $sth->finish();
    $dbh->commit or die DBI::errstr;
    #$flag1 = 1;
    print "\ninserting";
    #open $File1,'+>>', $logFileName or die "Replacing 0 to 1";
    #while(<str>){
    #    chomp ($_);
    #    my $file1info = $_;
    #    print "\nfile info is". $file1info ."\n";
    #    $file1info =~ s/0/1/;
    print "\n string is : ".$str."\n";
    $str =~ s/0/1/;
    #return $str;
    }
   # close $File1;
#}