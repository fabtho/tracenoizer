#/usr/bin/perl -w


use DBI;

connect_db();

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}

open (FILE,"<name400_2.txt");


while (<FILE>){ 
print $_;
chomp($_);
chop($_);
   print "---->insert into users (usr_name,usr_pw) values ('$_','traci')";
    my $insert= $dbh->prepare("insert into users (usr_name,usr_pw) values ('$_','traci')");
    $insert->execute;
    
    my $select= $dbh->prepare("select usr_id from users where usr_name='$_'");
    $select->execute;
 	my $usr_id = $select->fetchrow_array;
   
   $insert= $dbh->prepare("insert into main (main_date,main_usr_id,main_generation)values(CURRENT_DATE(),'$usr_id',1)");
   $insert->execute;
    
	$select= $dbh->prepare("select max(main_id) from main");
    $select->execute;
    my $max_main_id = $select->fetchrow_array;
    
    #system "perl forward.pl $max_main_id '$_'";  
    system "perl artclone_central.pl $max_main_id '$_'";
    
   
}
