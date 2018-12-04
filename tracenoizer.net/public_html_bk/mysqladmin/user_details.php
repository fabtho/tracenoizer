<?php
/* $Id: user_details.php,v 1.84 2002/12/01 12:41:58 lem9 Exp $*/
// vim: expandtab sw=4 ts=4 sts=4:


/**
 * Gets some core libraries
 */
require('./libraries/grab_globals.lib.php');
require('./libraries/common.lib.php');


/**
 * Defines the url to return to in case of error in a sql statement
 */
$err_url = 'user_details.php'
         . '?lang=' . $lang
         . '&amp;convcharset=' . $convcharset
         . '&amp;server=' . $server
         . '&amp;db=mysql'
         . '&amp;table=user';


/**
 * Displays the table of grants for an user
 *
 * @param   mixed    the id of the query used to get hosts and databases lists
 *                   or an arry containing host and user informations
 * @param   mixed    the database to check garnts for, FALSE for all databases
 *
 * @return  boolean  always true
 *
 * @global  string   the current language
 * @global  string   the current charset for MySQL
 * @global  integer  the server to use (refers to the number in the
 *                   configuration file)
 *
 * @see     PMA_checkDb()
 *
 * @TODO    "SHOW GRANTS" statements is available and buggyless since
 *          MySQL 3.23.4 and it seems not to return privileges of the anonymous
 *          user while these privileges applies to all users.
 */
function PMA_tableGrants(&$host_db_result, $dbcheck = FALSE) {
    global $lang, $convcharset, $server;
    ?>

<!-- Table of grants -->
<table border="<?php echo $GLOBALS['cfg']['Border']; ?>">
<tr>
    <?php
    // 1. Table headers
    if ($dbcheck) {
        echo "\n";
        echo '    <th>' . $GLOBALS['strAction'] . '</th>' . "\n";
        echo '    <th>' . $GLOBALS['strHost'] . '</th>' . "\n";
        echo '    <th>' . $GLOBALS['strUser'] . '</th>';
    } else {
        echo "\n";
        echo '    <th colspan="2">' . $GLOBALS['strAction'] . '</th>';
    }
    echo "\n";
    echo '    <th>' . $GLOBALS['strDatabase'] . '</th>' . "\n";
    echo '    <th>' . UCFirst($GLOBALS['strTable']) . '</th>' . "\n";
    echo '    <th>' . $GLOBALS['strPrivileges'] . '</th>' . "\n";
    if (!$dbcheck) {
        echo '    <th>Grant Option</th>' . "\n";
    }
    ?>
</tr>
    <?php
    echo "\n";

    // 2. Table body
    $url_query  = 'lang=' . $lang . '&amp;convcharset=' . $convcharset . '&amp;server=' . $server . '&amp;db=mysql&amp;table=user';

    while ($row = (is_array($host_db_result) ? $host_db_result : PMA_mysql_fetch_array($host_db_result))) {
        $local_query = 'SHOW GRANTS FOR \'' . $row['User'] . '\'@\'' . $row['Host'] . '\'';
        $result      = PMA_mysql_query($local_query);
        $grants_cnt  = ($result) ? @mysql_num_rows($result) : 0;

        if ($grants_cnt) {
            $i = 0;
            while ($usr_row = PMA_mysql_fetch_row($result)) {
                if (eregi('GRANT (.*) ON ([^.]+).([^.]+) TO .*$', $usr_row[0], $parts)) {
                    if ($parts[1] == 'USAGE') {
                        $priv = '';
                    } else {
                        // loic1: bug #487673 - revoke 'reference'
                        $priv = ereg_replace('REFERENCE([^S]|$)', 'REFERENCES\\1', trim($parts[1]));
                        // loic1: bug #576896 - No "FILE" privileges on a
                        //        database if neither "INSERT" nor "UPDATE" one
                        if (strpos(' ' . $priv, 'FILE')
                            && !(strpos(' ' . $priv, 'INSERT') || strpos(' ' . $priv, 'UPDATE'))) {
                            $priv = ereg_replace('(^FILE(, )?)|(, FILE)', '', $priv);
                        }
                    }
                    $db       = $parts[2];
                    $table    = trim($parts[3]);
                    $grantopt = eregi('WITH GRANT OPTION$', $usr_row[0]);
                } else {
                    $priv     = '';
                    $db       = '&nbsp;';
                    $table    = '&nbsp;';
                    $column   = '&nbsp;';
                    $grantopt = FALSE;
                } // end if...else

                // Password Line
                if ($priv == '' && !$grantopt) {
                    continue;
                }

                // Checking the database (take into account wildcards)
                if ($dbcheck
                    && ($db != '*' && $db != $dbcheck)) {
                    // TODO: db names may contain characters that are regexp
                    //       instructions
                    $re        = '(^|(\\\\\\\\)+|[^\])';
                    $db_regex  = ereg_replace($re . '%', '\\1.*', ereg_replace($re . '_', '\\1.{1}', $db));
                    if (!eregi('^' . $db_regex . '$', $dbcheck)) {
                        continue;
                    }
                } // end if

                $bgcolor    = ($i % 2) ? $GLOBALS['cfg']['BgcolorOne'] : $GLOBALS['cfg']['BgcolorTwo'];
                $revoke_url = 'sql.php'
                            . '?' . $url_query
                            . '&amp;sql_query=' . urlencode('REVOKE ' . $priv . ' ON ' . PMA_backquote($db) . '.' . PMA_backquote($table) . ' FROM \'' . $row['User'] . '\'@\'' . $row['Host'] . '\'')
                            . '&amp;zero_rows=' . urlencode(sprintf($GLOBALS['strRevokeMessage'], ' <span style="color: #002E80">' . $row['User'] . '@' . $row['Host'] . '</span>') . '<br />' . $GLOBALS['strRememberReload'])
                            . '&amp;goto=user_details.php';
                if ($grantopt) {
                    $revoke_grant_url = 'sql.php'
                                      . '?' . $url_query
                                      . '&amp;sql_query=' . urlencode('REVOKE GRANT OPTION ON ' . PMA_backquote($db) . '.' . PMA_backquote($table) . ' FROM \'' . $row['User'] . '\'@\'' . $row['Host'] . '\'')
                                      . '&amp;zero_rows=' . urlencode(sprintf($GLOBALS['strRevokeGrantMessage'], ' <span style="color: #002E80">' . $row['User'] . '@' . $row['Host'] . '</span>') . '<br />' . $GLOBALS['strRememberReload'])
                                      . '&amp;goto=user_details.php';
                }
                ?>
<tr>
                <?php
                if (!$dbcheck) {
                    if ($priv) {
                        echo "\n";
                        ?>
    <td<?php if (!$grantopt) echo ' colspan="2"'; ?> bgcolor="<?php echo $bgcolor; ?>">
        <a href="<?php echo $revoke_url; ?>">
            <?php echo $GLOBALS['strRevokePriv']; ?></a>
    </td>
                        <?php
                    }
                    if ($grantopt) {
                        echo "\n";
                        ?>
    <td<?php if (!$priv) echo ' colspan="2"'; ?> bgcolor="<?php echo $bgcolor; ?>">
        <a href="<?php echo $revoke_grant_url; ?>">
            <?php echo $GLOBALS['strRevokeGrant']; ?></a>
    </td>
                        <?php
                    }
                } else {
                    if ($priv) {
                        echo "\n";
                        ?>
    <td bgcolor="<?php echo $bgcolor; ?>">
        <a href="<?php echo $revoke_url; ?>">
            <?php echo $GLOBALS['strRevoke']; ?></a>
    </td>
                        <?php
                    } else {
                        echo "\n";
                        ?>
    <td bgcolor="<?php echo $bgcolor; ?>">&nbsp;</td>
                        <?php
                    }
                    echo "\n";
                    ?>
    <td bgcolor="<?php echo $bgcolor; ?>"><?php echo $row['Host']; ?></td>
    <td bgcolor="<?php echo $bgcolor; ?>"><?php echo ($row['User']) ? $row['User'] : '<span style="color: #FF0000">' . $GLOBALS['strAny'] . '</span>'; ?></td>
                    <?php
                }
                echo "\n";
                ?>
    <td bgcolor="<?php echo $bgcolor; ?>"><?php echo ($db == '*') ? '<span style="color: #002E80">' . $GLOBALS['strAll'] . '</span>' : $db; ?></td>
    <td bgcolor="<?php echo $bgcolor; ?>"><?php echo ($table == '*') ? '<span style="color: #002E80">' . $GLOBALS['strAll'] . '</span>' : $table; ?></td>
    <td bgcolor="<?php echo $bgcolor; ?>"><?php echo ($priv != '') ? $priv : '<span style="color: #002E80">' . $GLOBALS['strNoPrivileges'] . '</span>'; ?></td>
                <?php
                if (!$dbcheck) {
                    echo "\n";
                    ?>
    <td bgcolor="<?php echo $bgcolor; ?>"><?php echo ($grantopt) ? $GLOBALS['strYes'] : $GLOBALS['strNo']; ?></td>
                    <?php
                }
                echo "\n";
                ?>
    <!-- Debug <td bgcolor="<?php echo $bgcolor; ?>"><?php echo $usr_row[0] ?></td> Debug -->
</tr>
                <?php
                $i++;
                echo "\n";
            } // end while $usr_row
        } // end if $grants_cnt >0
        // $host_db_result is an array containing related to only one user
        // -> exit the loop
        if (is_array($host_db_result)) {
            break;
        }
    } // end while $row
    ?>
</table>
<hr />

    <?php
    echo "\n";

    return TRUE;
} // end of the 'PMA_tableGrants()' function


