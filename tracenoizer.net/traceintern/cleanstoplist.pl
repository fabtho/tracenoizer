#/usr/bin/perl

#####################################################################################
#######            text2list.pl  V0.01                           #####
#######          2002 copyleft martin krung                      #####			
#######	 martin at krungkuene dot org martin at krung dot org    #####
#####################################################################################



if ( length($ARGV[1]) < 1 ){
print "\nProgram aborted : too less argumentes.\n";
print "Programm vorzeitig beendet : zuwenig Argumente.\n\n";
print "Argumentes:\n\n";
print "text2list.pl input_filename output_filename \n\n";
exit;
};

# parse arguments, open files

$filename = $ARGV[0];
$o_filename = $ARGV[1];

open (FILE,"< $filename") || die("can't open $filename: $!");
open (TEMP,"> temp") || die("can't open temp: $!");
open (OUT,"> $o_filename") || die("can't open $o_filename: $!");;

# cleaning with regexp

$i = 1;

while (<FILE>){

# convert all withspace to newline
  $_=~ s/\s+?/\n/g ;
# lowercase
  $_ = lc($_);
# filter out all non alpah characters, and makes it to newline
  $_=~ s/[^a-z\n]+//g;

# leeding double chars to one char
$_=~ s/^(\w){1}\1{1,}/\1/g;
# tripple chars to 2 chars
$_=~ s/(\w)\1{2,}/\1\1/g;

print TEMP $_;
$i++;
}

# some output and sort

print "file $filename has $i lines \n";
print "datei $filename hat $i linien \n";

print "start sort \n";

exec ("sort -u temp > $o_filename");

print "remove temp file \n";

exec ("rm temp");



