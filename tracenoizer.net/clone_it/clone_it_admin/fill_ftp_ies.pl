#/usr/bin/perl
 
##fill the table accounts with ftp pages
##-------------------------------------------------------------
        
use DBI;

connect_db();
fill_ftp();  

sub connect_db{
    my $server = "www2.snm-hgkz.ch";
    my $db = "ies";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'ies','iespass');
    if (not $dbh){
        print "no connection to the db";
    }
}      



 
sub fill_ftp{
    # delete all old accounts;
    my $insert = $dbh->prepare("delete from accounts");
    $insert->execute;    
    
    #fill new account with form user,pw,ftp,http,path;
    
    #oneaccount("johndoeclone","56665","ftp.geocities.com","http://www.geocities.com/johndoeclone",".");
    
    #   oneaccount("klonorg","56665","ftp.angelfire.com","http://www.angelfire.com/art/klonorg",".");   
    
    #  oneaccount("xxxclone","annina","ftp.geocities.com","http://www.geocities.com/xxxclone",".");    
    
    # oneaccount("clone000001","annina","ftp.geocities.com","http://www.geocities.com/clone000001","."); 
    
    # oneaccount("xxxxclone","annina","ftp.geocities.com","http://www.geocities.com/xxxxclone",".");    
    
    # oneaccount("clone000002","annina","ftp.geocities.com","http://www.geocities.com/clone000002",".");
    
    # oneaccount("nun.ch","dsa","www.nun.ch","http://www.nun.ch/clone","html/clone");    
	
	# oneaccount("werner","gelbsucht","www.krungkuene.org","http://www.krungkuene.org/~werner","public_html");  

#       oneaccount("clone242913","annina","ftp.geocities.com","http://www.geocities.com/clone141913",".");
                                                                                                             
 #       oneaccount("clone890005","annina","ftp.geocities.com","http://www.geocities.com/clone890005",".");  
    
  #      oneaccount("clone232967","annina","ftp.geocities.com","http://www.geocities.com/clone232967","."); 

   #     oneaccount("clone677554","annina","ftp.geocities.com","http://www.geocities.com/clone677554",".");
                                                                                                                 

  oneaccount("werner","gelbsucht","www.krungkuene.org","http://www.krungkuene.org/~werner","public_html");  
  oneaccount("szurb780","szurb780","www.nektar.ch","http://www.nektar.ch/klon","../../web/klon"); 
  oneaccount("nun.ch","dsa","www.nun.ch","http://www.nun.ch/clone","html/clone");   
  oneaccount("mediamaterial","gbt2lt","www.mediamaterial.ch","http://www.mediamaterial.ch/~klon","public_html/klon");      

   

    sub oneaccount{
	print  "$_[0],$_[1],$_[2],0,$_[3],$_[4]\n"; 
	my $insert = $dbh->prepare("insert into accounts (ac_name,ac_pw,ac_ftp,ac_used,ac_http,ac_path) values ('$_[0]','$_[1]','$_[2]',0,'$_[3]','$_[4]')");
        $insert->execute;    	
    }
}
                                                                                                                     






