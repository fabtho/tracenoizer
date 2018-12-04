#/usr/bin/perl

use Mail::Mailer;
use Net::FTP;
use DBI;
connect_db();
keywordout();

sub connect_db{
    my $server = "www2.snm-hgkz.ch";
    my $db = "ies";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'ies','iespass');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}



sub keywordout{    
    my $select = $dbh->prepare("select keyword from keyword");
    $select->execute;
    my $keyword = $select->fetchrow_array;
 
    print $keyword."\n";   

    while (1 ){
	$keyword = $select->fetchrow_array;
	print $keyword."\n";
    }
}




