<?php
/* $Id: tbl_select.php,v 1.50 2002/11/29 11:31:21 lem9 Exp $ */
// vim: expandtab sw=4 ts=4 sts=4:


/**
 * Gets some core libraries
 */
require('./libraries/grab_globals.lib.php');
require('./libraries/common.lib.php');
require('./libraries/relation.lib.php'); // foreign keys


/**
 * Defines arrays of functions (should possibly be in config.inc.php
 * so it can also be used in tbl_qbe.php)
 */
$numfunctions  = array('=', '>', '>=', '<', '<=', '!=');
$textfunctions = array('LIKE', '=', '!=');


/**
 * Not selection yet required -> displays the selection form
 */
if (!isset($param) || $param[0] == '') {
    // Gets some core libraries
    include('./tbl_properties_common.php');
    //$err_url   = 'tbl_select.php' . $err_url;
    $url_query .= '&amp;goto=tbl_select.php&amp;back=tbl_select.php';
    include('./tbl_properties_table_info.php');

    if (!isset($goto)) {
        $goto = $cfg['DefaultTabTable'];
    }
    // Defines the url to return to in case of error in the next sql statement
    $err_url   = $goto
               . '?lang=' . $lang
               . '&amp;convcharset=' . $convcharset
               . '&amp;server=' . $server
               . '&amp;db=' . urlencode($db)
               . '&amp;table=' . urlencode($table);

    // Gets the list and number of fields
    $local_query = 'SHOW FIELDS FROM ' . PMA_backquote($table) . ' FROM ' . PMA_backquote($db);
    $result      = @PMA_mysql_query($local_query);
    if (!$result) {
        PMA_mysqlDie('', $local_query, '', $err_url);
    }
    else {
        $fields_cnt        = mysql_num_rows($result);
        while ($row = PMA_mysql_fetch_array($result)) {
            $fields_list[] = $row['Field'];
            $type          = $row['Type'];
            // reformat mysql query output - staybyte - 9. June 2001
            $shorttype     = substr($type, 0, 3);
            if ($shorttype == 'set' || $shorttype == 'enu') {
                $type      = eregi_replace(',', ', ', $type);
                // Removes automatic MySQL escape format
                $type      = str_replace('\'\'', '\\\'', $type);
            }
            $type          = eregi_replace('BINARY', '', $type);
            $type          = eregi_replace('ZEROFILL', '', $type);
            $type          = eregi_replace('UNSIGNED', '', $type);
            if (empty($type)) {
                $type      = '&nbsp;';
            }
            $fields_type[] = $type;
        } // end while
        mysql_free_result($result);

        // <markus@noga.de>
        // retrieve keys into foreign fields, if any
        $cfgRelation = PMA_getRelationsParam();
        $foreigners  = ($cfgRelation['relwork'] ? PMA_getForeigners($db, $table) : FALSE);
        ?>
<form method="post" action="tbl_select.php">
    <input type="hidden" name="server" value="<?php echo $server; ?>" />
    <input type="hidden" name="lang" value="<?php echo $lang; ?>" />
    <input type="hidden" name="convcharset" value="<?php echo $convcharset; ?>" />
    <input type="hidden" name="db" value="<?php echo htmlspecialchars($db); ?>" />
    <input type="hidden" name="table" value="<?php echo htmlspecialchars($table); ?>" />
    <input type="hidden" name="goto" value="<?php echo $goto; ?>" />
    <input type="hidden" name="back" value="tbl_select.php" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <?php echo $strSelectFields; ?>&nbsp;:<br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <select name="param[]" size="<?php echo ($fields_cnt < 10) ? $fields_cnt : 10; ?>" multiple="multiple">
        <?php
        echo "\n";
        // Displays the list of the fields
        for ($i = 0 ; $i < $fields_cnt; $i++) {
            echo '        <option value="' . urlencode($fields_list[$i]) . '" selected="selected">' . htmlspecialchars($fields_list[$i]) . '</option>' . "\n";
        }
        ?>
    </select><br />
    <ul>
        <li>
            <div style="margin-bottom: 10px">
            <?php echo $strLimitNumRows . "\n"; ?>
            <input type="text" size="4" name="session_max_rows" value="<?php echo $cfg['MaxRows']; ?>" class="textfield" />
            </div>
        </li>
        <li>
            <?php echo $strAddSearchConditions; ?><br />
            <input type="text" name="where" class="textfield" />&nbsp;
            <?php echo PMA_showMySQLDocu('Reference', 'Functions') . "\n"; ?>
            <br /><br />
            <?php echo '<i>' . $strOr . '</i> ' . $strDoAQuery; ?><br />
            <table border="<?php echo $cfg['Border']; ?>">
            <tr>
                <th><?php echo $strField; ?></th>
                <th><?php echo $strType; ?></th>
                <th><?php echo $strFunction; ?></th>
                <th><?php echo $strValue; ?></th>
            </tr>
        <?php
        for ($i = 0; $i < $fields_cnt; $i++) {
            echo "\n";
            $bgcolor   = ($i % 2) ? $cfg['BgcolorOne'] : $cfg['BgcolorTwo'];
            ?>
            <tr>
                <td bgcolor="<?php echo $bgcolor; ?>"><?php echo htmlspecialchars($fields_list[$i]); ?></td>
                <td bgcolor="<?php echo $bgcolor; ?>"><?php echo $fields_type[$i]; ?></td>
                <td bgcolor="<?php echo $bgcolor; ?>">
                    <select name="func[]">
            <?php
            reset($numfunctions);
            reset($textfunctions);
            if (eregi('char|blob|text|set|enum', $fields_type[$i])) {
                while (list($k, $fc) = each($textfunctions)) {
                    echo "\n" . '                        '
                         . '<option value="' . htmlspecialchars($fc) . '">' . htmlspecialchars($fc) . '</option>';
                } // end while
            } else {
                while (list($k, $fc) = each($numfunctions)) {
                    echo "\n" . '                        '
                         . '<option value="' .  htmlspecialchars($fc) . '">' . htmlspecialchars($fc) . '</option>';
                } // end while
            } // end if... else...
            echo "\n";
            ?>
                    </select>
                </td>
                <td bgcolor="<?php echo $bgcolor; ?>">
            <?php
            // <markus@noga.de>
            $field = $fields_list[$i];

            include('./libraries/get_foreign.lib.php');

            echo "\n";
            if ($foreigners && isset($foreigners[$field]) && isset($disp) && $disp) {
                echo '                    <select name="fields[]">' . "\n";
                echo '                        <option value=""></option>' . "\n";
                while ($relrow = @PMA_mysql_fetch_array($disp)) {
                    $key   = $relrow[$foreign_field];
                    $value = (($foreign_display != FALSE) ? '-' . htmlspecialchars($relrow[$foreign_display]) : '');
                    echo '                        <option value="' . urlencode($key) . '">'
                         . htmlspecialchars($key) . $value . '</option>' . "\n";
                } // end while
                echo '                    </select>' . "\n";
            } else {
                echo '                    <input type="text" name="fields[]" size="40" class="textfield" />' . "\n";
            }
            ?>
                    <input type="hidden" name="names[]" value="<?php echo urlencode($fields_list[$i]); ?>" />
                    <input type="hidden" name="types[]" value="<?php echo $fields_type[$i]; ?>" />
                </td>
            </tr>
            <?php
        } // end for
        echo "\n";
        ?>
            </table><br />
        </li>
        <li>
            <?php echo $strDisplayOrder; ?><br />
            <select name="orderField" style="vertical-align: middle">
                <option value="--nil--"></option>
        <?php
        echo "\n";
        for ($i = 0; $i < $fields_cnt; $i++) {
            echo '                ';
            echo '<option value="' . urlencode($fields_list[$i]) . '">' . htmlspecialchars($fields_list[$i]) . '</option>' . "\n";
        } // end for
        ?>
            </select>
            <input type="radio" name="order" value="ASC" checked="checked" />
            <?php echo $strAscending; ?>&nbsp;
            <input type="radio" name="order" value="DESC" />
            <?php echo $strDescending; ?><br /><br />
        </li>
    </ul>

    &nbsp;&nbsp;&nbsp;&nbsp;
    <input type="submit" name="submit" value="<?php echo $strGo; ?>" />
</form>
        <?php
    } // end if
    echo "\n";
    include('./footer.inc.php');
}


