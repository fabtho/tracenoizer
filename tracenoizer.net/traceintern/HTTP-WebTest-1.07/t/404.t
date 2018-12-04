print "1..1\n";
if (system("WEBTEST_LIB=blib/lib; export WEBTEST_LIB; ./wt t/404.wt")) {
   print "ok 1\n";
} else {
   print "not ok 1\n";
}
