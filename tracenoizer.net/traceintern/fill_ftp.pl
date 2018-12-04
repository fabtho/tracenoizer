#/usr/bin/perl
 
##fill the table accounts with ftp pages
##-------------------------------------------------------------
        
use DBI;

connect_db();
fill_ftp();  

sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
#   $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
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
    

    
   # oneaccount("xxxxxxclone","annina","ftp.geocities.com","http://www.geocities.com/xxxxxxclone",".");        
   # oneaccount("clone002111","annina","ftp.geocities.com","http://www.geocities.com/clone002111","."); 
   # oneaccount("xxxxxclone","annina","ftp.geocities.com","http://www.geocities.com/xxxxxclone",".");    
   # oneaccount("clone23232","annina","ftp.geocities.com","http://www.geocities.com/clone23232",".");
   # oneaccount("clone002233","annina","ftp.geocities.com","http://www.geocities.com/clone002233",".");
   # oneaccount("xxxxxclone","annina","ftp.geocities.com","http://www.geocities.com/xxxxxclone",".");    
   # oneaccount("clone000043","annina","ftp.geocities.com","http://www.geocities.com/clone000043",".");
  #     oneaccount("clone005533","annina","ftp.geocities.com","http://www.geocities.com/clone005533",".");
 #   oneaccount("nun.ch","dsa","www.nun.ch","http://www.nun.ch/clone","html/clone");                                                
   #  oneaccount("iclone1","annina","ftp.geocities.com","http://www.geocities.com/iclone1",".");
  # oneaccount("youclone","annina","ftp.geocities.com","http://www.geocities.com/youclone",".");
  # oneaccount("weallclone","annina","ftp.geocities.com","http://www.geocities.com/weallclone",".");
  # oneaccount("you_clone","annina","ftp.geocities.com","http://www.geocities.com/you_clone",".");
  # oneaccount("clone_xxx","annina","ftp.geocities.com","http://www.geocities.com/clone_xxx",".");


      # oneaccount("clone005533","annina","ftp.geocities.com","http://www.geocities.com/clone005533",".");
      # oneaccount("clone005533","annina","ftp.geocities.com","http://www.geocities.com/clone005533",".");

      # oneaccount("superclone2001","annina","ftp.geocities.com","http://www.geocities.com/superclone2001",".");  
      #  


#oneaccount("masterclone2002","annina","ftp.geocities.com","http://www.geocities.com/masterclone2002",".");  
      #  oneaccount("bestclone","annina","ftp.geocities.com","http://www.geocities.com/bestclone",".");  
#oneaccount("clonieponie","annina","ftp.geocities.com","http://www.geocities.com/clonieponie",".");  
#oneaccount("cloneaccount1","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount1",".");  
#oneaccount("cloneaccount2","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount2",".");  
#oneaccount("cloneaccount3","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount3",".");  
#oneaccount("cloneaccount4","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount4",".");  
#oneaccount("cloneaccount5","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount5",".");  
#oneaccount("cloneaccount6","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount6",".");  
#oneaccount("cloneaccount7","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount7",".");  
#oneaccount("cloneaccount8","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount8",".");  
#oneaccount("cloneaccount9","annina","ftp.geocities.com","http://www.geocities.com/cloneaccount9",".");

oneaccount("clonieponie","annina","ftp.tripod.com","http://clonieponie.tripod.com",".");
oneaccount("superclone1","annina","ftp.tripod.com","http://superclone1.tripod.com",".");
oneaccount("clone20015","annina","ftp.tripod.com","http://clone20015.tripod.com",".");


oneaccount("blubclone","annina","ftp.geocities.com","http://www.geocities.com/blubclone",".");
oneaccount("nukiclone","annina","ftp.geocities.com","http://www.geocities.com/nukiclone",".");
oneaccount("supiclone","annina","ftp.geocities.com","http://www.geocities.com/supiclone",".");
oneaccount("lustclone","annina","ftp.geocities.com","http://www.geocities.com/lustclone",".");

# oneaccount("clone77777","annina","ftp.geocities.com","http://www.geocities.com/clone77777",".");
oneaccount("clone2598","annina","ftp.geocities.com","http://www.geocities.com/clone2598",".");

# oneaccount("clone99993224","annina","ftp.geocities.com","http://www.geocities.com/clone99993224",".");
oneaccount("clone73593021","annina","ftp.geocities.com","http://www.geocities.com/clone73593021",".");
  
#
#  oneaccount("nun.ch","dsa","www.nun.ch","http://www.nun.ch/clone","html/clone"); 

  
    
    
    sub oneaccount{
	print  "$_[0],$_[1],$_[2],0,$_[3],$_[4]\n"; 
	my $insert = $dbh->prepare("insert into accounts (ac_name,ac_pw,ac_ftp,ac_used,ac_http,ac_path) values ('$_[0]','$_[1]','$_[2]',0,'$_[3]','$_[4]')");
        $insert->execute;    	
    }
}
