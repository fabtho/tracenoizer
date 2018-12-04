#/usr/bin/perl -w
srand
killall_numberfolder();




sub killall_numberfolder{
    for (my $k =0 ;$k<  586;$k++){
	my $filename = "";
	my $language = "";
	my $antwort = "";
	print "---->and the folder is : $k\n";
	opendir(DIR, "$k") || print "can't opendir $k: $!";
	
	
	my $select = $dbh->prepare("select ac_id from accounts where ac_used = 0");
    $select->execute;
    my @ac_id = ();
    my $ac_id = $select->fetchrow_array;
    while ($ac_id != undef){	
  	push (@ac_id,$ac_id);
	$ac_id = $select->fetchrow_array;
    } 	
    
    
    my $randac = $ac_id[rand(@ac_id)];	
   #my $select = $dbh->prepare("select ac_ftp, ac_name, ac_pw, ac_id,ac_http from accounts where ac_id = '$randac'");
    #for_test
    my $select = $dbh->prepare("select ac_ftp, ac_name, ac_pw, ac_id,ac_http from accounts where ac_id = '1'");
    #	
    $select->execute;
    my ($ftphost,$username,$password,$ac_id,$ac_http,ac_path) = $select->fetchrow_array;
	
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
	
	
	
	
	
	while (defined(my $foldername = readdir(DIR))) {
	    $language = $foldername;
	    
	    
	    if ($foldername =~ /html/){
	    	
	    	
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
	$ftp->quit() or print "Couldn't quit";
	
	if ($fehler != undef){
	    print "fehler--$fehler-----------\n";  
	}	
	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	  #  	system "rm","-R","$k/$foldername" or print "konnte $k/$foldername loeschen \n";
	   	print $foldername."\n";
	#	print $foldername;  
	    }
	}
	
    }
}	


