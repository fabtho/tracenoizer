#/usr/bin/perl

use DBI;

connect_db();

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'root','gifa767');
    if (not $dbh){
        print "no connection to the db";
    }
}      


$usr_id = $ARGV[0];




$select = $dbh->prepare("select main_id from main where main_usr_id = $usr_id");
$select->execute;
$main_id  = $select->fetchrow_array;

$delete= $dbh->prepare("delete from users where usr_id = $usr_id");
$delete->execute;


$delete= $dbh->prepare("delete from main where main_id = $main_id");
$delete->execute;



$delete= $dbh->prepare("delete from input where in_main_id = $main_id");
$delete->execute;

$delete= $dbh->prepare("delete from keyword where keyword_main_id = $main_id");
$delete->execute;


$select = $dbh->prepare("select url_id from url where url_main_id = $main_id");
$select->execute;

$url_id  = $select->fetchrow_array;

  while ($url_id  != undef){	
  	push (@url_id,$url_id );
	$url_id= $select->fetchrow_array;
    } 

foreach (@url_id){
$delete= $dbh->prepare("delete from image where img_url_id = $_");
$delete->execute;
$delete= $dbh->prepare("delete from globalurl where g_url_id = $_");
$delete->execute;
$delete= $dbh->prepare("delete from mailurl where m_url_id = $_");
$delete->execute;
}


$delete= $dbh->prepare("delete from url where url_main_id = $main_id");
$delete->execute;


$select = $dbh->prepare("select tx_id from text where tx_main_id = $main_id");
$select->execute;

$tx_id  = $select->fetchrow_array;

  while ($tx_id  != undef){	
  	push (@tx_id,$tx_id );
	$tx_id= $select->fetchrow_array;
    } 

foreach (@tx_id){
$delete= $dbh->prepare("delete from wordcount where wordcount_tx_id = $_");
$delete->execute;

}


$delete= $dbh->prepare("delete from text where tx_main_id = $main_id");
$delete->execute;
