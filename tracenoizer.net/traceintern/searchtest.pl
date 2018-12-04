#/usr/bin/perl 

use WWW::Search;

my $search = new WWW::Search('Yahoo');
           $search->native_query(WWW::Search::escape_query('fabian Thommen'));
           while (my $result = $search->next_result())
             {
             print $result->url, "\n";
             }
