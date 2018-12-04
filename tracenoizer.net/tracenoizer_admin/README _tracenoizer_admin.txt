
########clean_db_tracenoizer_main_id.pl $ARGV[0]

loescht alle eintrage in db wo main = $ARGV[0]

########clean_db_tracenoizer_usr_id.pl $ARGV[0]

loescht alle eintrage in db wo usr = $ARGV[0]
loescht auch usr


########clean_db_tracenoizer_isnull.pl


sucht alle  leeren datebankeeintrage und ermittelt deren $main löscht dann die 
main mit perl clean_db_tracenoizer_main_id.pl $main_id


########db_tracenoizer.pl

legt db an und fuellt stati

########fill_ftp.pl

fuellt accounts in db mit ftp accounts

########ftptest.pl

testet ob die ftpaccounts erreichbar sind

########keyword2file.pl

list alle keywords aus der db aus

########klonschub.pl

startet nacheinadner mehrer makeclone 

########makeclone.pl

startet makeclone.pl  $ARGV[0]

wo clone generation = $ARGV[0] und macht eine klongenaration


######## klon_central.pl

klon_central.pl  $ARGV[0]  $ARGV[1]  $ARGV[2]

dabei # $ARGV[0] = $old_main_id, $ARGV[1] = $main_id,   $ARGV[2] usr_id

hier findet das eingeltlich klonen statt

####stoplist

stopliste fuer rainbow