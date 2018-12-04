#!/usr/bin/perl
use Mail::Mailer;
use DBI;
connect_db();


$main_id = $ARGV[0];
mail();

sub connect_db{
	my $server = "snm2.hgkz.ch";
	my $db = "ies";
	$dbh = DBI->connect ("DBI:mysql:$db:$server",'ies','iespass');
	if (not $dbh){
		print "no connection to the db";
	}
}


sub mail {
	$from_address = "tracnoizer\@tracnoizer.org";
	my $abfrage= $dbh->prepare("select  USERS.usr_mail from USERS,MAIN
	where MAIN.main_usr_id = USERS.usr_id and
	MAIN.main_id = '$main_id'");
    $abfrage->execute;
    my $to_address  = $abfrage->fetchrow_array;
    print   "to_address  = $to_address \n";
    
    my $abfrage= $dbh->prepare("select  main_weblink from MAIN
	where MAIN.main_id = '$main_id' ");
    $abfrage->execute;
    my $weblink  = $abfrage->fetchrow_array;
    print "weblink  = $weblink \n";
    
    
    my $abfrage= $dbh->prepare("select in_keyword from INPUT
	where in_main_id = '$main_id'");
    $abfrage->execute;
    my $keyword  = $abfrage->fetchrow_array;
    $keyword=~ s/\+/ /g;
	print "keyword  =  $keyword\n";
    
    
	my $subject = "your clone is $keyword made";
	my $body = "thats my part of live and your weblink for your clone is $weblink ";


	$mailer = Mail::Mailer->new("sendmail");
	$mailer->open({ From    => $from_address,
               	 To      => $to_address,
               	 Subject => $subject,
             	 })
  	  or die "Can't open: $!\n";
		print $mailer $body;
		$mailer->close();
}
