#/usr/bin/perl -w

#######################################################
###		trace_central.pl								###
###		founded 100405	12.30  fabian 				###
###		last modified 100405	12.30  fabian 		###
#######################################################
use Net::FTP;
use DBI;
use WWW::Search;
srand;
use Time::localtime;



#######################funktioncall##########################
#
# global $filenumber

connect_db();

$filenumber = 0;

# $ARGV[0] = $main_id, $ARCV[1]= $searchterm


onesearch($ARGV[0],$ARGV[1]);


get_files();

url_loop();
makemodel();
modelask();
word_count();
search_stats();
all_page();
ftpup();
clearmake();




#########################db connect #######################################################################
##macht verbindung zu db auf
##global $dbh
##



sub connect_db{
    my $server = "www.clone-it.org";
    my $db = "ies";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'ies','iespass');
    if (not $dbh){
	print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}



#########################sub statussetz() ###########################################################
# andert die feld status in der db
#mit statussetz($main_id,"nolink");

sub statussetz{
    my $status = $_[0];
    my $insert= $dbh->prepare("update main set main_st_id = '$status' where main_id = $main_id");
    $insert->execute;
    print "---->status from $main_id set to $status \n";
}


######################### sub onesearch() ###############################################################
#startet die suche über einen namen der den status name hat, dh 
#in der db ist nur der name
#global $main_id

sub onesearch{
    $main_id = $_[0];
    my $searchterm = $_[1];

    my $input = $dbh->prepare("insert into input (in_main_id,in_keyword) values ($main_id,'$searchterm')");
    $input->execute;
    print "----> insert into input (in_main_id,in_keyword) values ($main_id,$searchterm) \n";

    #print "---->the ID = $main_id and person $name_vorname \n";
     	statussetz(0);
	search($searchterm);
}


#########################sub search #########################################################################
#die form des aufrufes muss die folgende sein
#perl search.pl sprache "searchterm"
#es gibt de,en,fr,it
#


sub search{
    @URL = ();
    my $searchterm = $_[0];
    my @searchterm= split(/ /,$searchterm);
 
    my $searchmachine = onelanguage("al");
    my $k = linkload($searchmachine,$searchterm,"al");
 
    $searchterm = $searchterm[1]." ".$searchterm[0];
 
    $k = $k + linkload($searchmachine,$searchterm,"al");
    print "---->  $k urls found and put into downloadlist \n";
    if ($k == 0) {
	print "---->  $k urls found no further processes\n";
        statussetz(9);
        exit;
    }
}
 


#########################sub onelanguage()#######################
# liefert die name der searchmachine zurueck
 
sub onelanguage{
    my $language = $_[0];
    my $searchmachine = "";
    if ($language eq "de") {
        $searchmachine = "AltaVistaDe";
    } elsif ($language eq "fr"){
        $searchmachine = "AltaVistaFr";
    }elsif ($language eq "en"){
        $searchmachine = "AltaVistaEn";
    }elsif ($language eq "it"){
        $searchmachine = "AltaVistaIt";
    } elsif ($language eq "al"){
        $searchmachine = "Google";
    }
    return($searchmachine);
}



#########################sub linkload()#######################
# sucht links und speichert sie in url.txt
sub linkload{
    my $searchmachine= $_[0];
    my $searchterm= "\"".$_[1]."\"";
    my $language= $_[2];   
    my $Search = new WWW::Search("$searchmachine");
    my $Query = WWW::Search::escape_query("$searchterm");
    print "---->this is the actual searchterm : $searchterm\n";
    print "---->and the language is : $language\n";
    
    $Search->native_query($Query);
    my $k = 0;	
    
    while (my $Result = $Search->next_result())
    {
	my $url = $Result->url;
	push (@URL,"$language$url");          
	$k++;
	
	if ($k == 50){
		last;
	}
    }
    print "---->in this part $k urls found \n";

    return($k);
    
}


	

#########################get_files() #######################################################################
#### hollt die files und lad sie in ordner $main_id/$k/$language/titel zb 129/1/en/index.html



