#/usr/bin/perl

use POSIX;

close STDOUT;
close STDERR;
close STDIN;
#fork() && exit 0;


$main_id = $ARGV[0];
$searchterm = $ARGV[1];





#foreach (@ARGV){
 
#system "echo $_ > $_.txt";
#print $_;
#}
 


system "/usr/bin/perl artclone_central.pl $main_id '$searchterm'"; 

#system "/usr/bin/perl /home/tracenoizer/public_html/trace_central.pl $main_id $searchterm & >/dev/null 2>/dev/null";        

#system "/usr/bin/perl", "/home/tracenoizer/public_html/trace_central.pl", "$main_id", "$searchterm","&";