/**
 * Displays the list of grants for a/all database/s
 *
 * @param   mixed    the database to check garnts for, FALSE for all databases
 *
 * @return  boolean  true/false in case of success/failure
 *
 * @see     PMA_tableGrants()
 */
function PMA_checkDb($dbcheck)
{
    $local_query  = 'SELECT Host, User FROM mysql.user ORDER BY Host, User';
    $result       = PMA_mysql_query($local_query);
    $host_usr_cnt = ($result) ? @mysql_num_rows($result) : 0;

    if (!$host_usr_cnt) {
        return FALSE;
    }
    PMA_tableGrants($result, $dbcheck);

    return TRUE;
} // end of the 'PMA_checkDb()' function


/**
 * Displays the privileges part of a page
 *
 * @param   string   the name of the form for js validation
 * @param   array    the list of the privileges of the user
 *
 * @return  boolean  always true
 *
 * @global  integer  whether all/none of the privileges have to be checked or
 *                   not
 *
 * @see     PMA_normalOperations()
 */
function PMA_tablePrivileges($form, $row = FALSE)
{
    global $checkpriv;

    $checkpriv_url               = $GLOBALS['cfg']['PmaAbsoluteUri']
                                 . 'user_details.php?';
    if (empty($GLOBALS['QUERY_STRING'])) {
        if (isset($_SERVER) && !empty($_SERVER['QUERY_STRING'])) {
            $GLOBALS['QUERY_STRING'] = $_SERVER['QUERY_STRING'];
        }
        else if (isset($GLOBALS['HTTP_SERVER_VARS']) && !empty($GLOBALS['HTTP_SERVER_VARS']['QUERY_STRING'])) {
            $GLOBALS['QUERY_STRING'] = $GLOBALS['HTTP_SERVER_VARS']['QUERY_STRING'];
        }
    }
    if (!empty($GLOBALS['QUERY_STRING'])) {
        $checkpriv_url           .= str_replace('&', '&amp;', $GLOBALS['QUERY_STRING']) . '&amp;';
    }
    ?>

            <table>
    <?php
    echo "\n";
    $list_priv = array('Select', 'Insert', 'Update', 'Delete', 'Create', 'Drop', 'Reload',
                       'Shutdown', 'Process', 'File', 'Grant', 'References', 'Index', 'Alter');
    $item      = 0;
    while ((list(,$priv) = each($list_priv)) && ++$item) {
        $priv_priv   = $priv . '_priv';
        if (isset($checkpriv)) {
            $checked = ($checkpriv == 'all') ?  ' checked="checked"' : '';
        } else {
            $checked = ($row && $row[$priv_priv] == 'Y') ?  ' checked="checked"' : '';
        }
        if ($item % 2 == 1) {
            echo '            <tr>' . "\n";
        } else {
            echo '                <td>&nbsp;</td>' . "\n";
        }
        echo '                <td>' . "\n";
        echo '                    <input type="checkbox" name="' . $priv . '_priv" id="checkbox_priv_' . $priv . '"' . $checked . ' />' . "\n";
        echo '                </td>' . "\n";
        echo '                <td><label for="checkbox_priv_' . $priv . '">' . $priv . '</label></td>' . "\n";
        if ($item % 2 == 0) {
            echo '            </tr>' . "\n";
        }
    } // end while
    if ($item % 2 == 1) {
        echo '                <td colspan="2">&nbsp;<td>' . "\n";
        echo '            </tr>' . "\n";
    } // end if
    ?>
            </table>
            <table>
            <tr>
                <td>
                    <a href="<?php echo $checkpriv_url; ?>checkpriv=all" onclick="checkForm('<?php echo $form; ?>', true); return false">
                        <?php echo $GLOBALS['strCheckAll']; ?></a>
                </td>
                <td>&nbsp;</td>
                <td>
                    <a href="<?php echo $checkpriv_url; ?>checkpriv=none" onclick="checkForm('<?php echo $form; ?>', false); return false">
                        <?php echo $GLOBALS['strUncheckAll']; ?></a>
                </td>
            </tr>
            </table>
    <?php
    echo "\n";

    return TRUE;
} // end of the 'PMA_tablePrivileges()' function


/**
 * Displays the page for "normal" operations
 *
 * @return  boolean  always true
 *
 * @global  string   the current language
 * @global  string   the current charset for MySQL
 * @global  integer  the server to use (refers to the number in the
 *                   configuration file)
 *
 * @see     PMA_tablePrivileges()
 */
