<?php
/* $Id: db_details_links.php,v 1.18 2002/10/23 04:17:42 robbat2 Exp $ */
// vim: expandtab sw=4 ts=4 sts=4:


/**
 * Counts amount of navigation tabs
 */
$db_details_links_count_tabs = 0;


/**
 * If coming from a Show MySQL link on the home page,
 * put something in $sub_part
 */
if (empty($sub_part)) {
    $sub_part = '_structure';
}


/**
 * Prepares links
 */
// Export link if there is at least one table
if ($num_tables > 0) {
    $lnk3 = 'db_details_export.php';
    $arg3 = $url_query;
    $lnk4 = 'db_search.php';
    $arg4 = $url_query;
}
else {
    $lnk3 = '';
    $arg3 = '';
    $lnk4 = '';
    $arg4 = '';
}
// Drop link if allowed
if (!$cfg['AllowUserDropDatabase']) {
    // Check if the user is a Superuser
    $links_result                 = @PMA_mysql_query('USE mysql');
    $cfg['AllowUserDropDatabase'] = (!PMA_mysql_error());
}
if ($cfg['AllowUserDropDatabase']) {
    $lnk5 = 'sql.php';
    $arg5 = $url_query . '&amp;sql_query='
          . urlencode('DROP DATABASE ' . PMA_backquote($db))
          . '&amp;zero_rows='
          . urlencode(sprintf($strDatabaseHasBeenDropped, htmlspecialchars(PMA_backquote($db))))
          . '&amp;goto=main.php&amp;back=db_details' . $sub_part . '.php&amp;reload=1';
    $att5 = 'class="drop" '
          . 'onclick="return confirmLink(this, \'DROP DATABASE ' . PMA_jsFormat($db) . '\')"';
}
else {
    $lnk5 = '';
}


/**
 * Displays tab links
 */
?>
<table border="0" cellspacing="0" cellpadding="3" width="100%" class="tabs">
    <tr>
        <td width="8">&nbsp;</td>
<?php
echo PMA_printTab($strStructure, 'db_details_structure.php', $url_query);
echo PMA_printTab($strSQL, 'db_details.php', $url_query . '&amp;db_query_force=1');
echo PMA_printTab($strExport, $lnk3, $arg3);
echo PMA_printTab($strSearch, $lnk4, $arg4);

// Query by example and dump of the db are only displayed if there is at least
// one table in the db
if ($num_tables > 0) {
    echo PMA_printTab($strQBE, 'db_details_qbe.php', $url_query);
} // end if

// Displays drop link
if ($lnk5) {
   echo PMA_printTab($strDrop, $lnk5, $arg5, $att5);
} // end if
echo "\n";
?>
    </tr>
</table>
<br />

