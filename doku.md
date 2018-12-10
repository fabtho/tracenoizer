
## Tracenoizer im Web (Stand Jan. 2017)

2001:

 * Plug-In: http://www.iplugin.ch/kalender/archiv/archiv/detail/article/tracenoizerorg/

## Ausstellung von Tracenoizer

 * 2002 Kontrollfelder - Programmieren als künstlerische Praxis, hartware medien kunst verein in Dortmund/Deutschland (020227_tracenoizer_mailingliste)



### restauration

# mysql anbindung php neu machen


# mysql perl anpassen machen



testen mit, 1 ist user_id von  Datenbank
```
/usr/bin/perl trace_centralV4.pl 1 'Fabian Thommen'
```


## trace_centralV4.pl sollte auch config.ini nutzen für db info

damit kein pw im code, also auch config.ini auslesen
cpan benutzen und  Config::IniFiles installieren, von https://metacpan.org/pod/Config::IniFiles

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


## trace_centralV4.pl googel anfragen neu machen

### Links

#### Google Cpan Modules

https://metacpan.org/pod/WWW::Google::CustomSearch
https://metacpan.org/pod/WWW::Google::CustomSearch::Result
https://metacpan.org/pod/WWW::Google::CustomSearch::Item

#### Google Custom Search API

https://developers.google.com/custom-search/v1/cse/list

#### Other Stuff

https://stackoverflow.com/questions/4082966/what-are-the-alternatives-now-that-the-google-web-search-api-has-been-deprecated

Installation of googel CostumSearch for perl
```
cpan
install WWW::Google::CustomSearch
```

## Software

### puf - Parallel URL fetcher 

puf is able to download in parallel, thus faster then wget or curl

in 2001 tracenoizer used puf-0.9.1beta6.tar

see install_tracnoizer.tar for original software used

https://sourceforge.net/projects/puf/

`
tar -zxf puf-1.0.0.tar.gz
cd puf-1.0.0
./configure
make
cd src
./puf -h
make install
`

installs puf to /usr/local/bin/puf


### rainbow

Rainbow is a program that performs statistical text classification.

Docu:

https://www.cs.cmu.edu/~mccallum/bow/rainbow/
http://archive.is/Wjp6o
http://archive.is/download/Wjp6o.zip

src:

http://www.cs.cmu.edu/~mccallum/bow/src/
http://archive.is/otho7
http://archive.is/download/otho7.zip

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

rainbow is not to compile with gcc version 5 on Ubuntu 12. There are some errors. By uncommenting them, I was able to reduce them, but was not able to get a executable code. And even there would be some funtion missing. Also faild to compile with older gcc version.

https://askubuntu.com/questions/923337/installing-an-older-gcc-version3-4-3-on-ubuntu-14-04-currently-4-8-installed


I have a compiled version from 2003, after installing some 32 bit library I was able to run it again.

`
apt-get install lib32z1
`

## Suchmaschinen Anbindung

For every run there are two searches,  "Firstname Secondname" and "Secondname Firstname"

Runns

6