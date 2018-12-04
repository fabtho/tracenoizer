package HTTP::WebTest;

=head1 NAME

HTTP::WebTest - Test remote URLs or local web files

=head1 SYNOPSIS

 This module can accept input parameters from a parameter file
 or subroutine arguments.

 TO RUN WEB TESTS DEFINED BY SUBROUTINE ARGUMENTS:

 use HTTP::WebTest qw(run_web_test);
 run_web_test(\@web_tests, \$num_fail, \$num_succeed, \%test_options)

 or

 use HTTP::WebTest qw(run_web_test);
 run_web_test(\@web_tests, \$num_fail, \$num_succeed)

 TO RUN WEB TESTS DEFINED BY A PARAMETER FILE:

 use sigtrap qw(die normal-signals); # Recommended, not necessary
 use HTTP::WebTest;
 $webtest = HTTP::WebTest->new();
 $webtest->web_test('my_web_tests.wt', \$num_fail, \$num_succeed);

 The web_test() method has an option to test a local file by
 starting Apache on a private port, copying the file to a temporary
 htdocs directory and fetching the page from Apache.  If you are
 testing with multiple parameter files, you can avoid restarting
 Apache each time by calling new() only once and recycling the object:

 use sigtrap qw(die normal-signals); # Recommended, not necessary
 use HTTP::WebTest;
 $webtest = HTTP::WebTest->new();
 foreach $file (@ARGV) {
    $webtest->web_test($file, \$num_fail, \$num_succeed);
 }

 TO ENABLE DEBUGGING MESSAGES (OUTPUT TO STDOUT):

 If you are calling the web_test method, use the debug parameter.
 If you are calling the run_web_test method, do this:

 use HTTP::WebTest qw(run_web_test);
 $HTTP::WebTest::Debug = 1; # Diagnostic messages
 $HTTP::WebTest::Debug = 2; # Messages and preserve temp Apache dir
 run_web_test(\@web_tests, \$num_fail, \$num_succeed)

=head1 DESCRIPTION

This module runs tests on remote URLs or local web files containing
Perl/JSP/HTML/JavaScript/etc. and generates a detailed test report.

The test specifications can be read from a parameter file or
input as method arguments.  If you are testing a local file, Apache
is started on a private/dynamic port with a configuration file in a
temporary directory.  The module displays the test results on the
terminal by default or directs them to a file.  The module optionally
e-mails the test results.

Each URL/web file is tested by fetching it from the web server using
a local instance of an HTTP user agent.  The basic test is simply
whether or not the fetch was successful.  You may also test using
literal strings or regular expressions that are either required to
exist or forbidden to exist in the fetched page.  You may also
specify tests for the minimum and maximum number of bytes in the
returned page.  You may also specify tests for the minimum and
maximum web server response time.

If you are testing a local file, the module checks the error log in
the temporary directory before and after the file is fetched from
Apache.  If messages are written to the error log during the fetch,
the module flags this as an error and writes the messages to the
output test report.

The wt script is provided for running HTTP::WebTest from the command
line.

Data flow for HTTP::WebTest using a remote URL:

          --------------              -------------
          |            |              |           |
          | Input      |------------->|  WebTest  |
          | parameters |              |           |
          |            |              -------------
          --------------                  |   ^
                                          |   |
                                          V   |
          -------------               ------------
          |           |    request    |          |
          | Remote    |<--------------|   HTTP   |
          | webserver |-------------->|   user   |
          |           |    response   |   agent  |
          -------------               |          |
                                      ------------

Data flow diagram for HTTP::WebTest using a local web file:

          --------------           ---------------------
          |            |           |                   |
          | Input      |           |  Web page code    |
          | parameters |           |  (Perl/HTML/etc.) |
          |            |           |                   |
          --------------           ---------------------
                |                            |
                |  ---------------------------
                |  |
                V  V              ------------------------
          -------------           |                      |
          |           |---------->| Temporary Apache     |
          |  WebTest  |           | directories (htdocs, |
          |           |<----------| conf, logs)          |
          -------------           |                      |
              |  ^                ------------------------
              |  |                        |    ^
              V  |                        V    |
          ------------             ----------------------
          |          |   request   |                    |
          |   HTTP   |------------>| Temporary local    |
          |   user   |             | instance of Apache |
          |   agent  |<------------|                    |
          |          |   response  ----------------------
          ------------

=head1 METHODS

=cut

require 5.005;
require Exporter;
use strict;

use Cwd qw(cwd);
use File::Basename qw(fileparse);
use File::Copy qw(copy);
use File::Find qw(find);
use File::Path qw(rmtree);
use File::Temp qw(tempdir);
use HTTP::Request::Common qw(GET POST);
use HTTP::Response qw(code content is_error status_line);
use LWP::UserAgent qw(agent request);
use Net::Domain qw(hostfqdn);
use Net::SMTP;
use Sys::Hostname qw(hostname);
use Term::ReadKey qw(ReadMode ReadLine);
use Time::HiRes qw/ gettimeofday /;
use URI::URL;

###########################
# Class (package) globals #
###########################

use vars qw($AUTHOR $Debug @EXPORT_OK @ISA $VERSION);
$AUTHOR = 'Richard Anderson <Richard.Anderson@unixscripts.com>';
$Debug = 0;
@ISA = qw(Exporter);
@EXPORT_OK = qw(run_web_test);
$VERSION = 1.07;

#############################
# Constants (magic numbers) #
#############################

# Default max time to wait for Apache
sub DEFAULT_MAX_APACHE_WAIT_SECONDS () { return 64; };
#
# Initial time to wait for Apache to start
sub INITIAL_APACHE_WAIT_SECONDS () { return 4; };
#
# Maximum time to wait for Apache
sub MAX_APACHE_WAIT_SECONDS () { return 600; };
#
# Minimum upper bound to wait for Apache
sub MIN_APACHE_WAIT_SECONDS () { return 10; };
#
# Permissions for creating directories, user's umask is superimposed on this
sub DIR_MODE () { return 0755; };
#
# Minimum number of cookie arguments
sub MIN_COOKIE_ARGS () { return 5; };
#
# Range for private/dynamic ports, see http://www.iana.org/numbers.html
sub MAX_PRIVATE_PORT () { return 65535; };
sub MIN_PRIVATE_PORT () { return 49152; };
#
# Maximum number of cookie arguments that do not require reformatting cookie
sub NCOOKIE_REFORMAT () { return 10; };

###################
# Other constants #
###################
#
# Allowed types for Apache input parameters/arguments
my %_APACHE_PARAMS = (
   apache_dir         => 'scalar',
   apache_exec        => 'scalar',
   apache_loglevel    => 'scalar',
   apache_max_wait    => 'scalar',
   apache_options     => 'scalar',
   include_file_path  => 'list',   # With an even number of elements
);
#
# Input parameters/arguments that have a Boolean value
my %_BOOLEAN = (
   accept_cookies   => 'arbitrary_value',
   ignore_error_log => 'arbitrary_value',
   ignore_case      => 'arbitrary_value',
   send_cookies     => 'arbitrary_value',
   show_cookies     => 'arbitrary_value',
   show_html        => 'arbitrary_value',
);
#
# Mapping of values for debug parameter
my %_DEBUG = (
   no       => 0,
   yes      => 1,
   preserve => 2,
);
#
# Allowed values of apache_loglevel parameter
my %_LOGLEVEL = (
   debug  => 'arbitrary_value',
   info   => 'arbitrary_value',
   notice => 'arbitrary_value',
   warn   => 'arbitrary_value',
   error  => 'arbitrary_value',
   crit   => 'arbitrary_value',
   alert  => 'arbitrary_value',
   emerg  => 'arbitrary_value',
);
#
# Allowed values of mail parameter/argument
my %_MAIL = (
   no      => 'arbitrary_value',
   errors  => 'arbitrary_value',
   all     => 'arbitrary_value',
);
#
# Allowed values of save_output parameter/argument
my %_SAVE_OUTPUT = (
   no       => 'arbitrary_value',
   yes      => 'arbitrary_value',
   preserve => 'arbitrary_value',
);
#
# Allowed values of terse parameter/argument
my %_TERSE = (
   summary      => 'arbitrary_value',
   failed_only  => 'arbitrary_value',
   no           => 'arbitrary_value',
);
#
# Allowed types for test_options input parameters/arguments (global params)
my %_TEST_OPTIONS_PARAMS = (
   accept_cookies   => 'scalar',
   auth             => 'list',   # Two-element list
   debug            => 'scalar',
   ignore_error_log => 'scalar',
   ignore_case      => 'scalar',
   mail             => 'scalar',
   mail_addresses   => 'list',
   mail_from        => 'scalar',
   mail_server      => 'scalar',
   max_bytes        => 'scalar',
   max_rtime        => 'scalar',
   min_bytes        => 'scalar',
   min_rtime        => 'scalar',
   pauth            => 'list',   # Two-element list
   proxies          => 'list',   # With an even number of elements
   regex_forbid     => 'list',
   regex_require    => 'list',
   save_output      => 'scalar',
   send_cookies     => 'scalar',
   show_html        => 'scalar',
   show_cookies     => 'scalar',
   terse            => 'scalar',
   text_forbid      => 'list',
   text_require     => 'list',
);
#
# Allowed values for Boolean input parameters/arguments
my %_YES_NO = (
   yes => 'arbitrary_value',
   no  => 'arbitrary_value',
);
#
# Allowed types for web_tests parameters/arguments (test block parameters)
my %_WEB_TEST_PARAMS = (
   accept_cookies   => 'scalar',
   auth             => 'list',   # Two-element list
   cookie           => 'list',   # Arrayref of arrayrefs
   file_path        => 'list',   # Two-element list
   ignore_error_log => 'scalar',
   ignore_case      => 'scalar',
   max_bytes        => 'scalar',
   max_rtime        => 'scalar',
   method           => 'scalar',
   min_bytes        => 'scalar',
   min_rtime        => 'scalar',
   params           => 'list',   # With an even number of elements
   pauth            => 'list',   # Two-element list
   regex_forbid     => 'list',
   regex_require    => 'list',
   send_cookies     => 'scalar',
   show_html        => 'scalar',
   test_name        => 'scalar',
   text_forbid      => 'list',
   text_require     => 'list',
   url              => 'scalar',
);

#####################################
# Class (package) private variables #
#####################################

my (
   $_web_test_tmp,   # Anonymous hashref, temp cache for test block parameters
   $_fh_out          # Filehandle for output (test report)
);

######################################
# Private methods, Level -4 (lowest) #
######################################

my $_copy_file = sub {
#
# Description:
# Copy a file to a root directory concatenated with a relative pathname,
# creating directories as needed.  The basename of the file is preserved.
#
# Synopsis: $_copy_file->($file, $root_dir, $rel_path, \$target_file);
#
# Input arguments:
# $file - File to copy.
# $root_dir - Absolute pathname of root directory.  This directory must exist.
# $rel_path - Relative pathname that is appended to $root_dir.  These
#            subdirectories will be created if they don't exist.
#
# Output arguments:
# \$target_file - Pathname of file that was created, relative to $root_dir.
#
# Return values:
# 1 -> No error
# 0 -> Error copying file or creating directory
#
   my ($file, $root_dir, $rel_path, $target_file) = @_;
   my ($base, $dir, $ext, @subdirs, $current_dir);
   unless (-d "$root_dir/$rel_path") {
      unless (-d $root_dir) {
         warn "ERROR: directory $root_dir not found";
         return 0;
      }
      @subdirs = split /\//, $rel_path;
      $current_dir = $root_dir;
      foreach (@subdirs) {
	 next if $_ eq '.';
	 $current_dir .= "/$_";
	 next if -d "$current_dir";
	 unless (mkdir("$current_dir", DIR_MODE)) {
	    warn "Can't create directory $current_dir: $!";
	    return 0;
	 }
      }
   }
   ($base, $dir, $ext) = fileparse($file, '\..*?');
   $$target_file = "$rel_path/$base$ext";
   unless (copy($file, "$root_dir/$$target_file")) {
      warn "ERROR: can't copy $file to $root_dir/$$target_file: $!";
      return 0;
   }
   return 1;
};

my $_count_error_log = sub {
#
# Description:
# On the first call, counts the number of lines in the Apache error log.  On
# the second call, counts the number of lines and adds a line to the report
# stating whether the number of lines increased (FAIL) or stayed the same
# (SUCCEED).
#
# Synopsis:
# $_count_error_log($error_log, \$nlines_before);   # First call
# $_count_error_log($error_log, \$nlines_before, $terse, \$report, \$num_fail,
#    \$num_succeed);   # Second call
#
# Input arguments:
# $error_log - Name of file containing Apache error log messages
#
# Input/output arguments:
# \$nlines_before - Number of lines in error log before page fetch.
# \$report - Test report, error log test results will be appended.
# $terse - Option to show only failed tests on the report
#          = 'failed_only' -> Show only tests that failed.
#          Otherwise, show all tests.
# \$num_fail - Running sum of test failures.
# \$num_succeed - Running sum of test successes.
#
# Return values:
# 1 -> Error anaysis completed
# 0 -> Couldn't open error log file
#
   my ($error_log, $nlines_before, $terse, $report, $num_fail, $num_succeed)
      = @_;
   my ($nlines_after, $line);
   unless (open(ERRLOG, "< $error_log")) {
      warn "Can't open file $error_log: $!";
      $$nlines_before = -1;
      return 0;
   }
   unless (defined($report)) {
      $$nlines_before = 0;
      ++$$nlines_before while <ERRLOG>;
   } elsif ($$nlines_before >= 0) {
      $nlines_after = 0;
      my @errors;
      while (defined($line = <ERRLOG>)) {
         ++$nlines_after;
         next if $nlines_after <= $$nlines_before;
         push @errors, $line;
      }
      if ($nlines_after <= $$nlines_before) {
         unless (defined($terse) and $terse eq 'failed_only') {
            $$report .= "              Number of messages "
            . "in Apache error log is zero ?          SUCCEED\n";
         }
         ++$$num_succeed;
      } else {
         $$report .= "   Error Log:\n";
         while (@errors) { $$report .= shift @errors; }
         $$report .= "\n              Number of messages "
            . "in Apache error log ( =";
         $$report .= sprintf "%2d", $nlines_after - $$nlines_before;
         $$report .= " ) is zero ?  FAIL\n";
         ++$$num_fail;
      }
   }
   close ERRLOG;
   return 1;
};

my $_check_nbytes = sub {
#
# Description:
# Compares the number of bytes to the specified maximum and minimum numbers,
# appends a line to the report stating the results, and increments the
# failure and success counts.
#
# Synopsis: $_check_nbytes->($nbytes, $max_bytes, $min_bytes, $terse, \$report,
#                            \$num_fail, \$num_succeed);
#
# Input arguments:
# $nbytes - Number of bytes in returned page
# $max_bytes - Maximum number of bytes allowed
# $min_bytes - Minimum number of bytes allowed
# $terse - Option to show only failed tests on the report
#          = 'failed_only' -> Show only tests that failed.
#          Otherwise, show all tests.
#
# Input/output arguments:
# \$report - Test report, results of max/min tests will be appended.
# \$num_fail - Running sum of test failures.
# \$num_succeed - Running sum of test successes.
#
# Return values:
# 1 -> Error analysis complete
# 0 -> Invalid input arguments
#
   my ($nbytes, $max_bytes, $min_bytes, $terse, $report, $num_fail,
       $num_succeed) = @_;
   my ($report_text, $result);
   format WRITE_NBYTES =
              @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<
              $report_text,                                             $result
.
   if ($nbytes < 0) {
      warn "Invalid value of nbytes ( = $nbytes )";
      return 0;
   }
   if ($max_bytes) {
#
# Check whether number of bytes is greater than allowed maximum
      if ($nbytes > $max_bytes) {
         $report_text = "Number of returned bytes (";
         $report_text .= sprintf "%6d", $nbytes;
         $report_text .= " ) is < or =";
         $report_text .= sprintf "%6d", $max_bytes;
         $report_text .= " ?";
         $result = 'FAIL';
         ++$$num_fail;
      } else {
         unless (defined($terse) and $terse eq 'failed_only') {
            $report_text = "Number of returned bytes (";
            $report_text .= sprintf "%6d", $nbytes;
            $report_text .= " ) is < or =";
            $report_text .= sprintf "%6d", $max_bytes;
            $report_text .= " ?";
         }
         $result = 'SUCCEED';
         ++$$num_succeed;
      }
      {
         pipe READ_NBYTES, WRITE_NBYTES;
         write WRITE_NBYTES;
         close WRITE_NBYTES;
         local $/ = undef;
         $$report .= <READ_NBYTES>;
         close READ_NBYTES;
      }
   }
   if ($min_bytes) {
#
# Check whether number of bytes is less than allowed minimum
      if ($nbytes < $min_bytes) {
         $report_text = "Number of returned bytes (";
         $report_text .= sprintf "%6d", $nbytes;
         $report_text .= " ) is > or =";
         $report_text .= sprintf "%6d", $min_bytes;
         $report_text .= " ?";
         $result = 'FAIL';
         ++$$num_fail;
      } else {
         unless (defined($terse) and $terse eq 'failed_only') {
            $report_text = "Number of returned bytes (";
            $report_text .= sprintf "%6d", $nbytes;
            $report_text .= " ) is > or =";
            $report_text .= sprintf "%6d", $min_bytes;
            $report_text .= " ?";
         }
         $result = 'SUCCEED';
         ++$$num_succeed;
      }
      {
         pipe READ_NBYTES, WRITE_NBYTES;
         write WRITE_NBYTES;
         close WRITE_NBYTES;
         local $/ = undef;
         $$report .= <READ_NBYTES>;
         close READ_NBYTES;
      }
   }
   return 1;
};

