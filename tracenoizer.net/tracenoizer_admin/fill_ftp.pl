#/usr/bin/perl
 
##fill the table accounts with ftp pages
##-------------------------------------------------------------
        
use DBI;

connect_db();
fill_ftp();  

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'root','gifa767');
    if (not $dbh){
        print "no connection to the db";
    }
}      



 
sub fill_ftp{
    # delete all old accounts;
    my $insert = $dbh->prepare("delete from accounts");
    $insert->execute;    
    
    #fill new account with form user,pw,ftp,http,path;
    

    
    oneaccount("xxxxxxclone","annina","ftp.geocities.com","http://www.geocities.com/xxxxxxclone",".");        
    oneaccount("clone002111","annina","ftp.geocities.com","http://www.geocities.com/clone002111","."); 
    oneaccount("xxxxxclone","annina","ftp.geocities.com","http://www.geocities.com/xxxxxclone",".");    
    oneaccount("clone23232","annina","ftp.geocities.com","http://www.geocities.com/clone23232",".");
    oneaccount("clone002233","annina","ftp.geocities.com","http://www.geocities.com/clone002233",".");
    oneaccount("xxxxxclone","annina","ftp.geocities.com","http://www.geocities.com/xxxxxclone",".");    
    oneaccount("clone000043","annina","ftp.geocities.com","http://www.geocities.com/clone000043",".");
    oneaccount("clone005533","annina","ftp.geocities.com","http://www.geocities.com/clone005533",".");
                                                
    
    
    
    sub oneaccount{
	print  "$_[0],$_[1],$_[2],0,$_[3],$_[4]\n"; 
	my $insert = $dbh->prepare("insert into accounts (ac_name,ac_pw,ac_ftp,ac_used,ac_http,ac_path) values ('$_[0]','$_[1]','$_[2]',0,'$_[3]','$_[4]')");
        $insert->execute;    	
    }
}
                                                                                                                     



