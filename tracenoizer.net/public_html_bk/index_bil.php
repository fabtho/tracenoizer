<?php

if(!isset($cont)) {
	$cont = 'html/start.html';
} else {
	$suf = explode('.', $cont);
	
	if($suf[count($suf)-1] == "php"){
		
		$url = explode('/', $cont);
		$cont = $url[count($url)-1];
	} else{
	
	
		$url = explode('/', $cont);
		$cont = 'html/'.$url[count($url)-1];
		
		
		if(strpos($cont, "_de.") > 0){
			//wechsle zu englisch
			$tmp = explode("_de", $cont);
			$newcont = $tmp[0].$tmp[1];
			
			if(file_exists($newcont)){
				$cont = $newcont;
				$lang = "";
			}
		
		
		} else {
			//wechsle zu deutsch
			$tmp = explode(".", $cont);
			$newcont = $tmp[0].'_de.'.$tmp[1];
			
			if(file_exists($newcont)){
				$cont = $newcont;
				$lang = "_de";
			}
		}
	}
}

echo '
<html>
<head>
<title>TranceNoizer</title>
</head>
<meta http-equiv="Content-type" content="text/html;charset=iso-8859-1">
<meta name="Copyright"          content="Copyright ©2001 by LAN">
<meta http-equiv="Author"       name="Author"   content="LAN, DH">
<meta name="Language"           content="de">
<meta name="Keywords"           lang="en"       content="tracenoizer, clone, klon, information, disinformation">
<meta name="Description"        lang="en"       content="TraceNoizer generates clones from your databody in order to disinform those, who are spying on you.">
<meta name="Revisit-after"      content="1 months">
<meta name="Date_modified"      content="Datum (2001-11-03)">
<meta name="Robots"             content="index,follow">
<frameset rows="10,339,10" frameborder="NO" framespacing="0"border="0"> 
  <frame name="oben" src="html/rand.html" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
  <frameset cols="18,*,18" frameborder="NO" framespacing="0" border="0"> 
    <frame name="links" src="html/rand.html" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
    <frameset rows="*,65" frameborder="NO" framespacing="0" border="0"> 
      <frameset cols="206,*" frameborder="NO" framespacing="0" border="0"> 
        <frame name="left" src="html/left'.$lang.'.html" noresize frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
        <frameset rows="115,*" frameborder="NO" framespacing="0" border="0"> 
          <frame name="top" src="html/top'.$lang.'.html" noresize frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
          <frameset cols="1,*,16" frameborder="NO" framespacing="0" border="0"> 
            <frame name="main_l" src="html/rand_l_innen.html" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
            <frameset rows="1,*,1" frameborder="NO" framespacing="0" border="0"> 
              <frame name="main_o" src="html/rand_o_innen.html" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
              <frame name="main" src="'.$cont.'" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="auto">
              <frame name="main_u" src="html/rand_u_innen.html" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
            </frameset>
            <frame name="main_r" src="html/rand_r_innen.html" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
          </frameset>
        </frameset>
      </frameset>
      <frame name="below" src="html/below'.$lang.'.html" noresize scrolling="NO">
    </frameset>
    <frame name="rechts" src="html/rand.html" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
  </frameset>
  <frame name="unten" src="html/rand.html" frameborder="0" framespacing="0" border="0" marginwidth="0" marginheight="0" scrolling="NO">
</frameset>
<noframes></noframes> 
<body><noframes>
www.TraceNoizer.org<br>
<a href="http://www.TraceNoizer.org">TraceNoizer</a><br>
TraceNoizer generates clones from your databody in order to disinform those, who 
are spying on you. 
cont = '.$cont.'
</noframes> 
</body>
</html>
';

?>