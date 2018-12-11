

<?php

$url = $_GET["url"];
$usr_id = (int) $_GET["usr_id"];
$main_id = (int) $_GET["main_id"];

if ( substr($url, 0, 5) != '/temp') {
    echo 'only /temp allowed';
    exit;
}


echo'<html>

<head>
<title>TraceNoizer - C C C </title>

	<script language="JavaScript">
	
	//alert("navV3.php?usr_id='.$url.'&main_id='.$main_id.'");
 </script>

</head>
<frameset  rows="150,*">
<frame name="top" src="navV3.php?usr_id='.$usr_id.'&main_id='.$main_id.'"marginwidth="10" marginheight="10" scrolling="no" frameborder="0">
<frame name="site" src="'.$url.'" marginwidth="10" marginheight="10" scrolling="yes" frameborder="0">
</frameset>
</html>
';



?>
