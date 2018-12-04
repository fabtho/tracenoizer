#!/usr/bin/perl



use Net::Google;
use constant LOCAL_GOOGLE_KEY => "HQT6+fFQFHJvj5Rin+Fh6WXYimfvC89S";

my $google = Net::Google->new(key=>LOCAL_GOOGLE_KEY);
my $search = $google->search();

 # Search interface

$search->query(qw("martin krung"));
$search->lr(qw());
$search->ie("utf8");
$search->oe("utf8");
$search->starts_at(0);
$search->max_results(10);


foreach my $r (@{$search->response()}) {
    @list = ();        
    map { push @list,$_->URL();}@{$r->resultElements()};
    
}



foreach $name (@list) {
    print "url=$name.\n";
}


 # Spelling interface

#print $google->spelling(phrase=>"muntreal qwebec")->suggest(),"\n";

 # Cache interface

#my $cache = $google->cache(url=>"http://search.cpan.org/recent");
#print $cache->get();



