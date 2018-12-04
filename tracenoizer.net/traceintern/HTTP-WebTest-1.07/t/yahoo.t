print "1..1\n";
if (system("WEBTEST_LIB=blib/lib; export WEBTEST_LIB; ./wt t/yahoo.wt")) {
   print "not ok 1\n";
} else {
   print "ok 1\n";
}
