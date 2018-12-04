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
}
 
        
sub clean{    
    my $select = $dbh->prepare("delete from globalurl");
    $select->execute;
	 
   
}

