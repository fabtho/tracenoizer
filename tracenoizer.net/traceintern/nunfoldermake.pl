#/usr/bin/perl

use Net::FTP;

ftpup();


sub ftpup{    
    my ($ftphost,$username,$password,$ac_path) = ("www.nun.ch","nun.ch","dsa","html/clone");
    $hostinformation = "ac_ftp, ac_name, ac_pw,ac_id,ac_http,ac_path = $ftphost,$username,$password,$ac_id,$ac_http,$ac_path";
    print $hostinformation."\n";
    
    my $ftp = Net::FTP->new($ftphost,
			    Timeout => 30,
			    Debug => 1 ) or my $fehler = 1;
    if ($fehler == undef){   
	$ftp->login($username, $password) or my $fehler = 2;
    }
    
    
    
    $ftp->cwd($ac_path) or my $fehler = 3;    
    
    
    for (my $k = 0;$k < 651; $k++){   
	
	
	$ftp->mkdir("$k", 1) or print "fehler = 4";
	
    }
}


