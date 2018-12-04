<html>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" background="images/main_bg.gif">

<?php

ignore_user_abort();

//echo $status;

//echo php_info();

// different forms are called

switch($status)

	{
	
		case "":
		
	/*echo'		<html>


<font size=+3>The tracenoizer service is temporarily not available because of maintenance work and software updates.<br>
We are sorry for any inconvenience.
<br>
<br>
<a href="mailto:traceDELETE_THE_CAPITAL_LETTERSnoizer at
www2.snm-hgkz.ch">Administrator: 
tr
aceDELETE_THE_CAPITAL_LETTERSnoizer at www2.snm-hgkz.ch</a>
</font>

<html>';*/

		
	firstform("the disinformation will be based on your name","run");
		break;
		case "run":
		
			if($Fname==""||$Sname==""){
			
			firstform('<STRONG><BR><font color="ff3300"> you have to fill out the form</font></STRONG>','run');
			} else {
			maketempuser($Fname,$Sname);
					
			}	
		break;
	}
function maketempuser($Fname,$Sname)
				{
				mysql_connect("localhost","root","");
				mysql_select_db("tracenoizer");
				$get = 'select max(usr_id) from users';
				$result = mysql_query("$get") or die (mysql_error());
				$max_id = mysql_fetch_row($result);
				$max_id = $max_id[0];
				$usr_id_neu = $max_id + 1;
						
				$insert = 'insert into users(usr_name)values("'.$usr_id_neu.'")';

				$ask_user = mysql_query("$insert") or die (mysql_error());
				
				//--> getMax from MAIN		
				$result = mysql_query("select max(main_id) from main") or die (mysql_error());
				$max_id = mysql_fetch_row($result);
				$max_id = $max_id[0];
				$main_id_neu = $max_id + 1;
 
				//--> insert into MAIN
				$fill_main = 'insert into main (main_date,main_usr_id,main_generation)values(CURRENT_DATE(),"'.$usr_id_neu.'",1)';
				$ask_main = mysql_query($fill_main) or die (mysql_error());

			
				 $Qname = "'$Fname $Sname'";
				 
				 //echo  'system ("/usr/bin/perl /home/tracenoizer/public_html/forwardV3.pl '. $main_id_neu . $Qname .'")';
				 system ("/usr/bin/perl forwardV4.pl $main_id_neu $Qname");
				 echo '<meta http-equiv="refresh" content="0;URL=control_firstV4.php?userID='.$usr_id_neu.'">';

				}

function firstform($title,$formvalue){

$link = mysql_connect("localhost","root","");


echo '<form name="queryform" action="start.php" method="post">
		<div align="left">
<table border="0" cellpadding="0" cellspacing="30"><tr><td>

		<table border="0" cellspacing="0" cellpadding="0">
					<tr>
					 <td valign="top"><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3" size="3" color="000000"><STRONG>AND FEED THE NOIZER!</STRONG><BR>'.$title.'</font></td>
					</tr>		
					<tr>
					 <td>&nbsp;</td>
					</tr>
					<tr>
					 <td><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3" size="2" color="ff3300">YOUR FIRST_NAME</font></td>
					</tr>
					<tr>
					 <td><input type="text" name="Fname"></td>
					</tr>
					<tr>
					 <td><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3" size="2" color="ff3300">YOUR SUR_NAME</font></td>
					</tr>
					<tr>
					<td><input type="text" name="Sname"></td>
					</tr>		
					<tr>
					 <td>&nbsp;</td>
					</tr>
					<tr>
					 <td align="left"><input type="submit" name="status" value="'.$formvalue.'"><font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular" size="3" size="2" color="ff3300"> Run Tracenoizer+</font></td>
					</tr>

		</table>
</td></tr></table></form>
';
}

?>
</body>
</html>
