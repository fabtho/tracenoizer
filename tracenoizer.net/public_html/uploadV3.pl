#/usr/bin/perl

use Mail::Mailer;
use POSIX;
use Net::FTP;
use DBI;
srand;

close STDOUT;
close STDERR;
close STDIN;
#fork() && exit 0;
#system "echo uploadstart > uploadstart.txt";

$usr_id = $ARGV[0];
$main_id = $ARGV[1];


connect_db();
word();
fileup();
makestartindex();
#ftpup();
print "cloning start";
#system "/usr/bin/perl /home/tracenoizer/traceintern/klonschub.pl &";
clearmake();


#########################db connect #######################################################################
##macht verbindung zu db auf
##global $dbh
##



sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
	print "----> no connection to the db";
    }
    print LOG "----> connection to db $db established \n";
}



#########################sub statussetz() ###########################################################
# andert die feld status in der db
#mit statussetz($main_id,"nolink");

sub statussetz{
    my $status = $_[0];
    my $insert= $dbh->prepare("update main set main_st_id = '$status' where main_id = $main_id");
    $insert->execute;
    my $select = $dbh->prepare("select st_string from status where st_id = $status");
    $select->execute;
    my $st_string = $select->fetchrow_array;
    print "\n----> status from process $main_id set to $st_string \n\n";
	}
sub word{
 	$abfrage= $dbh->prepare("select keyword from keyword where keyword_main_id = $main_id");
 	$abfrage->execute;    
    for (my $k=0;$k < 10;$k++) {
	my $keywort = $abfrage->fetchrow_array;
	push (@word,$keywort);
	print $keywort."\n";
	}
}
	

sub fileup{
        system ("cp -r temp/$main_id ../public_html_freepages/");
	$ac_http = "http://www.freepages.ath.cx/$main_id/index.html";
	my $update = $dbh->prepare("update main set main_ac_id=1, main_weblink='$ac_http' where main_id ='$main_id'");	
	$update->execute;
	statussetz(7);
}	
	


sub ftpup{	

	#NICHT MEHR GUELTIG
  
    statussetz(6);
    while (1){
	my $select = $dbh->prepare("select ac_id from accounts where ac_used != 1");
	$select->execute;
	
	my $ac_id = $select->fetchrow_array;
	
	if ($ac_id == undef){
	print "----> alle acounts weg\n";
	#mailsend($ac_http," alle tracenoizeracounts sind weg. der tracenoizer verliert damit die funktionstŠtigkeit");
	exit;
	}

	my $fehler = 0;
	my $select = $dbh->prepare("select ac_ftp, ac_name, ac_pw, ac_id,ac_http,ac_path from accounts where ac_id = '$ac_id'");
	
	$select->execute;
	my ($ftphost,$username,$password,$ac_id,$ac_http,$ac_path) = $select->fetchrow_array;
	#my $ftp = Net::FTP->new($ftphost,
	#			Timeout => 30,
	#			Debug => 1 ) or $fehler = 1;
	if ($fehler == 0){   
	#    $ftp->login($username, $password) or $fehler = 2;
	}
	if ($fehler == 0){
	    if ($ac_path ne "."){
	#	$ftp->cwd($ac_path) or $fehler = 3;    
	    }                
	}  
	if ($fehler == 0){
	    #$ftp->mkdir($main_id, 1) or $fehler = 4;
	}
	if ($fehler == 0){
	   # $ftp->cwd($main_id)  or $fehler = 5; 
	}	
	if ($fehler != 0){
		exit;
	    my $update = $dbh->prepare("update accounts set ac_used = ac_used + 2 where ac_id = $ac_id");
            $update->execute;
            my $select = $dbh->prepare("select ac_used from accounts where ac_id = $ac_id");
            $select->execute;
            my $ac_used = $select->fetchrow_array;
            if ($ac_used > 30){
              #  my $update = $dbh->prepare("update accounts set ac_used = 1 where ac_id = $ac_id");
              #  $update->execute;
		#		mailsend($ac_http," dieser account:  $ac_id ist voll");
                 print "----> ERROR problem with  uploading to $ftphost \n";
                 
                # system "echo $fehler >> xxx.txt";
		redo;            
	    }                                                                            
	}
	push (@word,"index");
	foreach(@word){
	    my $filename = $_.".html";
	    if ($fehler == 0){
		#$ftp->put("temp/$main_id/$filename") or $fehler = 6;      
	    }
	}
	#$ftp->quit() or print "Couldn't quit";
	if ($fehler != 0){
	    exit;
		pop (@word);
            my $update = $dbh->prepare("update accounts set ac_used = ac_used + 2 where ac_id = $ac_id");
            $update->execute;
            my $select = $dbh->prepare("select ac_used from accounts where ac_id = $ac_id");
            $select->execute;
            my $ac_used = $select->fetchrow_array;
            if ($ac_used > 30){
                #my $update = $dbh->prepare("update accounts set ac_used = 1 where ac_id = $ac_id");
                #$update->execute;        
	    	}
	    #mailsend($ac_http,"dieser account uploadV3:  $ac_id ist voll");
	    print "----> ERROR problem with  uploading to $ftphost \n";
	    system "echo $fehler >> xxx.txt";
	    redo;
	} else {               
	#  makestartindex($ac_http);

	print "----> the site has been uploaded to $ac_http\n";
	    #print "update main set main_ac_id = '$ac_id',main_weblink = '$ac_http' where main_id = '$main_id'";
	    my $update = $dbh->prepare("update main set main_ac_id = 1,main_weblink = 'http:/www.freepages.ath.cx' where main_id ='$main_id'");
	    $update->execute;
	 #$ftp->cdup()  or print "Couldn't change into ueberordner von testordner directory\n";
         #$ftp->delete("index.html")  or print "Couldn't delete index\n";
       	 #$ftp->put("hauptindex/index.html") or  print "Couldn't upload index.html \n";
	 		mailsend($ac_http,$ac_http);
	    last;
	}
    }
}


