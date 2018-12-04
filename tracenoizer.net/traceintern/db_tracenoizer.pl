#/usr/bin/perl

#######################################################
###		make_db_liste.pl							###
###		founded 100405	12.30  fabian 				###
###		last modified 100405	12.30  fabian 		###
#######################################################

use DBI;

connect_db();


sub connect_db{
    my $server = "localhost";
    my $db = "tracenoizer";
    $dbh = DBI->connect ("DBI:mysql:$db:$server",'root','');
    if (not $dbh){
	print "no connection to the db";
    }
}

			
sub tablecreate{
    my $inhalt = $_[0];
    print $inhalt."\n";
    my $tablemake = $dbh->prepare($inhalt);
    $tablemake->execute;
}


######################################### MAIN 
# tablecreate("create table main(main_id int not null auto_increment, Index(main_id),
#			main_date date,main_usr_id int, index(main_usr_id),main_generation int, 
#index(main_generation),main_weblink tinytext, 
#			main_ac_id int,index(main_ac_id), main_html text, main_st_id int, index(main_st_id))");

######################################### INPUT
#
#tablecreate("create table input(in_id int not null auto_increment, Index(in_id),
#			in_main_id int,index (in_main_id), in_keyword tinytext)");

######################################### URL
#tablecreate("create table url(url_id int not null auto_increment, Index(url_id),
#		url_main_id int, index(url_main_id),url text)");



######################################### TEXT
tablecreate("create table text(tx_id int not null auto_increment, Index(tx_id),
		tx_main_id int, Index(tx_main_id), tx_url_id int, Index(tx_url_id), tx_word int, Index (tx_word), tx_text longtext, tx_lang char(2), 
index(tx_lang))");



######################################### KEYWORD
#tablecreate("create table keyword(keyword_id int  not null auto_increment, Index(keyword_id),
#			keyword_main_id int, index(keyword_main_id),keyword char (255), index (keyword), 
#keyword_infog float(11,9),keyword_html text, keyword_size
# int, index (keyword_size), index (keyword_main_id,keyword))");

######################################### IMAGE
#tablecreate("create table image(img_id int not null auto_increment, Index(img_id),
#			img_url_id int, index(img_url_id), img_used int(1),index(img_used), img_link text)");


######################################### ACCOUNTS
#tablecreate("create table accounts(ac_id int  not null auto_increment, Index(ac_id),
#			ac_name tinytext, ac_pw tinytext, ac_ftp tinytext, ac_used int,index(ac_used),
#			ac_http tinytext,ac_path tinytext)");
######################################### PAGE

#tablecreate("create table page(pg_id int  not null auto_increment, Index(pg_id),
#			pg_url_id text, pg_link text)");
#
######################################### globalURL
tablecreate("create table globalurl (g_id int not null auto_increment, index(g_id),
 			g_url_id int, index(g_url_id), g_used int(1), index (g_used), g_string text)");

exit;
######################################### mailURL
tablecreate("create table mailurl(m_id int not null auto_increment, index(m_id),
 			m_url_id int,index(m_url_id),m_used int(1),index(m_used),m_string tinytext)");

	
######################################### WORDCOUNT 
tablecreate("create table wordcount(wordcount_id int not null auto_increment, Index(wordcount_id), 
wordcount_tx_id int not null,index(wordcount_tx_id),
	 wordcount_keyword_id int not null,index(wordcount_keyword_id), wordcount_infog float(11,9))");



######################################### USERS 

tablecreate("create table users(usr_id int not null auto_increment, index (usr_id), usr_name char(30)
 not null, index(usr_name),usr_pw tinytext,usr_mail 
tinytext, unique(usr_name))");



######################################### status

tablecreate("create table status (st_id int , index(st_id), st_string tinytext)"); 




##open db, delete and refill table
##--------------------------------    
 
@id = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9","10");
@string = ("searching", "downloading", "extracting data", "prepareing analyse", "analysing", "producing HTML", "uploading", "online", "removed","there are 
no links for this person","there are to less information for this person");
 
  
print "open db, delete and refill table\n";
 
 
 
 
for($i = 0; $i < @id; $i++){
my $insert = $dbh->prepare("insert into status (st_id, st_string) values ('$id[$i]', '$string[$i]')");
 $insert->execute;   

print "status".$i." = ".$string[$i]."\n";
};
 
        












