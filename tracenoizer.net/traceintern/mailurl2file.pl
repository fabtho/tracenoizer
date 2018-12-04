#/usr/bin/perl

use Mail::Mailer;
use Net::FTP;
use DBI;
connect_db();
keywordout();

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}



sub keywordout{    
    my $select = $dbh->prepare("select m_string from  mailurl");
    $select->execute;
    my $keyword = $select->fetchrow_array;
 
    print $keyword."\n";   

    while (1 ){
	$keyword = $select->fetchrow_array;
	print $keyword."\n";
    }
}




