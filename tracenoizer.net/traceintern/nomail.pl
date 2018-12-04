
#/usr/bin/perl -w   

use DBI;



# setz alle bei denen keinn mail vorhanden die main_generation zu null
# auch alle die einen anderen status als 7 = online haben
  
connect_db();
  
 
 
sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'web','w2kkadb');
    if (not $dbh){
        print "----> no connection to the db";
    }
    print "----> connection to db $db established \n";
}




$select = $dbh->prepare("select usr_id from users where usr_mail = '' " );
$select->execute;
$main_id  = $select->fetchrow_array;
push (@main_id,$main_id);
while ($main_id != undef){
    $main_id= $select->fetchrow_array;
    push (@main_id,$main_id);
}
 
 
 
 
for (my $k=0 ;$k < @main_id;$k++){
    $select = $dbh->prepare("update main set main_generation = 0 where main_usr_id = $main_id[$k]");
    $select->execute;
}
     






#exit;
 
$select = $dbh->prepare("select main_id from main where main_st_id != '7' " );
$select->execute;
$main_id  = $select->fetchrow_array;
push (@main_id,$main_id);
while ($main_id != undef){
    $main_id= $select->fetchrow_array;
    push (@main_id,$main_id);
}
 
 
 
 
for (my $k=0 ;$k < @main_id;$k++){
    $select = $dbh->prepare("update main set main_generation = 0 where main_id = $main_id[$k]");
    $select->execute;
}
 
     


