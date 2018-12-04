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
    my $select = $dbh->prepare("select ac_id from accounts");
    $select->execute;
    my @ac_id = ();
    my $ac_id = $select->fetchrow_array;
    while ($ac_id != undef){	
  	push (@ac_id,$ac_id);
	$ac_id = $select->fetchrow_array;
    } 
    for (my $k = 0;$k < @ac_id; $k++){  
    
    
    #for (my $k = 0;$k < 1; $k++){  
	my $ac_id =  $k+1;
   	my $select = $dbh->prepare("select ac_ftp, ac_name, ac_pw, ac_id,ac_http,ac_path from accounts where ac_id = '$ac_id'");
	$select->execute;
	my ($ftphost,$username,$password,$ac_id,$ac_http,$ac_path) = $select->fetchrow_array;
	$hostinformation = "ac_ftp, ac_name, ac_pw,ac_id,ac_http,ac_path = $ftphost,$username,$password,$ac_id,$ac_http,$ac_path";
	print $hostinformation."\n"; 
	my $ftp = Net::FTP->new($ftphost,
				Timeout => 30,
				Debug => 1 ) or my $fehler = 1;
	if ($fehler == undef){   
	    $ftp->login($username, $password) or my $fehler = 2;
	}
	
	if ($fehler == undef){
	    if ($ac_path ne "."){
		$ftp->cwd($ac_path) or my $fehler = 3;    
            }                
        }  
	if ($fehler == undef){
	    $ftp->mkdir("testordner", 1) or my $fehler = 4;
	}
	if ($fehler == undef){
	    $ftp->cwd("testordner")  or my $fehler = 5; 
 	}	
	if ($fehler == undef){
	    $ftp->put("test.html") or my $fehler = 6;   
	}	
	if ($fehler == undef){
	    $ftp->delete("test.html") or print "Couldn't delete test.html";
	}
	if ($fehler == undef){
	    $ftp->cdup() or print "Couldn't change into ueberordner von testordner directory\n";
	}	
	if ($fehler == undef){
	    $ftp->rmdir("testordner") or print "Couldn't delete testordern";  
        }
	
	if ($fehler == undef){
	    $ftp->quit() or print "Couldn't delete testordern";
        }           
	
	
	if ($fehler != undef){
	    print "fehler--$fehler-----------\n";  
	}	
    }
}

#mailsend($hostinformation);       


sub mailsend {
    my $errormessage = $_[0];    
    print $errormessage;
    $from_address = "fab\@krungkuen.org";
    $to_address  = "fabtho\@gmx.net";
    print "the to_address  = $to_address \n"; 
    $subject = "error in ftp from tracenoizer engine";
    $body = "das ist die fehlermeldung";
    $body = $body ."$errormessage";
    $mailer = Mail::Mailer->new("sendmail");
    $mailer->open({ From    => $from_address,
		   To      => $to_address,
		   Subject => $subject
		   })
	or die "Can't open: $!\n";

    print $mailer $body;
    $mailer->close();
    print "$maile mailing from message $body to $to_address seceed \n" ;  
}

