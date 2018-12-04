#/usr/bin/perl -w

#######################################################
###		trace_central.pl								###
###		founded 100405	12.30  fabian 				###
###		last modified 100405	12.30  fabian 		###
#######################################################
use Net::FTP;
use DBI;
use WWW::Search;
srand;
use Time::localtime;

connect_db();
holleer();

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}



sub holleer{
    my $select = $dbh->prepare("select main_id from main where main_st_id = 9");
    $select->execute;
    $main_id = $select->fetchrow_array;
    while  ($main_id != undef) {
	@word = ();
	opendir(DIR, "$main_id") || print "can't opendir $main_id: $!";
	while (defined(my $foldername = readdir(DIR))) {
	    $language = $foldername;
	    if ($foldername =~ /html/){
		push (@word,$foldername);  
		print $foldername."\n";	
	    }
	}
	ftpup();

	$main_id = $select->fetchrow_array;   
    }
}




sub ftpup{    
 
    my $select = $dbh->prepare("select ac_id from accounts where ac_used = 0");
    $select->execute;
    my @ac_id = ();
    my $ac_id = $select->fetchrow_array;
    while ($ac_id != undef){	
  	push (@ac_id,$ac_id);
	$ac_id = $select->fetchrow_array;
    } 
    
    while (1){
	my $fehler = 0;
	my $randac = $ac_id[rand(@ac_id)]+1; 	
	my $select = $dbh->prepare("select ac_ftp, ac_name, ac_pw, ac_id,ac_http,ac_path from accounts where ac_id = '$randac'");
	#for_test
	#my $select = $dbh->prepare("select ac_ftp, ac_name, ac_pw, ac_id,ac_http,ac_path from accounts where ac_id = '1'");
	#
	$select->execute;
	my ($ftphost,$username,$password,$ac_id,$ac_http,$ac_path) = $select->fetchrow_array;
	my $ftp = Net::FTP->new($ftphost,
				Timeout => 30,
				Debug => 1 ) or $fehler = 1;
	if ($fehler == 0){   
	    $ftp->login($username, $password) or $fehler = 2;
	}
	if ($fehler == 0){
	    if ($ac_path ne "."){
		$ftp->cwd($ac_path) or $fehler = 3;    
	    }                
	}  
	if ($fehler == 0){
	    $ftp->mkdir($main_id, 1) or $fehler = 4;
	}
	if ($fehler == 0){
	    $ftp->cwd($main_id)  or $fehler = 5; 
	}	
	if ($fehler != 0){
	    redo;
	}
	
	foreach(@word){
	  
	    if ($fehler == 0){
		$ftp->put("/home/tracenoizer/traceintern/art/$main_id/$_") or $fehler = 6;      
	    }
	}
	$ftp->quit() or print "Couldn't quit";
	if ($fehler != 0){
	    redo;
	} else {               
	    $ac_http = $ac_http."/$main_id/index.html";
	    print "update main set main_ac_id = '$ac_id',main_weblink = '$ac_http' where main_id = '$main_id'";
	    my $update = $dbh->prepare("update main set main_ac_id = '$ac_id',main_weblink = '$ac_http' where main_id = '$main_id'");
	    $update->execute;       
	    last;
	}
    }
    my $select = $dbh->prepare("update main set main_st_id = 7 where main_id = $main_id");
    $select->execute;       
}









