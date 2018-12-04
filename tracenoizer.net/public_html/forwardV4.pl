#/usr/bin/perl

use POSIX;

#chdir ("/home/tracenoizer/public_html/");

#start prozess abhaengen
#close STDOUT;
close STDERR;
close STDIN;
fork() && exit 0;
#end

$main_id = $ARGV[0];
$searchterm = $ARGV[1];

#system "/usr/bin/perl /home/tracenoizer/public_html/trace_centralV4.pl $main_id '$searchterm' &"; 
system "/usr/bin/perl trace_centralV4.pl $main_id '$searchterm' &"; 


