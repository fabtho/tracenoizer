#/usr/bin/perl


# sucht alle  leeren datebankeeintrage und ermittelt deren $main löscht dann die 
# main mit perl clean_db_tracenoizer_main_id.pl $main_id
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


$select = $dbh->prepare("select main_id from main where isnull(main_weblink)");
$select->execute;

$main_id  = $select->fetchrow_array;

  while ($main_id  != undef){	
  	push (@main_id,$main_id );
	$main_id= $select->fetchrow_array;
    } 

foreach (@main_id){
system "perl clean_db_tracenoizer_main_id.pl $_";

}
