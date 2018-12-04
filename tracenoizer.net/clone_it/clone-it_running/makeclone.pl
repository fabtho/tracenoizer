#!/usr/bin/perl
use DBI;

connect_db();
accountest();                

$main_generation = $ARGV[0];
#$new_main_id = new_main();

generation_loop();


sub connect_db{
    my $server = "localhost";
    my $db = "ies";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'ies','iespass');
    if (not $dbh){
	print "no connection to the db";
    }
}

sub accountest{    
    my $select = $dbh->prepare("select ac_id from accounts where ac_used != 1");
    $select->execute;
    my $ac_id = $select->fetchrow_array;                        
    if ($ac_id == undef){
	print "no accunts anymore\n";	
	exit;
    }
}

sub generation_loop{

    print "select main_id,main_usr_id from main where main_generation = '$main_generation'\n"; 
    my $abfrage= $dbh->prepare("select main_id,main_usr_id from main where main_generation = '$main_generation' and main_st_id != 9");
    $abfrage->execute;
    my $main_id = 0;
    my $main_usr_id = "";
    while (1){     
	@result  = $abfrage->fetchrow_array;
	$main_id = $result[0];
	$main_usr_id  = $result[1];
	print "--$main_id--";
	if ($main_id == undef){last;} 
	main_entry($main_usr_id);         
	my $new_main_id = new_main();
	print "/usr/bin/perl klon_central.pl $main_id $new_main_id $main_usr_id\n";  
	system "/usr/bin/perl klon_central.pl $main_id $new_main_id $main_usr_id";
	my $new_main_generation = $main_generation + 100; 
	my $update= $dbh->prepare("update main set main_generation= $new_main_generation where main_id = $main_id");
	$update->execute;       
    }
} 



################################### main_entry() #######################
 
sub main_entry{
    my $main_usr_id = $_[0];
    my $new_main_generation = $main_generation + 1;

    print "insert into main(main_date,main_usr_id,main_generation) values (CURRENT_DATE(),'$main_usr_id','$new_main_generation')\n";    
    my $insert= $dbh->prepare("insert into main(main_date,main_usr_id,main_generation) values (CURRENT_DATE(),'$main_usr_id','$new_main_generation')");
    $insert->execute;
 
}
        

##################################### new_main() ######################


sub new_main{
    my $abfrage= $dbh->prepare("select max(main_id) from main");
    $abfrage->execute;
    my $new_main_id = $abfrage->fetchrow_array;
 print "new_main_id$new_main_id \n"; 
    return ($new_main_id);
}
    