function PMA_normalOperations()
{
    global $lang, $convcharset, $server;
    ?>

<ul>

    <li>
        <div style="margin-bottom: 10px">
        <a href="user_details.php?lang=<?php echo $lang; ?>&amp;convcharset=<?php echo $convcharset; ?>&amp;server=<?php echo $server; ?>&amp;db=mysql&amp;table=user&amp;mode=reload">
            <?php echo $GLOBALS['strReloadMySQL']; ?></a>&nbsp;
        <?php echo PMA_showMySQLDocu('MySQL_Database_Administration.', 'FLUSH') . "\n"; ?>
        </div>
    </li>

    <li>
        <form name="dbPrivForm" action="user_details.php" method="post">
            <?php echo $GLOBALS['strCheckDbPriv'] . "\n"; ?>
            <table>
            <tr>
                <td>
                    <?php echo $GLOBALS['strDatabase']; ?>&nbsp;:&nbsp;
                    <select name="db">
    <?php
    echo "\n";
    $result = PMA_mysql_query('SHOW DATABASES');
    if ($result && @mysql_num_rows($result)) {
        while ($row = PMA_mysql_fetch_row($result)) {
            echo '                        ';
            echo '<option value="' . str_replace('"', '&quot;', $row[0]) . '">' . htmlspecialchars($row[0]) . '</option>' . "\n";
        } // end while
    } // end if
    ?>
                    </select>
                    <input type="hidden" name="lang" value="<?php echo $lang; ?>" />
                    <input type="hidden" name="convcharset" value="<?php echo $convcharset; ?>" />
                    <input type="hidden" name="server" value="<?php echo $server; ?>" />
                    <input type="hidden" name="check" value="1" />
                    <input type="submit" value="<?php echo $GLOBALS['strGo']; ?>" />
                </td>
            </tr>
            </table>
        </form>
    </li>

    <li>
        <form action="user_details.php" method="post" name="addUserForm" onsubmit="return checkAddUser()">
            <?php echo $GLOBALS['strAddUser'] . "\n"; ?>
            <table>
            <tr>
                <td>
                    <input type="radio" name="anyhost" id="radio_anyhost0" checked="checked" />
                    <label for="radio_anyhost0"><?php echo $GLOBALS['strAnyHost']; ?></label>
                </td>
                <td>&nbsp;</td>
                <td>
                    <input type="radio" name="anyhost" id="radio_anyhost1" />
                    <label for="radio_anyhost1"><?php echo $GLOBALS['strHost']; ?></label>&nbsp;:&nbsp;
                </td>
                <td>
                    <input type="text" name="host" size="10" class="textfield" <?php echo $GLOBALS['chg_evt_handler']; ?>="this.form.anyhost[1].checked = true" />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="radio" name="anyuser" value="1" id="radio_anyuser1" />
                    <label for="radio_anyuser1"><?php echo $GLOBALS['strAnyUser']; ?></label>
                </td>
                <td>&nbsp;</td>
                <td>
                    <input type="radio" name="anyuser" value="0" id="radio_anyuser0" checked="checked" />
                    <label for="radio_anyuser0"><?php echo $GLOBALS['strUserName']; ?></label>&nbsp;:&nbsp;
                </td>
                <td>
                    <input type="text" name="pma_user" size="10" class="textfield" <?php echo $GLOBALS['chg_evt_handler']; ?>="this.form.anyuser[1].checked = true" />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="radio" name="nopass" value="1" id="radio_nopass1" onclick="pma_pw.value = ''; pma_pw2.value = ''; this.checked = true" />
                    <label for="radio_nopass1"><?php echo $GLOBALS['strNoPassword']; ?></label>
                </td>
                <td>&nbsp;</td>
                <td>
                    <input type="radio" name="nopass" value="0" id="radio_nopass0" checked="checked" />
                    <label for="radio_nopass0"><?php echo $GLOBALS['strPassword']; ?></label>&nbsp;:&nbsp;
                </td>
                <td>
                    <input type="password" name="pma_pw" size="10" class="textfield" <?php echo $GLOBALS['chg_evt_handler']; ?>="nopass[1].checked = true" />
                    &nbsp;&nbsp;
                    <?php echo $GLOBALS['strReType']; ?>&nbsp;:&nbsp;
                    <input type="password" name="pma_pw2" size="10" class="textfield" <?php echo $GLOBALS['chg_evt_handler']; ?>="nopass[1].checked = true" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <br />
                    <?php echo $GLOBALS['strPrivileges']; ?>&nbsp;:
                    <br />
                </td>
            </tr>
            </table>
    <?php
    echo "\n";
    PMA_tablePrivileges('addUserForm');
    ?>
            <input type="hidden" name="lang" value="<?php echo $lang; ?>" />
            <input type="hidden" name="convcharset" value="<?php echo $convcharset; ?>" />
            <input type="hidden" name="server" value="<?php echo $server; ?>" />
            <input type="submit" name="submit_addUser" value="<?php echo $GLOBALS['strGo']; ?>" />
        </form>
    </li>

</ul>
    <?php

    return TRUE;
} // end of the 'PMA_normalOperations()' function


/**
 * Displays the grant operations part of an user properties page
 *
 * @param   array    grants of the current user
 *
 * @return  boolean  always true
 *
 * @global  string   the current language
 * @global  string   the current charset for MySQL
 * @global  integer  the server to use (refers to the number in the
 *                   configuration file)
 * @global  string   the host name to check grants for
 * @global  string   the username to check grants for
 * @global  string   the database to check grants for
 * @global  string   the table to check grants for
 *
 * @see     PMA_tablePrivileges()
 */
function PMA_grantOperations($grants)
{
    global $lang, $convcharset, $server, $host, $pma_user;
    global $dbgrant, $tablegrant, $newdb;
    ?>

<ul>

    <li>
        <div style="margin-bottom: 10px">
        <a href="user_details.php?lang=<?php echo $lang; ?>&amp;convcharset=<?php echo $convcharset; ?>&amp;server=<?php echo $server; ?>&amp;db=mysql&amp;table=user">
            <?php echo $GLOBALS['strBack']; ?></a>
        </div>
    </li>

    <li>
        <form action="user_details.php" method="post" name="userGrants">
            <input type="hidden" name="lang" value="<?php echo $lang; ?>" />
            <input type="hidden" name="convcharset" value="<?php echo $convcharset; ?>" />
            <input type="hidden" name="server" value="<?php echo $server; ?>" />
            <input type="hidden" name="grants" value="1" />
            <input type="hidden" name="host" value="<?php echo str_replace('"', '&quot;', $host); ?>" />
            <input type="hidden" name="pma_user" value="<?php echo str_replace('"', '&quot;', $pma_user); ?>" />

            <?php echo $GLOBALS['strAddPriv'] . "\n"; ?>
            <table>
            <tr>
                <td>
                    <input type="radio" name="anydb" value="1" id="radio_anydb1"<?php echo ($dbgrant) ? '' : ' checked="checked"'; ?> />
                    <label for="radio_anydb1"><?php echo $GLOBALS['strAnyDatabase']; ?></label>
                </td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <td>
                    <input type="radio" name="anydb" value="0" id="radio_anydb0"<?php echo ($dbgrant) ? ' checked="checked"' : ''; ?> />
                    <label for="radio_anydb0"><?php echo $GLOBALS['strDatabase']; ?></label><a href="./Documentation.html#underscore" target="documentation" title="<?php echo $GLOBALS['strDocu']; ?>">(*)</a>&nbsp;:&nbsp;
                </td>
                <td>
                    <select name="dbgrant" onchange="change(this)">
                        <option></option>
    <?php
    echo "\n";
//    if (!isset($dbgrant)) {
//        echo '                        ';
//        echo '<option></option>' . "\n";
//    }
    $is_selected_db = FALSE;
    $result         = PMA_mysql_query('SHOW DATABASES');
    if ($result && @mysql_num_rows($result)) {
        while ($row = PMA_mysql_fetch_row($result)) {
            $selected           = (($row[0] == $dbgrant) ? ' selected="selected"' : '');
            if (!empty($selected)) {
                $is_selected_db = TRUE;
            }
            echo '                        ';
            echo '<option' . $selected . '>' . $row[0] . '</option>' . "\n";
        } // end while
    } // end if
    ?>
                    </select>
                </td>
                <td>
                    &nbsp;
                    <input type="submit" value="<?php echo $GLOBALS['strShowTables']; ?>" />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="radio" name="anytable" value="1" id="radio_anytable1"<?php echo ($tablegrant) ? '' : ' checked="checked"'; ?> />
                    <label for="radio_anytable1"><?php echo $GLOBALS['strAnyTable']; ?></label>
                </td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <td>
                    <input type="radio" name="anytable" value="0" id="radio_anytable0"<?php echo ($tablegrant) ? ' checked="checked"' : ''; ?> />
                    <label for="radio_anytable0"><?php echo $GLOBALS['strTable']; ?></label>&nbsp;:&nbsp;
                </td>
                <td>
                    <select name="tablegrant" onchange="change(this)">
                        <option></option>
    <?php
    echo "\n";
//    if (!isset($tablegrant)) {
//        echo '                        ';
//        echo '<option></option>' . "\n";
//    }
    if (isset($dbgrant)) {
        $result = PMA_mysql_query('SHOW TABLES FROM ' . PMA_backquote($dbgrant));
        if ($result && @mysql_num_rows($result)) {
            while ($row = PMA_mysql_fetch_row($result)) {
                $selected = ((isset($tablegrant) && $row[0] == $tablegrant) ? ' selected="selected"' : '');
                echo '                        ';
                echo '<option' . $selected . '>' . $row[0] . '</option>' . "\n";
            } // end while
        } // end if
    } // end if
    ?>
                    </select>
                </td>
                <td>
                    &nbsp;
                    <input type="submit" value="<?php echo $GLOBALS['strShowCols']; ?>" />
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <input type="radio" name="anycolumn" value="1" id="radio_anycolumn1" checked="checked" />
                    <label for="radio_anycolumn1"><?php echo $GLOBALS['strAnyColumn']; ?></label>
                </td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <td valign="top">
                    <input type="radio" name="anycolumn" value="0" id="radio_anycolumn0" />
                    <label for="radio_anycolumn0"><?php echo $GLOBALS['strColumn']; ?></label>&nbsp;:&nbsp;
                </td>
                <td>
    <?php
    echo "\n";
    if (!isset($dbgrant) || !isset($tablegrant)) {
        echo '                    ' . '<select name="colgrant[]">' . "\n";
        echo '                        ' . '<option></option>' . "\n";
        echo '                    ' . '</select>' . "\n";
    }
    else {
        $result = PMA_mysql_query('SHOW COLUMNS FROM ' . PMA_backquote($tablegrant) . ' FROM ' . PMA_backquote($dbgrant));
        if ($result && @mysql_num_rows($result)) {
            echo '                    '
                 . '<select name="colgrant[]" multiple="multiple" onchange="anycolumn[1].checked = true">' . "\n";
            while ($row = PMA_mysql_fetch_row($result)) {
                echo '                        ';
                echo '<option value="' . str_replace('"', '&quot;', $row[0]) . '">' . $row[0] . '</option>' . "\n";
            } // end while
        } else {
            echo '                    ' . '<select name="colgrant[]">' . "\n";
            echo '                        ' . '<option></option>' . "\n";
        } // end if... else...
        echo '                    '
             . '</select>' . "\n";
    } // end if... else
    ?>
                </td>
                <td></td>
            </tr>
            <tr>
                <td colspan="5">
                    <i><?php echo $GLOBALS['strOr']; ?></i>
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <?php echo $GLOBALS['strDatabaseWildcard'] . "\n"; ?>&nbsp;
                    <input type="text" name="newdb" value="<?php echo ((!$is_selected_db && !empty($pma_user)) ? $pma_user . '%' : ''); ?>" class="textfield" <?php echo $GLOBALS['chg_evt_handler']; ?>="change(this)" />
                </td>
            <tr>
            </table>

            <table>
            <tr>
                <td>
                    <br />
                    <?php echo $GLOBALS['strPrivileges']; ?>&nbsp;:&nbsp;
                    <br />
                </td>
            </tr>
            </table>
    <?php
    echo "\n";
    PMA_tablePrivileges('userGrants', $grants);
    ?>
            <input type="submit" name="upd_grants" value="<?php echo $GLOBALS['strGo']; ?>" />
        </form>
    </li>

</ul>
    <?php
    echo "\n";

    return TRUE;
} // end of the 'PMA_grantOperations()' function


