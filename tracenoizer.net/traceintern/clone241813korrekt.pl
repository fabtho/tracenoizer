#/usr/bin/perl

use Mail::Mailer;
use Net::FTP;
use DBI;
connect_db();
ftpup();

sub connect_db{
    my $server = "www2.snm-hgkz.ch";
    my $db = "ies";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'ies','iespass');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}






sub ftpup{    

    my $select = $dbh->prepare("select main_id,main_weblink from main where main_weblink like 'http://www.geocities.com/clone241913%'");
    $select->execute; 
    for (my $k = 0;$k < 300; $k++){    
	my ($main_id,$main_weblink)= $select->fetchrow_array;
	print $main_weblink."----$main_id--------old\n";  
#	$main_weblink =~ s/clone\/clone/clone/;
	$main_weblink =~ s/241913/242913/;  
#	unless  ($main_weblink  = /clone\/clone/){     
	print $main_weblink."---new\n";
	my $select = $dbh->prepare("update main set main_weblink = '$main_weblink' where main_id = '$main_id'");
	$select->execute;  
	
#}	
    }		
}



