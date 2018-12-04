<?php
/* $Id: db_details_common.php,v 1.6 2002/10/23 04:17:42 robbat2 Exp $ */
// vim: expandtab sw=4 ts=4 sts=4:

/**
 * Gets some core libraries
 */
if (!defined('PMA_GRAB_GLOBALS_INCLUDED')) {
    include('./libraries/grab_globals.lib.php');
}
if (!defined('PMA_COMMON_LIB_INCLUDED')) {
    include('./libraries/common.lib.php');
}
if (!defined('PMA_BOOKMARK_LIB_INCLUDED')) {
    include('./libraries/bookmark.lib.php');
}


/**
 * Defines the urls to return to in case of error in a sql statement
 */
$err_url_0 = 'main.php'
           . '?lang=' . $lang
           . '&amp;convcharset=' . $convcharset
           . '&amp;server=' . $server;
$err_url   = $cfg['DefaultTabDatabase']
           . '?lang=' . $lang
           . '&amp;convcharset=' . $convcharset
           . '&amp;server=' . $server
           . '&amp;db=' . urlencode($db);


/**
 * Ensures the database exists (else move to the "parent" script) and displays
 * headers
 */
if (!isset($is_db) || !$is_db) {
    // Not a valid db name -> back to the welcome page
    if (!empty($db)) {
        $is_db = @PMA_mysql_select_db($db);
    }
    if (empty($db) || !$is_db) {
        header('Location: ' . $cfg['PmaAbsoluteUri'] . 'main.php?lang=' . $lang . '&convcharset=' . $convcharset . '&server=' . $server . (isset($message) ? '&message=' . urlencode($message) : '') . '&reload=1');
        exit();
    }
} // end if (ensures db exists)
// Displays headers
if (!isset($message)) {
    $js_to_run = 'functions.js';
    include('./header.inc.php');
    // Reloads the navigation frame via JavaScript if required
    if (isset($reload) && $reload) {
        echo "\n";
        ?>
<script type="text/javascript" language="javascript1.2">
<!--
window.parent.frames['nav'].location.replace('./left.php?lang=<?php echo $lang; ?> &convcharset=<?php echo $convcharset; ?>&server=<?php echo $server; ?>&db=<?php echo urlencode($db); ?>');
//-->
</script>
        <?php
    }
    echo "\n";
} else {
    PMA_showMessage($message);
}

/**
 * Set parameters for links
 */
$url_query = 'lang=' . $lang
           . '&amp;convcharset=' . $convcharset
           . '&amp;server=' . $server
           . '&amp;db=' . urlencode($db);

?>
