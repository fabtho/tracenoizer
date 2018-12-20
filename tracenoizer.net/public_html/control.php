<?php
include_once('db_connect.php');

$usr = $_POST["usr"];
$pwd = $_POST["pwd"];

$usr = mysqli_real_escape_string($db_connection, $usr);
$pwd = mysqli_real_escape_string($db_connection, $pwd);

###----check, if pw and user_id are in db---
#--------------------------------------------------

$sql = "select usr_id from users where usr_name='$usr' and usr_pw='$pwd'";
$query =  mysqli_query($db_connection,  $sql );

while($row = mysqli_fetch_row($query)){ 
	$userID=$row[0];
} 


###---if user_id and pw are not in db, go back to input-form---
###------------------------------------------------------------

$NumMembers = mysqli_num_rows($query); 
if ($NumMembers==0){

	echo '
<html>
<head>
	<title>TraceNoizer - Login</title>
</head>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" background="images/main_bg.gif" text="#000000">

<font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3">

<table border="0" height="100%" width="100%"><tr><td align="center" valign="middle">

<form method="post" action="control.php">
	<table border="0">
		<tr>
			<td colspan="2"><b>Invalid Username or Password!!</b><br><br></td>
		</tr>
		<tr>
			<td>Username: </td>
			<td><input type="text" name="usr" value="'.$usr.'"</td>
		</tr>
		<tr>
			<td>Password: </td>
			<td><input type="password" name="pwd"></td>
		</tr>
		<tr>
			<td><br><br></td>
			<td valign="bottom"><input type="submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
</form>

</td></tr></table>

</font>

</body>
</html>
';

	mysqli_close($db_connection);
	die("");
} else {






###---if user_id and pw are correct, get clone info (main_weblink and main_date)---------------------------------------------------------------------------------
	
	$query2 = ("SELECT main_date, main_weblink, main_ac_id, main_st_id, main_id FROM main WHERE main_usr_id = '$userID' ");
	$query2_id = mysqli_query($db_connection, $query2);

	$query3 = ("SELECT main_id FROM main WHERE main_usr_id = '$userID' ");
	$query3_id = mysqli_query($db_connection, $query3);

	
}//end "if ($NumMembers==0)"


###---if there is no clone-info in db print message that clone is under construction ---
###-------------------------------------------------------------------------------------

$NumMembers2 = mysqli_num_rows($query2_id); 
if ($NumMembers2==0){
	echo '<html>
	<body background="images/main_bg.gif" text="#000000">
	Sorry!<br>
	<br>
	Your clone control center is not ready yet!<br>
	please check again later.
	</body>
	</html>';
} else {

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
</head>

<style type="text/css">
A.nav:link {TEXT-DECORATION: none}
A.nav:visited {TEXT-DECORATION: none}
A.nav:active {TEXT-DECORATION: none}
A.nav:hover {TEXT-DECORATION: none}
</style>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" background="images/main_bg.gif" text="#000000" link="#3333FF" alink="#FFFFFF" vlink="#000000">
<table border="0" cellspacing="0" cellpadding="30" height="95%" width="95%"><tr><td>

<a name="top"></a>
<font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3">
<div align="center">
Hello '.$usr.' this is your personal<br>
<font size="5"><b>Clone Control Center</b></font><br><br>
</div><br>
';


//clonelist--------------------------------------------------------
echo '
<table border="0">
	<tr>
		<td valign="top">Your Clones: </td>
		<td>';
			while ($list = mysqli_fetch_array($query3_id)) {
			$nr = $list[main_id];
				echo '<a href="#'.$nr.'" class="nav">U'.$userID.' - '.$nr.'M</a><br>
				';
			};
		
		echo '</td>
	</tr>
</table><br>
<br>
<br>
';

//clones-----------------------------------------------------------
	while ($row = mysqli_fetch_array($query2_id)) {
		$nr = $row[main_id];
		$state = $row[main_st_id];
		for($st = 0; $st < count($st_strings); $st++){
			if($state == $st){
				if($state == 6){//value needs to be changed if number of states changes (to the case where clone is active)
					
					echo '
					<a name="'.$nr.'"></a>
					<font size="4"><b>Clone: U'.$userID.' - '.$nr.'M</b></font><br>
					<font size="2">date of creation: '.$row[main_date].'</font><br><br>
					
					<b>Status:</b><br>
					Online: <a href="'.$row[main_weblink].'" class="nav" target="_new">'.$row[main_weblink].'</a><br>

					Online for Status 6 (2018-12-20): <a href="/temp/'.$userID.'/index.html" class="nav" target="_new">/temp/'.$userID.'/index.html</a><br>
					<font size="2">link opens in a new window</font><br><br>
					
					<b>Composition:</b><br>
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
							};
						
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
					
					<form method="post" action="killa.php">
					<input type="hidden" name="main_id" value ="'.$row[main_id].'" >
					<input type="hidden" name="main_ac_id" value="'.$row[main_ac_id].'">
					<input type="hidden" name="pwd" value="'.$pwd.'">
					<input type="hidden" name="usr" value="'.$usr.'">

					<input type="submit" name="Submit" value="Permanently KILL this Clone!" style="font-size:12px">
					<br>
					<br>
					<font size="2"><a href="#top" class="nav">^ top</a></font><br><br><br>
					';
					
					
				}else{
					
					echo '
					<a name="'.$nr.'"></a>
					<font size="4"><b>Clone: U'.$userID.' - '.$nr.'M</b></font><br>
					<font size="2">date of cccreation: '.$row[main_date].'</font><br><br>
					
					<b>Status:</b><br>
					Clone is not finished yet: '.$st_strings[$st].'...<br><br>
					
					<font size="2"><a href="#top" class="nav">^ top</a></font><br><br><br>
					';
				}
			}
		}
	}//end while "write clone row"



//html footer
echo'
</font><br><br>
</td></tr></table>
</body>
</html>';

mysqli_close($db_connection);

}//end "if ($NumMembers2==0)"

?>
