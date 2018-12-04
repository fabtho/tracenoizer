use Config;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'HTTP::WebTest',
    'VERSION_FROM' => 'WebTest.pm', # finds $VERSION
    'LIBS'	=> [''],   # e.g., '-lm'
    'DEFINE'	=> '',     # e.g., '-DHAVE_SOMETHING'
    'INC'	=> '',     # e.g., '-I/usr/include/other'
    'AUTHOR'    => 'Richard Anderson <Richard.Anderson@unixscripts.com>',
    'ABSTRACT'  => 'Run tests on remote URLs or local web files',
    'EXE_FILES' => ['wt'],
    'PREREQ_PM' => { File::Temp            => 0,
		     HTTP::Request::Common => 0,
                     HTTP::Response        => 0,
                     LWP::UserAgent        => 0,
                     Net::Domain           => 0,
                     Net::SMTP             => 0,
                     Term::ReadKey         => 0,
                     Time::HiRes           => 0,
                     URI::URL              => 0 }
);

sub MY::postamble {
   my $response = undef;
   my $apachedir = undef;
#
# Verify standard input and output are attached to a terminal and we
# don't run on Win32 system
   if (-t STDIN and -t STDOUT and $^O ne 'MSWin32' ) {
#
# Prompt for name of http-webtest installation directory
      print STDOUT "HTTP-WebTest requires installation of the http-webtest ",
                   "directory\n",
                   "for running local file tests. If you don't use local ",
		   "file tests you\n",
		   "can skip installation of this directory.\n",
                   "Install http-webtest directory? (y/n): ";
      chomp($response = <STDIN>);
      if($response =~ /^y(es)?$/i) {
	 $apachedir = '/usr/local/etc';
         print STDOUT "Default directory to install the http-webtest ",
                      "directory in is /usr/local/etc,\n",
                      "but you should probably use another location if MYSQL ",
                      "is installed.\n";
         print STDOUT "Install http-webtest directory ",
                      "in /usr/local/etc? (y/n): ";
         chomp($response = <STDIN>);
         until ($response =~ /^y(es)?$/i)
         {
            print STDOUT "Enter directory that will contain http-webtest "
               . "directory: ";
            chomp($response = <STDIN>);
            if (-d $response) {
               $apachedir = $response;
               $response = 'y';
            } else {
               print STDOUT "ERROR: $response is not a valid directory\n";
            }
	}
      }
   }
   my $makefile = defined $apachedir ? <<EOF : '';

pure_install ::
	-\@\$(CP) -r http-webtest $apachedir

EOF
#
# Add pathname of Perl to wt file
   open(WT, ">wt") or die "Can't open file wt: $!";
   print WT "$Config{startperl} -w\n";
   open(WT_DIST, "<wt_dist") or die "Can't open file wt_dist: $!";
   open(WT, ">>wt") or die "Can't open file wt: $!";
   while (<WT_DIST>) {
      print WT;
   }
   close WT;
   close WT_DIST;
   chmod 0755, 'wt';

   print "\nWARNING: If your system does not have an HTTP connection to ",
         "the Internet or\n",
         "your system requires a proxy HTTP server, the \"make test\" tests ",
         "will fail.\n\n";
   return $makefile;
}
