<?php
/* $Id: relation.lib.php,v 1.22 2002/10/23 04:17:26 robbat2 Exp $ */
// vim: expandtab sw=4 ts=4 sts=4:

/**
 * Set of functions used with the relation and pdf feature
 */


if (!defined('PMA_RELATION_LIB_INCLUDED')){
    define('PMA_RELATION_LIB_INCLUDED', 1);

    /**
     * Executes a query as controluser if possible, otherwise as normal user
     *
     * @param   string   the query to execute
     * @param   boolean  whether to display SQL error messages or not
     *
     * @return  integer  the result id
     *
     * @global  string   the URL of the page to show in case of error
     * @global  string   the name of db to come back to
     * @global  integer  the ressource id of DB connect as controluser
     * @global  array    configuration infos about the relations stuff
     *
     * @access  public
     *
     * @author  Mike Beck <mikebeck@users.sourceforge.net>
     */
     function PMA_query_as_cu($sql, $show_error = TRUE) {
        global $err_url_0, $db, $dbh, $cfgRelation;

        if (isset($dbh)) {
            PMA_mysql_select_db($cfgRelation['db'], $dbh);
            $result = @PMA_mysql_query($sql, $dbh);
            if (!$result && $show_error == TRUE) {
                PMA_mysqlDie(mysql_error($dbh), $sql, '', $err_url_0);
            }
            PMA_mysql_select_db($db, $dbh);
        } else {
            PMA_mysql_select_db($cfgRelation['db']);
            $result = @PMA_mysql_query($sql);
            if ($result && $show_error == TRUE) {
                PMA_mysqlDie('', $sql, '', $err_url_0);
            }
            PMA_mysql_select_db($db);
        } // end if... else...

        if ($result) {
            return $result;
        } else {
            return FALSE;
        }
     } // end of the "PMA_query_as_cu()" function


    /**
     * Defines the relation parameters for the current user
     * just a copy of the functions used for relations ;-)
     * but added some stuff to check what will work
     *
     * @param   boolean  whether to check validity of settings or not
     *
     * @return  array    the relation parameters for the current user
     *
     * @global  array    the list of settings for servers
     * @global  integer  the id of the current server
     * @global  string   the URL of the page to show in case of error
     * @global  string   the name of the current db
     * @global  string   the name of the current table
     * @global  array    configuration infos about the relations stuff
     *
     * @access  public
     *
     * @author  Mike Beck <mikebeck@users.sourceforge.net>
     */
    function PMA_getRelationsParam($verbose = FALSE)
    {
        global $cfg, $server, $err_url_0, $db, $table;
        global $cfgRelation;

        $cfgRelation                = array();
        $cfgRelation['relwork']     = FALSE;
        $cfgRelation['displaywork'] = FALSE;
        $cfgRelation['pdfwork']     = FALSE;
        $cfgRelation['commwork']    = FALSE;
        $cfgRelation['allworks']    = FALSE;

        // No server selected -> no bookmark table
        // we return the array with the FALSEs in it,
        // to avoid some 'Unitialized string offset' errors later
        if ($server == 0
           || empty($cfg['Server'])
           || empty($cfg['Server']['pmadb'])) {
            if ($verbose == TRUE) {
                echo 'PMA Database ... '
                     . '<font color="red"><b>' . $GLOBALS['strNotOK'] . '</b></font>'
                     . '[ <a href="Documentation.html#pmadb">' . $GLOBALS['strDocu'] . '</a> ]<br />' . "\n"
                     . $GLOBALS['strGeneralRelationFeat']
                     . ' <font color="green">' . $GLOBALS['strDisabled'] . '</font>' . "\n";
            }
            return $cfgRelation;
        }

        $cfgRelation['user']  = $cfg['Server']['user'];
        $cfgRelation['db']    = $cfg['Server']['pmadb'];

        //  Now I just check if all tables that i need are present so I can for
        //  example enable relations but not pdf...
        //  I was thinking of checking if they have all required columns but I
        //  fear it might be too slow
        // PMA_mysql_select_db($cfgRelation['db']);

        $tab_query = 'SHOW TABLES FROM ' . PMA_backquote($cfgRelation['db']);
        $tab_rs    = PMA_query_as_cu($tab_query, FALSE);

        while ($curr_table = @PMA_mysql_fetch_array($tab_rs)) {
            if ($curr_table[0] == $cfg['Server']['bookmarktable']) {
                continue;
            } else if ($curr_table[0] == $cfg['Server']['relation']) {
                $cfgRelation['relation']        = $curr_table[0];
            } else if ($curr_table[0] == $cfg['Server']['table_info']) {
                $cfgRelation['table_info']      = $curr_table[0];
            } else if ($curr_table[0] == $cfg['Server']['table_coords']) {
                $cfgRelation['table_coords']    = $curr_table[0];
            } else if ($curr_table[0] == $cfg['Server']['column_comments']) {
                $cfgRelation['column_comments'] = $curr_table[0];
            } else if ($curr_table[0] == $cfg['Server']['pdf_pages']) {
                $cfgRelation['pdf_pages']       = $curr_table[0];
            }
        } // end while
        if (isset($cfgRelation['relation'])) {
            $cfgRelation['relwork']         = TRUE;
            if (isset($cfgRelation['table_info'])) {
                $cfgRelation['displaywork'] = TRUE;
            }
            if (isset($cfgRelation['table_coords']) && isset($cfgRelation['pdf_pages'])) {
                $cfgRelation['pdfwork']     = TRUE;
            }
            if (isset($cfgRelation['column_comments'])) {
                $cfgRelation['commwork']    = TRUE;
            }
        } // end if

        if ($cfgRelation['relwork'] == TRUE && $cfgRelation['displaywork'] == TRUE
            && $cfgRelation['pdfwork'] == TRUE && $cfgRelation['commwork'] == TRUE) {
            $cfgRelation['allworks'] = TRUE;
        }
        if ($tab_rs) {
            mysql_free_result($tab_rs);
        } else {
            $cfg['Server']['pmadb'] = FALSE;
        }

        if ($verbose == TRUE) {
            $shit     = '<font color="red"><b>' . $GLOBALS['strNotOK'] . '</b></font> [ <a href="Documentation.html#%s">' . $GLOBALS['strDocu'] . '</a> ]';
            $hit      = '<font color="green"><b>' . $GLOBALS['strOK'] . '</b></font>';
            $enabled  = '<font color="green">' . $GLOBALS['strEnabled'] . '</font>';
            $disabled = '<font color="red">'   . $GLOBALS['strDisabled'] . '</font>';

            echo '<table>' . "\n";
            echo '    <tr><th align="left">PMA Database ... </th><td align="right">'
                 . (($cfg['Server']['pmadb'] == FALSE) ? sprintf($shit, 'pmadb') : $hit)
                 . '</td></tr>' . "\n";
            echo '    <tr><td>&nbsp;</td></tr>' . "\n";

            echo '    <tr><th align="left">relation Table ... </th><td align="right">'
                 . ((isset($cfgRelation['relation'])) ? $hit : sprintf($shit, 'relation'))
                 . '</td></tr>' . "\n";
            echo '    <tr><td colspan=2 align="center">'. $GLOBALS['strGeneralRelationFeat'] . ': '
                 . (($cfgRelation['relwork'] == TRUE) ? $enabled :  $disabled)
                 . '</td></tr>' . "\n";
            echo '    <tr><td>&nbsp;</td></tr>' . "\n";

            echo '    <tr><th align="left">table_info   ... </th><td align="right">'
                 . (($cfgRelation['displaywork'] == FALSE) ? sprintf($shit, 'table_info') : $hit)
                 . '</td></tr>' . "\n";
            echo '    <tr><td colspan=2 align="center">' . $GLOBALS['strDisplayFeat'] . ': '
                 . (($cfgRelation['displaywork'] == TRUE) ? $enabled : $disabled)
                 . '</td></tr>' . "\n";
            echo '    <tr><td>&nbsp;</td></tr>' . "\n";

            echo '    <tr><th align="left">table_coords ... </th><td align="right">'
                 . ((isset($cfgRelation['table_coords'])) ? $hit : sprintf($shit, 'table_coords'))
                 . '</td></tr>' . "\n";
            echo '    <tr><th align="left">pdf_pages ... </th><td align="right">'
                 . ((isset($cfgRelation['pdf_pages'])) ? $hit : sprintf($shit, 'table_coords'))
                 . '</td></tr>' . "\n";
            echo '    <tr><td colspan=2 align="center">' . $GLOBALS['strCreatePdfFeat'] . ': '
                 . (($cfgRelation['pdfwork'] == TRUE) ? $enabled : $disabled)
                 . '</td></tr>' . "\n";
            echo '    <tr><td>&nbsp;</td></tr>' . "\n";

            echo '    <tr><th align="left">column_comments ... </th><td align="right">'
                 . ((isset($cfgRelation['column_comments'])) ? $hit : sprintf($shit, 'col_com'))
                 . '</td></tr>' . "\n";
            echo '    <tr><td colspan=2 align="center">' . $GLOBALS['strColComFeat'] . ': '
                 . (($cfgRelation['commwork'] == TRUE) ? $enabled : $disabled)
                 . '</td></tr>' . "\n";
            echo '</table>' . "\n";
        } // end if ($verbose == TRUE) {

        return $cfgRelation;
    } // end of the 'PMA_getRelationsParam()' function


    /**
     * Gets all Relations to foreign tables for a given table or
     * optionally a given column in a table
     *
     * @param   string   the name of the db to check for
     * @param   string   the name of the table to check for
     * @param   string   the name of the column to check for
     *
     * @return  array    db,table,column
     *
     * @global  array    the list of relations settings
     * @global  string   the URL of the page to show in case of error
     *
     * @access  public
     *
     * @author  Mike Beck <mikebeck@users.sourceforge.net>
     */
    function PMA_getForeigners($db, $table, $column = '') {
        global $cfgRelation, $err_url_0;

        $rel_query     = 'SELECT master_field, foreign_db, foreign_table, foreign_field'
                       . ' FROM ' . PMA_backquote($cfgRelation['relation'])
                       . ' WHERE master_db =  \'' . PMA_sqlAddslashes($db) . '\' '
                       . ' AND   master_table = \'' . PMA_sqlAddslashes($table) . '\' ';
        if (!empty($column)) {
            $rel_query .= ' AND master_field = \'' . PMA_sqlAddslashes($column) . '\'';
        }
        $relations     = PMA_query_as_cu($rel_query);
        $i = 0;
        while ($relrow = @PMA_mysql_fetch_array($relations)) {
            $field                            = $relrow['master_field'];
            $foreign[$field]['foreign_db']    = $relrow['foreign_db'];
            $foreign[$field]['foreign_table'] = $relrow['foreign_table'];
            $foreign[$field]['foreign_field'] = $relrow['foreign_field'];
            $i++;
         } // end while

         if (isset($foreign) && is_array($foreign)) {
            return $foreign;
         } else {
            return FALSE;
         }
    } // end of the 'PMA_getForeigners()' function


    /**
     * Gets the display field of a table
     *
     * @param   string   the name of the db to check for
     * @param   string   the name of the table to check for
     *
     * @return  string   field name
     *
     * @global  array    the list of relations settings
     *
     * @access  public
     *
     * @author  Mike Beck <mikebeck@users.sourceforge.net>
     */
    function PMA_getDisplayField($db, $table) {
        global $cfgRelation;

        $disp_query = 'SELECT display_field FROM ' . PMA_backquote($cfgRelation['table_info'])
                    . ' WHERE db_name  = \'' . PMA_sqlAddslashes($db) . '\''
                    . ' AND table_name = \'' . PMA_sqlAddslashes($table) . '\'';

        $disp_res   = PMA_query_as_cu($disp_query);
        $row        = ($disp_res ? PMA_mysql_fetch_array($disp_res) : '');
        if (isset($row['display_field'])) {
            return $row['display_field'];
        } else {
            return FALSE;
        }
    } // end of the 'PMA_getDisplayField()' function


    /**
     * Gets the comments for all rows of a table
     *
     * @param   string   the name of the db to check for
     * @param   string   the name of the table to check for
     *
     * @return  array    [field_name] = comment
     *
     * @global  array    the list of relations settings
     *
     * @access  public
     *
     * @author  Mike Beck <mikebeck@users.sourceforge.net>
     */
    function PMA_getComments($db, $table) {
        global $cfgRelation;

        $com_qry  = 'SELECT column_name, comment FROM ' . PMA_backquote($cfgRelation['column_comments'])
                  . ' WHERE db_name = \'' . PMA_sqlAddslashes($db) . '\''
                  . ' AND table_name = \'' . PMA_sqlAddslashes($table) . '\'';
        $com_rs   = PMA_query_as_cu($com_qry);

        while ($row = @PMA_mysql_fetch_array($com_rs)) {
            $col           = $row['column_name'];
            $comment[$col] = $row['comment'];
        } // end while

        if (isset($comment) && is_array($comment)) {
            return $comment;
         } else {
            return FALSE;
         }
     } // end of the 'PMA_getComments()' function
} // $__PMA_RELATION_LIB__
?>
