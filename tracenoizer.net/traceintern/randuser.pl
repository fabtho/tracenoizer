#/usr/bin/perl -w



use DBI;
srand;




connect_db();
randuser();

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}


sub randuser{    
    my $select = $dbh->prepare("select usr_id from users where char_length(usr_name) < 18");
    $select->execute;
    my @usr_id = ();
    my $usr_id = $select->fetchrow_array;
    while ($usr_id != undef){	
  	push (@usr_id,$usr_id);
	$usr_id = $select->fetchrow_array;
    } 
    
    for (my $i=0 ;$i < 250;$i++){
	my $rand_usr = $usr_id[rand(@usr_id)];
	print $rand_usr."\n";
	my $select = $dbh->prepare("update main set main_generation = 1 where main_usr_id = $rand_usr");
	$select->execute;    
    }
}

