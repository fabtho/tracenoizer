# Restauration for Tracenoizer in 2018

## Main difference to 2011 Version (Running on tracenoizer.net) 

### config.ini

Now confidential configurations like db connection and api key are not hardcoded and written down in several files anymore.

config.ini is the file where db config and api keys are stored, see tracenoizer.net/config.ini.example

### update mysql connection for PHP 7

now mysqli_ is used, not outdated  mysql_ used

### db connection for php is centralized in new file

see tracenoizer.net/db_connect.php

### Handling of POST and GET is changed. 

In the old days $var could be used directly from url?var=test. Now PHP only allows $_GET['var'] or  $_POST['var'] 
 
### Google Custom Search is used for Search

see below

### replace with &apos; in html code to prevent this bug:

```DBD::mysql::st execute failed: You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'll do our best to improve things and get you the information you need. . Franz M' at line 1 at trace_centralV4.pl line 860.```
 


## trace_centralV4.pl should also use config.ini for DB Conenction

Using Config::IniFiles from cpan (https://metacpan.org/pod/Config::IniFiles)

```
cpan
```

to see all installed modules, use this
```
cpan -l
```

```
install Config::IniFiles
```

## trace_centralV4.pl restore google search

### Google Cpan Modules

* https://metacpan.org/pod/WWW::Google::CustomSearch
* https://metacpan.org/pod/WWW::Google::CustomSearch::Result
* https://metacpan.org/pod/WWW::Google::CustomSearch::Item

Installation of Google CostumSearch for perl
```
cpan
install WWW::Google::CustomSearch
```

### Google Custom Search API (CSE) for Tracenoizer

https://stackoverflow.com/questions/4082966/what-are-the-alternatives-now-that-the-google-web-search-api-has-been-deprecated

Account of sammlung.tracenoizer@gmail.com (Do not send any mail to this account, its not checked)

 * https://cse.google.com/cse/all
 * https://developers.google.com/custom-search/v1/cse/list

 * Public Search: https://cse.google.com/cse?cx=005586137235572118471:emva1jwhri4
 * API Call Stats: https://console.developers.google.com/apis/dashboard?folder&project=tracenoizer


### Usage

For every run there are two searches,  "Firstname Secondname" and "Secondname Firstname"

## Software

### puf - Parallel URL fetcher 

puf is able to download in parallel, thus faster then wget or curl

in 2001 tracenoizer used puf-0.9.1beta6.tar

see install_tracnoizer.tar for original software used or here https://sourceforge.net/projects/puf/

`
tar -zxf puf-1.0.0.tar.gz
cd puf-1.0.0
./configure
make
cd src
./puf -h
make install
`

puff cannot get https content, so replaced with curl in fc2374dfcc58f149bea3109ff5bc9d2620cd55dd 

### rainbow

Rainbow is a program that performs statistical text classification.

Documentation:

 * https://www.cs.cmu.edu/~mccallum/bow/rainbow/
 * http://archive.is/Wjp6o
 * http://archive.is/download/Wjp6o.zip

Source Code:

 * http://www.cs.cmu.edu/~mccallum/bow/src/
 * http://archive.is/otho7
 * http://archive.is/download/otho7.zip

### Usage of compiled version from 2003

I have a compiled version from 2003, after installing some 32 bit library I was able to run it again.

tracenoizer/tracenoizer.net/public_html/rainbow
      
`
apt-get install lib32z1
`

### compile rainbow (not working)

Rainbow is not to compile with gcc version 5 on Ubuntu 12. There are some errors. By uncommenting them, I was able to reduce them, but was not able to get a executable code. And even there would be some function missing. Also failed to compile with older gcc version.

https://askubuntu.com/questions/923337/installing-an-older-gcc-version3-4-3-on-ubuntu-14-04-currently-4-8-installed

`
wget http://www.cs.cmu.edu/~mccallum/bow/src/bow-20020213.tar.gz
tar -zxf bow-20020213.tar.gz
cd bow-20020213
CPPFLAGS='-w' CC='gcc -traditional'  ./configure --prefix=/usr/local/
make
`
make throws this error:

`
^./bow/libbow.h: At top level:
./bow/libbow.h:2071:26: error: array type has incomplete element type ‘struct argp_child’
 extern struct argp_child bow_argp_children[];
                          ^
array.c: In function ‘bow_array_new_with_entry_size_from_data_fp’:
./bow/libbow.h:1591:5: warning: function with qualified void return type called
     _bow_error (FORMAT , ## ARGS);   \
     ^
array.c:195:4: note: in expansion of macro ‘bow_error’
    bow_error ("Proper header not found in file.");
    ^
Makefile:90: recipe for target 'array.o' failed
make: *** [array.o] Error 
`

### Testcommands & important URL

```
perl trace_centralV4.pl 14 'Franz Mueller'
```

```
http://tracenoizer.net/control_firstV4.php?userID=4
```



## Tracenoizer im Web (Stand Jan. 2017)

2001:

 * Plug-In: http://www.iplugin.ch/kalender/archiv/archiv/detail/article/tracenoizerorg/

## Ausstellung von Tracenoizer

 * 2002 Kontrollfelder - Programmieren als künstlerische Praxis, hartware medien kunst verein in Dortmund/Deutschland (020227_tracenoizer_mailingliste)

