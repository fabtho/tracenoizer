

#/usr/bin/perl -w

killall_numberfolder();




sub killall_numberfolder{
    for (my $k =0 ;$k<  586;$k++){
	my $filename = "";
	my $language = "";
	my $antwort = "";
	print "---->and the folder is : $k\n";
	opendir(DIR, "$k") || print "can't opendir $k: $!";
	
	while (defined(my $foldername = readdir(DIR))) {
	    $language = $foldername;
	    
	    
	    if ($foldername =~ /\d/){
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	  system "rm","-R","$k/$foldername" or print "konnte $k/$foldername loeschen \n";
	  # 	print $foldername."\n";
	#	print $foldername;  
	    }
	}
	
    }
}	