sub get_files{
	statussetz(1);	
    mkdir($main_id,0777) || print "konnte dir $main_id nicht machen";
    for (my $k=0 ;$k< @URL;$k++){
	my $language = substr($URL[$k],0,2);
	my $url = substr($URL[$k],2,);
	print "---->this is the actual url : $url\n";
	system ("mkdir $main_id/$k");
	system ("mkdir $main_id/$k/$language");
	system ("chmod 777 $main_id/$k");
	system ("chmod 777 $main_id/$k/$language");
	if ((@URL - 10) < $k){
	    system "/usr/local/bin/puf -Tl 2 -Td 4 -Tc 4 -lb 200000 -nw -t 3  -P $main_id/$k/$language  $url ";
	} else {
	    system "/usr/local/bin/puf -Tl 2 -Td 4 -Tc 4 -lb 200000 -nw -t 3  -P $main_id/$k/$language  $url &";
	}
    }
}



#########################url_loop() #######################################################################
#macht fur jede url_id eine schleife, holt text aus der db
#macht extraxtion wenn die seite text enthalt


sub url_loop{
	statussetz(2);
    my $folder = biggestsdir();
    print $folder;
    chdir("$main_id/");
    
    for (my $k =0 ;$k<  $folder;$k++){
		my $filename = "";
		my $language = "";
		my $antwort = "";
		print "---->and the folder is : $k\n";
		opendir(DIR, "$k") || print "can't opendir $k: $!";
	
		while (defined(my $foldername = readdir(DIR))) {
	    	$language = $foldername;
	    }
		closedir(DIR);
		opendir(DIR, "$k/$language") || print "can't opendir $language: $!";
		while (defined(my $file = readdir(DIR))) {
		    $filename = $file;
		}
		closedir(DIR);
		if ($filename ne ".."){
		    my $html;
		    print "---->and the language is : $language\n";
		    print "---->and the filename is : $filename\n";
		    open (FILE,"<$k/$language/$filename") || print "die Datei $k/$filename nicht gefunden\n";
		    while (<FILE>){
			$html = $html.$_;
		    }
		    close (FILE);
		    # print $html;
		    system "rm","-Rf","$k", "&";
		    my @existurl = satz_extract($html,$language,$k);		    
		    if  ($existurl[0] != 0){
			look_img($html,$existurl[0],$existurl[1]);
			look_global($html,$existurl[0]);
			look_mail($html,$existurl[0]);
			}
		}else{
		    print "---->folder ist empty\n";
		    system "rm","-Rf","$k", "&";
  	 	}
	    }		
    chdir("..");
    @URL = ();
}

#########################sub biggestsdir()#######################

sub biggestsdir{
    my $folder = "";
    opendir(DIR, "$main_id") || print "can't opendir $main_id: $!";
    while (defined(my $foldername = readdir(DIR))) {
	$folder = $foldername;
    }  
    print "---->folderzahl $folder\n";
    return($folder);
}


