<?

include_once('db_connect.php');


$query = mysqli_query($db_connection, "select  ac_http, ac_path from accounts  where ac_id='$main_ac_id'"); 

while($row = mysqli_fetch_array($db_connection, $query)){ 
	$ac_path = $row[ac_path]; 
	$ac_http = $row[ac_http];
}  


## update MAIN table
##---------------------------------------------------------------------------------------------

//update

$link = $ac_http."/".$main_id."/";
//echo $link;

$update = mysqli_query($db_connection,  "update main set main_weblink = $link, main_ac_id = $ac_id where main_id = $main_id");


//update clonestate
$update = mysqli_query($db_connection,  "update main set main_st_id = 8 where main_id = $main_id");
//echo "<br>sql main update: ".$update;

$dir = $ac_path."/".$main_id;

//echo $dir;

//deldir($dir);

function deldir($dir){
 $current_dir = opendir($dir);
 while($entryname = readdir($current_dir)){
   if(is_dir("$dir/$entryname") and ($entryname != "." and $entryname!="..")){
    deldir("${dir}/${entryname}");
   }elseif($entryname != "." and $entryname!=".."){
    unlink("${dir}/${entryname}");
   }
 }
 closedir($current_dir);
 rmdir(${dir});
}


//closw db
mysqli_close($db_connection);

echo '<meta http-equiv="refresh" content="0;URL=control.php?usr='.$usr.'&pwd='.$pwd.'">';


?>
