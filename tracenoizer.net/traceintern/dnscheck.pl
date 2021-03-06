#!/usr/bin/perl -w
#

#$base_url = shift;
#$antwort =   open (AFR,"nslookup $base_url");
#print $antwort;


#!/usr/bin/perl

use Net::DNS;
use DBI;

connect_db();
allmail();

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
        print "no connection to the db";
    }
    print "---->connection to db $db established \n";
}
  

sub allmail{
    my $select = $dbh->prepare("select usr_id,usr_mail from users");
    $select->execute;
    my @temp = $select->fetchrow_array;
    @usr_id =();
    @usr_mail =();  
    push (@usr_id,$temp[0]);
    push (@usr_mail,$temp[1]);
    while ($temp[0]  != undef  ){
	@temp = $select->fetchrow_array;
	push (@usr_id,$temp[0]);
	push (@usr_mail,$temp[1]);   
    }

    for (@usr_id){print $_."\n";}
    return(0);
}


for (my $r = 0;$r < @usr_id; $r++){
    # print  $usr_mail[$r];
   $usr_mail[$r] =~ s/.*\@+//;
   print $usr_mail[$r]."\n";
   if (length($usr_mail[$r]) > 0){ 
       $exist = host_exist($usr_mail[$r]);
       if ($exist == 0){
	   print $exist."\n";
	   push(@korrekt,$usr_id[$r]);
       }
   } else {
       push(@korrekt,$usr_id[$r])
       }
}

for (@korrekt){
    print $_."\n";
    my  $update = $dbh->prepare("update users set usr_mail = '' where usr_id = $_");
    $update->execute;
}





sub host_exist{
    my $host = $_[0];
    $res = Net::DNS::Resolver->new();
    @mx = ();
    @mx = mx($res,$host) or return(0);
    return(1);
}

