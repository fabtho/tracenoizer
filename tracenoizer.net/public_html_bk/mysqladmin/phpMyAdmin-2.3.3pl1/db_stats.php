<?php
/* $Id: db_stats.php,v 1.45 2002/11/28 09:15:47 rabus Exp $ */
// vim: expandtab sw=4 ts=4 sts=4:

/**
 * Gets the variables sent to this script and send headers
 */
$js_to_run = 'functions.js';
require('./libraries/grab_globals.lib.php');
require('./header.inc.php');


/**
 * Ensures the current user is super-user
 */
if (!@PMA_mysql_query('USE mysql', $userlink)) {
    echo '<p><b>' . $strError . '</b></p>' . "\n";
    echo '<p>&nbsp;&nbsp;&nbsp;&nbsp;' .  $strNoRights . '</p>' . "\n";
    include('./footer.inc.php');
    exit();
} // end if


/**
 * Drop databases if required
 */
if ((!empty($submit_mult) && isset($selected_db))
    || isset($mult_btn)) {
    $err_url    = 'db_stats.php'
                . '?lang=' . $lang
                . '&amp;convcharset=' . $convcharset
                . '&amp;server=' . $server;
    $action     = 'db_stats.php';
    $show_query = '1';
    include('./mult_submits.inc.php');
}


/**
 * Sorts the databases array according to the user's choice
 *
 * @param   array    a record associated to a database
 * @param   array    a record associated to a database
 *
 * @return  integer  a value representing whether $a should be before $b in the
 *                   sorted array or not
 *
 * @global  mixed    the array to sort
 * @global  mixed    'key' if the table has to be sorted by key, the column
 *                   number to use to sort the array else
 *
 * @access  private
 */
function PMA_dbCmp($a, $b)
{
    global $dbs_array;
    global $col;

    $is_asc = ($GLOBALS['sort_order'] == 'asc');

    // Sort by key (the db names) if required
    if (!is_int($col) && $col == 'key') {
        return (($is_asc) ? strcasecmp($a, $b) : -strcasecmp($a, $b));
    }
    // Sort by key (the db names) in ascending order if the columns' values are
    // the same
    else if ($dbs_array[$a][$col] == $dbs_array[$b][$col]) {
        return strcasecmp($a, $b);
    }
    // Other cases
    else {
        $tmp = (($dbs_array[$a][$col] < $dbs_array[$b][$col]) ? -1 : 1);
        return (($is_asc) ? $tmp : -$tmp);
    }
} // end of the 'PMA_dbCmp()' function


/**
 * Get the list and number of available databases.
 * Skipped if no server selected: in this case no database should be displayed
 * before the user choose among available ones at the welcome screen.
 */
if ($server > 0) {
    // Get the valid databases list
    $num_dbs = count($dblist);
    $dbs     = @mysql_list_dbs() or PMA_mysqlDie('', 'mysql_list_dbs()', '', 'main.php?lang' . $lang . '&amp;server=' . $server);
    if ($dbs) {
        while ($a_db = PMA_mysql_fetch_object($dbs)) {
            if (!$num_dbs) {
                $dblist[]                     = $a_db->Database;
            } else {
                $true_dblist[$a_db->Database] = '';
            }
        } // end while
        mysql_free_result($dbs);
    } // end if
    if ($num_dbs && empty($true_dblist)) {
        $dblist = array();
    } else if ($num_dbs) {
        for ($i = 0; $i < $num_dbs; $i++) {
            if (isset($true_dblist[$dblist[$i]])) {
                $dblist_valid[] = $dblist[$i];
            }
        }
        if (isset($dblist_valid)) {
            $dblist = $dblist_valid;
            unset($dblist_valid);
        } else {
            $dblist = array();
        }
        unset($true_dblist);
    }
    // Get the valid databases count
    $num_dbs = count($dblist);
} else {
    $num_dbs = 0;
}



/**
 * Displays the page
 */
?>
<h1 align="center">
    <?php echo $strDatabasesStats; ?>
