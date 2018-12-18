<?php

include_once('db_connect.php');

$userID = $_GET['userID'];
$userID = mysqli_real_escape_string($db_connection, $userID);


###---if user_id and pw are correct, get clone info (main_weblink and main_date)---------------------------------------------------------------------------------


###---if there is no clone-info in db print message that clone is under construction ---
###-------------------------------------------------------------------------------------

	//get status descriptions
	$stati =  mysqli_query($db_connection,  "select st_string from status");
	while($row = mysqli_fetch_array($stati)){
		$st_strings[] = $row["st_string"];
	}

###---if there is clone-info spell it out
###--------------------------------------------------------------------------------------
//head-------------------------------------------------------------
echo '
<html>
<head>
	<title>TraceNoizer - C C C </title>
';


$query2 = ("SELECT main_date, main_weblink, main_ac_id, main_st_id, main_id FROM main WHERE main_usr_id = $userID ");
$query2_id = mysqli_query($db_connection, $query2);

$row = mysqli_fetch_array($query2_id);

$state = $row[main_st_id];

echo '<!-- state = '.$state.'-->';


if($state < 6){
	echo '<meta http-equiv="refresh" content="7;URL=control_firstV4.php?userID='.$userID.'">';
} 
	
echo '
</head>

<style type="text/css">
A.nav:link {TEXT-DECORATION: none}
A.nav:visited {TEXT-DECORATION: none}
A.nav:active {TEXT-DECORATION: none}
A.nav:hover {TEXT-DECORATION: none}
</style>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" background="images/main_bg.gif" text="#000000" link="#3333FF" alink="#FFFFFF" vlink="#000000">
<table border="0" cellspacing="0" cellpadding="30"><tr><td align="left" valign="top">

<font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3">
';






//clones-----------------------------------------------------------

$query2 = ("SELECT main_date, main_weblink, main_ac_id, main_st_id, main_id FROM main WHERE main_usr_id = $userID ");
	$query2_id = mysqli_query($db_connection, $query2);


	while ($row = mysqli_fetch_array($query2_id)) {
		$nr = $row[main_id];
		$state = $row[main_st_id];
		for($st = 0; $st < count($st_strings); $st++){
			if($state == $st){
				if($state >= 6){//value needs to be changed if number of states changes (to the case where clone is active)
					$url= '/temp/'.$nr.'/index.html';
					echo '
					<a name="'.$nr.'"></a>
					<font size="4"><b>Clone: U'.$userID.' - '.$nr.'M</b></font><br>
					<font size="2">date of creation: '.$row[main_date].'</font><br><br>
					
					<b>Status:</b><br>
					
					';
					
					if ($state == 6) {// lokal
					
						echo '
						Your Site : <a href="/temp/'.$nr.'/index.html" class="nav" target="_new">/temp/'.$nr.'/index.html</a><br>
						<font size="2">link opens in a new window</font><br><br>
						<b>Composition:</b><br>
						<script language="JavaScript">
						//alert("es tut");
							F1 = window.open("popupV3.php?usr_id='.$userID.'&main_id='.$nr.'&url='.$url.'","clonesite","width=800,heigth=600,resizable=yes");

 						</script>
 						';
 	
						 } else {// wenn vom user raufgeladen
	 					echo '
						Online: <a href="'.$row[main_weblink].'" class="nav" target="_new">'.$row[main_weblink].'</a><br>
						<font size="2">link opens in a new window</font><br><br>
						';
 					} // end if == 6

 					echo '
		
					<table border="0" cellpadding="0" cellspacing="1">';
						
							$query4 = ("SELECT keyword, keyword_infog, keyword_size FROM keyword WHERE keyword_main_id = '$nr' ");
							$query4_id = mysqli_query($db_connection, $query4);
							
							while ($comp = mysqli_fetch_array($query4_id)) {
							$thema = $comp[keyword];
							$infog = round (100 * $comp[keyword_infog]);
							$size = round ($comp[keyword_size] / 25);
							
								echo '
								<tr>
									<td align="right">'.$thema.'</td>
									<td>
										<table border="0" cellpadding="0" cellspacing="0"><tr>
											<td>
												<img src="images/spacer.gif" height="12" width="10">
											</td>
											<td>
												<table border="0" cellpadding="0" cellspacing="0"><tr><td bgcolor="#3333FF"><img src="images/spacer.gif" height="12" width="'.$size.'"></td></tr></table>
											</td>
											<td>
												<img src="images/spacer.gif" height="12" width="10">
											</td>
											<td>
												<font size="2">'.$infog.' R pts</font>
											</td>
										</tr></table>
									</td>
								</tr>
								';
							}; //end while
						
					echo '
						<tr>
							<td align="right" valign="bottom">( <font size="1"><b>TOPIC</b></font></td>
								<td>
									<table border="0" cellpadding="0" cellspacing="0"><tr>
										<td>
											<img src="images/spacer.gif" height="20" width="10">
										</td>
										<td valign="bottom">
											<table border="0" cellpadding="0" cellspacing="0"><tr><td bgcolor="#3333FF"><font size="1"><b>  TEXT LENGTH  </b></font></td></tr></table>
										</td>
										<td>
											<img src="images/spacer.gif" height="12" width="10">
										</td>
										<td valign="bottom">
											<font size="1"><b>RELEVANT POINTS</b></font> )
										</td>
									</tr></table>
								 </td>
						</tr>
					</table><br>
					<br>
					
					<!--
					<form method="post" action="publish.php">
					<input type="hidden" name="main_id" value ="'.$row[main_id].'" >
					<input type="hidden" name="main_ac_id" value="'.$row[main_ac_id].'">
					<input type="submit" name="Submit" value="publish this clone" style="font-size:12px"></form> -->
					<br>
					<br>
					<font size="2"><a href="#top" class="nav">^ top</a></font><br><br><br>
					';
					
					
				}else{ // ist < 6
					$blau = ($state+1) * 50;
					$grau = 350 - ($state+1) * 50;
					echo '
					Tracenoizer is now producing your test clone:<br>
					<br>
					<br>
					<font size="4"><b>Clone: U'.$userID.' - '.$nr.'M</b></font><br>
					<font size="2">date of cccreation: '.$row[main_date].'</font><br><br>
					
					
					<b>Status:</b><br>
					<b>'.$st_strings[$st].'...</b><br>
					<br>
					<table border="0" cellpadding="1" cellspacing="0">
						<tr>
							<td bgcolor="#000000"><img src="images/v3blau.gif" height="12" width="'.$blau.'"><img src="images/v3grau.gif" height="12" width="'.$grau.'"></td>
						</tr>
					</table><br>
					<br>
					<font size="2"><a href="#top" class="nav">^ top</a></font>
					';
				}//end if >= 6
				
			}//end if state == st
			
		}//end for states
		
	}//end while "write clone row"


//html footer

echo'

</font><br><br>
</td></tr></table>
</body>
</html>';



mysqli_close($db_connection);

?>