# sucht die bilder die gr–sser als 100 * 100 raus und macht deren pfad absolut
sub look_img{
    my $text = $_[0];
    my $url_id = $_[1];
    my $base_url = $_[2];
    my @srcs =  $text =~ /(img.+src.*\=\"{1}[^\"]+\"{1}.*?)>{1}/ig;
    foreach (@srcs){
	print $_."-------------limglink\n";
	my $heightsrc= $_ =~/(height\=\"?\d{3}\"?)/i;
	my $height = $1;
	my $widthsrc= $_ =~  /(width\=\"?\d{3}\"?)/i;
	my $width = $1;
	my $nursrc=  $_ =~ /src\=\"([^\"]*)\"/i;
	my $src= $1;
	if ($heightsrc == 1 and $widthsrc == 1 and $nursrc == 1 and length($src) > 3){
	    my $img_link = localurl2globurl($src,$base_url);
	    my $img_tag = "<img ". $height ." ". $width." src=\"".$img_link."\">";
	    my $insert= $dbh->prepare("insert into image (img_link,img_url_id,img_used) values ('$img_tag','$url_id',0)");
	    $insert->execute;
	 #   print "----> insert $img_tag mit $url_id \n";
	}	
    }
}

sub localurl2globurl{
    my $src = $_[0];
    my $base_url = $_[1];
    if ($src =~ /^(http:\/\/)/){
	return ($src);
    }	
    $base_url =~ /(.*\/)/;
    $base_url = $1;
    my $join =$base_url.$src;
    #   print  "/usr/local/bin/puf -Tl 2 -Td 4 -Tc 4 -lb 400000 -nw -t 3  -P /home/martin/trace/bilder/$main_id  $join"; 
#	 system "/usr/local/bin/puf -Tl 4 -Td 8 -Tc 8 -lb 500000 -nw -t 3  -P /home/tracenoizer/traceintern/bilder/$main_id  $join &";
    return ($base_url.$src);
}

sub look_mail{
    my $text = $_[0];
    my $url_id = $_[1];
    my @mails =  $text =~ /\"{1}mailto:(\w+\@{1}\w+\.{1}\w+)\"/ig;
     foreach (@mails){
	my $insert= $dbh->prepare("insert into mailurl (m_url_id,m_string) values ('$url_id','$_')");
	$insert->execute;
    }
}

sub look_global{
    my $text = $_[0];
    my $url_id = $_[1];
    my @urls =  $text =~ /HREF=\"(http:\/\/www[^\"\']*)\"/ig;
    foreach (@urls){
	my $insert= $dbh->prepare("insert into globalurl (g_url_id,g_string,g_used) values ('$url_id','$_',0)");
	$insert->execute;
	#print $_."\n";
 }
}






#########################satz_extract()#######################
# sucht aus dem text satze raus


sub satz_extract{
    print "---->satzextract start\n";
    my $text= $_[0];
    my $language = $_[1];
    my $urlindex = $_[2];
    my $eintext = "";
    my $url;
    #kickt html -- alle zeichen nach < gefolgt von bliebigen zeichen . 0 oder mehr mal * bis zum zeichen > und der kleinste treffer ? mit // ersetzen
    $text=~ s/<[^>]*>//gs;
    # weg mit den sonderzeichen
    $text=~ s/\&aelig\;/ae/g;
    $text=~ s/&auml\;/ae/g;
    $text=~ s/&ouml\;/oe/g;
    $text=~ s/&uuml\;/ue/g;
    $text=~ s/\&AElig\;/Ae/g;
    $text=~ s/&Auml\;/Ae/g;
    $text=~ s/&Uuml\;/Ue/g;
    $text=~ s/&Ouml\;/Oe/g;
    #fasst mehere leerschlaege zu einem zusammen - eins oder mehrer + withspaces \s mit / / ersetzen
    $text=~ s/\s+/ /g;
    my @satze = split(/[\.|!|\?]/,$text);
    foreach (@satze){	
	if (/[^A-Za-z_|^\'|^\s|^\-|^\;|^\"|^\d|^\,|^\(|^\)]/){
	} elsif (length($_)>50){
	    #ersetze ' durch * damit in die db geschrieben werden kann, da sonst mysql-perl error
	    $_ =~ s/\'/\*/g;
	    my $count = 0;
	    $count++ while $_ =~ /,/g;
	    if ($count <= 3) {
		$eintext = $eintext.$_."\. ";
	    }
	}	
    }
    if (length($eintext) > 30){
    $eintext=~ s/\s+/ /g;
	$url = substr($URL[$urlindex],2,);
	print "---->text into db mit $url \n";
	my $insert = $dbh->prepare("insert into url (url_main_id,url)values('$main_id','$url')");
	$insert->execute;
	my $tx_url_id= maxask("url");
	$insert= $dbh->prepare("insert into text(tx_main_id,tx_text,tx_lang,tx_url_id) values('$main_id','$eintext','$language','$tx_url_id') ");
	$insert->execute;
	out2folder($eintext);
	return($tx_url_id,$url);
    } else {
	print "---->no sentenc in this file \n";
	return 0;
    }
}


########################sub maxask()#######################

sub maxask{
    my $table = $_[0];
    if ($table eq "url"){
	my $abfrage= $dbh->prepare("select max(url_id) from url");
	$abfrage->execute;
	my $result = $abfrage->fetchrow_array;
	return($result);
    } elsif ($table eq "text"){
	my $abfrage= $dbh->prepare("select max(tx_id) from text");
	$abfrage->execute;
	my $result = $abfrage->fetchrow_array;
	return($result);
    } elsif ($table eq "main"){
	my $abfrage= $dbh->prepare("select max(main_id) from main");
	$abfrage->execute;
	my $result = $abfrage->fetchrow_array;
	return($result);
    }	
}

	


########################sub out2folder()#######################

sub out2folder{
    print "---->text to folder \n";
    my $eintext = $_[0];
    my @zeile = ();
    
    if ($filenumber == 0){
   		$filenumber = maxask("text");
   		   
    print "---->db askd \n";
   	}
    system ("mkdir $filenumber");
	system ("chmod 777 $filenumber");
	open (FILE,">$filenumber/txt") || print "konnet  $filenumber/txt nicht anlegen";
	 print "---->several sentences in this file  $filenumber/txt\n";
	#print $eintext;
	print FILE $eintext;
	close (FILE);
	 $filenumber++;
}


#########################makemodel() #######################################################################
# macht mit rainbow ein model über den ordner $main_id

sub makemodel{
 statussetz(3);
    print "/usr/local/bin/rainbow --append-stoplist-file=/home/tracenoizer/traceintern/stoplist -H -d model -i $main_id/*";
    `/usr/local/bin/rainbow --append-stoplist-file=/home/tracenoizer/traceintern/stoplist -H -d model -i $main_id/*`;
    
    print "finemodel";
  
}

#########################modelask() #######################################################################

sub modelask{
    @word = ();
    my @infogain = ();
    $infogain = `/usr/local/bin/rainbow -d  model -I 10`;
    print $infogain."\n";
   
    $infogain=~ s/\s+/ /g;
    $infogain=~ s/ //;
    @infogain = split(/ /,$infogain);
    for (my $i=0 ;$i < @infogain;$i++){
	if ($i % 2){
	    push (@word,$infogain[$i]);
	} else {
	    push (@infog,$infogain[$i]);
	}
    }
    #foreach (@infog){print $_."\n";}
    #foreach (@word){print $_."\n";}
    for (my $i=0 ;$i < @word;$i++){
	my $input = $dbh->prepare("insert into keyword (keyword_main_id, keyword, keyword_infog,keyword_size) values ('$main_id','$word[$i]','$infog[$i]','0')");
	$input->execute;
    }
}


########################################wordcount
sub word_count{
    @wordcount = ();
    for (my $i=0 ;$i < @word;$i++){
	$wordcount[$i]=`/usr/local/bin/rainbow -d model --print-word-counts=$word[$i]`;
	print  "---".$wordcount[$i]."---\n";
    }
}


#############################################verarbeiten#von#wordcount


sub search_stats{
    for (my $i=0 ;$i < @wordcount;$i++){
	@wordcountline=split(/\n/,$wordcount[$i]);
	for (my $r=0 ;$r < @wordcountline;$r++){
	    $wordcountline[$r] =~ s/[^0-9\.]/ /g;
	    $wordcountline[$r] =~ s/\s+/ /g;
	    $wordcountline[$r] =~ s/\s+//;
	    @wordcountstat =split(/ /,$wordcountline[$r]);
	    foreach (@wordcountstat){print "----->$_\n";}
	    my $select = $dbh->prepare("select keyword_id from keyword where keyword_main_id='$main_id' and keyword='$word[$i]'");
	    $select->execute;
	    $keyword_id=$select->fetchrow;
	    my $input = $dbh->prepare("insert into wordcount  (wordcount_tx_id, wordcount_keyword_id, wordcount_infog) 
values ('$wordcountstat[3]', '$keyword_id', '$wordcountstat[2]')");
	    $input->execute;
	    $input = $dbh->prepare("update keyword set keyword_size = keyword_size + '$wordcountstat[1]' where keyword_id = $keyword_id ");
	    $input->execute;
	}
    }
}



#########################################################################################################################makepage()################


sub all_page{
    my $abfrage= $dbh->prepare("select in_keyword from input where in_main_id = '$main_id'");
    $abfrage->execute;
    my $suchwort = $abfrage->fetchrow_array;
    my $abfrage2= $dbh->prepare("select keyword_id from keyword where keyword_main_id = '$main_id' and keyword='$word[0]'");
    $abfrage2->execute;
    my $keyword_id = $abfrage2->fetchrow_array;
    foreach(@infog){print $_."\n";}
    $normal =  abs($infog[0] - $infog[@infog-1]);
	print $normal."--------$keyword_id  $infog[0]--- $infog[@infog-1]----------";
    foreach(@normal){print $_."\n";}
      start_page($suchwort);

    for (my $i= 0;$i < @word;$i++) {
	my $keyword = $word[$i];
	my $keyword_infog = $infog[$i]; 
	$ranthema = $word[rand(@word)];
	on_page($keyword_id,$word[$i],$infog[$i],$suchwort,$ranthema); 
	$keyword_id++;
    }
}


sub start_page{
	statussetz(5);
    my @allthemas = @word;
    my $suchwort = $_[0];
    my $image = "";
    $seite = "<html><head><title>$suchwort</title>\n";
    $seite = $seite."<meta http-equiv=\"Content-Type\" content=\"text/html\">\n";  
    $seite = $seite."<meta http-equiv=\"Copyright\" content=\"".$suchwort.$allthemas[rand(@allthemas)]."\">\n";
    $seite = $seite."<meta http-equiv=\"Author\" name=\"$suchwort\" content=\"".$allthemas[rand(@allthemas)]."\">\n";
    $seite = $seite."<meta name=\"Language\" content=\"de-en\">\n";
    $seite = $seite."<meta name=\"Keywords\" lang=\"de\" content=\"$allthemas[0], $allthemas[1], $allthemas[2], $allthemas[3], $allthemas[4]. 
    $allthemas[5]\, $allthemas[6], $allthemas[7], $allthemas[8], $allthemas[9]\">\n";
    $seite = $seite."<meta name=\"Keywords\" lang=\"en\" content=\"$allthemas[0], $allthemas[1], $allthemas[2], $allthemas[3], $allthemas[4]. 
    $allthemas[5]\, $allthemas[6], $allthemas[7], $allthemas[8], $allthemas[9]\">\n";
    $seite = $seite."<meta name=\"Description\" lang=\"en\" \"content=\"".$allthemas[rand(@allthemas)]."\">\n";
    $seite = $seite."<meta name=\"Revisit-after\" content=\"1 month\">\n";
    ($day,$month,$year) = (localtime)[3,4,5];
    $month = $month +1;
    $year =  $year + 1900;
    $seite = $seite."<meta name=\"Date_modified\" content=\"$year-$month-$day\">\n";
    $seite = $seite."<meta name=\"ROBOTS\" content=\"index,follow\">\n";
    $seite = $seite."</head>\n"; 

    $seite = $seite."<style type=\"text/css\"> 
	A.nav:link {TEXT-DECORATION: none}
	A.nav:visited {TEXT-DECORATION: none} 
	A.nav:visited {TEXT-DECORATION: none}
	A.nav:active {TEXT-DECORATION: none}
	A.nav:hover {TEXT-DECORATION: none}
	</style><body bgcolor=\"#FFFFF\">
	<div align=\"center\">
	<font face=\"arial\" size=\"3\" color=\"#000000\">
	<font size=\"6\">";
    my @anrede = ("<br>HELLO dear surfer<br>I am $suchwort and this is my page<br>","<br>Welcome to $suchwort\'s Homepage<br>",
		  "<br>Homepage of $suchwort<br>","<br>Hi, thank you for visiting my Site<br>$suchwort Home<br>");
    $seite = $seite.$anrede[int(rand(@anrede))]."</font>";
    my $image = get_image($allthemas[rand(4)]);
    if ($image ne "0"){
	$seite = $seite."<br><br><br><div align=\"center\">$image</div><br>";
    }
    $seite = $seite. "<br> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"> <tr>
	<td colspan=\"10\" align=\"center\">";
    ### clspan muss anzahl endg¸ltige seine sein.
    @anrede = ();
    @anrede = ("I am intrested in:","This site is about:",
	       "My pages:","Have a look at:");
    
    $seite = $seite.$anrede[int(rand(@anrede))];
    $seite = $seite."<br><br></td></tr><tr>";
    $seite = $seite."<td aligne=\"center\"><a href=\"$allthemas[0].html\" class=\"nav\">$allthemas[0]</a></td>
	<td aligne=\"center\"><a href=\"$allthemas[1].html\" class=\"nav\">$allthemas[1]</a></td>
	<td aligne=\"center\"><a href=\"$allthemas[2].html\" class=\"nav\">$allthemas[2]</a></td>
	<td aligne=\"center\"><a href=\"$allthemas[3].html\" class=\"nav\">$allthemas[3]</a></td>
	<td aligne=\"center\"><a href=\"$allthemas[4].html\" class=\"nav\">$allthemas[4]</a></td>
	</tr>
	<tr>
	<td aligne=\"center\"><a href=\"$allthemas[5].html\" class=\"nav\">$allthemas[5]</a></td>
	<td aligne=\"center\"><a href=\"$allthemas[6].html\" class=\"nav\">$allthemas[6]</a></td>
	<td aligne=\"center\"><a href=\"$allthemas[7].html\" class=\"nav\">$allthemas[7]</a></td>
	<td aligne=\"center\"><a href=\"$allthemas[8].html\" class=\"nav\">$allthemas[8]</a></td>
	<td aligne=\"center\"><a href=\"$allthemas[9].html\" class=\"nav\">$allthemas[9]</a></td></tr></table>";
    $seite = $seite."</body></html>";
	my $update = $dbh->prepare("update main set main_html = '$seite' where main_id = '$main_id' ");
	$update->execute;
 open (FILE,">$main_id/index.html");
    print FILE $seite;
    close FILE;
}


sub on_page{
    my $keyword_id = $_[0];
    my $keyword = $_[1];
    my $keyword_infog = $_[2];
    my $suchwort = $_[3];
    my $ranthema = $_[4];
    my $n = 4;
    my $seite = ""; 
    my @satze= ();
    my @tx_lang = ();   
   
    my $max_id = maxask("main");
	my $randmax = int(rand($max_id));
    print "select main_weblink from main where main_id = $randmax";
    my $abfrage= $dbh->prepare("select main_weblink from main where main_id = '$randmax'");
    $abfrage->execute;
    my $main_weblink= $abfrage->fetchrow_array;
    
    print "select wordcount_tx_id from wordcount where wordcount_keyword_id = '$keyword_id' order by wordcount_infog desc limit $n\n";
    $abfrage= $dbh->prepare("select wordcount_tx_id from wordcount where wordcount_keyword_id = '$keyword_id' order by wordcount_infog desc limit $n");
    $abfrage->execute;
    
    for (my $k=0;$k < $n;$k++) {
	my $tx_id = $abfrage->fetchrow_array;
	#print "tx_id $tx_id\n";
	unless ($tx_id){
	    last;
	}
	my @temp=satzgenerator($tx_id,$keyword);
	$satze[$k] = $temp[0];
	$tx_lang[$k] = $temp[1];
	#print $satze[$k];
    }
    $seite = "<html><head><title>$suchwort $keyword</title>\n";
    $seite = $seite."<meta http-equiv=\"Content-Type\" content=\"text/html\">\n";
    $seite = $seite."<meta http-equiv=\"Author\" name=\"$suchwort\" content=\"$keyword\">\n";
    $seite = $seite."<meta http-equiv=\"Author\" name=\"$keyword\" content=\"$ranthema\">\n";
    $seite = $seite."<meta name=\"Language\" content=\"de-en\">\n";
    $seite = $seite."<meta name=\"Keywords\" lang=\"de\" content=\"$keyword, $suchwort, $ranthema\">\n";
    $seite = $seite."<meta name=\"Keywords\" lang=\"en\" content=\"$suchwort, $keyword, , $ranthema\">\n";
    my  $random = rand(@satze);
    $seite = $seite."<meta name=\"Description\" lang=\"". $tx_lang[$random] ." \"content=\"".$satze[$random]."\">\n";
    $seite = $seite."<meta name=\"Revisit-after\" content=\"1 month\">\n";
    ($day,$month,$year) = (localtime)[3,4,5];
    $month = $month +1;
    $year =  $year + 1900;
    $seite = $seite."<meta name=\"Date_modified\" content=\"$year-$month-$day\">\n";
    $seite = $seite."<meta name=\"ROBOTS\" content=\"index,follow\">\n";
    $seite = $seite."</head>\n"; 
    $seite = $seite."<style type=\"text/css\"> 
	A.nav:link {TEXT-DECORATION: none}
	A.nav:visited {TEXT-DECORATION: none} 
	A.nav:visited {TEXT-DECORATION: none}
	A.nav:active {TEXT-DECORATION: none}
	A.nav:hover {TEXT-DECORATION: none}
	</style><body bgcolor=\"#FFFFF\">
	<font face=\"arial\" size=\"3\" color=\"#000000\">
	<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">
	<tr><td><a href=\"".$ranthema.".html\" class=\"nav\">$ranthema</a></td></tr>
	<tr><td><a href=\"index.html\" class=\"nav\">home page</a></td></tr></table>
	<br><div align=\"center\"><font size=\"6\">- $keyword -<br><br></font></div>\n";
    my @position =  ("top","center","bottom");
    for (my $s = 0;$s < @satze; $s++){
	my $image = "0";
	if (int(rand(2)) == 1){
	print "billlllllllllllLLLLLLLLLLLLLLLLLLLLLLLLLLDDDDDDDDDDDDDDD\n";
	    $image = get_image($keyword);
	    print "billlllll---$image---LLLLLLLLLLLLLLLLLLLLLDDDDDDDDDDDDDDD\n";
	}
	if (int(rand(2)) == 1){
	    $seite = $seite."<table width=\"100%\" border=\"0\" cellspacing=\"".int(rand(4))."\" cellpadding=\"".int(rand(7))."\"\n";
	    $seite = $seite."<td valign=\"".$position[rand(@position)]."\">\n";
	    $seite = $seite.$satze[$s];
	    $seite = $seite."</td>\n";
	    if ($image ne 0){
		$seite = $seite.  "<td valign=\"".$position[rand(@position)]."\">$image</td>\n";
	    }
	    $seite = $seite."<tr>\n";
	    $seite = $seite."</table>\n";
	}else{
	    $seite = $seite."<table width=\"100%\" border=\"0\" cellspacing=\"".int(rand(4))."\" cellpadding=\"".int(rand(7))."\">\n"; 
	    if ($image ne 0){
		$seite = $seite.  "<td valign=\"".$position[rand(@position)]."\">$image</td>\n";
	    }
	    
	    $seite = $seite."<td valign=\"".$position[rand(@position)]."\">\n";
	    $seite = $seite.$satze[$s];
	    $seite = $seite."</td>\n";  
	    $seite = $seite."<tr>\n";
	    $seite = $seite."</table>\n";  
	}
    }
    my @anrede = ("A site I really like: ","A good $keyword site: ",
		  "read more at: ","also look at: ","further information: ","another $keyword site: ");
    $seite = $seite."<br>".$anrede[int(rand(@anrede))];
    my $get_url = get_url($keyword);
    print "--------$get_url----\n";
    if ($get_url ne "0"){    
	print	"+++++++++++++++++++++++++++++++++++++++++++\n";
	$seite = $seite."<a href=\"$get_url\">$get_url</a><br><br>\n";
    }
    $seite = $seite."</font><font size=-6> <a class=\"nav\" href=\"$main_weblink\">.</a><br><br>\n";
    $seite = $seite."</font></body></html>\n";
    my $update = $dbh->prepare("update keyword set keyword_html = '$seite' where keyword_main_id  = '$main_id' and keyword = '$keyword' ");
    $update->execute;
    open (FILE,">$main_id/$keyword.html");
    print FILE $seite;
    close FILE;
    
}

sub satzgenerator{
    my $tx_id = $_[0];
    my $keyword = $_[1];
    my $obergrenze = 5;
    #print "new file\n";
    my $abfrage= $dbh->prepare("select tx_text,tx_lang from text where tx_id = '$tx_id'");
    $abfrage->execute;
    my ($text,$tx_lang)= $abfrage->fetchrow_array;
    $text =~ s/\*/\'/ig;
    my @satze = split(/\./,$text);
    my $neusatz = "";
    for (my $i = 0; $i < @satze;$i++) {
	my $localsatz = $satze[$i].".";
	#print "------".$keyword ."------------$tx_id--------\n";
	if ($localsatz =~ /\b$keyword\b/i){
	    for (my $k = $i;$k < ($i+$obergrenze);$k++){ 
		my $localsatz = $satze[$k-int($obergrenze/2)].".";
		#print "------".$localsatz ."--------------------\n";
		$neusatz = $neusatz."$localsatz";
	    }
	   # print($neusatz);
	    return($neusatz,$tx_lang);
	}	
    }
    return;
}



sub get_url{
    my $keyword = $_[0];
    my $abfrage = $dbh->prepare("select globalurl.g_string,g_id from globalurl,url where globalurl.g_url_id = url.url_id 
and url.url_main_id = '$main_id' and globalurl.g_used = 0");   
    $abfrage->execute;
    print "ask \n";
    my @globalurl = (); 
    my @get_url = ();
    my @get_url_id = ();
    do {
	@globalurl = $abfrage->fetchrow_array;
	push (@get_url,$globalurl[0]);
	push (@get_url_id,$globalurl[1]);
    } while (length($globalurl[0]) != 0);
    if (@get_url == 1){
	print "keinurlmehr--------------\n";
	return 0;
    }  
    for (my $k = 0; $k < @get_url; $k++){
	if ($get_url[$k]=~ /$keyword/i){
	    set_used("globalurl",$get_url_id[$k]);
	    return ($get_url[$k]);
	}
#	print"--$get_url[$k]--$get_url_id[$k]--\n";
    }
    my $randzahl = int(rand(@get_url));
    $globalurl = $get_url[$randzahl];
    set_used("globalurl",$get_url_id[$randzahl]);
    return($globalurl);
}

sub get_image{
    my $keyword = $_[0];
    my @result = ();    
    my @image = ();
    my @image_id = ();
    my $image = "";
    my $abfrage= $dbh->prepare("select image.img_link,img_id from image,url where image.img_url_id = url.url_id and url.url_main_id = '$main_id' and image.img_used = 0");
    $abfrage->execute;
    @result = $abfrage->fetchrow_array;
	push (@image,$result[0]);
	push (@image_id,$result[1]);
    while ($result[0] != undef){
      @result = $abfrage->fetchrow_array;
	push (@image,$result[0]);
	push (@image_id,$result[1]);
 } 
 
    #foreach(@image){print @image."-++++++\n"};
    if ($result[0] != undef){
	#foreach(@image){print @image[0]."\n"};
	print "keinbildmehr--------------\n\n\n\n\n";
	return ("0");

    }  
    for (my $k = 0; $k < @image; $k++){
		if ($image[$k]=~ /$keyword/i){
	   	 set_used("image",$image_id[$k]);
	   	 return ($image[$k]);
	    	print"--$image[$k]--$image_id[$k]--\n";
		}
    }
    my $randzahl = int(rand(@image));
    $image = $image[$randzahl];
    set_used("image",$image_id[$randzahl]);
     print"--$image--$image_id[$randzahl]-----------\n";
    return($image);
}

sub set_used{
    my $type = $_[0];
    my $id = $_[1];
#    print "---typ :$typ and id $id  -> in sub set_used\n";
    if ($type eq "image" ){	
	my $update= $dbh->prepare("update image set img_used = 1 where img_id = '$id'");
	$update->execute;
    } elsif ($type eq "globalurl"){
	my $update= $dbh->prepare("update globalurl set g_used = 1 where g_id = '$id'");
	$update->execute;
    }
}


sub ftpup{
    statussetz(6);
    while (1){
        my $select = $dbh->prepare("select ac_id from accounts where ac_used != 1");
        $select->execute;
        my $ac_id = $select->fetchrow_array;
        my $fehler = 0;
        my $select = $dbh->prepare("select ac_ftp, ac_name, ac_pw, ac_id,ac_http,ac_path from accounts where ac_id = '$ac_id'");
        $select->execute;
        my ($ftphost,$username,$password,$ac_id,$ac_http,$ac_path) = $select->fetchrow_array;
        my $ftp = Net::FTP->new($ftphost,
                                Timeout => 30,
                                Debug => 1 ) or $fehler = 1;
        if ($fehler == 0){
            $ftp->login($username, $password) or $fehler = 2;
        }
        if ($fehler == 0){
            if ($ac_path ne "."){
                $ftp->cwd($ac_path) or $fehler = 3;
            }
        }
        if ($fehler == 0){
            $ftp->mkdir($main_id, 1) or $fehler = 4;
        }
        if ($fehler == 0){
            $ftp->cwd($main_id)  or $fehler = 5;
        }
        if ($fehler != 0){
 
            my $update = $dbh->prepare("update accounts set ac_used = ac_used + 2 where ac_id = $ac_id");
            $update->execute;
            my $select = $dbh->prepare("select ac_used from accounts where ac_id = $ac_id");
            $select->execute;
            my $ac_used = $select->fetchrow_array;
            if ($ac_used > 30){
                my $update = $dbh->prepare("update accounts set ac_used = 1 where ac_id = $ac_id");
                $update->execute;
                redo;
            }
        }
        push (@word,"index");
        foreach(@word){
            my $filename = $_.".html";
            if ($fehler == 0){
                $ftp->put("$main_id/$filename") or $fehler = 6;
            }
        }
        #$ftp->quit() or print "Couldn't quit";
        if ($fehler != 0){
            pop (@word);
 
            my $update = $dbh->prepare("update accounts set ac_used = ac_used + 2 where ac_id = $ac_id");
            $update->execute;
            my $select = $dbh->prepare("select ac_used from accounts where ac_id = $ac_id");
            $select->execute;
            my $ac_used = $select->fetchrow_array;
            if ($ac_used > 30){
                my $update = $dbh->prepare("update accounts set ac_used = 1 where ac_id = $ac_id");
                $update->execute;
            }                              
	    redo;
        } else {
            $ac_http = $ac_http."/$main_id/index.html";
            print "update main set main_ac_id = '$ac_id',main_weblink = '$ac_http' where main_id = '$main_id'";
            my $update = $dbh->prepare("update main set main_ac_id = '$ac_id',main_weblink = '$ac_http' where main_id = '$main_id'");
            $update->execute;
            last;
        }
    }
}
                            



#####################################sub clear()################

sub clearmake{
	statussetz(7);
    if ($filenumber == 0){
	#statussetz ($main_id,"nosatz");
    } else {
	#statussetz ($main_id,"finito");
    }
    system "rm","-R","model";
    system "rm","-R","$main_id";
}

















