#/usr/bin/perl

use Mail::Mailer;
use Net::FTP;
use DBI;
connect_db();
ftpup();

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}






sub ftpup{    

 
    my $select = $dbh->prepare("select main_id,main_weblink from main where main_weblink like 'http://www.nun.ch/%'");
    $select->execute; 
                            
 
    for (my $k = 0;$k < 100; $k++){    
	
	
	my ($main_id,$main_weblink)= $select->fetchrow_array;
	
	print $main_weblink."----$main_id--------old\n";  

#	$main_weblink =~ s/clone\/clone/clone/;
	$main_weblink =~ s/ch\//ch\/clone\//;  

	unless  ($main_weblink  = /clone\/clone/){     
	print $main_weblink."---new\n";
	
#		my $select = $dbh->prepare("update main set main_weblink = '$main_weblink' where main_id = '$main_id'");
#	$select->execute;  
	
}	
    }		
}