/**
 * Displays the page to edit operations
 *
 * @param   string   the host name to check grants for
 * @param   string   the user name to check grants for
 *
 * @return  boolean  always true
 *
 * @global  string   the current language
 * @global  string   the current charset for MySQL
 * @global  integer  the server to use (refers to the number in the
 *                   configuration file)
 *
 * @see     PMA_tablePrivileges()
 */
function PMA_editOperations($host, $user)
{
    global $lang, $convcharset, $server;

    $result = PMA_mysql_query('SELECT * FROM mysql.user WHERE User = \'' . PMA_sqlAddslashes($user) . '\' AND Host = \'' . PMA_sqlAddslashes($host) . '\'');
    $rows   = ($result) ? @mysql_num_rows($result) : 0;

    if (!$rows) {
        return FALSE;
    }

    $row = PMA_mysql_fetch_array($result);
    ?>

<ul>

    <li>
        <div style="margin-bottom: 10px">
        <a href="user_details.php?lang=<?php echo $lang; ?>&amp;convcharset=<?php echo $convcharset; ?>&amp;server=<?php echo $server; ?>&amp;db=mysql&amp;table=user">
            <?php echo $GLOBALS['strBack']; ?></a>
        </div>
    </li>

    <li>
        <form action="user_details.php" method="post" name="updUserForm" onsubmit="return checkUpdProfile()">
            <?php echo $GLOBALS['strUpdateProfile'] . "\n"; ?>
            <table>
            <tr>
                <td>
                    <input type="radio" value="1" name="anyhost" id="radio_anyhost1"<?php if ($host == '' || $host == '%') echo ' checked="checked"'; ?> />
                    <label for="radio_anyhost1"><?php echo $GLOBALS['strAnyHost']; ?></label>
                </td>
                <td>&nbsp;</td>
                <td>
                    <input type="radio" value="0" name="anyhost" id="radio_anyhost0"<?php if ($host != '' && $host != '%') echo ' checked="checked"'; ?> />
                    <label for="radio_anyhost0"><?php echo $GLOBALS['strHost']; ?></label>&nbsp;:&nbsp;
                </td>
                <td>
                    <input type="text" name="new_server" size="10" value="<?php echo str_replace('"', '&quot;', $host); ?>" class="textfield" <?php echo $GLOBALS['chg_evt_handler']; ?>="this.form.anyhost[1].checked = true" />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="radio" value="1" name="anyuser" id="radio_anyuser1"<?php if ($user == '') echo ' checked="checked"'; ?> />
                    <label for="radio_anyuser1"><?php echo $GLOBALS['strAnyUser']; ?></label>
                </td>
                <td>&nbsp;</td>
                <td>
                    <input type="radio" value="0" name="anyuser" id="radio_anyuser0"<?php if ($user != '') echo ' checked="checked"'; ?> />
                    <label for="radio_anyuser0"><?php echo $GLOBALS['strUserName']; ?></label>&nbsp;:&nbsp;
                </td>
                <td>
                    <input type="text" name="new_user" size="10" value="<?php echo str_replace('"', '&quot;', $user); ?>" class="textfield" <?php echo $GLOBALS['chg_evt_handler']; ?>="this.form.anyuser[1].checked = true" />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="radio" name="nopass" value="-1" id="radio_nopass-1" checked="checked" onclick="new_pw.value = ''; new_pw2.value = ''; this.checked = true" />
                    <label for="radio_nopass-1"><?php echo $GLOBALS['strKeepPass']; ?></label>
                </td>
                <td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="4" align="<?php echo $GLOBALS['cell_align_left']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $GLOBALS['strOr']; ?></td>
            </tr>
            <tr>
                <td>
                    <input type="radio" name="nopass" value="1" id="radio_nopass1" onclick="new_pw.value = ''; new_pw2.value = ''; this.checked = true" />
                    <label for="radio_nopass1"><?php echo $GLOBALS['strNoPassword']; ?></label>
                </td>
                <td>&nbsp;</td>
                <td>
                    <input type="radio" name="nopass" value="0" id="radio_nopass0" />
                    <label for="radio_nopass0"><?php echo $GLOBALS['strPassword']; ?></label>&nbsp;:&nbsp;
                </td>
                <td>
                    <input type="password" name="new_pw" size="10" <?php echo $GLOBALS['chg_evt_handler']; ?>="nopass[2].checked = true" />
                    &nbsp;&nbsp;
                    <?php echo $GLOBALS['strReType']; ?>&nbsp;:&nbsp;
                    <input type="password" name="new_pw2" size="10" <?php echo $GLOBALS['chg_evt_handler']; ?>="nopass[2].checked = true" />
                </td>
            </tr>
            </table>
            <input type="hidden" name="lang" value="<?php echo $lang; ?>" />
            <input type="hidden" name="convcharset" value="<?php echo $convcharset; ?>" />
            <input type="hidden" name="server" value="<?php echo $server; ?>" />
            <input type="hidden" name="host" value="<?php echo str_replace('"', '&quot;', $host); ?>" />
            <input type="hidden" name="pma_user" value="<?php echo str_replace('"', '&quot;', $user); ?>" />
            <input type="submit" name="submit_updProfile" value="<?php echo $GLOBALS['strGo']; ?>" />
        </form>
    </li>

    <li>
        <form action="user_details.php" method="post" name="privForm">
            <?php echo $GLOBALS['strEditPrivileges'] . "\n"; ?>
    <?php
    PMA_tablePrivileges('privForm', $row);
    echo "\n";
    ?>
            <input type="hidden" name="lang" value="<?php echo $lang; ?>" />
            <input type="hidden" name="convcharset" value="<?php echo $convcharset; ?>" />
            <input type="hidden" name="server" value="<?php echo $server; ?>" />
            <input type="hidden" name="host" value="<?php echo str_replace('"', '&quot;', $host); ?>" />
            <input type="hidden" name="pma_user" value="<?php echo str_replace('"', '&quot;', $user); ?>" />
            <input type="submit" name="submit_chgPriv" value="<?php echo $GLOBALS['strGo']; ?>" />
        </form>
    </li>

</ul>
    <?php
    echo "\n";

    return TRUE;
} // end of the 'PMA_editOperations()' function


