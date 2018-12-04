<?
print 'BLAH';
$string = "/usr/bin/perl /home/tracenoizer/public_html/super_villainizer/newpork2.pl ".$vill_fname.' '.$vill_sname.' '.$mailaddress1.' '.$password.' '.$comment1.' '.$comment2.' '.$mailaddress2.' '.$male.' '.$address1.' '.$address2.' '.$address3.' '.$address4.' '.$address5.' '.$birthdates1.' '.$birthdates2.' '.$birthdates3.' '.$stat_id.' '.$acc_id;



shell_exec ($string);
?>