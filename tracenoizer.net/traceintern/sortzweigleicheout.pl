#/usr/bin/perl	


#nimmt text a, wenn ein wert zweimal vorkommt, so fällt er raus

open (FILE,"<keyword3.txt") || print "konnet  $filenumber/txt nicht anlegen";
$en = "";

open (OUT,">zustop.txt");

while  (<FILE>){
    chomp($_);
    if (index ($_,"-") != -1){
	$_ =~ s/-//;
	$_en = "-";
	print $_;
    } else {
	$_en = "";
	
    }
    
    
    if ($alt eq $alt2 or $_ eq $alt){
	
	
    } else {
	print OUT  $alt.$en."\n";
	
    }
    
    $alt2 = $alt;
    $en2 = $en;
    
    $en= $_en;
    $alt = $_;
    
}

close (FILE);