/**
 * Displays the table of the users
 *
 * @param   string   the host name
 * @param   string   the user name
 *
 * @return  boolean  always true
 *
 * @global  string   the current language
 * @global  string   the current charset for MySQL
 * @global  integer  the server to use (refers to the number in the
 *                   configuration file)
 */
function PMA_tableUsers($host = FALSE, $user = FALSE)
{
    global $lang, $convcharset, $server;

    $local_query     = 'SELECT * FROM mysql.user ';
    if ($host || $user) {
        $local_query .= ' WHERE 1 ';
    }
    if ($host) {
        $local_query .= ' AND Host = \'' . PMA_sqlAddslashes($host) . '\'';
        $local_query .= ' AND User = \'' . PMA_sqlAddslashes($user) . '\'';
    }
    $local_query     .= ' ORDER BY Host, User';
    $result          = PMA_mysql_query($local_query);
    $rows            = ($result) ? @mysql_num_rows($result) : 0;

    if (!$rows) {
        return FALSE;
    }

    echo '<i>' . $GLOBALS['strEnglishPrivileges'] . '</i><br />' . "\n";
    echo '<table border="' . $GLOBALS['cfg']['Border'] . '">' . "\n";
    echo '<tr>' . "\n";
    echo '    <th colspan="'. (($user) ? '2' : '3') . '">' . $GLOBALS['strAction'] . '</th>' . "\n";
    echo '    <th>' . $GLOBALS['strHost'] . '</th>' . "\n";
    echo '    <th>' . $GLOBALS['strUser'] . '</th>' . "\n";
    echo '    <th>' . $GLOBALS['strPassword'] . '</th>' . "\n";
    echo '    <th>' . $GLOBALS['strPrivileges'] . '</th>' . "\n";
    echo '</tr>' . "\n";

    $i = 0;
    while ($row = PMA_mysql_fetch_array($result)) {

        $bgcolor = ($i % 2) ? $GLOBALS['cfg']['BgcolorOne'] : $GLOBALS['cfg']['BgcolorTwo'];

        $strPriv     = '';
        if ($row['Select_priv'] == 'Y') {
            $strPriv .= 'Select ';
        }
        if ($row['Insert_priv'] == 'Y') {
            $strPriv .= 'Insert ';
        }
        if ($row['Update_priv'] == 'Y') {
            $strPriv .= 'Update ';
        }
        if ($row['Delete_priv'] == 'Y') {
            $strPriv .= 'Delete ';
        }
        if ($row['Create_priv'] == 'Y') {
            $strPriv .= 'Create ';
        }
        if ($row['Drop_priv'] == 'Y') {
            $strPriv .= 'Drop ';
        }
        if ($row['Reload_priv'] == 'Y') {
            $strPriv .= 'Reload ';
        }
        if ($row['Shutdown_priv'] == 'Y') {
            $strPriv .= 'Shutdown ';
        }
        if ($row['Process_priv'] == 'Y') {
            $strPriv .= 'Process ';
        }
        if ($row['File_priv'] == 'Y') {
            $strPriv .= 'File ';
        }
        if ($row['Grant_priv'] == 'Y') {
            $strPriv .= 'Grant ';
        }
        if ($row['References_priv'] == 'Y') {
            $strPriv .= 'References ';
        }
        if ($row['Index_priv'] == 'Y') {
            $strPriv .= 'Index ';
        }
        if ($row['Alter_priv'] == 'Y') {
            $strPriv .= 'Alter ';
        }
        if ($strPriv == '') {
            $strPriv = '<span style="color: #002E80">' . $GLOBALS['strNoPrivileges'] . '</span>';
        }

        $query          = 'lang=' . $lang . '&amp;server=' . $server . '&amp;db=mysql&amp;table=user&amp;convcharset=' . $convcharset;
        if (!$user) {
            $edit_url   = 'user_details.php'
                        . '?lang=' . $lang . '&amp;convcharset=' . $convcharset . '&amp;server=' . $server
                        . '&amp;edit=1&amp;host=' . urlencode($row['Host']) . '&amp;pma_user=' . urlencode($row['User']);
        }
        $delete_url     = 'user_details.php'
                        . '?' . $query
                        . '&amp;delete=1&amp;confirm=1&amp;delete_host=' . urlencode($row['Host']) . '&amp;delete_user=' . urlencode($row['User']);
        $check_url      = 'user_details.php'
                        . '?lang=' . $lang . '&amp;convcharset=' . $convcharset . '&amp;server=' . $server
                        . '&amp;grants=1&amp;host=' . urlencode($row['Host']) . '&amp;pma_user=' . urlencode($row['User']);
        ?>

<tr>
        <?php
        if (!$user) {
            echo "\n";
            ?>
    <td bgcolor="<?php echo $bgcolor;?>">
        <a href="<?php echo $edit_url; ?>">
            <?php echo $GLOBALS['strEdit']; ?></a>
    </td>
            <?php
        }
        echo "\n";
        ?>
    <td bgcolor="<?php echo $bgcolor;?>">
        <a href="<?php echo $delete_url; ?>">
            <?php echo $GLOBALS['strDelete']; ?></a>
    </td>
    <td bgcolor="<?php echo $bgcolor;?>">
        <a href="<?php echo $check_url; ?>">
            <?php echo $GLOBALS['strGrants']; ?></a>
    </td>
<!--
    <td bgcolor="<?php echo $bgcolor;?>">
        <a href="<?php echo (($check_url != '') ? $check_url : '#'); ?>">
            <?php echo $GLOBALS['strGrants']; ?></a>
    </td>
//-->
    <td bgcolor="<?php echo $bgcolor;?>">
        <?php echo $row['Host'] . "\n"; ?>
    </td>
    <td bgcolor="<?php echo $bgcolor;?>">
        <?php echo (($row['User']) ? '<b>' . $row['User'] . '</b>' : '<span style="color: #FF0000">' . $GLOBALS['strAny'] . '</span>') . "\n"; ?>
    </td>
    <td bgcolor="<?php echo $bgcolor;?>">
        <?php echo (($row[$GLOBALS['password_field']]) ? $GLOBALS['strYes'] : '<span style="color: #FF0000">' . $GLOBALS['strNo'] . '</span>') . "\n"; ?>
    </td>
    <td bgcolor="<?php echo $bgcolor;?>">
        <?php echo $strPriv . "\n"; ?>
    </td>
</tr>
        <?php
        echo "\n";
        $i++;
    } //  end while

    echo "\n";
    ?>
</table>
<hr />
    <?php
    echo "\n";

    return TRUE;
} // end of the 'PMA_tableUsers()' function


/**
 * Displays a confirmation form
 *
 * @param   string   the host name and...
 * @param   string   ... the username to delete
 *
 * @global  string   the current language
 * @global  string   the current charset for MySQL
 * @global  integer  the server to use (refers to the number in the
 *                   configuration file)
 */