/**
 * Selection criteria have been submitted -> do the work
 */
else {
    // Builds the query
    $sql_query = 'SELECT ' . PMA_backquote(urldecode($param[0]));
    $i         = 0;
    $c         = count($param);
    while ($i < $c) {
        if ($i > 0) {
            $sql_query .= ',' . PMA_backquote(urldecode($param[$i]));
        }
        $i++;
    }
    $sql_query .= ' FROM ' . PMA_backquote($table);
    // The where clause
    if ($where != '') {
        $sql_query .= ' WHERE ' . ((get_magic_quotes_gpc()) ? stripslashes($where) : $where);
    }
    else {
        $sql_query .= ' WHERE 1';
        for ($i = 0; $i < count($fields); $i++) {
            if (!empty($fields) && $fields[$i] != '') {
                if (eregi('char|blob|text|set|enum|date|time|year', $types[$i])) {
                    $quot     = '\'';
                } else {
                    $quot     = '';
                }
                if (strtoupper($fields[$i]) == 'NULL' || strtoupper($fields[$i]) == 'NOT NULL') {
                    $quot     = '';
                    $func[$i] = 'IS';
                }
                $sql_query    .= ' AND ' . PMA_backquote(urldecode($names[$i])) . " $func[$i] $quot$fields[$i]$quot";
            } // end if
        } // end for
    } // end if

    if ($orderField != '--nil--') {
        $sql_query .= ' ORDER BY ' . PMA_backquote(urldecode($orderField)) . ' ' . $order;
    } // end if

    // The query will be stripslashed in sql.php if "magic_quotes_gpc" is on
    if (get_magic_quotes_gpc()) {
        $sql_query = addslashes($sql_query);
    }
    include('./sql.php');

}

?>