</h1>
<table align="center" border="<?php echo $cfg['Border']; ?>" cellpadding="5">
<tr>
    <th align="<?php echo $cell_align_left; ?>"><big><?php echo $strHost . ' :'; ?></big></th>
    <th align="<?php echo $cell_align_left; ?>"><big><?php echo $cfg['Server']['host']; ?></big></th>
</tr>
<tr>
    <th align="<?php echo $cell_align_left; ?>"><big><?php echo $strGenTime . ' :'; ?></big></th>
    <th align="<?php echo $cell_align_left; ?>"><big><?php echo PMA_localisedDate(); ?></big></th>
</tr>
</table>
<br /><br />


<?php
/**
 * At least one db -> do the work
 */
if ($num_dbs > 0) {
    // Defines the urls used to sort the table
    $common_url     = 'db_stats.php?lang=' . $lang . '&amp;convcharset=' . $convcharset . '&amp;server=' . $server;
    if (empty($sort_by)) {
        $sort_by                 = 'db_name';
        $sort_order              = 'asc';
    }
    else if (empty($sort_order)) {
        $sort_order              = (($sort_by == 'db_name') ? 'asc' : 'desc');
    }
    $img_tag        = '&nbsp;' . "\n"
                    . '            '
                    . '<img src="./images/' . $sort_order . '_order.gif" border="0" width="7" height="7"'
                    . ' alt="' . (($sort_order == 'asc') ? $strAscending : $strDescending) . '"'
                    . ' title="' . (($sort_order == 'asc') ? $strAscending : $strDescending) . '" />';
    // Default order is ascending for db name, descending for sizes
    for ($i = 0; $i < 5; $i++) {
        $url_sort[$i]['order']   = (($i == 0) ? 'asc' : 'desc');
        $url_sort[$i]['img_tag'] = '';
    }
    if ($sort_by == 'db_name') {
        $url_sort[0]['order']    = (($sort_order == 'asc') ? 'desc' : 'asc');
        $url_sort[0]['img_tag']  = $img_tag;
        $col                     = 'key'; // used in 'PMA_dbCmp()'
    } else if ($sort_by == 'tbl_cnt') {
        $url_sort[1]['order']    = (($sort_order == 'asc') ? 'desc' : 'asc');
        $url_sort[1]['img_tag']  = $img_tag;
        $col                     = 0;
    } else if ($sort_by == 'data_sz') {
        $url_sort[2]['order']    = (($sort_order == 'asc') ? 'desc' : 'asc');
        $url_sort[2]['img_tag']  = $img_tag;
        $col                     = 1;
    } else if ($sort_by == 'idx_sz') {
        $url_sort[3]['order']    = (($sort_order == 'asc') ? 'desc' : 'asc');
        $url_sort[3]['img_tag']  = $img_tag;
        $col                     = 2;
    } else {
        $url_sort[4]['order']    = (($sort_order == 'asc') ? 'desc' : 'asc');
        $url_sort[4]['img_tag']  = $img_tag;
        $col                     = 3;
    }
    ?>
<form action="db_stats.php" name="dbStatsForm">
    <input type="hidden" name="lang" value="<?php echo $lang; ?>" />
    <input type="hidden" name="convcharset" value="<?php echo $convcharset; ?>" />
    <input type="hidden" name="server" value="<?php echo $server; ?>" />

    <table align="center" border="<?php echo $cfg['Border']; ?>">
    <tr>
        <th>&nbsp;</th>
        <th>
            &nbsp;
            <a href="<?php echo $common_url . '&amp;sort_by=db_name&amp;sort_order=' . $url_sort[0]['order']; ?>">
                <?php echo $strDatabase . $url_sort[0]['img_tag']; ?></a>&nbsp;
        </th>
        <th>
            &nbsp;
            <a href="<?php echo $common_url . '&amp;sort_by=tbl_cnt&amp;sort_order=' . $url_sort[1]['order']; ?>">
                <?php echo $strNumTables . $url_sort[1]['img_tag']; ?></a>&nbsp;
        </th>
        <th>
            &nbsp;
            <a href="<?php echo $common_url . '&amp;sort_by=data_sz&amp;sort_order=' . $url_sort[2]['order']; ?>">
                <?php echo $strData . $url_sort[2]['img_tag']; ?></a>&nbsp;
        </th>
        <th>
            &nbsp;
            <a href="<?php echo $common_url . '&amp;sort_by=idx_sz&amp;sort_order=' . $url_sort[3]['order']; ?>">
                <?php echo $strIndexes . $url_sort[3]['img_tag']; ?></a>&nbsp;
        </th>
        <th>
            &nbsp;
            <a href="<?php echo $common_url . '&amp;sort_by=tot_sz&amp;sort_order=' . $url_sort[4]['order']; ?>">
                <?php echo $strTotalUC . $url_sort[4]['img_tag']; ?></a>&nbsp;
        </th>
    </tr>
    <?php
    unset($url_sort);
    echo "\n";

    $total_array[0] = 0;        // number of tables
    $total_array[1] = 0;        // total data size
    $total_array[2] = 0;        // total index size
    $total_array[3] = 0;        // big total size

    // Gets the tables stats per database
    for ($i = 0; $i < $num_dbs; $i++) {
        $db         = $dblist[$i];
        $tables     = @PMA_mysql_list_tables($db);

        // Number of tables
        if ($tables) {
            $dbs_array[$db][0] = mysql_numrows($tables);
            mysql_free_result($tables);
        } else {
            $dbs_array[$db][0] = 0;
        }
        $total_array[0]    += $dbs_array[$db][0];

        // Size of data and indexes
        $dbs_array[$db][1] = 0; // data size column
        $dbs_array[$db][2] = 0; // index size column
        $dbs_array[$db][3] = 0; // full size column

        if (PMA_MYSQL_INT_VERSION >= 32303) {
            $local_query = 'SHOW TABLE STATUS FROM ' . PMA_backquote($db);
            $result      = @PMA_mysql_query($local_query);
            // needs the "@" below otherwise, warnings in case of special DB names
            if ($result && @mysql_num_rows($result)) {
                while ($row = PMA_mysql_fetch_array($result)) {
                    $dbs_array[$db][1] += $row['Data_length'];
                    $dbs_array[$db][2] += $row['Index_length'];
                }
                $dbs_array[$db][3]     = $dbs_array[$db][1] + $dbs_array[$db][2];
                $total_array[1]        += $dbs_array[$db][1];
                $total_array[2]        += $dbs_array[$db][2];
                $total_array[3]        += $dbs_array[$db][3];
                mysql_free_result($result);
            } // end if
        } // end if MySQL 3.23.03+

    } // end for
    mysql_close();

    // Sorts the dbs arrays
    uksort($dbs_array, 'PMA_dbCmp');
    reset($dbs_array);

    // Check/unchek all databases url
    $checkall_url = 'db_stats.php'
                  . '?lang=' . $lang
                  . '&amp;convcharset=' . $convcharset
                  . '&amp;server=' . $server
                  . (empty($sort_by) ? '' : '&amp;sort_by=' . $sort_by)
                  . (empty($sort_order) ? '' : '&amp;sort_order=' . $sort_order);
    $do_check     = (empty($checkall))
                  ? ''
                  : ' checked="checked"';

    // Displays the tables stats per database
    $i = 0;
    while (list($db_name, $db_prop) = each($dbs_array)) {
        $bgcolor = ($i % 2) ? $cfg['BgcolorOne'] : $cfg['BgcolorTwo'];

        list($data_size, $data_unit) = PMA_formatByteDown($dbs_array[$db_name][1], 3, 1);
        list($idx_size, $idx_unit)   = PMA_formatByteDown($dbs_array[$db_name][2], 3, 1);
        list($tot_size, $tot_unit)   = PMA_formatByteDown($dbs_array[$db_name][3], 3, 1);

        echo '    <tr>' . "\n";
        echo '        <td align="center" bgcolor="'. $bgcolor . '">' . "\n";
        echo '            &nbsp;<input type="checkbox" name="selected_db[]" value="' . urlencode($db_name) . '"' . $do_check . ' />&nbsp;' . "\n";
        echo '        </td>' . "\n";
        echo '        <td bgcolor="'. $bgcolor . '">&nbsp;<a href="index.php?lang=' . $lang . '&amp;convcharset=' . $convcharset . '&amp;server=' . $server . '&amp;db=' . urlencode($db_name) . '" target="_parent">' . htmlspecialchars($db_name) . '</a>&nbsp;</td>' . "\n";
        echo '        <td align="right" bgcolor="'. $bgcolor . '">&nbsp;' . $dbs_array[$db_name][0] . '&nbsp;</td>' . "\n";
        echo '        <td align="right" bgcolor="'. $bgcolor . '">&nbsp;' . $data_size . '<bdo dir="' . $text_dir . '"> </bdo>' . $data_unit . '&nbsp;</td>' . "\n";
        echo '        <td align="right" bgcolor="'. $bgcolor . '">&nbsp;' . $idx_size . '<bdo dir="' . $text_dir . '"> </bdo>' . $idx_unit . '&nbsp;</td>' . "\n";
        echo '        <td align="right" bgcolor="'. $bgcolor . '">&nbsp;<b>' . $tot_size . '<bdo dir="' . $text_dir . '"> </bdo>' . $tot_unit . '</b>&nbsp;</td>' . "\n";
        echo '    </tr>' . "\n";

        $i++;
    } // end while
    unset($dbs_array);

    // Displays the server stats
    list($data_size, $data_unit) = PMA_formatByteDown($total_array[1], 3, 1);
    list($idx_size, $idx_unit)   = PMA_formatByteDown($total_array[2], 3, 1);
    list($tot_size, $tot_unit)   = PMA_formatByteDown($total_array[3], 3, 1);

    echo '    <tr>' . "\n";
    echo '        <th>&nbsp;</th>' . "\n";
    echo '        <th>&nbsp;' . $strSum . ':&nbsp;' . $num_dbs . '</th>' . "\n";
    echo '        <th align="right">&nbsp;' . $total_array[0] . '&nbsp;</th>' . "\n";
    echo '        <th align="right">&nbsp;' . $data_size . '<bdo dir="' . $text_dir . '"> </bdo>' . $data_unit . '&nbsp;</th>' . "\n";
    echo '        <th align="right">&nbsp;' . $idx_size . '<bdo dir="' . $text_dir . '"> </bdo>' . $idx_unit . '&nbsp;</th>' . "\n";
    echo '        <th align="right">&nbsp;<b>' . $tot_size . '<bdo dir="' . $text_dir . '"> </bdo>' . $tot_unit . '</b>&nbsp;</th>' . "\n";
    echo '    </tr>' . "\n\n";

    echo '    <tr>' . "\n";
    echo '        <td colspan="6">' . "\n";
    echo '            <img src="./images/arrow_' . $text_dir . '.gif" border="0" width="38" height="22" alt="' . $strWithChecked . '" />' . "\n";
    echo '            <a href="' . $checkall_url . '&amp;checkall=1" onclick="setCheckboxes(\'dbStatsForm\', true); return false;">' . "\n";
    echo '                ' . $strCheckAll . '</a>' . "\n";
    echo '            &nbsp;/&nbsp;' . "\n";
    echo '            <a href="' . $checkall_url . '" onclick="setCheckboxes(\'dbStatsForm\', false); return false;">' . "\n";
    echo '                ' . $strUncheckAll . '</a>' . "\n";
    echo '            &nbsp;&nbsp;&nbsp;' . "\n";
    echo '            <i>' . $strWithChecked . '</i>&nbsp;&nbsp;<input type="submit" name="submit_mult" value="' . $strDrop . '" />' . "\n";
    echo '        </td>' . "\n";
    echo '    </tr>' . "\n";

    echo '    </table>' . "\n\n";

    echo '</form>' . "\n";

    unset($total_array);
} // end if ($num_dbs > 0)


/**
 * No database case
 */
else {
    ?>
<p align="center"><big>&nbsp;&nbsp;<?php echo $strNoDatabases; ?></big></p>
    <?php
} // end if ($num_dbs == 0)
echo "\n";


/**
 * Displays the footer
 */
require('./footer.inc.php');
?>
