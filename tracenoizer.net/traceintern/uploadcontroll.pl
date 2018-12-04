#/usr/bin/perl


use Net::FTP;
use DBI;
connect_db();
html_get();

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}

sub html_get{    
    my $select = $dbh->prepare("select main_id,main_weblink from main");
    $select->execute;
    
    for (my $k = 0;$k < 700; $k++){ 
	
	print "$main_id";
	my ($main_id,$main_weblink)= $select->fetchrow_array;  
	
        system "/usr/local/bin/puf -Tl 2 -Td 2 -Tc 2 -lb 200000 -nw -t 2  -P test2 $main_weblink";    	
	open (FILE,"<test2/index.html");

	my $inhalt = "";

	while (<FILE>){
	    $inhalt = $inhalt . $_;  
	}
#	print $inhalt;
	unless ($inhalt =~ /A.nav:link/ ){ 
	    print "weblink $main_weblink von $main_id  not found\n";   

	    my $select = $dbh->prepare("update main set main_st_id = 9  where main_id = '$main_id'");
            $select->execute;  


	} else {	 
	
	    my $select = $dbh->prepare("update main set main_st_id = 7  where main_id = '$main_id'");
	    $select->execute;
	}
	system "rm test2/index.html";
    }  
    
}