function PMA_confirm($the_host, $the_user) {
    global $lang, $convcharset, $server;

    if (get_magic_quotes_gpc() == 1) {
        $the_host = stripslashes($the_host);
        $the_user = stripslashes($the_user);
    }

    echo $GLOBALS['strConfirm'] . '&nbsp;:&nbsp<br />' . "\n";
    echo 'DELETE FROM mysql.user WHERE Host = \'' . $the_host . '\' AND User = \'' . $the_user . '\'' . '<br />' . "\n";
    ?>
<form action="user_details.php" method="post">
    <input type="hidden" name="lang" value="<?php echo $lang; ?>" />
    <input type="hidden" name="convcharset" value="<?php echo $convcharset; ?>" />
    <input type="hidden" name="server" value="<?php echo $server; ?>" />
    <input type="hidden" name="db" value="mysql" />
    <input type="hidden" name="table" value="user" />
    <input type="hidden" name="delete" value="<?php echo(isset($GLOBALS['delete']) ? '1' : '0'); ?>" />
    <input type="hidden" name="delete_host" value="<?php echo str_replace('"', '&quot;', $the_host); ?>" />
    <input type="hidden" name="delete_user" value="<?php echo str_replace('"', '&quot;', $the_user); ?>" />
    <input type="submit" name="btnConfirm" value="<?php echo $GLOBALS['strYes']; ?>" />
    <input type="submit" name="btnConfirm" value="<?php echo $GLOBALS['strNo']; ?>" />
</form>
    <?php
    echo "\n";

    include('./footer.inc.php');
} // end of the 'PMA_confirm()' function



/**
 * Ensures the user is super-user and gets the case sensitive password field
 * name
 */
$result         = @PMA_mysql_query('USE mysql');
if (PMA_mysql_error()) {
    include('./header.inc.php');
    echo '<p><b>' . $strError . '</b></p>' . "\n";
    echo '<p>&nbsp;&nbsp;&nbsp;&nbsp;' .  $strNoRights . '</p>' . "\n";
    include('./footer.inc.php');
    exit();
}
// The previous logic did not work if the password field is named "password":
//$result         = @PMA_mysql_query('SELECT COUNT(Password) FROM mysql.user');
//$password_field = (($result && PMA_mysql_result($result, 0)) ? 'Password' : 'password');

// using a syntax that works with older and recent MySQL,
// and assumes that the field name ends with "assword":
$result         = @PMA_mysql_query('SHOW FIELDS FROM user FROM mysql LIKE \'%assword\'');
if ($result) {
    $password_field = PMA_mysql_result($result, 0);
}

/**
 * Autocomplete feature of IE kills the "onchange" event handler and it must be
 * replaced by the "onpropertychange" one in this case
 */
$chg_evt_handler = (PMA_USR_BROWSER_AGENT == 'IE' && PMA_USR_BROWSER_VER >= 5)
                 ? 'onpropertychange'
                 : 'onchange';


/**
 * Displays headers
 */
if (isset($db)) {
    $db_bkp       = (get_magic_quotes_gpc() ? stripslashes($db) : $db);
    unset($db);
}
if (isset($table)) {
    $table_bkp    =  (get_magic_quotes_gpc() ? stripslashes($table) : $table);
    unset($table);
}
if (get_magic_quotes_gpc()) {
    if (!empty($host)) {
        $host     = stripslashes($host);
    }
    if (!empty($pma_user)) {
        $pma_user = stripslashes($pma_user);
    }
}

if (!isset($message)) {
    $js_to_run = 'user_details.js';
    include('./header.inc.php');
}
if (!isset($submit_updProfile)) {
    echo '<h1>' . "\n";
    echo '    ' . ((!isset($host) || $host == '') ? $strAnyHost : $strHost . ' ' . $host) . ' - ' . ((!isset($pma_user) || $pma_user == '') ? $strAnyUser : $strUser . ' ' . $pma_user) . "\n";
    echo '</h1>';
}
if (isset($message)) {
    $show_query = '1';
    PMA_showMessage($message);
}

if (isset($db_bkp)) {
    $db    = $db_bkp;
    unset($db_bkp);
}
if (isset($table_bkp)) {
    $table = $table_bkp;
    unset($table_bkp);
}


/**
 * Some actions has been submitted
 */
// Confirms an action
if (isset($confirm) && $confirm) {
    PMA_confirm($delete_host, $delete_user);
    exit();
}

// Reloads mysql
else if (($server > 0) && isset($mode) && ($mode == 'reload')) {
    $result = PMA_mysql_query('FLUSH PRIVILEGES');
    if ($result != 0) {
        echo '<p><b>' . $strMySQLReloaded . '</b></p>' . "\n";
    } else {
        echo '<p><b>' . $strReloadFailed . '</b></p>' . "\n";
    }
}

// Deletes an user
else if (isset($delete) && $delete
         && isset($btnConfirm) && $btnConfirm == $strYes) {
    if (get_magic_quotes_gpc()) {
        $delete_host = stripslashes($delete_host);
        $delete_user = stripslashes($delete_user);
    }
    $common_where    = ' WHERE Host = \'' . PMA_sqlAddslashes($delete_host) . '\' AND User = \'' . PMA_sqlAddslashes($delete_user) . '\'';

    // Delete Grants First!
    $sql_query       = 'DELETE FROM mysql.db' . $common_where;
    $sql_query_cpy   = $sql_query;
    PMA_mysql_query($sql_query);
    $sql_query       = 'DELETE FROM mysql.tables_priv' . $common_where;
    $sql_query_cpy   .= ";\n" . $sql_query;
    PMA_mysql_query($sql_query);
    $sql_query       = 'DELETE FROM mysql.columns_priv' . $common_where;
    $sql_query_cpy   .= ";\n" . $sql_query;
    PMA_mysql_query($sql_query);

    $sql_query       = 'DELETE FROM mysql.user' . $common_where;
    $sql_query_cpy   .= ";\n" . $sql_query;
    $result          = PMA_mysql_query($sql_query);

    $sql_query       = $sql_query_cpy;
    unset($sql_query_cpy);
    if ($result) {
        PMA_showMessage(sprintf($strDeleteUserMessage, '<span style="color: #002E80">' . $delete_user . '@' . $delete_host . '</span>') . '<br />' . $strRememberReload);
    } else {
        PMA_showMessage($strDeleteFailed);
    }
}

// Adds an user
else if (isset($submit_addUser)) {
    $show_query   = '1';
    if (!isset($host) || $host == '') {
        $host     = '%';
    }
    //if (!isset($pma_user) || $pma_user == '') {
    //    $pma_user = '%';
    //}
    if (isset($anyuser) && $anyuser=="1") {
        $pma_user = '';

    // this is for the case where js is disabled, so they did not get
    // the error before submitting
    } else if (isset($pma_user) && empty($pma_user)) {
        echo '<p><b>' . $strError . '&nbsp;:&nbsp;' . $strUserEmpty . '</b></p>' . "\n";
        unset($host);
        unset($pma_user);
        $forgot_checkbox_any_user = TRUE;
    }

    // Password is not confirmed
    if ((!isset($nopass) || !$nopass) && $pma_pw == '') {
        echo '<p><b>' . $strError . '&nbsp;:&nbsp;' . $strPasswordEmpty . '</b></p>' . "\n";
        unset($host);
        unset($pma_user);
    }
    else if ($pma_pw != ''
        && (!isset($pma_pw2) || $pma_pw != $pma_pw2)) {
        echo '<p><b>' . $strError . '&nbsp;:&nbsp;' . $strPasswordNotSame . '</b></p>' . "\n";
        unset($host);
        unset($pma_user);
    }

    // Password confirmed
    else if (!isset($forgot_checkbox_any_user)) {
        $sql_query = '';
        $list_priv = array('Select', 'Insert', 'Update', 'Delete', 'Create', 'Drop', 'Reload',
                           'Shutdown', 'Process', 'File', 'Grant', 'References', 'Index', 'Alter');
        for ($i = 0; $i < 14; $i++) {
            $priv_name = $list_priv[$i] . '_priv';
            if (isset($$priv_name)) {
                $sql_query .= (empty($sql_query) ? $priv_name : ', ' . $priv_name) . ' = \'Y\'';
            } else  {
                $sql_query .= (empty($sql_query) ? $priv_name : ', ' . $priv_name) . ' = \'N\'';
            }
        } // end for
        unset($list_priv);

        if (get_magic_quotes_gpc() && $pma_pw != '') {
            $pma_pw   = stripslashes($pma_pw);
        }

        $local_query  = 'INSERT INTO mysql.user '
                      . 'SET Host = \'' . PMA_sqlAddslashes($host) . '\', User = \'' . PMA_sqlAddslashes($pma_user) . '\', ' . $password_field . ' = ' . (($pma_pw == '') ? '\'\'' : 'PASSWORD(\'' . PMA_sqlAddslashes($pma_pw) . '\')')
                      . ', ' . $sql_query;
        $sql_query    = 'INSERT INTO mysql.user '
                      . 'SET Host = \'' . PMA_sqlAddslashes($host) . '\', User = \'' . PMA_sqlAddslashes($pma_user) . '\', ' . $password_field . ' = ' . (($pma_pw == '') ? '\'\'' : 'PASSWORD(\'' . ereg_replace('.', '*', $pma_pw) . '\')')
                      . ', ' . $sql_query;
        $result       = @PMA_mysql_query($local_query) or PMA_mysqlDie('', '', FALSE, $err_url);
        unset($host);
        unset($pma_user);
        PMA_showMessage($strAddUserMessage . '<br />' . $strRememberReload);
    } // end else
}

