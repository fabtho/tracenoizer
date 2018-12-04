<?php

include_once('db_connect.php');


$query2 = ('SELECT main_date, main_weblink, main_ac_id, main_st_id FROM main WHERE main_id="'.$main_id.'"');

//$query2 = ("SELECT main_date, main_weblink, main_ac_id, main_st_id FROM main WHERE main_id=4253");
$query2_id = mysqli_query($db_connection, query2);


$row = mysqli_fetch_array($query2_id);

$state = $row[main_st_id];

//echo $state;


if ($state==7){

echo '
<html>
	<head>
	<title>uploading</title>
	</head>

<style type="text/css">
A.nav:link {TEXT-DECORATION: none}
A.nav:visited {TEXT-DECORATION: none}
A.nav:active {TEXT-DECORATION: none}
A.nav:hover {TEXT-DECORATION: none}
</style>


<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" background="images/main_bg.gif" text="#000000" link="#3333FF" alink="#FFFFFF" vlink="#000000">

<font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3">
	Your Clone is now online: <a href="'.$row[main_weblink].'" class="nav" target="_top">'.$row[main_weblink].'</a><br>
	<br>
	With your username and password, you can access your<br>
	<b>Clone Control Center</b> via the Tracenoiner webpage.<br>
	<br>
</font>

</body>

</html>';

		echo ' <br>';





} else {



echo '
<html>

<head>
	<title>uploading</title>
</head>
	
<meta http-equiv="refresh" content="1;URL=uploadcontrolV3.php?main_id='.$main_id.'">


<style type="text/css">
A.nav:link {TEXT-DECORATION: none}
A.nav:visited {TEXT-DECORATION: none}
A.nav:active {TEXT-DECORATION: none}
A.nav:hover {TEXT-DECORATION: none}
</style>


<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" background="images/main_bg.gif" text="#000000" link="#3333FF" alink="#FFFFFF" vlink="#000000">

<font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3">
	Please stand by, while you are being registered and your clone is being published.
</font>

</body>

</html>';



}



















echo '</html></head>';















?>