my $_check_response_time = sub {
#
# Description:
# Compares the response time to the specified maximum and minimum numbers,
# appends a line to the report stating the results, and increments the
# failure and success counts.
#
# Synopsis: $_check_response_time->($rtime, $max_rtime, $min_rtime, $terse,
#                                   \$report, \$num_fail, \$num_succeed);
#
# Input arguments:
# $rtime - response time for the returned page, in seconds
# $max_rtime - Maximum response time allowed
# $min_rtime - Minimum response time allowed
# $terse - Option to show only failed tests on the report
#          = 'failed_only' -> Show only tests that failed.
#          Otherwise, show all tests.
#
# Input/output arguments:
# \$report - Test report, results of max/min tests will be appended.
# \$num_fail - Running sum of test failures.
# \$num_succeed - Running sum of test successes.
#
# Return values:
# 1 -> Error analysis complete
# 0 -> Invalid input arguments
#
   my ($rtime, $max_rtime, $min_rtime, $terse, $report, $num_fail,
       $num_succeed) = @_;
   my ($report_text, $result);
   format WRITE_RTIME =
              @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<
              $report_text,                                             $result
.
   if ($rtime < 0) {
      warn "Invalid value of rtime ( = $rtime )";
      return 0;
   }
   if ($max_rtime) {
#
# Check whether response time is greater than allowed maximum
      if ($rtime > $max_rtime) {
         $report_text = "Response time ( ";
         $report_text .= sprintf "%3.3f", $rtime;
         $report_text .= " ) is < or = ";
         $report_text .= sprintf "%3.3f", $max_rtime;
         $report_text .= " ?";
         $result = 'FAIL';
         ++$$num_fail;
      } else {
         unless (defined($terse) and $terse eq 'failed_only') {
            $report_text = "Response time ( ";
            $report_text .= sprintf "%3.3f", $rtime;
            $report_text .= " ) is < or = ";
            $report_text .= sprintf "%3.3f", $max_rtime;
            $report_text .= " ?";
         }
         $result = 'SUCCEED';
         ++$$num_succeed;
      }
      {
         pipe READ_RTIME, WRITE_RTIME;
         write WRITE_RTIME;
         close WRITE_RTIME;
         local $/ = undef;
         $$report .= <READ_RTIME>;
         close READ_RTIME;
      }
   }
   if ($min_rtime) {
#
# Check whether response time is less than allowed minimum
      if ($rtime < $min_rtime) {
         $report_text = "Response time ( ";
         $report_text .= sprintf "%3.3f", $rtime;
         $report_text .= " ) is > or = ";
         $report_text .= sprintf "%3.3f", $min_rtime;
         $report_text .= " ?";
         $result = 'FAIL';
         ++$$num_fail;
      } else {
         unless (defined($terse) and $terse eq 'failed_only') {
            $report_text = "Response time ( ";
            $report_text .= sprintf "%3.3f", $rtime;
            $report_text .= " ) is > or = ";
            $report_text .= sprintf "%3.3f", $min_rtime;
            $report_text .= " ?";
         }
         $result = 'SUCCEED';
         ++$$num_succeed;
      }
      {
         pipe READ_RTIME, WRITE_RTIME;
         write WRITE_RTIME;
         close WRITE_RTIME;
         local $/ = undef;
         $$report .= <READ_RTIME>;
         close READ_RTIME;
      }
   }
   return 1;
}; # end _check_response_time

sub get_response {
#
# Description:
# Create an HTTP GET or POST request and get the response from the web server.
# Optionally passes parameters and userid/password.  Optionally passes cookies
# with the request and receives returned cookies.  If the server response code
# is a redirect, recurses until non-redirect code is returned.
#
# (Conceptually a private method, but syntacticly public.)
#
# Synopsis:
# $response = get_response($url, $user_agent, \%test, $cookie_jar, \$rtime);
#
# Input arguments:
# $url - URL to get response object for.
# $user_agent - HTTP user agent, an LWP::UserAgent object.
# \%test - Hashref containing method, params, userid/password, options, etc.
#
# Input/output arguments:
# $cookie_jar - Cache for sent or returned cookies; an HTTP::Cookies object.
#
# Output arguments:
# \$rtime - Web server response time (seconds)
#
# Return value:
# HTTP::Response object for the URL, after all redirects have been followed.
#
# See also:
# lwpcook, HTTP::Response, HTTP::Cookies, HTTP::Headers, URI::URL
#
   my ($url, $user_agent, $test, $cookie_jar, $rtime) = @_;
   my ($request, $response, $uri);

   if (uc($test->{method}) eq 'POST') {
      $request = POST($url, [ %{$test->{params}} ]);
      $request->header('Content-type' => 'application/x-www-form-urlencoded');
   } else {
      if (ref($test->{params}) eq 'HASH') {
#
# Append parameters to URL using URI escapes as defined by RFC 2396
         $uri = URI::URL->new($url);
         $uri->query_form(%{$test->{params}});
         $url = $uri->abs();
      }
      $request = GET($url);
   }
   if (ref($test->{auth}) eq 'ARRAY') {
      $request->authorization_basic($test->{auth}->[0], $test->{auth}->[1]);
   }
   if (ref($test->{pauth}) eq 'ARRAY') {
      $request->proxy_authorization_basic($test->{pauth}->[0],
         $test->{pauth}->[1]);
   }
   local $cookie_jar->{send_cookies} = not (defined($test->{send_cookies})
                                       and $test->{send_cookies} eq 'no');
   local $cookie_jar->{accept_cookies} = not (defined($test->{accept_cookies})
                                         and $test->{accept_cookies} eq 'no');
   $user_agent->cookie_jar($cookie_jar);
#
# Fetch the URL
   $$rtime = gettimeofday;
   $response = $user_agent->request($request);
   $$rtime = gettimeofday - $$rtime;
   return $response;
}

my $_mail_report = sub {
#
# Description: Optionally e-mails the test report to the specified addresses.
#
# Synopsis:
# $_mail_report->($report, $mail, $mail_server, $mail_from,
#                 $mail_addresses, $num_fail);
#
# Input arguments:
# $report - Test report, results of max/min tests will be appended.
# $mail - Option to e-mail output to one or more addresses.
#         = 'all'      -> Send e-mail containing test results.
#         = 'errors'   -> Send e-mail only if one or more tests fails.
#         = 'no'       -> Do not send e-mail.
#         = undefined  -> Same as 'no'.
# $mail_server - Name of mail server
# $mail_addresses - Arrayref containing one or more e-mail addresses
# $num_fail - Total number of tests that failed.
#
# Return values:
# 1 -> O.K.
# 0 -> Invalid input arguments, no mail sent
#
   my ($report, $mail, $mail_server, $mail_from,
       $mail_addresses, $num_fail) = @_;

   return 1 unless (defined($mail) and ($mail eq 'all' or $mail eq 'errors'));
   return 1 if ($mail eq 'errors' and 0 == $num_fail);
   unless (defined($mail_server) and length($mail_server) > 0) {
      warn "Invalid value of mail_server ( = null )";
      return 0;
   }
   unless (defined($mail_addresses) and @{$mail_addresses} > 0) {
      warn "Invalid value of mail_addresses ( = null )";
      return 0;
   }
   Net::SMTP->debug($Debug);
   my $smtp = Net::SMTP->new($mail_server);
   my $user = $mail_from || getlogin() || (getpwuid($<))[0] || 'nobody';
   $smtp->mail($user);
   $smtp->to(@{$mail_addresses});
   $smtp->data();
   $smtp->datasend("From: $user\n");
   $smtp->datasend("To: @{$mail_addresses}\n");
   if (0 != $num_fail) {
      $smtp->datasend("Subject: WEB TESTS FAILED! FOUND $num_fail ERRORS\n");
   } else {
      $smtp->datasend("Subject: Web tests succeeded\n");
   }
   $smtp->datasend("\n$report");
   $smtp->dataend();
   $smtp->quit;
   return 1;
};

