



<?php
//echo ($usr_id $main_id); 

switch($status)

	{
		case "":
		echo'
		<html>

		<head>
		<title>TraceNoizer - C C C </title>
		</head>
		<body topmargin="10" leftmargin="10" marginwidth="0" marginheight="0" background="images/main_bg.gif">
		<form name="queryform" action="navV3.php" method="post">
		<font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="000000">
			<b>If you are satisfied with your testclone, you can create an account.</b><br>
			This clone will then be published on the world wide web. You can access the data through
your personal clone control center using your username and password. Due to the fact that search 
engines have become ever  more restrictive in the past year, tracenoizer will not continue cloning. If you
want more clones, run TraceNoizer again. <br>
			<br>
		</font>
		
		<table border="0" cellspacing="0" cellpadding="3">
			<tr>
				 <td><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="ff3300"><b>Username: </b><input type="text" name="usr_name" size="9"></font></td>
				 <td><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="ff3300"><b>&nbsp;&nbsp; Password: </b><input type="password" name="usr_pw" size="9"></font></td>
				 <td><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="ff3300"><b>&nbsp;&nbsp; Confirm Password: </b><input type="password" name="confpwd" size="9"></font></td>
			</tr>
			<tr>
				<td colspan="2"><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="ff3300"> </b></font></td>
				<td align="right" valign="bottom"><input type="hidden" name="usr_id" value="'.$usr_id.'"><input type="hidden" name="main_id" value="'.$main_id.'"><input type="submit" name="status" value="create"></td>
			</tr>
		</table>
		
		</form>
		
		</body>
		</html>';	
		
		break;
		
		case "create":

				mysql_connect("localhost","root","");

				mysql_select_db("tracenoizer");

				$get = 'select usr_id from users where usr_name="'.$usr_name.'"';

				$result = mysql_query($get) or die (mysql_error());

				$usr_exist = mysql_fetch_row($result);

				$usr_exist = $usr_exist[0];

				if ($usr_exist || $usr_pw != $confpwd){

				
				if ($usr_exist){
					$string1 ='<b>Sorry! This Username already exists.</b><br>';
					$usr_name = '';
				}
				
				if ($usr_pw != $confpwd){
					$string2 ='<b>Sorry! Your passwords didn\'t match.</b><br>';
					$usr_pw='';
					$confpwd='';
				}
				

				echo'
		<html>

		<head>
		<title>TraceNoizer - C C C </title>
		</head>


		<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" background="images/main_bg.gif">
		
		<form name="queryform" action="navV3.php" method="post">
		
		<font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="000000">';

				echo $string1;
				echo $string2;

				echo'
		</font>
		
		<table border="0" cellspacing="0" cellpadding="3">
			<tr>
				 <td><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="ff3300"><b>Username: </b><input type="text" name="usr_name" value="'.$usr_name.'" size="9"></font></td>
				 <td><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="ff3300"><b>&nbsp;&nbsp; Password: </b><input type="password" name="usr_pw" value="'.$usr_pw.'" size="9"></font></td>
				 <td><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="ff3300"><b>&nbsp;&nbsp; Confirm Password: </b><input type="password" name="confpwd" value="'.$confpwd.'" size="9"></font></td>
			</tr>
			<tr>
				<td colspan="2"><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="2" color="ff3300"> </b></font></td>
				<td align="right" valign="bottom"><input type="hidden" name="usr_id" value="'.$usr_id.'"><input type="hidden" name="main_id" value="'.$main_id.'"><input type="submit" name="status" value="create"></td>
			</tr>
		</table>
		
		</form>
		
		</body>
		</html>';

				} else { 

				
				
				

				$put = 'update users set usr_name="'.$usr_name.'",usr_pw="'.$usr_pw.'",usr_mail="'.$usr_mail.'" where usr_id='.$usr_id.'';

				//echo $put;

				//mysql_query('update users set usr_name="'.$usr_name.'",usr_pw="'.$usr_pw.'",usr_mail="'.$usr_mail.'" where usr_id='.$usr_id.'') or die (mysql_error());

				mysql_query($put) or die (mysql_error());

				//system ("/usr/bin/perl /home/tracenoizer/public_html/forwardV3up.pl $usr_id $main_id");	
				system ("/usr/bin/perl /var/www/uploadV3.pl $usr_id $main_id");
				
				echo '<html><head><meta http-equiv="refresh" content="0;URL=uploadcontrolV3.php?main_id='.$main_id.'"></head></html>';
				

				//echo 'system ("/usr/bin/perl /home/tracenoizer/public_html/forwardV3up.pl '.$usr_id.'  '. $main_id. '")';

		}
	}
?>