// Updates the profile of an user
else if (isset($submit_updProfile)) {
    $show_query     = '1';
    $edit           = TRUE;
    if (!isset($host) || $host == '') {
        $host     = '%';
    }
    //if (!isset($pma_user) || $pma_user == '') {
    //    $pma_user = '%';
    //}
    if (!isset($pma_user)) {
        $pma_user = '';
    }

    // Builds the sql query
    $common_upd     = '';

    if (isset($anyhost) && $anyhost) {
        $new_server = '%';
    } else if ($new_server != '' && get_magic_quotes_gpc()) {
        $new_server = stripslashes($new_server);
    }
    if ($new_server != '' && $new_server != $host) {
        $common_upd .= 'Host = \'' . PMA_sqlAddslashes($new_server) . '\'';
    } else if (isset($new_server)) {
        unset($new_server);
    }
    if (isset($anyuser) && $anyuser=="1") {
        //$new_user   = '%';
        // anonymous user must be empty, not %
        $new_user   = '';
    } else if ($new_user != '' && get_magic_quotes_gpc()) {
        $new_user   = stripslashes($new_user);
    }
    //if ($new_user != '' && $new_user != $pma_user) {
    if ($new_user != $pma_user) {
        $common_upd .= (empty($common_upd) ? '' : ', ')
                    . 'User = \'' . PMA_sqlAddslashes($new_user) . '\'';
    } else if (isset($new_user)) {
        unset($new_user);
    }

    if (isset($nopass) && $nopass == -1) {
        $sql_query   = $common_upd;
        $local_query = $common_upd;
    }
    else if ((!isset($nopass) || $nopass == 0) && $new_pw == '') {
        echo '<h1>' . "\n";
        echo '    ' . $strHost . ' ' . $host . ' - ' . $strUser . ' ' . (($pma_user != '') ?  $pma_user : $strAny) . "\n";
        echo '</h1>' . "\n";
        echo '<p><b>' . $strError . '&nbsp;:&nbsp;' . $strPasswordEmpty . '</b></p>' . "\n";
    }
    else if ($new_pw != ''
        && (!isset($new_pw2) || $new_pw != $new_pw2)) {
        echo '<h1>' . "\n";
        echo '    ' . $strHost . ' ' . $host . ' - ' . $strUser . ' ' . (($pma_user != '') ?  $pma_user : $strAny) . "\n";
        echo '</h1>' . "\n";
        echo '<p><b>' . $strError . '&nbsp;:&nbsp;' . $strPasswordNotSame . '</b></p>' . "\n";
    }
    else {
        $sql_query   = (empty($common_upd) ? '' : $common_upd . ', ')
                     . $password_field . ' = ' . (($new_pw == '') ? '\'\'' : 'PASSWORD(\'' . ereg_replace('.', '*', $new_pw) . '\')');
        $local_query = (empty($common_upd) ? '' : $common_upd . ', ')
                     . $password_field . ' = ' . (($new_pw == '') ? '\'\'' : 'PASSWORD(\'' . PMA_sqlAddslashes($new_pw) . '\')');
    }

    if (!empty($sql_query)) {
        $common_where       = ' WHERE Host = \'' . PMA_sqlAddslashes($host) . '\' AND User = \'' . PMA_sqlAddslashes($pma_user) . '\'';
        // Updates profile
        $local_query        = 'UPDATE user SET ' . $local_query . $common_where;
        $sql_query_cpy      = 'UPDATE user SET ' . $sql_query . $common_where;
        $result             = @PMA_mysql_query($local_query) or PMA_mysqlDie('', '', FALSE, $err_url . '&amp;host=' . urlencode($host) . '&amp;pma_user=' . urlencode($pma_user) . '&amp;edit=1');

        // Updates grants
        if (isset($new_server) || isset($new_user)) {
            $sql_query      = 'UPDATE mysql.db SET ' . $common_upd . $common_where;
            $sql_query_cpy  .= ";\n" . $sql_query;
            PMA_mysql_query($sql_query);
            $sql_query      = 'UPDATE mysql.tables_priv SET ' . $common_upd . $common_where;
            $sql_query_cpy  .= ";\n" . $sql_query;
            PMA_mysql_query($sql_query);
            $sql_query      = 'UPDATE mysql.columns_priv SET ' . $common_upd . $common_where;
            $sql_query_cpy  .= ";\n" . $sql_query;
            PMA_mysql_query($sql_query);
            unset($common_upd);
        }

        $sql_query = $sql_query_cpy;
        unset($sql_query_cpy);
        if (isset($new_server)) {
            $host     = $new_server;
        }
        if (isset($new_user)) {
            $pma_user = $new_user;
        }
        echo '<h1>' . "\n";
        echo '    ' . $strHost . ' ' . $host . ' - ' . $strUser . ' ' . (($pma_user != '') ?  $pma_user : $strAny) . "\n";
        echo '</h1>' . "\n";
        PMA_showMessage($strUpdateProfileMessage . '<br />' . $strRememberReload);
    } else {
        echo '<h1>' . "\n";
        echo '    ' . $strHost . ' ' . $host . ' - ' . $strUser . ' ' . (($pma_user != '') ?  $pma_user : $strAny) . "\n";
        echo '</h1>' . "\n";
        PMA_showMessage($strNoModification);
    }
}

// Changes the privileges of an user
else if (isset($submit_chgPriv)) {
    $show_query   = '1';
    $edit         = TRUE;
    if (!isset($host) || $host == '') {
        $host     = '%';
    }
    if (!isset($pma_user) || $pma_user == '') {
        $pma_user = '%';
    }

    $sql_query = '';
    $list_priv = array('Select', 'Insert', 'Update', 'Delete', 'Create', 'Drop', 'Reload',
                       'Shutdown', 'Process', 'File', 'Grant', 'References', 'Index', 'Alter');
    for ($i = 0; $i < 14; $i++) {
        $priv_name = $list_priv[$i] . '_priv';
        if (isset($$priv_name)) {
            $sql_query .= (empty($sql_query) ? $priv_name : ', ' . $priv_name) . ' = \'Y\'';
        } else  {
            $sql_query .= (empty($sql_query) ? $priv_name : ', ' . $priv_name) . ' = \'N\'';
        }
    } // end for
    unset($list_priv);

    $sql_query = 'UPDATE user SET '
               . $sql_query
               . ' WHERE Host = \'' . PMA_sqlAddslashes($host) . '\' AND User = \'' . PMA_sqlAddslashes($pma_user) . '\'';
    $result     = @PMA_mysql_query($sql_query) or PMA_mysqlDie('', '', FALSE, $err_url . '&amp;host=' . urlencode($host) . '&amp;pma_user=' . urlencode($pma_user) . '&amp;edit=1');
    PMA_showMessage(sprintf($strUpdatePrivMessage, '<span style="color: #002E80">' . $pma_user . '@' . $host . '</span>') . '<br />' . $strRememberReload);
}