sub makestartindex{
        open    (INDEX,"<../public_html_freepages/index.html");
        my $index = ();
        $i = 1;
        while(<INDEX>){
        	$index = $index.$_;
        if ($i==2){
        	$index = $index.'<a href="http://www.freepages.ath.cx/'.$main_id.'/index.html">Freepage '.$main_id.'</a><br>'."\n";
        print $index;
	}
	#print $i."\n";
        $i++;
       }
	close (INDEX);
        open    (INDEX,">../public_html_freepages/index.html");

      # print $index;
        print INDEX $index;
        close (INDEX2);
 }


sub makestartindexalt{
 my $ac_http = $_[0];
        my $select = $dbh->prepare("select main_weblink from main where main_weblink like '$ac_http%'");
        $select->execute;
        my $main_weblink = $select->fetchrow_array;
        my @weblink =();
        push (@weblink,$main_weblink);
        while (length($main_weblink) > 1){
        $main_weblink = $select->fetchrow_array;
        push (@weblink,$main_weblink);
        }
	my $ac_indexfile = "<html><head><meta name=\"robots\" content=\"index,follow\">";
	$ac_indexfile = $ac_indexfile ."<meta name=\"Date_modified\" content=\"2002-04-13\">\n";
	$ac_indexfile = $ac_indexfile ."</head><body>\n";
	 for(@weblink){
		$ac_indexfile = $ac_indexfile . "<a href=\"$_\">$_</a><br>"."\n";
 	}
	$ac_indexfile = $ac_indexfile . "</body></html>";
        open    (INDEX,">hauptindex/index.html");
	print INDEX $ac_indexfile;
	close (INDEX);   
 }
 
 
 sub clearmake{

	statussetz (7);
   #// system "rm","-R","model";
    #//system "rm","-R","$main_id";
     #my $delete = $dbh->prepare("delete from globalurl");
	 #$update->$delete;   
    print "----> clean up and successfuly finito\n";
}



sub mailsend {
    my $subject = $_[0];
    my $body = $_[1];
    $from_address = "tracenoizer\@tracenoizer.org";
    $to_address  = "martin\@krungkuene.org";
    #$to_address  = "tracenoizer\@www2.snm-hgkz.ch";
    $mailer = Mail::Mailer->new("sendmail");
    $mailer->open({ From    => $from_address,
                   To      => $to_address,
                   Subject => $subject
                   })
        or die "Can't open: $!\n";
    print $mailer $body;
    $mailer->close();
}
