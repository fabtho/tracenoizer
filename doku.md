
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