// Revoke/Grant privileges
else if (isset($grants) && $grants) {
    $show_query   = '1';
    if (!isset($host) || $host == '') {
        $host     = '%';
    }
    if (!isset($pma_user) || $pma_user == '') {
        $pma_user = '%';
    }

    if (isset($upd_grants)) {
        $sql_query = '';
        $col_list  = '';

        if (isset($colgrant) && !$anycolumn && !$newdb) {
            $colgrant_cnt = count($colgrant);
            for ($i = 0; $i < $colgrant_cnt; $i++) {
                if (get_magic_quotes_gpc()) {
                    $colgrant[$i] = stripslashes($colgrant[$i]);
                }
                $col_list .= (empty($col_list) ?  PMA_backquote($colgrant[$i]) : ', ' . PMA_backquote($colgrant[$i]));
            } // end for
            unset($colgrant);
            $col_list     = ' (' . $col_list . ')';
        } // end if

        $list_priv = array('Select', 'Insert', 'Update', 'Delete', 'Create', 'Drop', 'Reload',
                           'Shutdown', 'Process', 'File', 'References', 'Index', 'Alter');
        for ($i = 0; $i < 13; $i++) {
            $priv_name = $list_priv[$i] . '_priv';
            if (isset($$priv_name)) {
                $sql_query .= (empty($sql_query) ? $list_priv[$i] : ', ' . $list_priv[$i]) . $col_list;
            }
        } // end for
        unset($list_priv);
        if (empty($sql_query)) {
            $sql_query = 'USAGE' . $col_list;
        }
        $priv_grant = 'Grant_priv';
        $priv_grant = (isset($$priv_grant) ? ' WITH GRANT OPTION' : '');

        if (get_magic_quotes_gpc()) {
            if ($newdb) {
                $newdb          = stripslashes($newdb);
            } else {
                if (isset($dbgrant) && !$anydb && !$newdb) {
                    $dbgrant    = stripslashes($dbgrant);
                }
                if (isset($tablegrant) && !$anytable && !$newdb) {
                    $tablegrant = stripslashes($tablegrant);
                }
            }
        } // end if

        // Escape wilcard characters if required
        if (isset($dbgrant) && !$anydb && !$newdb) {
            $re      = '(^|(\\\\\\\\)+|[^\])(_|%)'; // non-escaped wildcards
            $dbgrant = ereg_replace($re, '\\1\\\\3', $dbgrant);
        }

        if (!$newdb) {
            $sql_query .= ' ON '
                       . (($anydb || $dbgrant == '') ? '*' : PMA_backquote($dbgrant))
                       . '.'
                       . (($anytable || $tablegrant == '') ? '*' : PMA_backquote($tablegrant));
        } else {
            $sql_query .= ' ON ' . PMA_backquote($newdb) . '.*';
        }

        $sql_query     .= ' TO ' . '\'' . PMA_sqlAddslashes($pma_user) . '\'' . '@' . '\'' . PMA_sqlAddslashes($host) . '\'';

        $sql_query     = 'GRANT ' . $sql_query . $priv_grant;
        $result        = @PMA_mysql_query($sql_query) or PMA_mysqlDie('', '', FALSE, $err_url . '&amp;host=' . urlencode($host) . '&amp;pma_user=' . urlencode($pma_user) . '&amp;grants=1');
        PMA_showMessage($strAddPrivMessage . '.<br />' . $strRememberReload);
    } // end if
}



/**
 * Displays the page
 */
// Edit an user properies
if (isset($edit) && $edit) {
    PMA_tableUsers($host, $pma_user);
    PMA_editOperations($host, $pma_user);
}

// Revoke/Grant privileges for an user
else if (isset($grants) && $grants) {
    // Displays the full list of privileges for this host & user
    $infos['Host'] = $host;
    $infos['User'] = $pma_user;
    PMA_tableGrants($infos);

    // Displays the list of privileges for user on the selected db/table/column
    $user_priv     = array();
    $list_priv     = array('Select', 'Insert', 'Update', 'Delete', 'Create', 'Drop', 'Reload',
                           'Shutdown', 'Process', 'File', 'Grant', 'References', 'Index',
                           'Alter');
    $list_priv_new = array();

    // Gets globals privileges
    $result = PMA_mysql_query('SELECT * FROM mysql.user WHERE (Host = \'' . PMA_sqlAddslashes($host) . '\' OR Host = \'%\') AND (User = \'' . PMA_sqlAddslashes($pma_user) . '\' OR User = \'\')');
    $row    = ($result) ? @PMA_mysql_fetch_array($result) : FALSE;
    if ($row) {
        while (list(,$priv) = each($list_priv)) {
            $priv_priv = $priv . '_priv';
            if ($row[$priv_priv] == 'Y') {
                $user_priv[$priv_priv] = 'Y';
            } else {
                $user_priv[$priv_priv] = 'N';
                $list_priv_new[]       = $priv;
            }
        } // end while
        mysql_free_result($result);
        $list_priv     = $list_priv_new;
        unset($list_priv_new);
        $list_priv_new = array();
    } // end if $row

    // If a target database is set, gets privileges for this database
    if (count($list_priv) && isset($dbgrant)) {
        if (get_magic_quotes_gpc()) {
            $dbgrant = stripslashes($dbgrant);
        }
        $result      = PMA_mysql_query('SELECT * FROM mysql.db WHERE (Host = \'' . PMA_sqlAddslashes($host) . '\' OR Host = \'%\') AND (User = \'' . PMA_sqlAddslashes($pma_user) . '\' OR User = \'\') AND Db = \'' . PMA_sqlAddslashes($dbgrant) . '\'');
        $row         = ($result) ? @PMA_mysql_fetch_array($result) : FALSE;
        if ($row) {
            while (list(,$priv) = each($list_priv)) {
                $priv_priv = $priv . '_priv';
                if (isset($row[$priv_priv]) && $row[$priv_priv] == 'Y') {
                    $user_priv[$priv_priv] = 'Y';
                } else {
                    $list_priv_new[]       = $priv;
                }
            } // end while
            mysql_free_result($result);
            $list_priv     = $list_priv_new;
            unset($list_priv_new);
            $list_priv_new = array();
        } // end if $row
    } // end if

    // If a target table is set, gets privileges for this table
    if (count($list_priv) && isset($tablegrant)) {
        if (get_magic_quotes_gpc()) {
            $tablegrant = stripslashes($tablegrant);
        }
        $result         = PMA_mysql_query('SELECT * FROM mysql.tables_priv WHERE (Host = \'' . PMA_sqlAddslashes($host) . '\' OR Host = \'%\') AND (User = \'' . PMA_sqlAddslashes($pma_user) . '\' OR User = \'\') AND Db = \'' . PMA_sqlAddslashes($dbgrant) . '\' AND Table_name = \'' . PMA_sqlAddslashes($tablegrant) . '\'');
        $row            = ($result) ? @PMA_mysql_fetch_array($result) : FALSE;
        if ($row && $row['Table_priv']) {
            while (list(,$priv) = each($list_priv)) {
                $priv_priv = $priv . '_priv';
                if (eregi('(^|,)' . $priv . '(,|$)', $row['Table_priv'])) {
                    $user_priv[$priv_priv] = 'Y';
                } else {
                    $list_priv_new[]       = $priv;
                }
            } // end while
            mysql_free_result($result);
            $list_priv     = $list_priv_new;
            unset($list_priv_new);
            $list_priv_new = array();
        } // end if $row
    } // end if

    // TODO: column privileges

    PMA_grantOperations($user_priv);
}

// Check database privileges
else if (isset($check) && $check) {
    PMA_checkDb($db);
    ?>
<ul>
    <li>
        <a href="user_details.php?lang=<?php echo $lang;?>&amp;convcharset=<?php echo $convcharset; ?>&amp;server=<?php echo $server; ?>&amp;db=mysql&amp;table=user">
            <?php echo $strBack; ?></a>
    </li>
</ul>
    <?php
    echo "\n";
}

// Displays all users profiles
else {
    if (!isset($host)) {
        $host = FALSE;
    }
    if (!isset($pma_user)) {
        $pma_user = FALSE;
    }
    PMA_tableUsers($host, $pma_user) or PMA_mysqlDie($strNoUsersFound, '', FALSE, '');
    PMA_normalOperations();
}


/**
 * Displays the footer
 */
require('./footer.inc.php');
?>