my $_parse_line = sub {
#
# Description:
# Parse a parameter name and/or value from a line of text.  Looks for
# parenthesis indicating beginning or end of a list.
#
# Synopsis: $_parse_line->($line, \$param, \$value);
#
# Input arguments:
# $line - the input text
#
# Output arguments:
# \$value - Either undefined or output parameter value
# \$param - Either undefined or output parameter name
#
# Return values:
# 'param' -> $param defined, $value may be defined
# 'param list begin' -> $param defined, $value may be defined, begin list
# 'param list begin_end' -> $param defined, $value defined, one-element list
# 'scalar' -> $param undefined, $value defined, scalar value
# 'list begin' -> $param undefined, $value may be defined, begin list
# 'list begin_end' -> $param undefined, $value defined, one-element list
# 'list end' -> $param undefined, $value may be defined, finished reading list
# 'error' -> Bad syntax in $line or $line is blank
#
# Restrictions / bugs:
# $line must contain at least one non-whitespace character.  See the section
# titled "Parameter file format" in the POD documentation below for the
# restrictions on parameter parsing.
#
   my ($line, $param, $value) = @_;
   my $rest;
   $$param = $$value = undef;

   if ( $line =~ /^\s*(\w+)\s*=\s(.*)/ ) { # Then have a parameter name
      $$param = $1;
      $rest = $2;
      if ( $rest =~ /^\s*\(/ ) {    # Then I have a beginning of list delimiter
#
# Parse a line containing a parameter name and beginning of list delimiter

         if ( $rest =~ /\)\s*$/ ) {      # Then I have an end of list delimiter
            if ( $rest =~ /^\s*\(\s*(\S.*\S|\S)\s*\)\s*$/ ) { # Then have value
               $$value = $1;
               return 'param list begin_end';
            } else {                           # Then I have an empty list
               return 'error';
            }
         } elsif ( $rest =~ /^\s*\(\s*(\S.*\S|\S)/ ) {  # Then I have a value
            $$value = $1;
            return 'param list begin';
         } else {              # Then I have only a beginning of list delimiter
            return 'param list begin';
         }
      } elsif ( $rest =~ /^\s*(\S.*\S|\S)/ ) {  # Then I have a value
#
# Parse a line containing a parameter name and a scalar value
         $$value = $1;
         return 'param';
      } else {                             # Then I have only a parameter name
         return 'param';
      }
   } elsif ( $line =~ /\)\s*$/ ) {       # Then I have an end of list delimiter
#
# Parse a line containing an end of list delimiter and no parameter name

      if ( $line =~ /^\s*\(/ ) {    # Then I have a beginning of list delimiter
         if ( $line =~ /^\s*\(\s*(\S.*\S|\S)\s*\)\s*$/ ) {  # Then have a value
            $$value = $1;
            return 'list begin_end';
         } else {                         # Then I have an empty list
            return 'error';
         }
      } elsif ( $line =~ /\s*(\S.*\S|\S)\s*\)\s*$/ ) {   # Then I have a value
         $$value = $1;
         return 'list end';
      } else {                     # Then I have only an end of list delimiter
         return 'list end';
      }
   } elsif ( $line =~ /^\s*\(/ ) {  # Then I have a beginning of list delimiter
#
# Parse a line containing a beginning of list delimiter and no parameter name

      if ( $line =~ /\(\s*(\S.*\S|\S)/ ) { # Then I have the first list element
         $$value = $1;
         return 'list begin';
      } else {               # Then I have only a beginning of list delimiter
         return 'list begin';
      }
   } elsif ( $line =~ /(\S.*\S|\S)/ ) {        # Then I have a scalar value
#
# Parse a line containing only a scalar value
      $$value = $1;
      return 'scalar';
   } else {                                  # Then I have a blank line
      return 'error';
   }
};

my $_parse_list_delimiter = sub {
#
# Description:
# Parses the delimiters ' and => from a list element.
#
# Synopsis: $_parse_list_delimiter->($element, \@new_element);
#
# Input arguments:
# $element - List element value to parse.
#
# Output arguments:
# \@new_element - List that has one or two new elements added.
#
# Return value:  Always 1
#
   my ($element, $new_element) = @_;
   my ($match1, $match2);
   if ($element =~ /'(.*)'/) {
      $match1 = $1;
      if ($element =~ /'(.*?)'\s*=>\s*'(.*)'/) {
	 push @{$new_element}, ($1, $2);
      } else {
	 push @{$new_element}, $match1;
      }
   } else {
      if ($element =~ /(.*?)\s*=>\s*(.*)/) {
	 $match1 = $1;
	 if ($match1 =~ /'(.*)'/) { $match1 = $1; }
	 $match2 = $2;
	 if ($match2 =~ /'(.*)'/) { $match2 = $1; }
	 push @{$new_element}, ($match1, $match2);
      } else {
	 push @{$new_element}, $element;
      }
   }
   return 1;
};

my $_redirect_to_file = sub {
#
# Description:
# Redirects the program output to a file.  The routine constructs the file
# name by taking the name of the input parameter file, removing the file
# extension if it exists and appending ".out".
#
# Synopsis: $_redirect_to_file->($self, $save_output);
#
# Input arguments:
# $self - a HTTP::WebTest object
# $save_output - Option to save program output to a file.
#    = no       -> Return without doing anything
#    = yes      -> Save output to file, overwrite existing file
#    = preserve -> Save output to file unless file exists
#
# Return values:
# 1 -> Parameter save_output processed successfully
# 0 -> Error
#
   my ($self, $save_output) = @_;
   return 1 if (lc($save_output) eq 'no' or $_fh_out !~ /STDOUT$/);
   my ($base, $dir, $ext) = fileparse($self->{param_file}, '\..*?');
   my $output_file = $dir . $base . '.out';
   if ($output_file eq $self->{param_file}) {
      warn "ERROR: output file $output_file has the same name ",
         "as input parameter file\n";
      return 0;
   }
   if (lc($save_output) eq 'preserve' and -e $output_file) {
      warn "Output file $output_file exists; specify ",
         "save_output = 'yes' to overwrite\n";
      return 0;
   }
   unless (open OUTPUT, ">$output_file") {
      warn "Can't open file $output_file: $!";
      return 0;
   }
   $_fh_out = *OUTPUT;
   return 1;
};

my $_test_regexes = sub {
#
# Description:
# Test for the presence and/or absence of regular expressions in the web
# page and appends results to the report.
#
# Synopsis:
# $_test_regexes->($web_page, $regex_require, $regex_forbid, $terse, \$report,
#                  \$num_fail, \$num_succeed);
#
# Input arguments:
# $web_page - Contents of web page to be tested
# $regex_require - Arrayref of regular expressions that are required to
#                  exist on the web page
# $regex_forbid - Arrayref of regular expressions that are forbidden to
#                 exist on the web page
# $terse - Option to show only failed tests on the report
#          = 'failed_only' -> Show only tests that failed.
#          Otherwise, show all tests.
#
# Input/output arguments:
# \$report - Test report, results of max/min tests will be appended.
# \$num_fail - Running sum of test failures.
# \$num_succeed - Running sum of test successes.
#
# Return value:  Always 1.
#
   my ($web_page, $regex_require, $regex_forbid, $terse, $report, $num_fail,
       $num_succeed) = @_;
   my ($regex, $result);
   format WRITE_REGEX =
              @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<
              $regex,                                                   $result
.

   if (ref($regex_require) eq 'ARRAY' and @{$regex_require}) {
      $$report .= "\n              REQUIRED REGEXS (may be "
         . "truncated to fit page)\n";
      foreach $regex (@{$regex_require}) {
#
# Test for regular expressions that are required to exist in the web page
         if ($web_page =~ $regex) {
            $result = "SUCCEED";
            ++$$num_succeed;
         } else {
            $result = "FAIL";
            ++$$num_fail;
         }
         unless (defined($terse) and $terse eq 'failed_only'
                 and $result eq "SUCCEED")
         {
            pipe READ_REGEX, WRITE_REGEX;
            write WRITE_REGEX;
            close WRITE_REGEX;
            local $/ = undef;
            $$report .= <READ_REGEX>;
            close READ_REGEX;
         }
      }
   }
   if (ref($regex_forbid) eq 'ARRAY' and @{$regex_forbid}) {
      $$report .= "\n              FORBIDDEN REGEXS (may be "
         . "truncated to fit page)\n";
      foreach $regex (@{$regex_forbid}) {
#
# Test for regular expressions that are forbidden to exist in the web page
         if ($web_page =~ $regex) {
            $result = "FAIL";
            ++$$num_fail;
         } else {
            $result = "SUCCEED";
            ++$$num_succeed;
         }
         unless (defined($terse) and $terse eq 'failed_only'
                 and $result eq "SUCCEED")
         {
            pipe (READ_REGEX, WRITE_REGEX);
            write WRITE_REGEX;
            close WRITE_REGEX;
            local $/ = undef;
            $$report .= <READ_REGEX>;
            close READ_REGEX;
         }
      }
   }
   return 1;
};

my $_validate_value = sub {
#
# Description: Validates that a parameter/argument has an allowed value
#
# Synopsis: $_validate_value->($value, $name, \%valid_value, $test_name);
#
# Input arguments:
# $value - Value to check, check skipped if $value not defined
# $name - Parameter/argument name
# \%valid_value - Hashref containing allowed values as keys
# $test_name (optional) - Name of test
#
# Return values:
# 1 -> $value is a valid key in %valid
# 0 -> $value is not a key in %valid
#
   my ($value, $name, $valid_value, $test_name) = @_;
   if (defined($value) and not defined($valid_value->{$value})) {
      if (defined($test_name)) {
         warn "Found error in test named: $test_name\n",
            "ERROR: invalid value for $name ( = $value )\n";
      } else {
         warn "ERROR: invalid value for $name ( = $value )\n";
      }
      my @allowed = keys %$valid_value;
      warn "       Allowed values: @allowed\n";
      return 0;
   }
   return 1;
};

my $_validate_value_type = sub {
#
# Description:
# Validates that a parameter/argument is correct type (scalar or list)
#
# Synopsis: $_validate_value_type->(\%values, \%valid_types, $test_name);
#
# Input arguments:
# $values - Hashref containing parameter/argument values
# $valid_types - Hashref containing allowed types ('scalar' or 'list')
# $test_name (optional) - Name of test
#
# Return values:
# 1 -> $value has a valid type.
# 0 -> $value does not have a valid type.
#
# Restrictions / bugs:
# Assumes that any parameter/argument that is a reference is a reference to
# an array.  This restriction is enforce by the _load_param private method.
#
   my ($values, $valid_types, $test_name) = @_;
   my ($param, $type);
   my $found_error = '';
   foreach $param (keys %{$valid_types}) {
      next unless exists($values->{$param});
      if (ref($values->{$param})) {
         $type = 'list';
      } else {
         $type = 'scalar';
      }
      if ($valid_types->{$param} ne $type) {
         $found_error = 'yes';
         if (defined($test_name) and not ref($test_name)) {
            warn "Found error in test named: $test_name\n",
               "ERROR: $param must be a $valid_types->{$param}, ",
               "not a $type\n";
         } else {
            warn "ERROR: $param must be a $valid_types->{$param}, ",
               "not a $type\n";
         }
      }
   }
   return 0 if $found_error;
   return 1;
};

########################################
# Private methods, Level -3 (midlevel) #
########################################

my $_fetch_url = sub {
#
# Description:
# Fetches a web page using a GET or POST request.  Returns the web page
# contents and number of bytes in the contents.  Appends the HTTP status line
# to the report.
#
# Synopsis: $_fetch_url->(\%test, $user_agent, $show_cookies, $send_cookies,
#              $cookie_jar, \$report, \$web_page, \$nbytes, \$rtime);
#
# Input arguments:
# \%test - Hashref containing URL, method, params, userid/password, etc.
# $user_agent - HTTP user agent, an LWP::UserAgent object.
# $show_cookies - Option to display any cookies sent or received.
#                 = 'yes'    -> Display cookies in report.
#                 Otherwise  -> Do not display.
#
# Input/output arguments:
# $cookie_jar - Cache for sent or returned cookies; an HTTP::Cookies object.
# \$report - Test report, HTTP status line is appended.
#
# Output arguments:
# \$web_page - Returned contents of web page.
# \$nbytes - Number of bytes in returned page.
# \$rtime - Web server response time (seconds)
#
# Return values:
# 1 -> Web page fetched O.K.
# 0 -> HTTP request failed or invalid input parameters
#
# See also: HTTP::Cookies
#
   my ($test, $user_agent, $show_cookies, $send_cookies, $cookie_jar, $report,
       $web_page, $nbytes, $rtime) = @_;
   my ($request, $response, $cookies);

   $$report .= "\n   Test Name: " . $test->{test_name} . "\n";
   $$report .= "         URL: " . $test->{url} . "\n";
#
# Add the cookies to the cookie jar
   if (ref($test->{cookies}) eq 'ARRAY') {
      unless (defined($test->{send_cookies})
              and $test->{send_cookies} eq 'no')
      {
         foreach (@{$test->{cookies}}) {
            $cookie_jar->set_cookie($_->[0], $_->[1], $_->[2], $_->[3],
                                    $_->[4], $_->[5], $_->[6], $_->[7],
                                    $_->[8], $_->[9], $_->[10]);
         }
      }
   }
#
# Fetch the URL
   $response = get_response($test->{url}, $user_agent, $test, $cookie_jar,
                            $rtime);
   if (not defined($response)) {
      $$nbytes = 0;
      $$report .= " Return Code: NONE - Invalid URL or bad HTTP redirect\n";
      $$report .= "              HTTP request for web page satisfied ?"
                  . "                     FAIL\n";
      ++$test->{num_fail};
   } elsif ($response->is_error()) {
      $$nbytes = 0;
      $$report .= " Return Code: " . $response->status_line . "\n";
      $$report .= "              HTTP request for web page satisfied ?"
                  . "                     FAIL\n";
      ++$test->{num_fail};
   } else {
      $$web_page = $response->content();
      $$nbytes = length $$web_page;
      $$report .= ' Return Code: ' . $response->status_line
                . " ($$nbytes bytes)\n";
      if (defined($test->{show_html}) and $test->{show_html} eq 'yes') {
         $$report .= "Page Content:\n";
         $$report .= $$web_page;
      }
      ++$test->{num_succeed};
   }
#
# Optionally display sent and returned cookies in the report
   if (defined($show_cookies) and $show_cookies eq 'yes'
       and (not defined($send_cookies) or $send_cookies ne 'no') ) {
      if ($cookies = $cookie_jar->as_string) {
         format WRITE_COOKIE =
~~    Cookie: ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
              $cookies
.
         pipe (READ_COOKIE, WRITE_COOKIE);
         write WRITE_COOKIE;
         close WRITE_COOKIE;
         local $/ = undef;
         $$report .= <READ_COOKIE>;
         close READ_COOKIE;
      }
   }
   return 0 unless defined($response);
   return 1 if $response->is_success();
   return 0;
};

my $_load_other_param = sub {
#
# Description:
# Loads an apache parameter or a test_options parameter to the object.
# If the parameter is the debug or save_output parameter, it's effect is
# immediately enabled.
#
# Synopsis: $_load_other_param->($param, $value, $line_num, $self);
#
# Input arguments:
# $param - the name of the parameter
# $value - the parameter value, either a scalar or an array reference
# $line_num - current line number of parameter file, used for error messages
#
# Input/output arguments:
# $self - a HTTP::WebTest object
#
# Return values:
# 1 -> $value is an allowed value for $param
# 0 -> $value is NOT an allowed value for $param
#
   my ($param, $value, $line_num, $self) = @_;
   if ($param eq 'debug') {
#
# Enable/disable diagnostic messages, preservation of temporary directory
      unless ($_validate_value->($value, 'debug', \%_DEBUG)) {
         warn "Syntax error in file $self->{param_file} at line ",
            "$line_num\n";
         return 0;
      }
      $Debug = $_DEBUG{$value};

   } elsif ($param eq 'save_output') {
      unless ($_validate_value->($value, 'save_output', \%_SAVE_OUTPUT)) {
         warn "Syntax error in file $self->{param_file} at line $line_num\n";
         return 0;
      }
      if (lc($value) ne 'no') {
         $_redirect_to_file->($self, $value) or return 0;
      }
   } else {
      if ($_APACHE_PARAMS{$param}) {
#
# This is an Apache parameter
         if ($param eq 'include_file_path') {
            push @{$self->{include_file_path}}, $value;
         } else {
            if (exists($self->{$param})) {
               warn "ERROR: found duplicate value of global parameter $param\n",
                  "Syntax error in file $self->{param_file}, line $line_num\n";
               return 0;
            }
            $self->{$param} = $value;
         }
      } elsif ($_TEST_OPTIONS_PARAMS{$param}) {
#
# This is a test_options parameter, verify it was not previously read
         if (exists($self->{test_options}->{$param})) {
            warn "ERROR: found duplicate value of global parameter $param\n",
               "Syntax error in file $self->{param_file} at line $line_num\n";
            return 0;
         }
         $self->{test_options}->{$param} = $value;
      } else {
          warn "ERROR: $param is not a valid global parameter\n",
             "Syntax error in file $self->{param_file} at line $line_num\n";
          return 0;
      }
   }
   return 1;
};

my $_parse_delimiters = sub {
#
# Description:
# Parses the delimiters ' and => from a scalar or list.
#
# Synopsis:
# $new_value = $_parse_delimiters->($param, $value);
#
# Input arguments:
# $param - Parameter name.
# $value - Parameter value, either a scalar or arrayref.
#
# Return value:  The parsed value, either a scalar or arrayref.
#
   my ($param, $value) = @_;
   my ($type, $match1, $match2, $new_value, $element, $new_element);
#
# Is parameter a scalar or a list?
   if (defined($_APACHE_PARAMS{$param})) {
      $type = $_APACHE_PARAMS{$param};
   } elsif (defined($_TEST_OPTIONS_PARAMS{$param})) {
      $type = $_TEST_OPTIONS_PARAMS{$param};
   } elsif (defined($_WEB_TEST_PARAMS{$param})) {
      $type = $_WEB_TEST_PARAMS{$param};
   } else {
      $type = 'scalar';
   }
#
# Parse delimiters
   if ($type eq 'scalar') {
      if ($value =~ /'(.*)'/) { $value = $1; }
      return $value;
   } elsif ($type eq 'list') {
      $new_value = [ ];
      foreach $element (@{$value}) {
         if (ref($element) eq 'ARRAY') {
            $new_element = [ ];
            foreach (${$element}) {
               $_parse_list_delimiter->($_, $new_element)
            }
            push @{$new_value}, $new_element;
         } else {
            $_parse_list_delimiter->($element, $new_value)
         }
      }
      return $new_value;
   } else {
      warn 'PROGRAMMER ERROR - unknown parameter type';
      return $value;
   }
};

my $_test_strings = sub {
#
# Description:
# Test for the presence and/or absence of regular expressions in the web
# page and appends results to the report.
#
# Synopsis:
# $_test_strings->($web_page, $text_require, $text_forbid, $ignore_case,
#                  $terse, \$report, \$num_fail, \$num_succeed);
#
# Input arguments:
# $web_page - Contents of web page to be tested
# $text_require - Arrayref of regular expressions that are required to
#                  exist on the web page
# $text_forbid - Arrayref of regular expressions that are forbidden to
#                 exist on the web page
# $ignore_case - Option to do case-insensitive string matching.
#                = 'yes'   -> Ignore case while matching strings.
#                Otherwise -> Case-sensitive string matching.
# $terse - Option to show only failed tests on the report
#          = 'failed_only' -> Show only tests that failed.
#          Otherwise, show all tests.
#
# Input/output arguments:
# \$report - Test report, results of max/min tests will be appended.
# \$num_fail - Running sum of test failures.
# \$num_succeed - Running sum of test successes.
#
# Return value:  Always 1.
#
   my ($web_page, $text_require, $text_forbid, $ignore_case, $terse, $report,
       $num_fail, $num_succeed) = @_;
   my ($text, $result, @string_require, @string_forbid, $string);
   format WRITE_TEXT =
              @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<
              $text,                                                   $result
.
   my $_match_string = sub {
#
# Description:
# Checks for the occurence of the shorter string at any position in the
# longer string.  (Embedded subroutine because of scope conflict with format
# statement.  Bug in Perl?)
#
# Return values:
# 1 -> Found $short_string in $long_string.
# 0 -> No match.
#
      my ($short_string, $long_string) = @_;
      my ($len_short, $len_long, $ichar, @strings);

      $len_short = length($short_string);
      $len_long = length($long_string);
      return 0 if ($len_short > $len_long);
      for ($ichar = 0; $ichar <= ($len_long - $len_short); ++$ichar) {
         if ($short_string eq substr($long_string, $ichar, $len_short)) {
            return 1;
         }
      }
      return 0;
   };

   unless (ref($text_require) eq 'ARRAY' or ref($text_forbid) eq 'ARRAY') {
      return 1;
   }
#
# Optionally condition data for case-insensitive matching
   if (defined($ignore_case) and $ignore_case eq 'yes') {
      $web_page = lc $web_page;
      if (ref($text_require) eq 'ARRAY') {
         foreach $text (@{$text_require}) { push @string_require, lc $text; }
      }
      if (ref($text_forbid) eq 'ARRAY') {
         foreach $text (@{$text_forbid}) { push @string_forbid, lc $text; }
      }
   } else {
      if (ref($text_require) eq 'ARRAY') {
         foreach $text (@{$text_require}) { push @string_require, $text; }
      }
      if (ref($text_forbid) eq 'ARRAY') {
         foreach $text (@{$text_forbid}) { push @string_forbid, $text; }
      }
   }
   if (ref($text_require) eq 'ARRAY' and @{$text_require}) {
      $$report .= "\n              REQUIRED TEXT (may be "
         . "truncated to fit page)\n";
      foreach $text (@{$text_require}) {
#
# Test for regular expressions that are required to exist in the web page
         $string = shift @string_require;
         if ($_match_string->($string, $web_page)) {
            $result = "SUCCEED";
            ++$$num_succeed;
         } else {
            $result = "FAIL";
            ++$$num_fail;
         }
         unless (defined($terse) and $terse eq 'failed_only'
                 and $result eq "SUCCEED")
         {
            pipe READ_TEXT, WRITE_TEXT;
            write WRITE_TEXT;
            close WRITE_TEXT;
            local $/ = undef;
            $$report .= <READ_TEXT>;
            close READ_TEXT;
         }
      }
   }
   if (ref($text_forbid) eq 'ARRAY' and @{$text_forbid}) {
      $$report .= "\n              FORBIDDEN TEXT (may be "
         . "truncated to fit page)\n";
      foreach $text (@{$text_forbid}) {
#
# Test for regular expressions that are forbidden to exist in the web page
         $string = shift @string_forbid;
         if ($_match_string->($text, $web_page)) {
            $result = "FAIL";
            ++$$num_fail;
         } else {
            $result = "SUCCEED";
            ++$$num_succeed;
         }
         unless (defined($terse) and $terse eq 'failed_only'
                 and $result eq "SUCCEED")
         {
            pipe (READ_TEXT, WRITE_TEXT);
            write WRITE_TEXT;
            close WRITE_TEXT;
            local $/ = undef;
            $$report .= <READ_TEXT>;
            close READ_TEXT;
         }
      }
   }
   return 1;
};

########################################
# Private methods, Level -2 (midlevel) #
########################################

my $_load_param = sub {
#
# Description:
# Loads a parameter value to the object.  Apache and test_options parameter
# values are loaded directly to the object.  Individual test parameters are
# loaded to the web_tests hashref, which is copied to the object when the
# "end_test" directive is processed.  Verifies that the parameter name is
# valid in the current context.
#
# Synopsis: $_load_param->($param, $value, $line_num, $self);
#
# Input arguments:
# $param - the name of the parameter
# $value - the parameter value, either a scalar or an array reference
# $line_num - current line number of parameter file, used for error messages
#
# Input/output arguments:
# $self - a HTTP::WebTest object
#
# Return values:
# 1 -> No error
# 0 -> Invalid value for $param or $value (or invalid sequencing in input file)
#
   my ($param, $value, $line_num, $self) = @_;
   if ($param eq 'end_test') {
#
# Then this is end of an individual test block
      unless (defined($_web_test_tmp->{test_name})) {
         warn "ERROR: test_name parameter must precede end_test parameter\n",
            "Syntax error in file $self->{param_file} at line $line_num\n";
         return 0;
      }
#
# Save the web_test parameters for this test
      push @{$self->{web_tests}}, $_web_test_tmp;
      undef $_web_test_tmp;
   } else {
#
# Then we are processing a parameter or value, not the end_test directive
      unless (defined($param) and defined($value)) {
         warn "Undefined parameter name or value\n",
            "Syntax error in file $self->{param_file} at line $line_num\n";
         return 0;
      }
#
# Parse quotes and => delimiter in the parameter value
      $value = $_parse_delimiters->($param, $value);
      if ($param eq 'test_name' or defined($_web_test_tmp)) {
#
# Then this parameter is within an individual test block
         if (exists($_web_test_tmp->{$param}) and $param ne 'cookie') {
            warn "Found error in test named: $_web_test_tmp->{test_name}\n",
               "ERROR: found duplicate value of parameter $param\n",
               "Syntax error in file $self->{param_file} at line $line_num\n";
            return 0;
         }
         if ($param eq 'test_name') {
#
# Then this is the beginning of new test specification
            if (ref($value)) {
               warn "ERROR: parameter test_name value must be scalar\nSyntax ",
                  "error in file $self->{param_file} at line $line_num\n";
               return 0;
            }
            $_web_test_tmp = { };
            $_web_test_tmp->{cookies} = [ ];
         }
#
# Save individual test parameter in the web_tests hashref
         if ($_WEB_TEST_PARAMS{$param}) {
            if ($param eq 'cookie') {
               push @{$_web_test_tmp->{cookies}}, $value;
            } else {
               $_web_test_tmp->{$param} = $value;
            }
         } else {
            warn "ERROR: $param is not a valid parameter within a test block\n",
               "Syntax error in file $self->{param_file} at line $line_num\n";
            return 0;
         }
      } else {
          $_load_other_param->($param, $value, $line_num, $self)
             or return 0;
      }
   }
   return 1;
};

########################################
# Private methods, Level -1 (midlevel) #
########################################

my $_prompt_for_auth = sub {
#
# Description:
# If necessary, prompts user for password or userid/password to be used for
# authorization.  The user can edit the input while typing the userid.  The
# password is not echoed back to the terminal.
#
# Synopsis: $_prompt_for_auth->(\@auth, $mode, $test_name)
#           $_prompt_for_auth->(\@auth, $mode)
#
# Input/output argument:
# \@auth - Arrayref containing auth parameter, either
#    ( 'prompt', 'userid_password' ) -> Prompt for both userid and password
#    ( 'prompt', 'password' )        -> Prompt for password, use process userid
#    ( 'some_userid', '' )           -> Prompt for password
#    ( 'some_userid' )               -> Prompt for password
#    If $auth contains some other input, routine returns without prompting.
#    On output, $auth contains the userid and password.
#
# Input arguments:
# $mode - Flag indicating if this is user or proxy authorization
#               = 'auth'  -> user authorization
#               = 'pauth' -> proxy authorization
# $test_name - (Optional) Name of test associated with this auth parameter.
#
# Return values:
# 1 -> No error
# 0 -> Error, invalid input, coding error or invalid response from user
#
   my ($auth, $mode, $test_name) = @_;
   return 1 unless defined($auth);
   if (@{$auth} < 1 or @{$auth} > 2) {
      warn "ERROR: parameter $mode must have either one or two elements\n";
      return 0;
   }
   if (length($auth->[0]) < 1) {
      warn "ERROR: first element of parameter $mode cannot be null\n";
      return 0;
   }
   return 1 unless ( @{$auth} < 2
                     or length($auth->[1]) < 1
                     or ( $auth->[0] eq 'prompt'
                          and $auth->[1] eq 'password'
                        )
                     or ( $auth->[0] eq 'prompt'
                          and $auth->[1] eq 'userid_password'
                        )
                   );
#
# Verify standard input and output are attached to a terminal
   unless (-t STDIN and -t STDOUT) {
      warn "ERROR: can't use prompt option for $mode parameter if program\n",
           "       is not interactive or terminal output/input is redirected\n";
      return 0;
   }
   if ($auth->[0] eq 'prompt' and $auth->[1] eq 'password') {
#
# Get the userid of the person running this program
      $auth->[0] = getlogin() || (getpwuid($<))[0];
      if (length($auth->[0]) > 0) {
         $auth->[1] = '';
      } else {
         $auth->[0] = 'prompt';
         $auth->[1] = 'userid_password';
      }
   }
   $auth->[1] = '' unless defined($auth->[1]);
   if ($auth->[0] eq 'prompt' and $auth->[1] eq 'userid_password') {
#
# Prompt for a userid
      $auth->[0] = '';
      while (length($auth->[0]) < 1) {
         if (defined($test_name)) {
            print STDOUT "Need authorization parameter for test name: ",
               "$test_name\n";
            undef $test_name;
         }
         if ($mode eq 'auth') {
            print STDOUT "Enter a userid for web page access: ";
         } else {
            print STDOUT "Enter a userid for proxy authorization: ";
         }
         $auth->[0] = <STDIN>;
         chomp($auth->[0]);
      }
   }
#
# Prompt for password, password is not echoed to terminal
   ReadMode('noecho');
   $auth->[1] = '';
   while (length($auth->[1]) < 1) {
      while (length($auth->[1]) < 1) {
         if (defined($test_name)) {
            print STDOUT "Need authorization parameter for test name: ",
               "$test_name\n";
            undef $test_name;
         }
         if ($mode eq 'auth') {
            print STDOUT "Enter a password for web page access: ";
         } else {
            print STDOUT "Enter a password for proxy authorization: ";
         }
         $auth->[1] = ReadLine(0);
         chomp($auth->[1]);
         print STDOUT "\n";
      }
      print STDOUT "Retype the password: ";
      my $retype = ReadLine(0);
      chomp($retype);
      print STDOUT "\n";
      unless ($auth->[1] eq $retype) {
         print STDOUT "Passwords do not match, please try again\n";
         $auth->[1] = '';
      }
   }
   ReadMode('normal');
   print $_fh_out "Using userid = $auth->[0], password = $auth->[1]\n"
      if $Debug;
   return 0 if (length($auth->[0]) < 1 or length($auth->[1]) < 1);
   return 1;
};

my $_read_params = sub {
#
# Description:
# Reads input parameters from file and store values in the object.
#
# Synopsis: $_read_params->($self);
#
# Input/output arguments:
# $self - a HTTP::WebTest object
#
# Return values:
# 1 -> No error
# 0 -> Error opening file or syntax error in file
#
   my $self = shift;
   my ($value, $line, $line_type, $param, $parameter, @values, $line_num,
      $found_error);
   $line_num = $found_error = '';
   my $input_mode = 'want a parameter';
   unless (open(PARAMS, "<$self->{param_file}")) {
      warn "Can't open parameter file $self->{param_file}: $!\n";
      return 0;
   }
   for (;;) {                          # Loop until end of file
      $line = <PARAMS>;
      ++$line_num;
      unless (defined($line)) {
         if ($input_mode eq 'want a parameter') {
            if (defined($_web_test_tmp)) {
               warn "Missing end_test directive for test ",
                  "$_web_test_tmp->{test_name}\n";
               return 0;
            } else {
               last;    # End-of-file is O.K. in this context
            }
         } else {
            warn "Still looking for a value or end-of-list delimiter\n",
               "Premature end of file in file $self->{param_file} at line ",
               "$line_num\n";
            return 0;
         }
      }
      next if ($line =~ /^\s*#|^\s*$/);   # Skip comments and blank lines
#
# Parse line, look for parameter name, value, list delimiter, end_test directive
      if ($input_mode eq 'want a parameter' and $line =~ /^\s*end_test\s*$/) {
         $param = 'end_test';
         $value = undef;
         $line_type = 'param';
      } else {
         $line_type = $_parse_line->($line, \$param, \$value);
      }
      if ($input_mode eq 'want a parameter') {
#
# We are looking for a parameter name
         unless (defined($param)) {
            warn "I was looking for parameter = or parameter = 'value' or ",
               "parameter = ( or parameter = ( 'value' or ",
               "parameter = ( 'value' )\n",
               "Syntax error in file $self->{param_file} at line $line_num\n";
            $found_error = 'yes';
         }
         $parameter = lc $param;
         if ($line_type eq 'param') {
            if (defined($value) or $parameter eq 'end_test') {
               $_load_param->($parameter, $value, $line_num, $self)
                  or $found_error = 'yes';
            } else {
               $input_mode = 'want a value';
            }
         } elsif ($line_type eq 'param list begin') {
            undef @values;
            if (defined($value)) { push @values, $value; }
            $input_mode = 'want a list';
         } elsif ($line_type eq 'param list begin_end') {
            undef @values;
            push @values, $value;
            $_load_param->($parameter, [ @values ], $line_num, $self)
               or $found_error = 'yes';
         } else {
            warn "I was looking for parameter = or parameter = 'value' or ",
               "parameter = ( or parameter = ( 'value' or ",
               "parameter = ( 'value' )\n",
               "Syntax error in file $self->{param_file} at line $line_num\n";
            $found_error = 'yes';
         }
      } elsif ($input_mode eq 'want a value') {
#
# We are looking for a scalar value, list value or beginning of list delimiter
         if ($line_type eq 'scalar') {
            $_load_param->($parameter, $value, $line_num, $self) or return 0;
            $input_mode = 'want a parameter';
         } elsif ($line_type eq 'list begin') {
            undef @values;
            if (defined($value)) { push @values, $value; }
            $input_mode = 'want a list';
         } elsif ($line_type eq 'list end') {
            if (defined($value)) { push @values, $value; }
            $_load_param->($parameter, [ @values ], $line_num, $self)
               or $found_error = 'yes';
            $input_mode = 'want a parameter';
         } elsif ($line_type eq 'list begin_end') {
            undef @values;
            push @values, $value;
            $_load_param->($parameter, [ @values ], $line_num, $self)
               or $found_error = 'yes';
            $input_mode = 'want a parameter';
         } else {
            warn "I was looking for 'value' or ( 'value' or ( 'value' ) or (\n",
               "Syntax error in file $self->{param_file} at line $line_num\n";
            $found_error = 'yes';
         }
      } elsif ($input_mode eq 'want a list') {
#
# We are looking for a list value or an end of list delimiter
         if ($line_type eq 'scalar') {
            push @values, $value;
         } elsif ($line_type eq 'list end') {
            if (defined($value)) { push @values, $value; }
            $_load_param->($parameter, [ @values ], $line_num, $self)
               or $found_error = 'yes';
            $input_mode = 'want a parameter';
         } elsif ($line_type eq 'list begin_end') {
            warn "Too many right parentheses in list parameter specification, ",
               "I was looking for 'value' or 'value' ) or )\n",
               "Syntax error in file $self->{param_file} at line $line_num\n";
            $found_error = 'yes';
         } else {
            warn "Missing right parenthesis in list parameter specification?, ",
               "I was looking for 'value' or 'value' ) or )\n",
               "Syntax error in file $self->{param_file} at line $line_num\n";
            $found_error = 'yes';
         }
      }
   }
   close PARAMS;
   return 0 if $found_error;
   return 1;
};

my $_transform_web_tests = sub {
#
# Description:
# Copy test parameters in @web_tests.  Transform cookies to formats needed
# by Perl library module.  Get default values of test parameters from
# test_options.
#
# Synopsis:
# $mod_web_tests = $_transform_web_tests->(\%test_options, \@web_tests);
#
# Input arguments:
# \%test_options - Hashref containing test options.
# \@web_tests - Arrayref of hashrefs containing web test specifications.
#
# Return value:
# \@mod_web_tests - Arrayref of hashrefs containing transformed web test
#                   specifications.
#
   my ($test_options, $web_tests) = @_;
   my ($test, $mod_test, $extra, $i, $new_cookie, $cookie, $mod_cookies);
   my $mod_web_tests = [ ];
   my $test_count = 1;
   foreach $test (@{$web_tests}) {
      $mod_test = { };
      foreach (keys %$test) { $mod_test->{$_} = $test->{$_}; }

      if (exists($test->{auth})) {
         $mod_test->{auth} = [ @{$test->{auth}} ];
      }
#
# Transform cookies into format needed by HTTP::Cookies set_cookie method
      $mod_cookies = [ ];
      foreach $cookie (@{$test->{cookies}}) {
         unless( @$cookie > NCOOKIE_REFORMAT ) {
            for (my $i = @$cookie, $i < NCOOKIE_REFORMAT, ++$i) {
               push @$cookie, undef;
            }
            push @$mod_cookies, $cookie;
            next;
         }
         $new_cookie = [ ];
         for ($i = 0; $i < NCOOKIE_REFORMAT; ++$i) {
            if (length($cookie->[$i]) > 0) {
               push @{$new_cookie}, $cookie->[$i];
            } else {
               push @{$new_cookie}, undef;
            }
         }
         $extra = { };
         for ($i = NCOOKIE_REFORMAT; $i < @{$cookie}; $i = $i + 2) {
            $extra->{$cookie->[$i]} = $cookie->[$i + 1];
         }
         push @$new_cookie, $extra;
         push @$mod_cookies, $new_cookie;
      }
      $mod_test->{cookies} = $mod_cookies;

      if (exists($mod_test->{params})) {
         my $mod_params = { };
         if (ref($mod_test->{params}) eq 'ARRAY') {
            %$mod_params = @{$test->{params}};
         } else {
            %$mod_params = %{$test->{params}};
         }
         $mod_test->{params} = $mod_params;
      }
      if (exists($test->{regex_forbid})) {
         $mod_test->{regex_forbid} = [ @{$test->{regex_forbid}} ];
      }
      if (exists($test->{regex_require})) {
         $mod_test->{regex_require} = [ @{$test->{regex_require}} ];
      }
      if (defined($test->{test_name})) {
         $mod_test->{test_name} = $test->{test_name};
      } else {
         $mod_test->{test_name} = 'Web Test #' . $test_count;
      }
      ++$test_count;
      if (exists($test->{text_forbid})) {
         $mod_test->{text_forbid} = [ @{$test->{text_forbid}} ];
      }
      if (exists($test->{text_require})) {
         $mod_test->{text_require} = [ @{$test->{text_require}} ];
      }
      if (defined($mod_test->{url}) and $mod_test->{url} =~ /^www\./) {
         $mod_test->{url} = 'http://' . $mod_test->{url};
      }
      foreach (keys %_WEB_TEST_PARAMS) {
#
# If this key is not defined, get value from corresponding test_options key
         if (not defined($mod_test->{$_}) and defined($test_options->{$_})) {
            if (ref($test_options->{$_}) eq 'ARRAY') {
               $mod_test->{$_} = [ @{$test_options->{$_}} ]; # Copy & preserve
            } else {
               $mod_test->{$_} = $test_options->{$_};
            }
         }
      }
      if (defined($mod_test->{ignore_error_log})
              and $mod_test->{ignore_error_log} eq 'yes')
      {
         $mod_test->{error_log} = undef;
      }
      push @{$mod_web_tests}, $mod_test;
   }
   return $mod_web_tests;
};

my $_validate_apache_params = sub {
#
# Description: Validates Apache parameters.
#
# Synopsis: $_validate_apache_params->($self, $need_apache);
#
# Input arguments:
# $self - a HTTP::WebTest object
# $need_apache - Flag indicating if a local instance of Apache will be started
#                'yes' -> Apache will be started, '' -> no
#
# Return values:
# 1 -> Parameters were validated successfully.
# 0 -> Error, invalid parameter
#
   my ($self, $need_apache) = @_;
   my $i;
   my $found_error = '';
#
# Verify that each parameter is of correct type (scalar or list)
   $_validate_value_type->($self, \%_APACHE_PARAMS) or $found_error = 'yes';

   if (defined($self->{apache_dir})) {
      APACHE_DIR: {
         unless (-d $self->{apache_dir}) {
            warn "ERROR: parameter apache_dir ( = $self->{apache_dir} ) not ",
               "accessible: $!\n";
            $found_error = 'yes';
            last APACHE_DIR;
         }
         unless (-r "$self->{apache_dir}/conf/httpd.conf-dist") {
            warn "ERROR: parameter apache_dir ( = $self->{apache_dir} ) not ",
               "valid; does not have readable file named ",
               "conf/httpd.conf-dist\n";
            $found_error = 'yes';
            last APACHE_DIR;
         }
         unless (-r
            "$self->{apache_dir}/htdocs/webtest/is_apache_responding.html")
         {
            warn "ERROR: parameter apache_dir ( = $self->{apache_dir} ) not ",
               "valid; does not have readable file ",
               "htdocs/webtest/is_apache_responding.html\n";
            $found_error = 'yes';
            last APACHE_DIR;
         }
      }
   }
   if ($need_apache) {
      if (defined($self->{apache_exec}))  {
         if (not -x $self->{apache_exec}) {
            warn "ERROR: parameter apache_exec ( = $self->{apache_exec} ) is ",
               "not executable command\n";
            unless ($self->{apache_exec} =~ /^\s*\//) {
               warn "     (Try specifying a full pathname)\n";
            }
            $found_error = 'yes';
         }
      } else {
         warn "ERROR: you must specify apache_exec parameter if you ",
            "specify file_path parameter\n";
         $found_error = 'yes';
      }
   }
   $_validate_value->($self->{apache_loglevel}, 'apache_loglevel', \%_LOGLEVEL)
      or $found_error = 'yes';
   if (defined($self->{apache_options})
      and $self->{apache_options} !~ /^\s*-/)
   {
      warn "ERROR: parameter apache_options ( = $self->{apache_options} ) ",
         "must begin with a minus sign\n";
      $found_error = 'yes';
   }
   if (defined($self->{apache_max_wait})) {
      unless ($self->{apache_max_wait} >= MIN_APACHE_WAIT_SECONDS
              and $self->{apache_max_wait} <= MAX_APACHE_WAIT_SECONDS)
      {
         warn "ERROR: parameter apache_max_wait ( = $self->{apache_max_wait} ",
            ") must be >= ", MIN_APACHE_WAIT_SECONDS,
            " and <= ", MAX_APACHE_WAIT_SECONDS, "\n";
         $found_error = 'yes';
      }
   }
   if (ref($self->{include_file_path}) eq 'ARRAY') {
      foreach (@{$self->{include_file_path}}) {
         if (@{$_} % 2 == 0) {
            for ($i = 0; $i < @{$_}; $i = $i + 2) {
               unless (-r $_->[$i]) {
                  warn "ERROR: can't access include file $_->[$i]: $!\n";
                    $found_error = 'yes';
               }
               unless (length($_->[$i + 1]) > 0) {
                  warn "ERROR: even-numbered elements of include_file_path ",
                       "can't be null\n";
                  $found_error = 'yes';
               }
               if ($_->[$i + 1] =~ m%^\.\.|/\.\./%) {
                  warn "ERROR: even-numbered elements of include_file_path ",
                     "( = $_->[$i + 1] ) can't begin with ../ or contain ",
                     " /../\n";
                  $found_error = 'yes';
               }
            }
         } else {
            warn "ERROR: include_file_path must have an even ",
                 "number of elements\n",
            $found_error = 'yes';
         }
      }
   }
   return 0 if $found_error;
   return 1;
};

my $_validate_web_tests = sub {
#
# Description:
# Validates input file parameters / subroutine arguments that specify
# individual web tests.
#
# Synopsis:
# $_validate_web_tests->($web_tests, \$need_apache);
# $_validate_web_tests->($web_tests);
#
# Input/output arguments:
# $web_tests - Arrayref of hashrefs containing the input web_tests parameters.
#              If the test_name key is not defined, a value is provided
#
# Output arguments:
# \$need_apache (optional) - Flag indicating if a local instance of Apache
#    will be started (so that a local file can be tested).
#    'yes' -> Apache will be started
#    ''    -> Apache not needed, all tests are for remote URLs
#
# Return values:
# 1 -> Parameters / arguments were validated successfully.
# 0 -> Error, invalid parameter
#
   my ($web_tests, $need_apache) = @_;
   my $found_error = '';
   my $test_count = 1;

   $$need_apache = '' if (ref($need_apache) eq 'SCALAR');
   unless (@{$web_tests}) {
      warn "ERROR: no web tests specified - quitting!\n";
      $found_error = 'yes';
   }
   my $test_name;
   foreach my $web_test (@{$web_tests}) {
      if (defined($web_test->{test_name})) {
         $test_name = $web_test->{test_name}
      } else {
         $test_name = 'Web Test #' . $test_count;
      }
      ++$test_count;
#
# Verify that each web_test parameter is of correct type (scalar or list)
      $_validate_value_type->($web_test, \%_WEB_TEST_PARAMS,
         $test_name) or $found_error = 'yes';
#
# Verify that each boolean web_test parameter has an allowed value
      foreach (keys %_BOOLEAN) {
         $_validate_value->($web_test->{$_}, $_, \%_YES_NO)
            or $found_error = 'yes';
      }
#
# Verify other web_test parameters
      if (defined($web_test->{auth})) {
         if (@{$web_test->{auth}} > 2 or @{$web_test->{auth}} < 1) {
            warn "Found error in test named: $test_name\n",
               "ERROR: parameter auth must have either one or two elements\n";
            $found_error = 'yes';
         }
         if (length($web_test->{auth}->[0]) < 1) {
            warn "Found error in test named: $test_name\n",
               "ERROR: first element of parameter auth cannot be null\n";
            $found_error = 'yes';
         }
      }
      if (defined($web_test->{pauth})) {
         if (@{$web_test->{pauth}} > 2 or @{$web_test->{pauth}} < 1) {
            warn "Found error in test named: $test_name\n",
               "ERROR: parameter pauth must have either one or two elements\n";
            $found_error = 'yes';
         }
         if (length($web_test->{pauth}->[0]) < 1) {
            warn "Found error in test named: $test_name\n",
               "ERROR: first element of parameter pauth cannot be null\n";
            $found_error = 'yes';
         }
      }
      foreach my $cookie (@{$web_test->{cookies}}) {
         if (scalar(@{$cookie}) > NCOOKIE_REFORMAT
             and scalar(@{$cookie}) % 2 != 0)
         {
            warn "Found error in test named: $test_name\n",
               "ERROR: cookie parameter must have even # of ",
               "elements if # elements > ", NCOOKIE_REFORMAT, "\n";
            $found_error = 'yes';
         }
         if (scalar(@{$cookie}) < MIN_COOKIE_ARGS) {
            warn "Found error in test named: $test_name\n",
               "ERROR: parameter cookie must have at least ",
               MIN_COOKIE_ARGS, " elements\n";
            $found_error = 'yes';
         }
         if (length($cookie->[0]) > 0 and length($cookie->[1]) > 0
                 and length($cookie->[2]) > 0 and length($cookie->[3]) > 0
                 and length($cookie->[4]) > 0)
         {
            if ($cookie->[1] =~ /^\$/) {
               warn "Found error in test named: $test_name\n",
                  "ERROR: name element of cookie cannot begin with a \$\n";
               $found_error = 'yes';
            }
            if ($cookie->[3] !~ m,^/,) {
               warn "Found error in test named: $test_name\n",
                  "ERROR: path element of cookie must begin with a /\n";
               $found_error = 'yes';
            }
            if ($cookie->[4] =~ tr/././ < 2 and $cookie->[4] !~ /\.local$/) {
               warn "Found error in test named: $test_name\n",
                  "ERROR: domain element of cookie must contain two periods ",
                  "or equal .local\n";
               $found_error = 'yes';
            }
         } else {
            warn "Found error in test named: $test_name\n",
               "ERROR: version, name, value, path and domain of ",
               "cookie must be defined\n";
            $found_error = 'yes';
         }
         if (length($cookie->[5]) > 0 and $cookie->[5] !~ /^_?\d+(?:,\d+)*$/) {
            warn "Found error in test named: $test_name\n",
               "ERROR: format for port element of cookie must be digits or ",
               "digits,digits ...\n";
            $found_error = 'yes';
         }
         if (length($cookie->[8]) > 0 and $cookie->[8] !~ /^\d+$/) {
            warn "Found error in test named: $test_name\n",
               "ERROR: max_age element of cookie must be a positive ",
               "integer\n";
            $found_error = 'yes';
         }
      }
      if (ref($need_apache) eq 'SCALAR') {
         if (ref($web_test->{file_path}) eq 'ARRAY') {
            $$need_apache = 'yes';
            if (2 == @{$web_test->{file_path}}) {
               unless (-r $web_test->{file_path}->[0]) {
                  warn "Found error in test named: $test_name\n",
                       "ERROR: can't access file $web_test->{file_path}->[0]:",
                       " $!\n";
                  $found_error = 'yes';
               }
               unless (length($web_test->{file_path}->[1]) > 0) {
                  warn "Found error in test named: $test_name\n",
                     "ERROR: second element of file_path can't be null\n";
                  $found_error = 'yes';
               }
               if ($web_test->{file_path}->[1] =~ m%^\.\.|/\.\./%) {
                  warn "Found error in test named: $test_name\n",
                     "ERROR: 2nd element of file_path can't contain /../ ",
                     "or begin with ../\n",
                  $found_error = 'yes';
               }
            } else {
               warn "Found error in test named: $test_name\n",
                  "ERROR: parameter file_path must be a two-element list\n";
               $found_error = 'yes';
            }
         }
         unless (defined($web_test->{url})
                 xor ref($web_test->{file_path}) eq 'ARRAY')
         {
            warn "Found error in test named: $test_name\n",
               "ERROR: must specify either url or file (not both)\n";
            $found_error = 'yes';
         }
      } elsif (not defined($web_test->{url})) {
         warn "Found error in test named: $test_name\n",
              "ERROR: must specify url\n";
         $found_error = 'yes';
      }
      if (defined($web_test->{max_bytes})) {
         if ($web_test->{max_bytes} < 1) {
            warn "Found error in test named: $test_name\n",
               "ERROR: max_bytes ( = $web_test->{max_bytes} ) must ",
               "be > 0\n";
            $found_error = 'yes';
         }
         if (defined($web_test->{min_bytes})
             and $web_test->{max_bytes} < $web_test->{min_bytes} )
         {
            warn "Found error in test named: $test_name\n",
               "ERROR: max_bytes ( = $web_test->{max_bytes} ) must ",
               "NOT be < min_bytes ( = $web_test->{min_bytes} )\n";
            $found_error = 'yes';
         }
      }
      if (defined($web_test->{max_rtime})) {
         if ($web_test->{max_rtime} <= 0) {
            warn "Found error in test named: $test_name\n",
               "ERROR: max_rtime ( = $web_test->{max_rtime} ) must ",
               "be > 0\n";
            $found_error = 'yes';
         }
         if (defined($web_test->{min_rtime})
             and $web_test->{max_rtime} < $web_test->{min_rtime} )
         {
            warn "Found error in test named: $test_name\n",
               "ERROR: max_rtime ( = $web_test->{max_rtime} ) must ",
               "NOT be < min_rtime ( = $web_test->{min_rtime} )\n";
            $found_error = 'yes';
         }
      }
      if (defined($web_test->{method})) {
         if (uc($web_test->{method}) !~ /^GET$|^POST$/) {
            warn "Found error in test named: $test_name\n",
               "ERROR: method ( = $web_test->{method} ) must equal ",
               "'get' or 'post'\n";
            $found_error = 'yes';
         }
      }
      if (exists($web_test->{params})) {
         if (ref($web_test->{params}) eq 'ARRAY') {
            if (scalar(@{$web_test->{params}}) % 2 != 0) {
               warn "Found error in test named: $test_name\n",
                  "ERROR: params array must have an even number of elements\n";
               $found_error = 'yes';
            }
         } else {
            unless (ref($web_test->{params}) eq 'HASH') {
               warn "Found error in test named: $test_name\n",
                  "ERROR: params must be a hashref or arrayref\n";
               $found_error = 'yes';
            }
         }
      }
   }
   return 0 if $found_error;
   return 1;
};

my $_validate_test_options = sub {
#
# Description: Validates test_options hashref.
#
# Synopsis: $_validate_test_options->(\%test_options);
#
# Input arguments:
# \%test_options - Hashref containing test options.
#
# Return values:
# 1 -> O.K., test_options was validated successfully.
# 0 -> Error, invalid value
#
   my $test_options = shift;
   return 1 unless defined($test_options);
   return 0 unless (ref($test_options) eq 'HASH');
   my $found_error = '';
#
# Verify that each parameter/argument is type 'scalar' or 'list'
   $_validate_value_type->($test_options, \%_TEST_OPTIONS_PARAMS)
      or $found_error = 'yes';
#
# Verify that Boolean parameters/arguments are either 'yes' or 'no'
   foreach (keys %_BOOLEAN) {
      $_validate_value->($test_options->{$_}, $_, \%_YES_NO)
         or $found_error = 'yes';
   }
#
# Verify values of other parameters/arguments
   if (defined($test_options->{auth})) {
      if (@{$test_options->{auth}} > 2 or @{$test_options->{auth}} < 1) {
         warn "ERROR: auth must have either one or two elements\n";
         $found_error = 'yes';
      }
      if (length($test_options->{auth}->[0]) < 1) {
         warn "ERROR: first element of auth cannot be null\n";
         $found_error = 'yes';
      }
   }
   if (defined($test_options->{pauth})) {
      if (@{$test_options->{pauth}} > 2 or @{$test_options->{pauth}} < 1) {
         warn "ERROR: pauth must have either one or two elements\n";
         $found_error = 'yes';
      }
      if (length($test_options->{pauth}->[0]) < 1) {
         warn "ERROR: first element of pauth cannot be null\n";
         $found_error = 'yes';
      }
   }
   if (defined($test_options->{error_log})) {
      unless (-r $test_options->{error_log}) {
         warn "ERROR: cannot access error log file ",
              "$test_options->{error_log}: $!\n";
         $found_error = 'yes';
      }
   }
   if (defined($test_options->{fh_out})) {
      my $fh = $test_options->{fh_out};
      unless (stat $fh) {
         warn "ERROR: fh_out is not a valid filehandle: $!";
         $found_error = 'yes';
      }
   }
   $_validate_value->($test_options->{mail}, 'mail', \%_MAIL)
      or $found_error = 'yes';
   if (defined($test_options->{mail})
       and $test_options->{mail} ne 'no')
   {
      unless (defined($test_options->{mail_addresses})
              and defined($test_options->{mail_server})
              and @{$test_options->{mail_addresses}})
      {
         warn "ERROR: if mail = 'all' or 'errors', you must specify ",
            "mail_addresses and mail_server\n";
         $found_error = 'yes';
      }
   }
   if (defined($test_options->{max_bytes})) {
      if ($test_options->{max_bytes} < 1) {
         warn "ERROR: max_bytes ( = $test_options->{max_bytes} ) must ",
            "be > 0\n";
         $found_error = 'yes';
      }
      if (defined($test_options->{min_bytes})
          and $test_options->{max_bytes} < $test_options->{min_bytes} )
      {
         warn "ERROR: max_bytes ( = $test_options->{max_bytes} ) must ",
            "NOT be < min_bytes ( = $test_options->{min_bytes} )\n";
         $found_error = 'yes';
      }
   }
   if (defined($test_options->{max_rtime})) {
      if ($test_options->{max_rtime} < 0) {
         warn "ERROR: max_rtime ( = $test_options->{max_rtime} ) must ",
            "be > 0\n";
         $found_error = 'yes';
      }
      if (defined($test_options->{min_rtime})
          and $test_options->{max_rtime} < $test_options->{min_rtime} )
      {
         warn "ERROR: max_rtime ( = $test_options->{max_rtime} ) must ",
            "NOT be < min_rtime ( = $test_options->{min_rtime} )\n";
         $found_error = 'yes';
      }
   }
   if (exists($test_options->{proxies})) {
      if (ref($test_options->{proxies}) eq 'ARRAY') {
	 if (scalar(@{$test_options->{proxies}}) % 2 != 0) {
	    warn "ERROR: proxies array must have an even number of elements\n";
	    $found_error = 'yes';
	 }
      } else {
	 unless (ref($test_options->{proxies}) eq 'HASH') {
	    warn "ERROR: proxies must be a hashref or arrayref\n";
	    $found_error = 'yes';
	 }
      }
   }
   $_validate_value->($test_options->{terse}, 'terse', \%_TERSE)
      or $found_error = 'yes';
   return 0 if $found_error;
   return 1;
};

######################################
# Private methods, Level 0 (highest) #
######################################

my $_init_web_test = sub {
#
# Description:
# Initialize object, read input parameters, validate input parameters and set
# default values.
#
# Synopsis: $_init_web_test->($param_file, $save_output, $self);
#
# Input parameters:
# $param_file - Name of file to read input parameters from
# $save_output - Option to save program output to a file.
#    = no       -> Send output to standard output
#    = yes      -> Save output to file, overwrite existing file
#    = preserve -> Save output to file unless file exists
#
# Input/output arguments:
# $self - a HTTP::WebTest object
#
# Return values:
# 1 -> All parameters successfully read and validated, object initialized O.K.
# 0 -> Error while reading or validating parameters or initializing object
#
   my ($param_file, $save_output, $self) = @_;
#
# Initialize object, preserving Apache attributes from previous call
   my @keys = keys %$self;
   foreach (@keys) {
      delete $self->{$_} unless /^apache_pid$|^base_url$|^temp_dir$/;
   }
   $self->{include_file_path} = [ ];
   $self->{param_file} = $param_file;
   $self->{test_options} = { };
   $self->{web_tests} = [ ];
#
# Optionally redirect program output to a file
   $_fh_out = *STDOUT;
   if (defined($save_output)) {
      unless (defined($_SAVE_OUTPUT{$save_output})) {
         warn "Invalid value of save_output";
         return 0;
      }
      $_redirect_to_file->($self, $save_output) or return 0;
   }
#
# Get fully-qualified hostname
   unless ($self->{hostname} = hostname()) {
      warn "Can't determine hostname of this system\n";
      return 0;
   }
   unless ($self->{hostname} =~ /\w+\.\w+/) {
      $self->{hostname} = hostfqdn();
      unless ($self->{hostname} =~ /\w+\.\w+/) {
         warn "Can't determine fully-qualified hostname of this system\n";
         return 0;
      }
   }
#
# Read input parameters
   $_read_params->($self) or return 0;
#
# Validate input parameters
   my $found_error = '';
   $_validate_test_options->($self->{test_options}) or $found_error = 'yes';
   my $need_apache;
   $_validate_web_tests->($self->{web_tests}, \$need_apache)
      or $found_error = 'yes';
   $_validate_apache_params->($self, $need_apache) or $found_error = 'yes';
   if ($found_error) {
      warn "ERROR: parameters in file $self->{param_file} are incorrect\n";
      return 0;
   }
   print $_fh_out "Parameters in file $self->{param_file} validated ",
      "successfully\n" if $Debug;
#
# If necessary, prompt user for userid/password for auth and pauth parameter(s)
   $_prompt_for_auth->($self->{test_options}->{auth}, 'auth')
      or return 0;
   $_prompt_for_auth->($self->{test_options}->{pauth}, 'pauth')
      or return 0;
   foreach (@{$self->{web_tests}}) {
      $_prompt_for_auth->($_->{auth}, $_->{test_name}, 'auth')
         or return 0;
      $_prompt_for_auth->($_->{pauth}, $_->{test_name}, 'pauth')
         or return 0;
   }
#
# Set input parameter defaults
   $self->{apache_dir} = '/usr/local/etc/http-webtest'
      unless defined($self->{apache_dir});
   $self->{apache_loglevel} = 'warn' unless defined($self->{apache_loglevel});
   $self->{apache_max_wait} = DEFAULT_MAX_APACHE_WAIT_SECONDS
      unless defined($self->{apache_max_wait});
   $self->{apache_options} = '-X' unless defined($self->{apache_options});
   $self->{test_options}->{fh_out} = $_fh_out;
   return 1;
};

my $_make_temp_dir = sub {
#
# Description:
# Copies all files and directories in directory $self->{apache_dir} to a
# temporary directory.
#
# Synopsis:
# $_make_temp_dir->($apache_dir, $temp_dir);
#
# Input arguments:
# $apache_dir - Name of directory to copy to temporary directory
#
# Output arguments:
# $temp_dir - Name of temporary directory
#
# Return values:
# 1 -> No error
# 0 -> Error copying file, making directory or chdir to directory
#
   my ($apache_dir, $temp_dir) = @_;
   my ($found_error, $cwd);
#
# Generate unique name for temporary directory using extreme paranoia
   $$temp_dir = tempdir('webtest_XXXXXX', TMPDIR => 1);
#
# Define subroutine that copies a file to a temporary directory tree
   my $copytree = sub {
      my $rel_dirname;
      my ($dev,$ino,$mode,$nlink,$uid,$gid) = lstat($_);
      if (-d _) {    # Check the same file as the last lstat call
#
# Copy this subdirectory to temporary directory tree
         unless ($File::Find::name =~ /^\.$|^\.\.$/) {
            ($rel_dirname = $File::Find::name) =~ s/^\.\///;
            unless (mkdir("$$temp_dir/$rel_dirname", DIR_MODE)) {
               warn "Can't create directory $$temp_dir/$rel_dirname";
               $found_error = 'yes';
               return;
            }
         }
      } else {
#
# Copy this file to temporary directory tree, create subdirectory if neccessary
         ($rel_dirname = $File::Find::dir) =~ s/^\.\///;
         unless (-d "$$temp_dir/$rel_dirname") {
            unless (mkdir("$$temp_dir/$rel_dirname", DIR_MODE)) {
               warn "Can't create directory $$temp_dir/$rel_dirname: $!";
               $found_error = 'yes';
               return;
            }
         }
         unless (copy($_, "$$temp_dir/$rel_dirname/$_")) {
            warn "Can't copy file $_ to $$temp_dir/$rel_dirname/$_: $!";
            $found_error = 'yes';
            return;
         }
      }
   };
#
# Descend recursively from directory, copy files to temporary directory tree
   $cwd = cwd();
   unless (chdir $apache_dir) {
      warn "Can't chdir to directory $apache_dir: $!";
      return 0;
   }
   $found_error = '';   # Set error flag to O.K. until proven otherwise
   find($copytree, '.');
   return 0 if $found_error;
   unless (chdir $cwd) {
      warn "Can't chdir to directory $cwd: $!";
      return 0;
   }
   return 1;
};

my $_start_apache = sub {
#
# Description:
# Forks a child process that starts Apache in on a random private/dynamic
# port number.  Verifies that Apache has started by fetching a test page
# and searching the fetched page for a tag line.
#
# Synopsis: $_start_apache->($self);
#
# Input/output arguments:
# $self - a HTTP::WebTest object
#
# Return values:
# 1 -> No error, Apache was started and is answering requests
# 0 -> Error opening file or Apache failed to start
#
   my $self = shift;
   my ($web_page, $config, $port, $user_agent, $req, $resp, $sleep,
       $started_apache);

   $sleep = INITIAL_APACHE_WAIT_SECONDS;
   $started_apache = 0; # Set flag to indicate Apache hasn't started yet
#
# Loop til Apache starts, chance of port collision on each iteration is 0.00006
   for (;;) {
#
# Insert random private/dynamic port number into Apache configuration file
      $port = int(MIN_PRIVATE_PORT
                  + rand(MAX_PRIVATE_PORT - MIN_PRIVATE_PORT));
      unless (open(CONFIG, "<$self->{temp_dir}/conf/httpd.conf-dist")) {
         warn "Can't open file $self->{temp_dir}/conf/httpd.conf-dist: $!";
         return 0;
      }
      local $/ = undef;
      $config = <CONFIG>;   # Slurp entire file
      $/ = "\n";
      close CONFIG;
      $config =~ s/Please_do_not_modify_PORT/$port/g;
#
# Insert required and optional Apache attributes into configuration file
      $config =~ s/Please_do_not_modify_HOST_NAME/$self->{hostname}/g;
      $config =~ s/Please_do_not_modify_LOG_LEVEL/$self->{apache_loglevel}/g;
      $config =~ s/Please_do_not_modify_SERVER_ROOT/$self->{temp_dir}/g;
      $config =~ s/Please_do_not_modify_PERLSETVAR_GLOBAL/PerlSetVar Global $self->{temp_dir}\/asp_tmp/g;
      if (defined($self->{test_options}->{mail_server})) {
         $config =~ s/Please_do_not_modify_PERLSETVAR_MAILHOST/PerlSetVar MailHost $self->{test_options}->{mail_server}/g;
      } else {
         $config =~ s/Please_do_not_modify_PERLSETVAR_MAILHOST//g;
      }
      if (defined($self->{test_options}->{mail_addresses}->[0])) {
         $config =~ s/Please_do_not_modify_PERLSETVAR_MAILERRORSTO/PerlSetVar MailErrorsTo $self->{test_options}->{mail_addresses}->[0]/g;
      } else {
         $config =~ s/Please_do_not_modify_PERLSETVAR_MAILERRORSTO//g;
      }
      unless (open(CONF, ">$self->{temp_dir}/conf/httpd.conf")) {
         warn "Can't open file $self->{temp_dir}/conf/httpd.conf: $!";
         return 0;
      }
      print CONF $config;
      close CONF;
#
# Fork a child process and start Apache
      print $_fh_out "Starting Apache with the command:\n",
         "     $self->{apache_exec} -f $self->{temp_dir}/conf/httpd.conf ",
         "$self->{apache_options}\n" if $Debug;
      unless ($self->{apache_pid} = fork) {
         exec "$self->{apache_exec} -f $self->{temp_dir}/conf/httpd.conf "
              . "$self->{apache_options}";
         die "Perl exec statement failed to start Apache: $!\n",
            "The apache_exec parameter may have an incorrect value\n";
      }
      print $_fh_out "Parent PID is $$, Apache PID is ",
         "$self->{apache_pid}, Apache port number is $port\n" if $Debug;
      print $_fh_out "Waiting $sleep seconds for Apache to start ...\n";
      sleep $sleep;
#
# Verify Apache is running by fetching a test page
      $self->{base_url} = "http://$self->{hostname}:$port";
      print $_fh_out
         "Fetching $self->{base_url}/webtest/is_apache_responding.html\n"
         if $Debug;
      $user_agent = LWP::UserAgent->new();
      $req = GET("$self->{base_url}/webtest/is_apache_responding.html");
      $resp = $user_agent->request($req);
      $web_page = $resp->content();
      if ($resp->is_error()) {
         warn "Fetch of initial test page FAILED, HTTP returned status:\n";
         printf STDERR "%s\n", $resp->status_line;
#
# Search for the expected tag line in the returned test page
      } elsif ($web_page =~ /Please_do_not_modify_TEST_TAG/) {
         if ($Debug) {
            print $_fh_out "Found string ",
               "Please_do_not_modify_TEST_TAG in is_apache_responding.html\n";
            print $_fh_out "Started Apache successfully on ",
               scalar localtime, "\n\n";
         } else {
            print $_fh_out "Started Apache successfully\n\n";
         }
         $started_apache = 1;
         last;
      } else {
         print $_fh_out "\n";
         warn "String 'Please_do_not_modify_TEST_TAG' not found in "
            . "file htdocs/webtest/is_apache_responding.html\n";
      }
#
# Could not verify that Apache is answering requests, kill it and restart it
      kill 'SIGTERM', $self->{apache_pid};
      $sleep *= 2;
      last if $sleep > $self->{apache_max_wait};
   }
   unless ($started_apache) {
      warn "Failed to start Apache after waiting $self->{apache_max_wait} ",
         "seconds\n";
      return 0;
   }
   return 1;
};

##################
# Public methods #
##################
sub new {

=pod

 new($proto)
 new()
    Create new HTTP::WebTest object.  $proto (optional) is
    either a reference or a class (package) name.  Returns a new
    HTTP::WebTest object.

=cut

   my $proto = shift;
#
# Initialize object
   my $self = { apache_pid    => '',
                temp_dir      => '',
              };
   my $class = ref($proto) || $proto;
   bless $self, $class;
#
# Activate autoflush so standard out and standard error don't get scrambled
   my $old_fh = select STDERR;
   $| = 1;
   select STDOUT;
   $| = 1;
   select $old_fh;
   return $self;
}

sub web_test {

=pod

 web_test($param_file, \$num_fail, \$num_succeed)
 web_test($param_file, \$num_fail, \$num_succeed, $save_output)
    Reads and validates input parameters, fetches one or more
    web pages, runs tests, writes results to standard output
    or a file.  Optionally e-mails test results if error found.
    If the parameters specify a test of a local web source file,
    starts Apache on a private/dynamic port and copies the file to
    a temporary htdocs directory.

    Input arguments:
    $param_file - A relative or absolute pathname to a parameter
       file.  See the FILES section for a description of the file.
    $save_output (optional) - Option to save program output to a file.
       The routine constructs the file name by taking the value of
       $param_file, removing the file extension if it exists and
       appending ".out".  Error messages are always sent to standard
       error.
       = no       -> Send output to standard output
       = yes      -> Save output to file, overwrite existing file
       = preserve -> Save output to file unless file exists

    Output arguments:
    \$num_fail - The number of tests that failed.
    \$num_succeed - The number of tests that succeeded.

    Return values:
    1 -> All tests ran successfully with no failures.
    0 -> Syntax error in input parameter file, system runtime error or
         one or more of the tests failed.

=cut

   my ($self, $param_file, $num_fail, $num_succeed, $save_output) = @_;
   my ($test, $nbadtest, $ngoodtest, $target_file, $i);
   my $unique_id = 0;
   $$num_succeed = $$num_fail = 0;
#
# Read and validate input parameters, initialize object
   $_init_web_test->($param_file, $save_output, $self) or return 0;

   foreach $test (@{$self->{web_tests}}) {
      if (ref($test->{file_path}) eq 'ARRAY') {
         if (not $self->{apache_pid} or not kill(0, $self->{apache_pid})
             or not -d $self->{temp_dir})
         {
#
# Recursive copy of files in apache_dir to temporary Apache directory
            $_make_temp_dir->($self->{apache_dir}, \$self->{temp_dir})
               or return 0;
#
# Copy include files to temporary Apache htdocs directory
            if (ref($self->{include_file_path}) eq 'ARRAY') {
               foreach (@{$self->{include_file_path}}) {
                  foreach ($i = 0; $i < @{$_}; $i = $i + 2) {
                     $_copy_file->($_->[$i], "$self->{temp_dir}",
                                   $_->[$i + 1], \$target_file)
                        or return 0;
                  }
               }
            }
#
# Start Apache on a random private/dynamic port number
            $_start_apache->($self) or return 0;
         }
         $test->{error_log} = "$self->{temp_dir}/logs/error.log";
#
# Copy file to be tested to temporary Apache htdocs directory
         $_copy_file->($test->{file_path}->[0], "$self->{temp_dir}/htdocs",
                       $test->{file_path}->[1], \$target_file)
            or return 0;
         $test->{url} = "$self->{base_url}/$target_file";
         print "Created URL: $test->{url}\n" if $Debug;
      }
   }
#
# Run the tests!
   run_web_test($self->{web_tests}, $num_fail, $num_succeed,
                $self->{test_options}, 'validated');
   return 0 if $$num_fail;
   return 1;
}

sub run_web_test {

=pod

 run_web_test(\@web_tests, \$num_fail, \$num_succeed, \%test_options)
 run_web_test(\@web_tests, \$num_fail, \$num_succeed)
    Validates input parameters, fetches one or more urls, runs
    tests, writes results to standard output or a file.  Optionally
    e-mails test results.

    Input/output arguments:
    \@web_tests - An arrayref of hashrefs.  Each hashref defines
       tests for one URL.

       Some of the hash keys can override the value of the
       corresponding $test_options keys.  For example, if the
       max_bytes hash key is defined in $test_options and you want
       to disable the max_bytes test a particular URL, set the
       web_tests max_bytes hash key to a value of undef or ''.

       If one of the keys below does not exist in one of the
       web_test hashes on input, the module checks the value for
       the corresponding key in the $test_options hash.  If that
       value is defined, then the value from $test_options is used
       during the tests for that web_test hash.

       All input values and keys are preserved on output, except
       the num_fail and num_succeed keys.

       web_tests keys:
       accept_cookies - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       auth - Overrides the value of the corresponding test_options
          key FOR THIS URL ONLY.
       cookies - Arrayref of arrayrefs containing cookies to pass
          with the HTTP request.  See RFC 2965 for details
          (ftp.isi.edu/in-notes/rfc2965.txt).  Each array must have
          at least 5 elements; if the number of elements is over 10
          it must have an even number of elements.  Each array has
          the form ( version name value path domain port path_spec
          secure maxage discard name1 value1 name2 value2 ... ),
          with the following definitions.  (REQUIRED elements are
          marked with an ASTERISK; elements that are not required
          can be specified using the undef value or ''.)

         *version: Version number of cookie spec to use, usually 0.
         *name: Name of cookie. Cannot begin with a $ character.
         *value: Value of cookie.
         *path: URL path name for which this cookie applies. Must
             begin with a / character.  See also path_spec.
         *domain: Domain for which cookie is valid. Should begin
             with a period.  Must either contain two periods or be
             equal to '.local'.
          port: List of allowed port numbers that the cookie may be
             returned to.  If not specified, cookie can be returned
             to any port.  Must be specified using the format N or
             N,N ..., where N is one or more digits.
          path_spec: Ignored if version is less than 1.  Option to
             ignore the value of path.  Default value is 0.
             = 1 -> Use the value of path.
             = 0 -> Ignore the specified value of path.
          secure: Option to require secure protocols for cookie
             transmission.  Default value is 0.
             = 1 -> Use only secure protocols to transmit cookie.
             = 0 -> Secure protocols not required for transmission.
          maxage: Number of seconds until cookie expires.
          discard: Option to discard cookie when program exits.
             Default 0.  (The cookie will be discarded regardless
             of the value of this element.)
             = 1 -> Discard cookie.
             = 0 -> Don't discard cookie.
          name/value: Zero, one or several name/value pairs may be
             specified.  The name parameters are words such as
             Comment or CommentURL and the value parameters are
             strings that may contain embedded blanks.

       ignore_case - Option to do case-insensitive string matching
                     for text_forbid and text_require arguments.
                      = 'yes'   -> Ignore case while matching strings.
                      Otherwise -> Do case-sensitive string matching.
       ignore_error_log - Option to ignore messages in Apache error
          log.  (See the error_log key in test_options argument.)
          = 'yes' -> Do not check for messages in the error log
                     FOR THIS URL ONLY.
          Otherwise, check messages if error_log key in test_options
          argument is defined.
       max_bytes - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       min_bytes - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       max_rtime - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       min_rtime - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       method - The type of the HTTP request, either 'get' or 'post'.
          If undefined or key does not exist, 'get' is used.
       num_fail (Output) - The number of tests that failed.  If the
          fetch of the URL fails, one error is counted and the tests
          for that URL are skipped.
       num_succeed (Output) - The number of tests that succeeded.  The
          successful fetch of the URL is not counted, only successful
          tests.  If the error_log argument is specified, the absence
          of errors in the logs is counted as a successful test.
       params - A hashref or arrayref containing name/value pairs to
          be passed as parameters to the URL.  (This element is
          used to test pages that process input from forms.) Unless
          the method key is set to post, these pairs are URI-escaped
          and appended to the requested URL.  (See
          http://www.ietf.org/rfc/rfc2396.txt for URI escapes.)
       pauth - Overrides the value of the corresponding test_options
          key FOR THIS URL ONLY.
       proxies - A hashref or arrayref containing service name
          / proxy URL pairs that specify proxy servers to use for
          requests.  For example:
          proxies = ( http => http://http_proxy.mycompany.com
                      ftp  => http://ftp_proxy.mycompany.com )
       regex_forbid - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       regex_require - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       send_cookies - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       show_html - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       test_name - Name associated with this url in the test report
          and error messages.
       text_forbid - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       text_require - Overrides the value of the corresponding
          $test_options key FOR THIS URL ONLY.
       url - The URL to fetch and test.  This key is REQUIRED. If
          it begins with 'www.', 'http://' is prefixed.

    Output arguments:
    \$num_fail - Total number of tests that failed.
    \$num_succeed - Total number of tests that succeeded.

    Input arguments:
    \%test_options - (Optional) A hashref defining testing options.
       All, some or none of the keys may be defined.  Some of these
       options can also be specified in the web_tests argument.  The
       allowed hash keys are:

       accept_cookies - Option to accept cookies from the web server.
          = 'no'     -> Do not accept cookies.
          Otherwise  -> Accept cookies.
       auth - Arrayref containing a userid and password to be used
          for web page access authorization.
       error_log - The pathname of a local web server error log.
          The module counts the number of lines in the error
          log before and after each request.  If the number of
          lines increases, an error is counted and the additional
          lines are listed in the report.  (This argument should
          be used only when the local web server is running in
          single-process mode.  Otherwise, requests generated by
          other processes/users may add lines to the error log that
          are not related to the requests generated by this module.)
       fh_out - A filehandle for a file that the test report will be
          written to instead of the terminal.
       mail_addresses - Arrayref containing one or more e-mail
          addresses.
       mail - Option to e-mail output to one or more addresses.
          = 'all'     -> Send e-mail containing test results.
          = 'errors'  -> Send e-mail only if one or more tests fails.
          Otherwise   -> Do not send e-mail.
       mail_server - Fully-qualified name of of the mail server
          (e.g., mailhost.mycompany.com).
       mail_from - Sets From: header for report e-mails
       max_bytes - Maximum number of bytes expected in returned
          pages.  If this value is exceeded, an error message is
          displayed.
       min_bytes - Minimum number of bytes expected in returned
          pages.  If the number of returned bytes is less than this
          value, an error message is displayed.
       max_rtime - Maximum web server response time (seconds) expected.
          If this value is exceeded, an error message is displayed.
       min_rtime - Minimum web server response time (seconds) expected.
          If this value is exceeded, an error message is displayed.
       pauth - Arrayref containing a userid and password to be used
          for proxy access authorization.

       (The regex_forbid and regex_require parameters contain
       one or more Perl regular expressions.  These are compared
       to the fetched page contents as the right hand side of a
       "=~" operator.  If you want to search for a literal string,
       use the text_forbid and text_require arguments.  For more
       information, type "man perlre" or see Programming Perl,
       3rd edition, Chapter 5.)

       regex_forbid - Arrayref of regular expressions that are
          forbidden to exist in the returned page.
       regex_require - Arrayref of regular expressions that are
          required to exist in the returned page.
       send_cookies - Option to send cookies to web server.  This
          applies to cookies received from the web server or cookies
          specified using the cookies key of the web_test argument.
          = 'no'     -> Do not send cookies to the web server.
          Otherwise  -> Send cookies to the web server.
       show_cookies - Option to display any cookies sent or received.
          = 'yes'    -> Display cookies in report.
          Otherwise  -> Do not display.
       show_html - Option to include the returned web page in the
          test report.
          = 'yes'    -> Display the web page in the test report.
          Otherwise  -> Do not display the web page.
       terse - Option to display shorter test report.
          = 'summary'     -> Only a one-line summary for each URL.
          = 'failed_only' -> Only tests that failed and the summary.
          Otherwise       -> Show all tests and the summary.
       text_forbid - Arrayref of text strings that are forbidden to
          exist in the returned page.
       text_require - Arrayref of text strings that are required to
          exist in the returned page.

    Return values:
    1 -> All tests succeeded.
    0 -> Error in input parameters, system runtime error, or one
         or more of the tests failed.

=cut

   my ($web_tests, $num_fail, $num_succeed, $test_options, $already_validated)
      = @_;
   my ($cookies, $nlines_before, $nbytes, $rtime, $web_page, $test,
       $final_report, $fetch_ok);
   $$num_fail = $$num_succeed = 0;
   my $report = '';
   my $summary = "Failed  Succeeded  Test Name\n";

   format WRITE_SUMMARY =
 @|||||     @||||| @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$test->{num_fail}, $test->{num_succeed}, $test->{test_name}
.

   if (ref($web_tests) eq 'ARRAY') {
      foreach (@{$web_tests}) {
         next unless (ref($_) eq 'HASH');
         $_->{num_fail} = $_->{num_succeed} = 0;
      }
   }
#
# Validate input arguments
   unless (defined($already_validated) and $already_validated) {
      my $found_error = '';
      $_validate_test_options->($test_options) or $found_error = 'yes';
      $_validate_web_tests->($web_tests) or $found_error = 'yes';
      return 0 if $found_error;
   }
   $test_options = { } unless (ref($test_options) eq 'HASH');
#
# Modify/transform test parameters
   my $mod_web_tests = $_transform_web_tests->($test_options, $web_tests);
#
# Initialize the HTTP user agent and cookie jar
   my $user_agent = new LWP::UserAgent;
   $user_agent->agent("WebTest/$VERSION " . $user_agent->agent());
   if (ref($test_options->{proxies}) eq 'HASH') {
      foreach (keys(%{$test_options->{proxies}})) {
         $user_agent->proxy($_  => $test_options->{proxies}->{$_});
      }
   } elsif (ref($test_options->{proxies}) eq 'ARRAY') {
      for (my $i = 0; $i < @{$test_options->{proxies}}; $i = $i + 2) {
         $user_agent->proxy( $test_options->{proxies}->[$i]
                             => $test_options->{proxies}->[$i+1]);
      }
   }
   my $cookie_jar = HTTP::WebTest::Cookies->new();

   my $itest = 0;
   foreach $test (@{$mod_web_tests}) {
      $test->{num_fail} = $test->{num_succeed} = 0;
      if (defined($test->{error_log})) {
         $_count_error_log->($test->{error_log}, \$nlines_before);
      }
      $fetch_ok = $_fetch_url->($test, $user_agent,
         $test_options->{show_cookies}, $test->{send_cookies},
         $cookie_jar, \$report, \$web_page, \$nbytes, \$rtime);
#
# If the number of error log messages increased, report an error
      if (defined($test->{error_log})) {
         $_count_error_log->($test->{error_log}, \$nlines_before,
            $test_options->{terse}, \$report, \$test->{num_fail},
            \$test->{num_succeed});
      }
#
# If the response time returned violates bounds, report an error
      $_check_response_time->($rtime, $test->{max_rtime},
         $test->{min_rtime}, $test_options->{terse}, \$report,
         \$test->{num_fail}, \$test->{num_succeed});
      if ($fetch_ok) {
#
# If the number of bytes returned violates bounds, report an error
         $_check_nbytes->($nbytes, $test->{max_bytes}, $test->{min_bytes},
            $test_options->{terse}, \$report, \$test->{num_fail},
            \$test->{num_succeed});
#
# Test web page for the presence/absence of specified regular expressions
         $_test_regexes->($web_page, $test->{regex_require},
            $test->{regex_forbid}, $test_options->{terse}, \$report,
            \$test->{num_fail}, \$test->{num_succeed});
#
# Test web page for the presence/absence of specified text strings
         $_test_strings->($web_page, $test->{text_require},
            $test->{text_forbid}, $test->{ignore_case}, $test_options->{terse},
            \$report, \$test->{num_fail}, \$test->{num_succeed});
      }
      $$num_fail += $test->{num_fail};
      $$num_succeed += $test->{num_succeed};
      $web_tests->[$itest]->{num_fail} = $test->{num_fail};
      $web_tests->[$itest]->{num_succeed} = $test->{num_succeed};
      ++$itest;
#
# Add a line to the report summarizing the test results for this URL
      pipe READ_SUMMARY, WRITE_SUMMARY;
      write WRITE_SUMMARY;
      close WRITE_SUMMARY;
      local $/ = undef;
      $summary .= <READ_SUMMARY>;
      close READ_SUMMARY;
   }
#
# Write the test report to standard output or a file
   if (defined($test_options->{terse}) and $test_options->{terse} eq 'summary')
   {
      $final_report = "$summary\n";
   } else {
      $final_report = $summary . $report . "\n";
   }
   $final_report .= "Total web tests failed: $$num_fail "
                    . "  succeeded: $$num_succeed\n";
   if (defined($test_options->{fh_out})) {
      my $fh_out = $test_options->{fh_out};
      print $fh_out $final_report;
   } else {
      print $final_report;
   }
   $_mail_report->($final_report, $test_options->{mail},
      $test_options->{mail_server}, $test_options->{mail_from},
      $test_options->{mail_addresses},
      $$num_fail);
   return 0 if $$num_fail;
   return 1;
}

sub DESTROY {

=pod

 DESTROY()
    Kills Apache (if started), deletes temporary directories (if
    created).  Returns 1 if clean up tasks were successful, 0
    otherwise.

=cut

   my $self = shift;
   my $found_error = '';
#
# Restore the normal terminal state
   ReadMode('normal');
   if ($self->{apache_pid} and kill(0, $self->{apache_pid})) {
#
# Kill Apache
      unless (kill('SIGTERM', $self->{apache_pid})) {
         warn "Can't kill Apache, process ID: $self->{apache_pid}";
         $found_error = 'yes';
      }
   }
   if ($Debug ne $_DEBUG{preserve} and -d $self->{temp_dir}) {
#
# Delete temporary directory
      sleep 1;              # Wait for Apache to stop to avoid error messages
      if ($Debug) {
         print $_fh_out "Deleting temporary directory ",
            "$self->{temp_dir}\n",
            "     (Ignore any Apache complaints about missing files)\n";
      }
      local $^W = 0;          # Turn off warnings for sloppy File::Path module
      unless (rmtree($self->{temp_dir})) {
         warn "Can't delete directory $self->{temp_dir}: $!";
         $found_error = 'yes';
      }
   }
   return 0 if $found_error;
   return 1;
}

package HTTP::WebTest::Cookies;
use base qw(HTTP::Cookies);
#
# Modified HTTP::Cookies class to enable optional transmission and
# receipt of cookies
#

sub extract_cookies {
   my $self = shift;
   if($self->{accept_cookies}) { $self->SUPER::extract_cookies(@_); }
}

sub add_cookie_header {
   my $self = shift;

   if($self->{send_cookies}) { $self->SUPER::add_cookie_header(@_); }
}

=head1 ENVIRONMENT VARIABLES

 None.

=head1 FILES

 The web_test() method requires (1) one or more input parameter
 files, and (2) if the file_path parameter is specified, a directory
 tree that contains the subdirectories and files described in the
 APACHE DIRECTORY AND FILES section below.

 The run_web_test method does not require a parameter file.


 PARAMETER FILE

 If the input parameters are specified in a text file, you must pass
 the name of the file as an argument to the web_test() method.
 If you are running dozens of tests, you may want to divide them
 into several parameter files.  This will organize the tests
 and reduce the size of the output and e-mail messages.  However,
 cookies passed to or received from the web server(s) are not shared
 between tests in different parameter files.

 Parameters - Overview
 =====================
 There are over 30 parameters, but the only required parameters
 are test_name, end_test, and either url or file_path.  Also, if
 you specify the file_path parameter, you will have to specify the
 apache_exec parameter.

 Each parameter is either a test block parameter, a global parameter,
 or both.  TEST BLOCK PARAMETERS are parameters specified between
 a test_name parameter and an end_test directive.  Test block
 parameters apply only to the tests for the file_path or url
 specified in that test block.  You can specify one or many test
 blocks in a parameter file.  GLOBAL PARAMETERS are parameters
 specified outside of a test block.  Global parameters apply to
 every test block in the parameter file.

 You can specify certain parameters as BOTH GLOBAL PARAMETERS AND TEST
 BLOCK PARAMETERS.  These include the parameters accept_cookies, auth,
 ignore_case, ignore_error_log, max_bytes, min_bytes, max_rtime,
 min_rtime, pauth, regex_forbid, regex_require, send_cookies,
 text_forbid and text_require.  If you specify one of these within
 a test block, that value is used instead of the value of the
 corresponding global parameter for that test block only.  If you
 specify some, but not all, of these parameters in a test block,
 the global parameter values are used for the unspecified test block
 parameters.

 Parameters - Short descriptions
 ===============================
 Parameters that are always required are marked with an asterisk.
 Parameters that are usually required are marked with a plus sign.

  accept_cookies: Option to accept cookies sent by web server.
  apache_dir: Name of directory containing Apache files.
 +apache_exec: Path name of Apache executable.
  apache_loglevel: Apache logging level.
  apache_max_wait: Maximum seconds to wait for Apache to start.
  apache_options: Additional Apache command line options.
  auth: Two-element list containing userid and password to be passed
     to web server for page access authorization.
  cookie: List specifying a cookie to send to the web server.
  debug: Option to output verbose diagnostic messages.
 *end_test: Signifies the end of a test block.
 +file_path: Two-element list containing name of web file to test and
     subdirectory path relative to the htdocs directory to copy it to.
  ignore_case: Option to do case-insensitive matching with text_forbid
     and text_require parameters.
  ignore_error_log: Option to ignore errors found in Apache error log.
  include_file_path: List containing files to copy and subdirectory
     path relative to the Apache ServerRoot directory to copy them to.
  mail: Option to send e-mail containing results of tests.
  mail_addresses: List of e-mail addresses to send reports to.
  mail_server: Name of mail server.
  mail_from: E-mail address for From: header of report e-mail.
  method: HTTP request method; either get or post.
  max_bytes: Maximum number of bytes expected in returned page.
  min_bytes: Minimum number of bytes expected in returned page.
  max_rtime: Maximum web server response time (seconds) expected.
  min_rtime: Minimum web server response time (seconds) expected.
  pauth: Two-element list containing userid and password to be passed
     to web server for proxy authorization.
  params: List of parameter name/value pairs to be passed to server.
  proxies: List of service name / proxy URL pairs to use for requests.
  regex_forbid: List of strings/regexs that must NOT occur in page.
  regex_require: List of strings/regexs that MUST occur in page.
  save_output: Option to redirect the program output to a file.
  send_cookies: Option to send cookies to the web server.
  show_cookies: Option to list cookies sent or received.
  show_html: Option to display the HTML source with the output.
 *test_name: Test name, usually just the URL.  Truncated at 56 chars.
  text_forbid: List of strings that must NOT occur in page.
  text_require: List of strings that MUST occur in page.
 +url: URL to test.
  terse: Option to display shorter test report.

 Parameter file format
 =====================
 The program ignores:
    * lines consisting of nothing but white space (blanks or tabs)
    * lines beginning with a number sign ("#")
    * lines beginning with white space (blanks or tabs) followed by
      a number sign

 The order of the parameters in the parameter file is arbitrary,
 with the following exceptions:
    * Test block parameters MUST occur between a test_name parameter
      and an end_test directive.
    * Global parameters must NOT occur between a test_name parameter
      and an end_test directive.  (This requirement does not apply to
      parameters that are both global and test block parameters.)
    * The parameter save_output, if specified, should be the first
      parameter in the file.  (This is not required.)

 Parameters are either scalar (single-valued) or lists (single or
 multi-valued).

 You can specify scalar parameters using forms such as:
 name = value
 name =
        value
 name = 'value'

 You can specify list parameters using forms such as:
 name = ( first value
          second value )
 name = ( first value => second value
          third value => fourth value
        )
 name = ( first value => second value )
 name = (
          'first value'
          'second value' )
 name = (
          first value
          second value
          third value => 'fourth value'
        )
 name =
    ( first value
      'second value' )
 name = (
          'first value'
          'second value'
        )
 (The equals sign must be followed by a space, tab or newline; all
 other spaces are optional.)

 PARAMETER VALUES BEGINNING AND ENDING WITH A SINGLE QUOTE WILL HAVE
 THE SINGLE QUOTES REMOVED.  For example, 'foobar' is parsed as a
 value of foobar and ''foobar'' is parsed as a value of 'foobar'.
 To specify a null (placeholder) value, use ''.

 You MUST enclose the parameter value in single quotes if you want
 to specify:
    * A value beginning with a left parenthesis
    * A value ending with a right parenthesis
    * A value beginning with leading white space (blanks or tabs)
    * A value ending with trailing white space (blanks or tabs)
    * A value beginning and ending with single quotes

 Examples of parameter files
 ===========================
 The parameters below specify tests of a local file and a remote
 URL.  The tests specified by the text_forbid parameter apply to
 both the "RayCosoft home page" and the "Yahoo home page" tests.
 Hence, if either returned page contains one of the case-
 insensitive strings in text_forbid, the test fails.  If any test
 fails or the fetch of the URL fails,, an e-mail will be sent to
 tester@unixscripts.com.

 apache_exec = /usr/sbin/apache
 ignore_case = yes
 mail = errors
 mail_addresses = ( tester@unixscripts.com )
 mail_server = mailhost.unixscripts.com
 text_forbid = ( Premature end of script headers
                 an error occurred while processing this directive
               )

 test_name = 'RayCosoft home page (static)'
    file_path = ( raycosoft_home.html => . )
    text_require = (
       <a href="/dept/peopledev/new_employee/"><font color="#0033cc">
       <a href="https://www.raycosoft.com/"><font color=
                   )
 end_test

 test_name = Yahoo home page
    url = www.yahoo.com
    text_require = ( <a href=r/qt>Quotations</a>...<br> )
    min_bytes = 13000
    max_bytes = 99000
    min_rtime = 0.010
    max_rtime = 30.0
 end_test

 The parameters below specify a test of a local file containing Perl
 code using the Apache::ASP module.  The includes.htm file requires
 five include files and two Perl modules, which are copied using
 the include_file_path parameter.

 apache_exec = /usr/sbin/apache
 ignore_case = yes
 include_file_path = ( footer.inc => htdocs/apps/myapp/inc
                       header.inc => htdocs/apps/myapp/inc
                       head.inc   => htdocs/apps/myapp/inc
                       go.script  => htdocs/shared/includes
                       go.include => htdocs/shared/includes
                       ../utils/DBconn.pm  => lib/perl/utils
                       ../utils/Window.pm  => lib/perl/utils
                     )

 test_name = includes.htm
     file_path = ( includes.htm => apps/myapp )
     min_bytes = 33000
     max_bytes = 35000
     text_require = ( input type=hidden name=control value= )
     text_forbid  = ( Premature end of script headers
                      an error occurred while processing this directive
                    )
 end_test

 Parameters - Detailed descriptions
 ==================================
 PARAMETER: accept_cookies TYPE: global and/or test block parameter
 DEFAULT: yes  ALLOWED VALUES: no yes  OPTIONAL PARAMETER.
 DESCRIPTION: Option to accept and save cookies sent by the web
 server.  These cookies exist only while the program is executing
 and do not affect subsequent runs.  These cookies do not affect your
 browser or any software other than the test program.  These cookies
 are only accessible to other tests in the same parameter file.

 You can specify this parameter globally or within a test block.
 If you specify it as both a global and a test block parameter, the
 value in the test block applies only to that test block.  See also
 the send_cookies parameter.

 PARAMETER: apache_dir  TYPE: global parameter
 DEFAULT: /usr/local/etc/http-webtest
 DESCRIPTION: Absolute or relative path name of directory containing
 Apache files.  See the APACHE DIRECTORY AND FILES section below.
 This parameter is ignored unless the file_path parameter is specified.

 PARAMETER: apache_exec  TYPE: global parameter
 NO DEFAULT.  REQUIRED if the file_path parameter is specified.
 DESCRIPTION: Path name of Apache executable.  This command must be
 in your $PATH or the path name must start with '/'.  This parameter
 is ignored unless the file_path parameter is specified.

 PARAMETER: apache_loglevel  TYPE: global parameter
 DEFAULT: warn  OPTIONAL PARAMETER.
 ALLOWED VALUES: debug info notice warn error crit alert emerg
 DESCRIPTION: Apache logging level.  If you use a level less than
 warn (i.e., debug, info, or notice), the program may generate
 irrelevant errors.  This parameter is ignored unless the file_path
 parameter is specified.  See also the ignore_error_log parameter.

 PARAMETER: apache_max_wait  TYPE: global parameter
 DEFAULT: 64  ALLOWED VALUES: Any integer > 9 and < 601  OPTIONAL
 PARAMETER.
 DESCRIPTION: Maximum number of seconds to wait for Apache to start.
 The program starts Apache, waits 4 seconds and fetches a test page.
 If this fails, it doubles the wait interval, restarts Apache,
 waits and fetches a test page.  This process repeats until the
 test page is fetched successfully or the wait interval becomes
 greater than apache_max_wait.  This parameter is ignored unless
 the file_path parameter is specified.

 PARAMETER: apache_options  TYPE: global parameter
 DEFAULT: -X  ALLOWED VALUES: See Apache man page.  OPTIONAL PARAMETER.
 DESCRIPTION: Additional Apache command line options.  Many of the
 options cause Apache to exit immediately after starting, so the
 web page tests will not run.  This parameter is ignored unless
 the file_path parameter is specified.

 PARAMETER: auth  TYPE: global and/or test block parameter
 No default.  ALLOWED VALUES: A one or two element list.  OPTIONAL
 PARAMETER.
 DESCRIPTION: Userid and password, in that order, to be passed to the
 web server if needed for authorization.  If you specify only one
 element, it is used as the userid and the program will prompt you
 interactively for the password.  If you specify values of 'prompt'
 and 'userid_password' in that order, the program will prompt you for
 both the userid and password.  If you specify values of 'prompt'
 and 'password' in that order, the program will prompt you for
 the password and use the userid of the user running the program.
 (This last option is probably not what you want, unless your Unix
 userid and web page userid are the same.)

 You can specify this parameter globally or within a test block.
 If you specify it as both a global and a test block parameter,
 the value in the test block applies only to that test block.

 PARAMETER: cookie  TYPE: test block parameter
 NO DEFAULT.  ALLOWED VALUES: A list with at least 5 elements.  If
 there are more than 10 elements, there must be an even number of
 elements.  The cookie parameter is ignored if the send_cookies
 parameter is set to no.  OPTIONAL PARAMETER.  Multiple cookie
 parameters may be specified.
 DESCRIPTION: List that specifies a cookie to send to the web server.
 See RFC 2965 for details (ftp.isi.edu/in-notes/rfc2965.txt).
 You may specify multiple cookies within each test block by
 specifying multiple instances of the cookie parameter.  The cookie
 parameter has the form:

 ( version
   name
   value
   path
   domain
   port
   path_spec
   secure
   maxage
   discard
   name1
   value1
   name2
   value2
   ...
 )

 Any element not marked below as REQUIRED may be defaulted by
 specifying a null value of ''

 version: Version number of cookie spec to use, usually 0. (REQUIRED)
 name: Name of cookie. (REQUIRED)  Cannot begin with a $ character.
 value: Value of cookie. (REQUIRED)
 path: URL path name for which this cookie applies. (REQUIRED)  Must
    begin with a / character.  See also path_spec.
 domain: Domain for which cookie is valid. (REQUIRED)  Should begin
    with a period.  Must either contain two periods or be equal
    to .local
 port: List of allowed port numbers that the cookie may be returned
    to.  If not specified, cookie can be returned to any port.
    Must be specified using the format N or N,N ..., where N is one
    or more digits.
 path_spec: Ignored if version is less than 1.  Option to ignore the
    value of path.  Default value is 0.
    = 1 -> Use the value of path.
    = 0 -> Ignore the specified value of path.
 secure: Option to require secure protocols for cookie transmission.
    Default value is 0.
    = 1 -> Use only secure protocols to transmit this cookie.
    = 0 -> Secure protocols are not required for transmission.
 maxage: Number of seconds until cookie expires.
 discard: Option to discard cookie when the program finishes.
    Default 0.  (The cookie will be discarded regardless of the value
    of this element.)
    = 1 -> Discard cookie when the program finishes.
    = 0 -> Don't discard cookie.
 name/value: Zero, one or several name/value pairs may be specified.
    The name parameters are words such as Comment or
    CommentURL and the value parameters are strings that
    may contain embedded blanks.

 See RFC 2965 for details (ftp.isi.edu/in-notes/rfc2965.txt).

 An example cookie would look like:
 ( 0
   WebTest cookie #1
   expires&2592000&type&consumer
   /
   .unixscripts.com
   ''
   0
   0
   200
   1
 )

 PARAMETER: debug  TYPE: global parameter
 DEFAULT: no  ALLOWED VALUES: no yes preserve  OPTIONAL PARAMETER.
 DESCRIPTION: This parameter is primarily for use by programmers
 modifying and testing the program code.  The "yes" value makes
 the program display verbose diagnostic messages.  (If you want
 diagnostics on the parameter processing, this parameter should
 preceed all other parameters.)  The "preserve" value makes the
 program display verbose diagnostic messages and prevents the
 program from deleting the temporary Apache directory, which is
 named "/tmp/webtest_x_y", where x and y are arbitrary positive
 integers.

 DIRECTIVE: end_test  TYPE: test block directive
 NO VALUE (i.e. specify end_test with no equals sign or value).
 There MUST be one end_test directive for each test_name parameter.
 Directive is REQUIRED.
 DESCRIPTION: Signifies the end of a test block.

 PARAMETER: file_path  TYPE: test block parameter
 NO DEFAULT.  ALLOWED VALUES: Second list element cannot begin with
 '../' or contain '/../'.  You MUST specify file_path or url, but
 not both, in each test block.
 DESCRIPTION: Two-element list.  First element is the file to test,
 either an absolute or a relative pathname.  Second element is the
 subdirectory pathname, relative to the Apache htdocs directory, to
 copy the file to.  The copied file will have the same basename as
 the first element and the relative pathname of the second element.
 To copy the file directly to the htdocs directory, use a pathname of
 . or './.'.

 For example:
 file_path = ( /home/tester/testfile.html => mydepartment/myproject )
 will copy the file to ./htdocs/mydepartment/myproject/testfile.html.

 PARAMETER: ignore_case  TYPE: global and/or test block parameter
 DEFAULT: no  ALLOWED VALUES: no yes  OPTIONAL PARAMETER.
 DESCRIPTION: Option to do case-insensitive matching for text_forbid
 and text_require parameters.  This does not affect the regex_forbid
 or regex_require parameters.

 PARAMETER: ignore_error_log  TYPE: global and/or test block
 parameter  DEFAULT: no  ALLOWED VALUES: no yes  OPTIONAL PARAMETER.
 DESCRIPTION: Option to ignore any errors found in the Apache error
 log.  The default behavior is to flag an error if the fetch causes
 any errors to be added to the error log and echo the errors to
 the program output. This parameter is ignored unless the file_path
 parameter is specified.  See also the apache_loglevel parameter.
 See also the Restrictions / Bugs section.

 PARAMETER: include_file_path  TYPE: global parameter
 NO DEFAULT.  ALLOWED VALUES: Even-numbered list elements cannot
 begin with '../' or contain '/../'.  OPTIONAL PARAMETER.  You can
 specify more than one instance of this paramter.
 DESCRIPTION: List with an even number of elements.  Odd-numbered
 elements are files to copy to the the temporary Apache directory
 before running the tests.  These files can be specified using
 either an absolute or a relative pathname.  Even-numbered elements
 are the subdirectory pathname, relative to the Apache ServerRoot
 directory, to copy the corresponding file to.  The copied file
 will have the same basename as the odd-numbered element and the
 relative pathname of the corresponding even-numbered element.
 To copy the file directly to the ServerRoot directory, use a
 pathname of . or './.'.

 For example:
 include_file_path = (/home/tester/inc/header.inc => htdocs/includes)
 will copy the file to htdocs/includes/header.inc.

 This parameter is also useful for adding Perl modules that are
 needed by the web page specified by the file_path parameter.  For
 example:
 include_file_path = ( ../apps/myapp/DBconn.pm => lib/perl/apps )
 will copy the Perl module DBconn.pm to a directory that is in the
 Perl @INC array.

 An alternative to using the include_file_path parameter is to
 manually copy the files into the desired subdirectory in the
 directory specified by the apache_dir parameter.

 PARAMETER: mail  TYPE: global parameter
 DEFAULT: no  ALLOWED VALUES: no errors all  OPTIONAL PARAMETER.
 DESCRIPTION: Option to e-mail reports to the addresses in
 the mail_addresses parameter using the server specified by the
 mail_server parameter.  If set to no, no e-mail is sent.  If set to
 errors and one or more of the tests in the parameter file fails,
 an e-mail is sent that contains the results of all tests in the
 parameter file.  If set to all, an e-mail is sent containing the
 results of all tests in the parameter file, regardless of success
 or failure.

 PARAMETER: mail_addresses  TYPE: global parameter
 NO DEFAULT.  REQUIRED unless mail = no.
 DESCRIPTION: List of e-mail addresses to send mail to.  This
 parameter has two uses.  If the mail parameter is set to "errors"
 or "all", the program sends mail containing the program output
 to these addresses.  If the Apache executable specified by the
 apache_exec parameter has the Apache::ASP Perl module configured,
 server errors generated while compiling or running Apache::ASP
 scripts will be e-mailed to the first address in the mail_addresses
 list.

 PARAMETER: mail_server  TYPE: global parameter
 NO DEFAULT.  REQUIRED unless mail = no.
 DESCRIPTION: Name of mail server.

 PARAMETER: mail_from  TYPE: global parameter
 DEFAULT: name of user under which test script runs.
 DESCRIPTION: E-mail address for From: header of report e-mail.

 PARAMETER: method  TYPE: test block parameter
 DEFAULT: get  ALLOWED VALUES: get post  OPTIONAL PARAMETER.
 DESCRIPTION: HTTP method for the request(s).  See RFC 2616
 (HTTP/1.1 protocol).

 PARAMETER: max_bytes  TYPE: global and/or test block parameter
 NO DEFAULT   ALLOWED VALUES: Any integer greater that zero and
 greater than min_bytes (if min_bytes is specified).  OPTIONAL
 PARAMETER.
 DESCRIPTION: Maximum number of bytes expected in returned page.
 If this value is exceeded, an error message is displayed.

 PARAMETER: min_bytes  TYPE: global and/or test block parameter
 NO DEFAULT   ALLOWED VALUES: Any integer less than max_bytes (if
 max_bytes is specified).  OPTIONAL PARAMETER.
 DESCRIPTION: Minimum number of bytes expected in returned page.
 If the number of returned bytes is less than this value, an error
 message is displayed.

 PARAMETER: max_rtime  TYPE: global and/or test block parameter
 NO DEFAULT   ALLOWED VALUES: Any number greater that zero and
 greater than min_rtime (if min_rtime is specified).  OPTIONAL
 PARAMETER.
 DESCRIPTION: Maximum web server response time expected.  If this
 value is exceeded, an error message is displayed.

 PARAMETER: min_rtime  TYPE: global and/or test block parameter
 NO DEFAULT   ALLOWED VALUES: Any number less than max_rtime (if
 max_rtime is specified).  OPTIONAL PARAMETER.
 DESCRIPTION: Minimum web server response time expected.  If this
 value is exceeded, an error message is displayed.

 PARAMETER: params  TYPE: test block parameter
 NO DEFAULT.  ALLOWED VALUES: A list with an even number of
 elements.  OPTIONAL PARAMETER.
 DESCRIPTION: A set of parameter name/value pairs to be passed
 with the request.  (This parameter is used to test pages that
 process forms.)  Unless the method parameter is set to 'post',
 these pairs are URI-escaped and appended to the requested URL.
 For example,
 url = http://www.hotmail.com/cgi-bin/hmhome
 params = ( curmbox
            F001 A005
            from
            HotMail )
 generates the request:
 http://www.hotmail.com/cgi-bin/hmhome?curmbox=F001%20A005&from=HotMail
 The names and values will be URI-escaped as defined by RFC 2396.
 (See http://www.ietf.org/rfc/rfc2396.txt.)

 PARAMETER: pauth  TYPE: global and/or test block parameter
 No default.  ALLOWED VALUES: A one or two element list.  OPTIONAL
 PARAMETER.
 DESCRIPTION: Userid and password, in that order, to be passed to
 the proxy if needed for authorization.  If you specify only one
 element, it is used as the userid and the program will prompt you
 interactively for the password.  If you specify values of 'prompt'
 and 'userid_password' in that order, the program will prompt you for
 both the userid and password.  If you specify values of 'prompt'
 and 'password' in that order, the program will prompt you for
 the password and use the userid of the user running the program.
 (This last option is probably not what you want, unless your Unix
 userid and web page userid are the same.)

 PARAMETER: proxies  TYPE: global parameter
 NO DEFAULT.  ALLOWED VALUES: A list with an even number of
 elements.  OPTIONAL PARAMETER.
 DESCRIPTION: A set of service name / proxy URL pairs that specify
 proxy servers to use for requests.  For example:
 proxies = ( http => http://http_proxy.mycompany.com
             ftp  => http://ftp_proxy.mycompany.com )

 -------------------------------------------------------------------

 The regex_forbid and regex_require parameters contain one or more
 Perl regular expressions.  The regex_forbid and regex_require
 parameter values are compared to the fetched page contents as the
 right hand side of a "=~" operator.  If you want to search for a
 literal string, use the text_forbid and text_require parameters.
 For more information, type "man perlre" or see Programming Perl,
 3rd edition, Chapter 5.

 You can specify these parameters globally or within a test block.
 If you specify one as both a global and a test block parameter, the
 value in the test block applies only to that test block.

 PARAMETER: regex_forbid  TYPE: global and/or test block parameter
 NO DEFAULT.  OPTIONAL PARAMETER.
 DESCRIPTION: List of one or more regular expressions that must
 NOT exist on the web page.  See also the text_forbid parameter.

 PARAMETER: regex_require  TYPE: global and/or test block parameter
 NO DEFAULT.  OPTIONAL PARAMETER.
 DESCRIPTION: List of one or more regular expressions that MUST
 exist on the web page.  See also the text_require parameter.

 -------------------------------------------------------------------

 PARAMETER: save_output  TYPE: global parameter
 DEFAULT: no  ALLOWED VALUES: no yes preserve  OPTIONAL PARAMETER.
 DESCRIPTION: Option to redirect the program output to a file.
 (Error messages still go to the terminal.)  The program constructs
 the file name by taking the name of this parameter file, removing
 the file extension if it exists and appending ".out".  If there is
 an existing file with that name, the program overwrites the file if
 save_output is set to 'yes'.  If save_output is set to 'preserve'
 and the file already exists, output is sent to the terminal.
 This parameter should precede all other parameters in the parameter
 file. (This order is not required.)

 PARAMETER: send_cookies TYPE: global and/or test block parameter
 DEFAULT: yes  ALLOWED VALUES: no yes  OPTIONAL PARAMETER.
 DESCRIPTION: Option to send cookies to the web server.  This applies
 to cookies passed by the web server(s) during the test session and
 to cookies created using the cookies parameter.  This does NOT
 give the web server(s) access to cookies created with a browser
 or any user agent software other than this program.  The cookies
 created while this program is running are only accessible to other
 tests in the same parameter file.

 You can specify this parameter globally or within a test block.
 If you specify it as both a global and a test block parameter, the
 value in the test block applies only to that test block.  See also
 the accept_cookies parameter.

 PARAMETER: show_cookies TYPE: global parameter
 DEFAULT: no  ALLOWED VALUES: no yes  OPTIONAL PARAMETER.
 DESCRIPTION: Option to list cookies sent to or received from the web
 server.  Each cookie will be preceded with the string "Set-Cookie3:"
 and the cookie elements will be separated by semicolons.

 PARAMETER: show_html  TYPE: global parameter
 DEFAULT: no  ALLOWED VALUES: no yes  OPTIONAL PARAMETER.
 DESCRIPTION: Option to display the HTML source with the output.
 You can specify this parameter globally or within a test block.
 If you specify it as both a global and a test block parameter,
 the value in the test block applies only to that test block.

 If, and only if, you specify the file_path parameter, the program
 starts a local instance of Apache, copies the file to its htdocs
 directory, fetches the file from Apache and runs the specified
 tests.

 PARAMETER: terse  TYPE: global parameter
 DEFAULT: no  ALLOWED VALUES: no failed_only summary  OPTIONAL
 PARAMETER.
 DESCRIPTION: Option to display short test report.  If you set
 it to 'summary', the program displays only a one-line summary of
 the tests for each URL/file.  If you set terse to 'failed_only',
 the program only displays the results of tests that failed and
 the summary.  If you set terse to 'no', the program displays all
 the test results and the summary.

 PARAMETER: test_name  TYPE: test block parameter
 NO DEFAULT.  Parameter is REQUIRED.
 DESCRIPTION: Name of this test, usually just the URL.  Only the
 first 56 characters are used.  This MUST be the first parameter
 in the block for each test.  You may specify multiple test blocks
 within a parameter file.  There MUST be one end_test directive
 for each test_name parameter.

 PARAMETER: text_forbid  TYPE: global and/or test block parameter
 NO DEFAULT.  OPTIONAL PARAMETER.
 DESCRIPTION: List of one or more text strings that must NOT exist
 on the web page.  See also the ignore_case and regex_forbid
 parameters.

 PARAMETER: text_require  TYPE: global and/or test block parameter
 NO DEFAULT.  OPTIONAL PARAMETER.
 DESCRIPTION: List of one or more text strings that MUST exist on
 the web page.  See also the ignore_case and regex_require
 parameters.

 PARAMETER: url  TYPE: test block parameter
 NO DEFAULT.  You MUST specify file_path or url, but not both, in
 each test block.
 DESCRIPTION: URL to test, if value starts with "www.", "http://"
 will be prefixed.  A parameter file can contain some test blocks
 that specify file_path and some that specify url.


 APACHE DIRECTORY AND FILES

 The apache_dir parameter must be set to the name of a directory
 that contains the subdirectories "conf", "logs" and "htdocs".
 The conf subdirectory must contain a file named "httpd.conf-dist".
 The htdocs subdirectory must contain a subdirectory named webtest
 that contains a file named "is_apache_responding.html".  If your
 installation of Apache has the Perl module Apache::ASP configured,
 the apache_dir directory must also contain a subdirectory named
 "asp_tmp".

 The file httpd.conf-dist must contain all the usual Apache
 configuration parameters.  Also, the httpd.conf-dist file must
 contain the following lines INSTEAD OF the lines containing the
 corresponding parameters (i.e., Port, Listen, ServerRoot, etc.):

 Port Please_do_not_modify_PORT
 Listen Please_do_not_modify_PORT
 ServerRoot Please_do_not_modify_SERVER_ROOT
 ErrorLog Please_do_not_modify_SERVER_ROOT/logs/error.log
 LogLevel Please_do_not_modify_LOG_LEVEL
 CustomLog Please_do_not_modify_SERVER_ROOT/logs/access.log common
 PidFile Please_do_not_modify_SERVER_ROOT/apache.pid
 LockFile Please_do_not_modify_SERVER_ROOT/apache.lock
 ServerName Please_do_not_modify_HOST_NAME
 SSLMutex  file:Please_do_not_modify_SERVER_ROOT/ssl_mutex
 SSLLog      Please_do_not_modify_SERVER_ROOT/logs/ssl_engine_log
 DocumentRoot Please_do_not_modify_SERVER_ROOT/htdocs

 At runtime these tags are replaced with the values needed by the
 Apache server that the program starts.  See the Apache documentation
 for details (http://www.apache.org/docs/mod/directives.html).

 Also, if your installation of Apache has the Perl module
 Apache::ASP configured, you must use the following lines instead
 of the lines containing the corresponding parameters (i.e.,
 PERLSETVAR_GLOBAL, PERLSETVAR_MAILHOST, PERLSETVAR_MAILERRORSTO):

 Please_do_not_modify_PERLSETVAR_GLOBAL
 Please_do_not_modify_PERLSETVAR_MAILHOST
 Please_do_not_modify_PERLSETVAR_MAILERRORSTO

 These lines are usually placed in the FileMatch block of the
 VirtualHost block for the PerlHandler Apache::ASP.  At runtime
 these tags are replaced with the the directive PerlSetVar followed
 by the name of the parameter (Global, MailHost, MailErrorsTo)
 and a parameter value derived from other input parameters.  See
 the Apache::ASP documentation for details
 (http://www.apache-asp.org/config.html).

 The subdirectory htdocs must contain a subdirectory named webtest
 that contains a file named "is_apache_responding.html".  This file
 must contain valid HTML and must contain the string
 Please_do_not_modify_TEST_TAG somewhere in the file.  (This file is
 used to verify that Apache has started successfully.)

=head1 PREREQUISITES

Perl version 5.005 or higher is required. The following Perl modules
are also required.  (Some of them are part of the base distribution.)

 Cwd
 File::Basename
 File::Copy
 File::Find
 File::Path
 File::Temp
 HTTP::Cookies
 HTTP::Request::Common
 HTTP::Response
 LWP::UserAgent
 Net::Domain
 Net::SMTP
 Sys::Hostname
 Term::ReadKey
 Time::HiRes
 URI::URL

=head1 RESTRICTIONS / BUGS

This module have been tested only on Unix (e.g., Solaris, Linux, AIX,
etc.) but it should work on Win32 systems.

Local file tests don't work on Win32 systems.

The module's HTTP requests time out after 3 minutes (the default
value for LWP::UserAgent).  If the file_path parameter is specified,
Apache must be installed.  If the file_path parameter is specified,
the directory /tmp cannot be NFS-mounted, since Apache's lockfile
and the SSL mutex file must be stored on a local disk.

=head1 TODO

Add option to validate HTML syntax using HTML::Validator.
Add option to check links using HTML::LinkExtor.
Add single-URL timeout block parameter to pass to LWP::UserAgent.
Move test_regexes into a plugin.

=head1 AUTHOR

Richard Anderson <Richard.Anderson@unixscripts.com> have wrote
HTTP::WebTest.

Ilya Martynov <ilya@martynov.org> maintains HTTP::WebTest now. Please
email him bug reports, suggestions, questions, etc.

=head1 COPYRIGHT

Copyright (c) 2000-2001 Richard Anderson. All rights reserved. This
module is free software.  It may be used, redistributed and/or modified
under the terms of the Perl Artistic License.

=head1 SEE ALSO

wt(1), perl(1), perlre(1), perldoc Apache::ASP.

=cut
1;
