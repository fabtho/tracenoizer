
open(HTML,"<index.html");

    while (<HTML>){
	$text = $text.$_;
    }

look_img ($text,"http://www.super.ch");




sub look_img{
    my $text = $_[0];

    my $base_url = $_[1];
    print $base_url."\n";
    my @srcs =  $text =~ /(img.+src.*\=\"{1}[^\"]+\"{1}.*?)>{1}/ig;
    foreach (@srcs){
#        print $_."-------------limglink \n";
        my $heightsrc= $_ =~/(height\=\"?\d{3}\"?)/i;
        my $height = $1;
        my $widthsrc= $_ =~  /(width\=\"?\d{3}\"?)/i;
        my $width = $1;
        my $nursrc=  $_ =~ /src\=\"([^\"]*)\"/i;
        my $src= $1;
        if ($heightsrc == 1 and $widthsrc == 1 and $nursrc == 1 and length($src) > 3){
            my $img_link = localurl2globurl($src,$base_url);
            my $img_tag = "<img ". $height ." ". $width." src=\"".$img_link."\">";
          #  my $insert= $dbh->prepare("insert into image (img_link,img_url_id,img_used) values ('$base_url $src $img_link ','$url_id',0)");
           # $insert->execute;
          print "----> insert $img_tag\n";
        }
    }
}
 
sub localurl2globurl{
    my $src = $_[0];
    my $base_url = $_[1];
    if ($src =~ /^(http:\/\/)/){
        return ($src);
    }

    $_ = $src;
    $src =~ /(.*\/)/;
    $src = $1;
    my $join =$base_url.$src;
    #print  "/usr/local/bin/puf -Tl 2 -Td 4 -Tc 4 -lb 400000 -nw -t 3  -P /home/martin/trace/bilder/$main_id  $join";
        #  system "/usr/local/bin/puf -Tl 4 -Td 8 -Tc 8 -lb 500000 -nw -t 3  -P /home/martin/trace/bilder/$main_id  $join ";
   
    print  $base_url.$src."\n";         
 return ($base_url.$src);
}
   
