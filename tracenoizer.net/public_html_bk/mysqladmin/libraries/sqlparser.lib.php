<?php
/* $Id: sqlparser.lib.php,v 1.50 2002/11/27 11:47:07 lem9 Exp $ */
// vim: expandtab sw=4 ts=4 sts=4:


/** SQL Parser Functions for phpMyAdmin
 *
 * Copyright 2002 Robin Johnson <robbat2@users.sourceforge.net>
 * http://www.orbis-terrarum.net/?l=people.robbat2
 *
 * These functions define an SQL parser system, capable of understanding and
 * extracting data from a MySQL type SQL query.
 *
 * The basic procedure for using the new SQL parser:
 * On any page that needs to extract data from a query or to pretty-print a
 * query, you need code like this up at the top:
 *
 * ($sql contains the query)
 * $parsed_sql = PMA_SQP_parse($sql);
 *
 * If you want to extract data from it then, you just need to run
 * $sql_info = PMA_SQP_analyze($parsed_sql);
 * (returned structure of this function is being rewritten presently);
 *
 * lem9: Currently the analyzer can interpret db, table, column, alias
 *       for SELECTs;
 *       see comments in PMA_SQP_analyze for the new returned info
 *       (select_expr and table_ref)
 *
 * If you want a pretty-printed version of the query, do:
 * $string = PMA_SQP_formatHtml($parsed_sql);
 * (note that that you need to have syntax.css.php included somehow in your
 * page for it to work, I recommend '<link rel="stylesheet" type="text/css"
 * href="syntax.css.php" />' at the moment.)
 */


if (!defined('PMA_SQP_LIB_INCLUDED')) {
    define('PMA_SQP_LIB_INCLUDED', 1);


    /**
     * Include the string library as we use it heavily
     */
    if (!defined('PMA_STR_LIB_INCLUDED')) {
        include('./libraries/string.lib.php');
    }

    /**
     * Include data for the SQL Parser
     */
    if (!defined('PMA_SQP_DATA_INCLUDED')) {
        include('./libraries/sqlparser.data.php');
    }

    if (!defined('DEBUG_TIMING')) {
        function PMA_SQP_arrayAdd(&$arr, $type, $data, &$arrsize)
        {
            $arr[] = array('type' => $type, 'data' => $data);
            $arrsize++;
        } // end of the "PMA_SQP_arrayAdd()" function
    } else {
        function PMA_SQP_arrayAdd(&$arr, $type, $data, &$arrsize)
        {
            global $timer;

            $t     = $timer;
            $arr[] = array('type' => $type, 'data' => $data , 'time' => $t);
            $timer = microtime();
            $arrsize++;
        } // end of the "PMA_SQP_arrayAdd()" function
    } // end if... else...


    /**
     * Do display an error message
     *
     * @param  string  The error message
     * @param  string  The failing SQL query
     *
     * @access public
     */
    function PMA_SQP_throwError($message, $sql)
    {
        $debugstr = 'ERROR: ' . $message . "\n";
        $debugstr .= 'SQL: ' . $sql;

        echo $GLOBALS['strSQLParserUserError'] . '<br />' . "\n"
             . '<pre>' . "\n"
             . $debugstr . "\n"
             . '</pre>' . "\n";

        flush();
        if (PMA_PHP_INT_VERSION >= 40200 && @function_exists('ob_flush')) {
            ob_flush();
        }
    } // end of the "PMA_SQP_throwError()" function


    /**
     * Do display the bug report
     *
     * @param  string  The error message
     * @param  string  The failing SQL query
     *
     * @access public
     */
    function PMA_SQP_bug($message, $sql)
    {
        $debugstr = 'ERROR: ' . $message . "\n";
        $debugstr .= 'CVS: $Id: sqlparser.lib.php,v 1.50 2002/11/27 11:47:07 lem9 Exp $' . "\n";
        $debugstr .= 'MySQL: '.PMA_MYSQL_STR_VERSION . "\n";
        $debugstr .= 'USR OS, AGENT, VER: ' . PMA_USR_OS . ' ' . PMA_USR_BROWSER_AGENT . ' ' . PMA_USR_BROWSER_VER . "\n";
        $debugstr .= 'PMA: ' . PMA_VERSION . "\n";
        $debugstr .= 'PHP VER,OS: ' . PMA_PHP_STR_VERSION . ' ' . PHP_OS . "\n";
        $debugstr .= 'LANG: ' . $GLOBALS['lang'] . "\n";
        $debugstr .= 'SQL: ' . $sql;

        $encodedstr     = $debugstr;
        if (PMA_PHP_INT_VERSION >= 40001 && @function_exists('gzcompress')) {
            $encodedstr = gzcompress($debugstr, 9);
        }
        $encodedstr     = preg_replace("/(\015\012)|(\015)|(\012)/", '<br />' . "\n", chunk_split(base64_encode($encodedstr)));

        echo $GLOBALS['strSQLParserBugMessage'] . '<br />' . "\n"
             . '----' . $GLOBALS['strBeginCut'] . '----' . '<br />' . "\n"
             . $encodedstr . "\n"
             . '----' . $GLOBALS['strEndCut'] . '----' . '<br />' . "\n";

        flush();
        if (PMA_PHP_INT_VERSION >= 40200 && @function_exists('ob_flush')) {
            ob_flush();
        }

        echo '----' . $GLOBALS['strBeginRaw'] . '----<br />' . "\n"
             . '<pre>' . "\n"
             . $debugstr
             . '</pre>' . "\n"
             . '----' . $GLOBALS['strEndRaw'] . '----<br />' . "\n";

        flush();
        if (PMA_PHP_INT_VERSION >= 40200 && @function_exists('ob_flush')) {
            ob_flush();
        }
    } // end of the "PMA_SQP_bug()" function


    /**
     * Parses the SQL queries
     *
     * @param  string   The SQL query list
     *
     * @return mixed    Most of times, nothing...
     *
     * @global array    The current PMA configuration
     * @global array    MySQL column attributes
     * @global array    MySQL reserved words
     * @global array    MySQL column types
     * @global array    MySQL function names
     * @global integer  MySQL column attributes count
     * @global integer  MySQL reserved words count
     * @global integer  MySQL column types count
     * @global integer  MySQL function names count
     *
     * @access public
     */
    function PMA_SQP_parse($sql)
    {
        global $cfg;
        global $PMA_SQPdata_column_attrib, $PMA_SQPdata_reserved_word, $PMA_SQPdata_column_type, $PMA_SQPdata_function_name,
        $PMA_SQPdata_column_attrib_cnt, $PMA_SQPdata_reserved_word_cnt, $PMA_SQPdata_column_type_cnt, $PMA_SQPdata_function_name_cnt;

        // if the SQL parser is disabled just return the original query string
        if ($cfg['SQP']['enable'] == FALSE) {
            // Debug : echo 'FALSE';
            return $sql;
        }

        // rabus: Convert all line feeds to Unix style
        $sql = str_replace("\r\n", "\n", $sql);
        $sql = str_replace("\r", "\n", $sql);

        $len = $GLOBALS['PMA_strlen']($sql);
        if ($len == 0) {
            return array();
        }

        $sql_array               = array();
        $sql_array['raw']        = $sql;
        $count1                  = 0;
        $count2                  = 0;
        $punct_queryend          = ';';
        $punct_qualifier         = '.';
        $punct_listsep           = ',';
        $punct_level_plus        = '(';
        $punct_level_minus       = ')';
        $digit_floatdecimal      = '.';
        $digit_hexset            = 'x';
        $bracket_list            = '()[]{}';
        $allpunct_list           =  '-,;:!?/.^~\*&%+<=>|';
        $allpunct_list_pair      = array (
            0 => '!=',
            1 => '&&',
            2 => ':=',
            3 => '<<',
            4 => '<=',
            5 => '<=>',
            6 => '<>',
            7 => '>=',
            8 => '>>',
            9 => '||'
        );
        $allpunct_list_pair_size = 10; //count($allpunct_list_pair);
        $quote_list              = '\'"`';
        $arraysize               = 0;

        while ($count2 < $len) {
            $c      = $sql[$count2];
            $count1 = $count2;

            if (($c == "\n")) {
                $count2++;
                PMA_SQP_arrayAdd($sql_array, 'white_newline', '', $arraysize);
                continue;
            }

            // Checks for white space
            if (PMA_STR_isSpace($c)) {
                $count2++;
                continue;
            }

            // Checks for comment lines.
            // MySQL style #
            // C style /* */
            // ANSI style --
            if (($c == '#')
                || (($count2 + 1 < $len) && ($c == '/') && ($sql[$count2 + 1] == '*'))
                || (($count2 + 2 < $len) && ($c == '-') && ($sql[$count2 + 1] == '-') && (($sql[$count2 + 2] == ' ') || ($sql[$count2 + 2] == "\n")))) {
                $count2++;
                $pos  = 0;
                $type = 'bad';
                switch ($c) {
                    case '#':
                        $type = 'mysql';
                    case '-':
                        $type = 'ansi';
                        $pos  = $GLOBALS['PMA_strpos']($sql, "\n", $count2);
                        break;
                    case '/':
                        $type = 'c';
                        $pos  = $GLOBALS['PMA_strpos']($sql, '*/', $count2);
                        $pos  += 2;
                        break;
                    default:
                        break;
                } // end switch
                $count2 = ($pos < $count2) ? $len : $pos;
                $str    = $GLOBALS['PMA_substr']($sql, $count1, $count2 - $count1);
                PMA_SQP_arrayAdd($sql_array, 'comment_' . $type, $str, $arraysize);
                continue;
            } // end if

            // Checks for something inside quotation marks
            if (PMA_STR_strInStr($c, $quote_list)) {
                $startquotepos   = $count2;
                $quotetype       = $c;
                $count2++;
                $escaped         = FALSE;
                $escaped_escaped = FALSE;
                $pos             = $count2;
                $oldpos          = 0;
                do {
                    $oldpos = $pos;
                    $pos    = $GLOBALS['PMA_strpos'](' ' . $sql, $quotetype, $oldpos + 1) - 1;
                    // ($pos === FALSE)
                    if ($pos < 0) {
                        $debugstr = $GLOBALS['strSQPBugUnclosedQuote'] . ' @ ' . $startquotepos. "\n"
                                  . 'STR: ' . $quotetype;
                        PMA_SQP_throwError($debugstr, $sql);
                        return $sql;
                    }

                    // If the quote is the first character, it can't be
                    // escaped, so don't do the rest of the code
                    if ($pos == 0) {
                        break;
                    }

                    // Checks for MySQL escaping using a \
                    // And checks for ANSI escaping using the $quotetype character
                    if (($pos < $len) && PMA_STR_charIsEscaped($sql, $pos)) {
                        $pos ++;
                        continue;
                    } else if (($pos + 1 < $len) && ($sql[$pos] == $quotetype) && ($sql[$pos + 1] == $quotetype)) {
                        $pos = $pos + 2;
                        continue;
                    } else {
                        break;
                    }
                } while ($len > $pos); // end do

                $count2       = $pos;
                $count2++;
                $type         = 'quote_';
                switch ($quotetype) {
                    case '\'':
                        $type .= 'single';
                        break;
                    case '"':
                        $type .= 'double';
                        break;
                    case '`':
                        $type .= 'backtick';
                        break;
                    default:
                        break;
                } // end switch
                $data = $GLOBALS['PMA_substr']($sql, $count1, $count2 - $count1);
                PMA_SQP_arrayAdd($sql_array, $type, $data, $arraysize);
                continue;
            }

            // Checks for brackets
            if (PMA_STR_strInStr($c, $bracket_list)) {
                // All bracket tokens are only one item long
                $count2++;
                $type_type     = '';
                if (PMA_STR_strInStr($c, '([{')) {
                    $type_type = 'open';
                } else {
                    $type_type = 'close';
                }

                $type_style     = '';
                if (PMA_STR_strInStr($c, '()')) {
                    $type_style = 'round';
                } elseif (PMA_STR_strInStr($c, '[]')) {
                    $type_style = 'square';
                } else {
                    $type_style = 'curly';
                }

                $type = 'punct_bracket_' . $type_type . '_' . $type_style;
                PMA_SQP_arrayAdd($sql_array, $type, $c, $arraysize);
                continue;
            }

            // Checks for punct
            if (PMA_STR_strInStr($c, $allpunct_list)) {
                while (($count2 < $len) && PMA_STR_strInStr($sql[$count2], $allpunct_list)) {
                    $count2++;
                }
                $l = $count2 - $count1;
                if ($l == 1) {
                    $punct_data = $c;
                } else {
                    $punct_data = $GLOBALS['PMA_substr']($sql, $count1, $l);
                }

                // Special case, sometimes, althought two characters are
                // adjectent directly, they ACTUALLY need to be seperate
                if ($l == 1) {
                    $t_suffix         = '';
                    switch ($punct_data) {
                        case $punct_queryend:
                            $t_suffix = '_queryend';
                            break;
                        case $punct_qualifier:
                            $t_suffix = '_qualifier';
                            break;
                        case $punct_listsep:
                            $t_suffix = '_listsep';
                            break;
                        default:
                            break;
                    }
                    PMA_SQP_arrayAdd($sql_array, 'punct' . $t_suffix, $punct_data, $arraysize);
                }
                else if (PMA_STR_binarySearchInArr($punct_data, $allpunct_list_pair, $allpunct_list_pair_size)) {
                    // Ok, we have one of the valid combined punct expressions
                    PMA_SQP_arrayAdd($sql_array, 'punct', $punct_data, $arraysize);
                }
                else {
                    // Bad luck, lets split it up more
                    $first  = $punct_data[0];
                    $first2 = $punct_data[0] . $punct_data[1];
                    $last2  = $punct_data[$l - 2] . $punct_data[$l - 1];
                    $last   = $punct_data[$l - 1];
                    if (($first == ',') || ($first == ';') || ($first == '.') || ($first = '*')) {
                        $count2     = $count1 + 1;
                        $punct_data = $first;
                    } else if (($last2 == '/*') || ($last2 == '--')) {
                        $count2     -= 2;
                        $punct_data = $GLOBALS['PMA_substr']($sql, $count1, $count2 - $count1);
                    } else if (($last == '-') || ($last == '+') || ($last == '!')) {
                        $count2--;
                        $punct_data = $GLOBALS['PMA_substr']($sql, $count1, $count2 - $count1);
                    } else {
                        $debugstr =  $GLOBALS['strSQPBugUnknownPunctuation'] . ' @ ' . ($count1+1) . "\n"
                                  . 'STR: ' . $punct_data;
                        PMA_SQP_throwError($debugstr, $sql);
                        return $sql;
                    }
                    PMA_SQP_arrayAdd($sql_array, 'punct', $punct_data, $arraysize);
                    continue;
                } // end if... else if... else
                continue;
            }

            // Checks for alpha
            if (PMA_STR_isSqlIdentifier($c, FALSE) || ($c == '@')) {
                $count2 ++;

                //TODO: a @ can also be present in expressions like
                // FROM 'user'@'%'
                // in this case, the @ is wrongly marked as alpha_variable

                $is_sql_variable         = ($c == '@');
                $is_digit                = (!$is_sql_variable) && PMA_STR_isDigit($c);
                $is_hex_digit            = ($is_digit) && ($c == '0') && ($count2 < $len) && ($sql[$count2] == 'x');
                $is_float_digit          = FALSE;
                $is_float_digit_exponent = FALSE;

                if ($is_hex_digit) {
                    $count2++;
                }

                while (($count2 < $len) && PMA_STR_isSqlIdentifier($sql[$count2], ($is_sql_variable || $is_digit))) {
                    $c2 = $sql[$count2];
                    if ($is_sql_variable && ($c2 == '.')) {
                        $count2++;
                        continue;
                    }
                    if ($is_digit && (!$is_hex_digit) && ($c2 == '.')) {
                        $count2++;
                        if (!$is_float_digit) {
                            $is_float_digit = TRUE;
                            continue;
                        } else {
                            $debugstr = $GLOBALS['strSQPBugInvalidIdentifer'] . ' @ ' . ($count1+1) . "\n"
                                      . 'STR: ' . $GLOBALS['PMA_substr']($sql, $count1, $count2 - $count1);
                            PMA_SQP_throwError($debugstr, $sql);
                            return $sql;
                        }
                    }
                    if ($is_digit && (!$is_hex_digit) && (($c2 == 'e') || ($c2 == 'E'))) {
                        if (!$is_float_digit_exponent) {
                            $is_float_digit_exponent = TRUE;
                            $is_float_digit          = TRUE;
                            $count2++;
                            continue;
                        } else {
                            $is_digit                = FALSE;
                            $is_float_digit          = FALSE;
                        }
                    }
                    if (($is_hex_digit && PMA_STR_isHexDigit($c2)) || ($is_digit && PMA_STR_isDigit($c2))) {
                        $count2++;
                        continue;
                    } else {
                        $is_digit     = FALSE;
                        $is_hex_digit = FALSE;
                    }

                    $count2++;
                } // end while

                $l    = $count2 - $count1;
                $str  = $GLOBALS['PMA_substr']($sql, $count1, $l);

                $type = '';
                if ($is_digit) {
                    $type     = 'digit';
                    if ($is_float_digit) {
                        $type .= '_float';
                    } else if ($is_hex_digit) {
                        $type .= '_hex';
                    } else {
                        $type .= '_integer';
                    }
                }
                else {
                    if ($is_sql_variable != FALSE) {
                        $type = 'alpha_variable';
                    } else {
                        $type = 'alpha';
                    }
                } // end if... else....
                PMA_SQP_arrayAdd($sql_array, $type, $str, $arraysize);

                continue;
            }

            // DEBUG
            $count2++;

            $debugstr = 'C1 C2 LEN: ' . $count1 . ' ' . $count2 . ' ' . $len .  "\n"
                      . 'STR: ' . $GLOBALS['PMA_substr']($sql, $count1, $count2 - $count1) . "\n";
            PMA_SQP_bug($debugstr, $sql);
            return $sql;

        } // end while ($count2 < $len)


        if ($arraysize > 0) {
          $t_next     = $sql_array[0]['type'];
          $t_prev     = '';
          $t_cur      = '';
        }

        for ($i = 0; $i < $arraysize; $i++) {
          $t_prev     = $t_cur;
          $t_cur      = $t_next;
          if (($i + 1) < $arraysize) {
            $t_next = $sql_array[$i + 1]['type'];
          } else {
            $t_next = '';
          }
          if ($t_cur == 'alpha') {
            $t_suffix     = '_identifier';
            $d_cur_upper  = strtoupper($sql_array[$i]['data']);
            if (($t_next == 'punct_qualifier') || ($t_prev == 'punct_qualifier')) {
              $t_suffix = '_identifier';
            } else if (($t_next == 'punct_bracket_open_round')
            && PMA_STR_binarySearchInArr($d_cur_upper, $PMA_SQPdata_function_name, $PMA_SQPdata_function_name_cnt)) {
              $t_suffix = '_functionName';
            } else if (PMA_STR_binarySearchInArr($d_cur_upper, $PMA_SQPdata_column_type, $PMA_SQPdata_column_type_cnt))  {
              $t_suffix = '_columnType';
                  // Temporary fix for BUG #621357
              //TODO FIX PROPERLY NEEDS OVERHAUL OF SQL TOKENIZER
              if($d_cur_upper == 'SET' && $t_next != 'punct_bracket_open_round') {
                $t_suffix = '_reservedWord';
              }
              //END OF TEMPORARY FIX
            } else if (PMA_STR_binarySearchInArr($d_cur_upper, $PMA_SQPdata_reserved_word, $PMA_SQPdata_reserved_word_cnt)) {
              $t_suffix = '_reservedWord';
            } else if (PMA_STR_binarySearchInArr($d_cur_upper, $PMA_SQPdata_column_attrib, $PMA_SQPdata_column_attrib_cnt)) {
              $t_suffix = '_columnAttrib';
            } else {
              // Do nothing
            }
            $sql_array[$i]['type'] .= $t_suffix;
          }
        } // end for

        // Stores the size of the array inside the array, as count() is a slow
        // operation.
        $sql_array['len'] = $arraysize;

        // Sends the data back
        return $sql_array;
    } // end of the "PMA_SQP_parse()" function


    /**
     * Analyzes SQL queries
     *
     * @param  array   The SQL queries
     *
     * @return array   The analyzed SQL queries
     *
     * @access public
     */
    function PMA_SQP_analyze($arr)
    {
        $result          = array();
        $size            = $arr['len'];
        $subresult       = array(
            'querytype'      => '',
            'select_expr'    => array(),
            'table_ref'      => array()
        );
        $subresult_empty = $subresult;
        $seek_queryend   = FALSE;

/* Description of analyzer results
 *
 * lem9: db, table, column, alias
 *      ------------------------
 *
 * Inside the $subresult array, we create ['select_expr'] and ['table_ref'] arrays.
 *
 * The SELECT syntax (simplified) is
 *
 * SELECT 
 *    select_expression,...
 *    [FROM [table_references]
 *
 *
 * ['select_expr'] is filled with each expression, the key represents the 
 * expression position in the list (0-based) (so we don't lose track of 
 * multiple occurences of the same column).
 *
 * ['table_ref'] is filled with each table ref, same thing for the key.
 *
 * I create all sub-values empty, even if they are
 * not present (for example no select_expression alias).
 *
 * There is a debug section at the end of the main loop, if you want to
 * see the exact contents of select_expr and table_ref
 */
        // must be sorted
        // TODO: current logic checks for only one word, so I put only the
        // first word of the reserved expressions that end a table ref;
        // maybe this is not ok (the first word might mean something else)
//        $words_ending_table_ref = array(
//            'FOR UPDATE',
//            'GROUP BY',
//            'HAVING',
//            'LIMIT',
//            'LOCK IN SHARE MODE',
//            'ORDER BY',
//            'PROCEDURE',
//            'WHERE'
//        );
        $words_ending_table_ref = array(
            'FOR',
            'GROUP',
            'HAVING',
            'LIMIT',
            'LOCK',
            'ORDER',
            'PROCEDURE',
            'WHERE'
        );
        $words_ending_table_ref_cnt = count($words_ending_table_ref);

        // must be sorted
        $supported_query_types = array(
            'SELECT'
            /*
            // Support for these additional query types will come later on.
            'DELETE',
            'INSERT',
            'REPLACE',
            'TRUNCATE',
            'UPDATE'
            'EXPLAIN',
            'DESCRIBE',
            'SHOW',
            'CREATE',
            'SET',
            'ALTER'
            */
        );
        $supported_query_types_cnt = count($supported_query_types);

        // main loop for each token

        for ($i = 0; $i < $size; $i++) {
//echo "trace <b>"  . $arr[$i]['data'] . "</b> (" . $arr[$i]['type'] . ")<br>";

            // High speed seek for locating the end of the current query
            if ($seek_queryend == TRUE) {
                if ($arr[$i]['type'] == 'punct_queryend') {
                    $seek_queryend = FALSE;
                } else {
                    continue;
                } // end if (type == punct_queryend)
            } // end if ($seek_queryend)

            if ($arr[$i]['type'] == 'punct_queryend') {
                $result[]  = $subresult;
                $subresult = $subresult_empty;
                continue;
            } // end if (type == punct_queryend)

            if ($arr[$i]['type'] == 'alpha_reservedWord') {
                // We don't know what type of query yet, so run this
                if ($subresult['querytype'] == '') {
                    $subresult['querytype'] = strtoupper($arr[$i]['data']);
                } // end if (querytype was empty)

                // Check if we support this type of query
                if (!PMA_STR_binarySearchInArr($subresult['querytype'], $supported_query_types, $supported_query_types_cnt)) {
                    // Skip ahead to the next one if we don't
                    $seek_queryend = TRUE;
                    continue; 
                } // end if (query not supported)

                // upper once
                $upper_data = strtoupper($arr[$i]['data']);
                //TODO: reset for each query?

                if ($upper_data == 'SELECT') {
                    $seen_from = FALSE;
                    $previous_was_identifier = FALSE;
                    $current_select_expr = -1;
                    $seen_end_of_table_ref = FALSE;
                    //$save_table_ref = TRUE;
                } // end if ( data == SELECT)

                if ($upper_data =='FROM') {
                    $current_table_ref = -1;
                    $seen_from = TRUE;
                    $previous_was_identifier = FALSE;
                    $save_table_ref = TRUE;
                } // end if (data == FROM)

                // here, do not 'continue' the loop, as we have more work for 
                // reserved words below 
            } // end if (type == alpha_reservedWord)

// ==============================
            if (($arr[$i]['type'] == 'quote_backtick')
             || ($arr[$i]['type'] == 'quote_double')
             || ($arr[$i]['type'] == 'quote_single')
             || ($arr[$i]['type'] == 'alpha_identifier')) {

                switch ($arr[$i]['type']) {
                    case 'alpha_identifier':
                        $identifier = $arr[$i]['data'];
                        break;
                    
                //TODO: check embedded double quotes or backticks?
                // and/or remove just the first and last character?
                    case 'quote_backtick':
                        $identifier = str_replace('`','',$arr[$i]['data']);
                        break;
                    case 'quote_double':
                        $identifier = str_replace('"','',$arr[$i]['data']);
                        break;                    
                    case 'quote_single':
                        $identifier = str_replace("'","",$arr[$i]['data']);
                        break;
                } // end switch
                         
                if ($subresult['querytype'] == 'SELECT') {
                    if (!$seen_from) {
                        if ($previous_was_identifier) {
                            // found alias for this select_expr, save it
                            $alias_for_select_expr = $identifier;
                        } else {
                            $chain[] = $identifier;
                            $previous_was_identifier = TRUE;

                        } // end if !$previous_was_identifier
                    } else {
                        // ($seen_from) 
                        if ($save_table_ref && !$seen_end_of_table_ref) {
                            if ($previous_was_identifier) {
                                // found alias for table ref
                                // save it for later
                                $alias_for_table_ref = $identifier;
                            } else {
                                $chain[] = $identifier;
                                $previous_was_identifier = TRUE;

                            } // end if ($previous_was_identifier)
                        } // end if ($save_table_ref &&!$seen_end_of_table_ref)
                    } // end if (!$seen_from)
                } // end if (querytype SELECT)
            } // end if ( quote_backtick or double quote or alpha_identifier)

// ===================================
            if ($arr[$i]['type'] == 'punct_qualifier') {
                // to be able to detect an identifier following another
                $previous_was_identifier = FALSE;
                continue;
            } // end if (punct_qualifier)

            // TODO: check if 3 identifiers following one another -> error

            //    s a v e    a    s e l e c t    e x p r
            // finding a list separator or FROM
            // means that we must save the current chain of identifiers
            // into a select expression

            // for now, we only save a select expression if it contains
            // at least one identifier, as we are interested in checking
            // the columns and table names, so in "select * from persons",
            // the "*" is not saved

            if (isset($chain) && !$seen_end_of_table_ref
               && (   (!$seen_from
                   && $arr[$i]['type'] == 'punct_listsep')
                  || ($arr[$i]['type'] == 'alpha_reservedWord' && $upper_data == 'FROM')) ) {
                $size_chain = count($chain);
                $current_select_expr++;
                $subresult['select_expr'][$current_select_expr] = array(
                  'expr' => '',
                  'alias' => '',
                  'db'   => '',
                  'table_name' => '',
                  'table_true_name' => '',
                  'column' => ''       
                 );

                if (!empty($alias_for_select_expr)) {
                    // we had found an alias for this select expression
                    $subresult['select_expr'][$current_select_expr]['alias'] = $alias_for_select_expr;
                    unset($alias_for_select_expr);
                }
                // there is at least a column
                $subresult['select_expr'][$current_select_expr]['column'] = $chain[$size_chain - 1];
                $subresult['select_expr'][$current_select_expr]['expr'] = $chain[$size_chain - 1];
       
                // maybe a table
                if ($size_chain > 1) {
                    $subresult['select_expr'][$current_select_expr]['table_name'] = $chain[$size_chain - 2];
                    // we assume for now that this is also the true name
                    $subresult['select_expr'][$current_select_expr]['table_true_name'] = $chain[$size_chain - 2];
                    $subresult['select_expr'][$current_select_expr]['expr'] 
                     = $subresult['select_expr'][$current_select_expr]['table_name']
                      . '.' . $subresult['select_expr'][$current_select_expr]['expr']; 
                } // end if ($size_chain > 1)

                // maybe a db
                if ($size_chain > 2) {
                    $subresult['select_expr'][$current_select_expr]['db'] = $chain[$size_chain - 3];
                    $subresult['select_expr'][$current_select_expr]['expr'] 
                     = $subresult['select_expr'][$current_select_expr]['db']
                      . '.' . $subresult['select_expr'][$current_select_expr]['expr']; 
                } // end if ($size_chain > 2)
                unset($chain);
   
                // TODO: explain this:
                if (($arr[$i]['type'] == 'alpha_reservedWord')
                 && ($upper_data != 'FROM')) {
                    $previous_was_identifier = TRUE;
                }

            } // end if (save a select expr)


//=========================
            //    s a v e    a    t a b l e    r e f
            // maybe we just saw the end of table refs
            // but the last table ref has to be saved
            // or we are at the last token (TODO: there could be another 
            // query after this one)
            // or we just got a reserved word

            if (isset($chain) && $seen_from && $save_table_ref
             && ($arr[$i]['type'] == 'punct_listsep'
               || ($arr[$i]['type'] == 'alpha_reservedWord' && $upper_data!="AS")
               || $seen_end_of_table_ref 
               || $i==$size-1 )) {

                $size_chain = count($chain);
                $current_table_ref++;
                $subresult['table_ref'][$current_table_ref] = array(
                  'expr'            => '',
                  'db'              => '',
                  'table_name'      => '',
                  'table_alias'     => '',
                  'table_true_name' => ''
                 );
                if (!empty($alias_for_table_ref)) {
                    $subresult['table_ref'][$current_table_ref]['table_alias'] = $alias_for_table_ref;
                    unset($alias_for_table_ref);
                }
                $subresult['table_ref'][$current_table_ref]['table_name'] = $chain[$size_chain - 1];
                // we assume for now that this is also the true name
                $subresult['table_ref'][$current_table_ref]['table_true_name'] = $chain[$size_chain - 1];
                $subresult['table_ref'][$current_table_ref]['expr'] 
                     = $subresult['table_ref'][$current_table_ref]['table_name'];
                // maybe a db
                if ($size_chain > 1) {
                    $subresult['table_ref'][$current_table_ref]['db'] = $chain[$size_chain - 2];
                    $subresult['table_ref'][$current_table_ref]['expr'] 
                     = $subresult['table_ref'][$current_table_ref]['db']
                      . '.' . $subresult['table_ref'][$current_table_ref]['expr']; 
                } // end if ($size_chain > 1)

                unset($chain);
                $previous_was_identifier = TRUE;
                //continue;

            } // end if (save a table ref)


            // when we have found all table refs, 
            // for each table_ref alias, put the true name of the table
            // in the corresponding select expressions

            if (isset($current_table_ref) && ($seen_end_of_table_ref || $i == $size-1)) {
                for ($tr=0; $tr <= $current_table_ref; $tr++) {
                    $alias = $subresult['table_ref'][$tr]['table_alias'];
                    $truename = $subresult['table_ref'][$tr]['table_true_name'];
                    for ($se=0; $se <= $current_select_expr; $se++) {
                        if (!empty($alias) && $subresult['select_expr'][$se]['table_true_name']
                           == $alias) {
                            $subresult['select_expr'][$se]['table_true_name']
                             = $truename; 
                        } // end if (found the alias)
                    } // end for (select expressions)

                } // end for (table refs)
            } // end if (set the true names)


           // e n d    o f    l o o p
           // set the $previous_was_identifier to FALSE if the current
           // token is not an identifier
           if (($arr[$i]['type'] != 'alpha_identifier')
            && ($arr[$i]['type'] != 'quote_double')
            && ($arr[$i]['type'] != 'quote_single')
            && ($arr[$i]['type'] != 'quote_backtick')) {
               $previous_was_identifier = FALSE;
           } // end if

           // however, if we are on AS, we must keep the $previous_was_identifier
           if (($arr[$i]['type'] == 'alpha_reservedWord')
            && ($upper_data == 'AS'))  {
               $previous_was_identifier = TRUE;
           }

           if (($arr[$i]['type'] == 'alpha_reservedWord')
            && ($upper_data =='ON' || $upper_data =='USING')) {
               $save_table_ref = FALSE;
           } // end if (data == ON)

           if (($arr[$i]['type'] == 'alpha_reservedWord')
            && ($upper_data =='JOIN' || $upper_data =='FROM')) {
               $save_table_ref = TRUE;
           } // end if (data == JOIN)

           // no need to check the end of table ref if we already did
           // TODO: maybe add "&& $seen_from"
           if (!$seen_end_of_table_ref) {
               // if this is the last token, it implies that we have
               // seen the end of table references
               // Check for the end of table references
               if (($i == $size-1)
               || ($arr[$i]['type'] == 'alpha_reservedWord'
                  && PMA_STR_binarySearchInArr($upper_data, $words_ending_table_ref, $words_ending_table_ref_cnt))) {
                   $seen_end_of_table_ref = TRUE;

                   // to be able to save the last table ref, but do not
                   // set it true if we found a word like "ON" that has
                   // already set it to false
                   if (isset($save_table_ref) && $save_table_ref != FALSE) {
                      $save_table_ref = TRUE;
                   } //end if

               } // end if (check for end of table ref)
           } //end if (!$seen_end_of_table_ref)

           if ($seen_end_of_table_ref) {
               $save_table_ref = FALSE;
           } // end if


        } // end for $i (main loop)

        // -------------------------------------------------------
        // This is a big hunk of debugging code by Marc for this.
        // -------------------------------------------------------
        /* 
           for ($trace=0; $trace<=$current_select_expr; $trace++) {

           echo "<br>";
           reset ($subresult['select_expr'][$trace]);
           while (list ($key, $val) = each ($subresult['select_expr'][$trace])) 
           echo "sel expr $trace $key => $val<br />\n";
           }
           for ($trace=0; $trace<=$current_table_ref; $trace++) {

           echo "<br>";
           reset ($subresult['table_ref'][$trace]);
           while (list ($key, $val) = each ($subresult['table_ref'][$trace])) 
           echo "table ref $trace $key => $val<br />\n";
           }
        */ 
        // -------------------------------------------------------

        // They are naughty and didn't have a trailing semi-colon,
        // then still handle it properly
        if ($subresult['querytype'] != '') {
            $result[] = $subresult;
        }
        return $result;
    } // end of the "PMA_SQP_analyze()" function


    /**
     * Colorizes SQL queries html formatted
     *
     * @param  array   The SQL queries html formatted
     *
     * @return array   The colorized SQL queries
     *
     * @access public
     */
    function PMA_SQP_formatHtml_colorize($arr)
    {
        $i         = $GLOBALS['PMA_strpos']($arr['type'], '_');
        $class     = '';
        if ($i > 0) {
            $class = 'syntax_' . $GLOBALS['PMA_substr']($arr['type'], 0, $i) . ' ';
        }

        $class     .= 'syntax_' . $arr['type'];

        //TODO: check why adding a "\n" after the </span> would cause extra 
        //      blanks to be displayed:
        //      SELECT p . person_name

        return '<span class="' . $class . '">' . htmlspecialchars($arr['data']) . '</span>';
    } // end of the "PMA_SQP_formatHtml_colorize()" function


    /**
     * Formats SQL queries to html
     *
     * @param  array   The SQL queries
     *
     * @return string  The formatted SQL queries
     *
     * @access public
     */
    function PMA_SQP_formatHtml($arr, $mode='color')
    {
        switch ($mode) {
            case 'color':
                $str                                = '<span class="syntax">';
                $html_line_break                    = '<br />';
                break;
            case 'query_only':
                $str                                = '';
                $html_line_break                    = ' ';
                break;
            case 'text':
                $str                                = '';
                $html_line_break                    = '<br />';
                break;
        } // end switch
        $indent                                     = 0;
        $bracketlevel                               = 0;
        $functionlevel                              = 0;
        $infunction                                 = FALSE;
        $space_punct_listsep                        = ' ';
        $space_punct_listsep_function_name          = ' ';
        // $space_alpha_reserved_word = '<br />'."\n";
        $space_alpha_reserved_word                  = ' ';

        $keywords_with_brackets_1before            = array(
            'INDEX',
            'KEY',
            'ON',
            'USING'
        );
        $keywords_with_brackets_1before_cnt        = 4;

        $keywords_with_brackets_2before            = array(
            'IGNORE',
            'INDEX',
            'INTO',
            'KEY',
            'PRIMARY',
            'PROCEDURE',
            'REFERENCES',
            'UNIQUE',
            'USE'
        );
        // $keywords_with_brackets_2before_cnt = count($keywords_with_brackets_2before);
        $keywords_with_brackets_2before_cnt        = 9;

        // These reserved words do NOT get a newline placed near them.
        $keywords_no_newline               = array(
            'AND',
            'AS',
            'ASC',
            'DESC',
            'IS',
            'NOT',
            'NULL',
            'ON',
            'OR'
        );
        $keywords_no_newline_cnt           = 9;

        $arraysize = $arr['len'];
        $typearr   = array();
        if ($arraysize >= 0) {
            $typearr[0] = '';
            $typearr[1] = '';
            $typearr[2] = '';
            $typearr[3] = $arr[0]['type'];
        }

        for ($i = 0; $i < $arraysize; $i++) {
            //DEBUG echo "<b>" . $arr[$i]['data'] . "</b> " . $arr[$i]['type'] . "<br />";
            $before = '';
            $after  = '';
            $indent = 0;
            // array_shift($typearr);
            /*
            0 prev2
            1 prev
            2 current
            3 next
            */
            if (($i + 1) < $arraysize) {
                // array_push($typearr, $arr[$i + 1]['type']);
                $typearr[4] = $arr[$i + 1]['type'];
            } else {
                //array_push($typearr, NULL);
                $typearr[4] = '';
            }

            for ($j=0; $j<4; $j++) {
                $typearr[$j] = $typearr[$j + 1];
            }

            switch ($typearr[2]) {
                case 'white_newline':
//                    $after      = '<br />';
                    $before     = '';
                    break;
                case 'punct_bracket_open_round':
                    $bracketlevel++;
                    $infunction = FALSE;
                    // Make sure this array is sorted!
                    if (($typearr[1] == 'alpha_functionName') || ($typearr[1] == 'alpha_columnType') || ($typearr[1] == 'punct')
                        || ($typearr[3] == 'digit_integer') || ($typearr[3] == 'digit_hex') || ($typearr[3] == 'digit_float')
                        || (($typearr[0] == 'alpha_reservedWord')
                            && PMA_STR_binarySearchInArr(strtoupper($arr[$i - 2]['data']), $keywords_with_brackets_2before, $keywords_with_brackets_2before_cnt))
                        || (($typearr[1] == 'alpha_reservedWord')
                            && PMA_STR_binarySearchInArr(strtoupper($arr[$i - 1]['data']), $keywords_with_brackets_1before, $keywords_with_brackets_1before_cnt))
                        ) {
                        $functionlevel++;
                        $infunction = TRUE;
                        $after      .= ' ';
                    } else {
                        $indent++;
                        $after      .= ($mode != 'query_only' ? '<div class="syntax_indent' . $indent . '">' : ' ');
                    }
                    break;
                case 'alpha_identifier':
                    if (($typearr[1] == 'punct_qualifier') || ($typearr[3] == 'punct_qualifier')) {
                        $after      = '';
                        $before     = '';
                    }
                    if (($typearr[3] == 'alpha_columnType') || ($typearr[3] == 'alpha_identifier')) {
                        $after      .= ' ';
                    }
                    break;
                case 'punct_qualifier':
                    $before         = '';
                    $after          = '';
                    break;
                case 'punct_listsep':
                    if ($infunction == TRUE) {
                        $after      .= $space_punct_listsep_function_name;
                    } else {
                        $after      .= $space_punct_listsep;
                    }
                    break;
                case 'punct_queryend':
                    if (($typearr[3] != 'comment_mysql') && ($typearr[3] != 'comment_ansi')) {
                        $after     .= $html_line_break;
                        $after     .= $html_line_break;
                    }
                    $space_punct_listsep               = ' ';
                    $space_punct_listsep_function_name = ' ';
                    $space_alpha_reserved_word         = ' ';
                    break;
                case 'comment_mysql':
                case 'comment_ansi':
                    $after         .= $html_line_break;
                    break;
                case 'punct':
                    $after         .= ' ';
                    $before        .= ' ';
                    break;
                case 'punct_bracket_close_round':
                    $bracketlevel--;
                    if ($infunction == TRUE) {
                        $functionlevel--;
                        $after     .= ' ';
                        $before    .= ' ';
                    } else {
                        $indent--;
                        $before    .= ($mode != 'query_only' ? '</div>' : ' ');
                    }
                    $infunction    = ($functionlevel > 0) ? TRUE : FALSE;
                    break;
                case 'alpha_columnType':
                    if ($typearr[3] == 'alpha_columnAttrib') {
                        $after     .= ' ';
                    }
                    if ($typearr[1] == 'alpha_columnType') {
                        $before    .= ' ';
                    }
                    break;
                case 'alpha_columnAttrib':
                    if (($typearr[3] == 'alpha_columnAttrib') || ($typearr[3] == 'quote_single')) {
                        $after     .= ' ';
                    }
                    break;
                case 'alpha_reservedWord':
                    //$upper         = $arr[$i]['data'];
                    $arr[$i]['data'] = strtoupper($arr[$i]['data']);
                    if ((($typearr[1] != 'alpha_reservedWord')
                        || (($typearr[1] == 'alpha_reservedWord')
                            && PMA_STR_binarySearchInArr(strtoupper($arr[$i - 1]['data']), $keywords_no_newline, $keywords_no_newline_cnt)))
                        && ($typearr[1] != 'punct_level_plus')
                        && (!PMA_STR_binarySearchInArr($arr[$i]['data'], $keywords_no_newline, $keywords_no_newline_cnt))) {
                        // do not put a space before the first token, because
                        // we use a lot of eregi() checking for the first
                        // reserved word at beginning of query
                        if ($i > 0) {
                            $before    .= $space_alpha_reserved_word;
                        }
                    } else {
                        $before    .= ' ';
                    }

                    switch ($arr[$i]['data']) {
                        case 'CREATE':
                            $space_punct_listsep       = $html_line_break;
                            $space_alpha_reserved_word = ' ';
                            break;
                        case 'EXPLAIN':
                        case 'DESCRIBE':
                        case 'SET':
                        case 'ALTER':
                        case 'DELETE':
                        case 'SHOW':
                        case 'DROP':
                        case 'UPDATE':
                        case 'TRUNCATE':
                        case 'ANALYZE':
                        case 'ANALYSE':
                            $space_punct_listsep       = $html_line_break;
                            $space_alpha_reserved_word = ' ';
                            break;
                        case 'INSERT':
                        case 'REPLACE':
                            $space_punct_listsep       = $html_line_break;
                            $space_alpha_reserved_word = $html_line_break;
                            break;
                        case 'VALUES':
                            $space_punct_listsep       = ' ';
                            $space_alpha_reserved_word = $html_line_break;
                            break;
                        case 'SELECT':
                            $space_punct_listsep       = ' ';
                            $space_alpha_reserved_word = $html_line_break;
                            break;
                        default:
                            break;
                    } // end switch ($arr[$i]['data'])

                    $after         .= ' ';
                    break;
                case 'digit_integer':
                case 'digit_float':
                case 'digit_hex':
                    if ($infunction && $typearr[3] == 'punct_bracket_close_round') {
                        $after     .= ' ';
                    }
                    break;
                case 'quote_double':
                case 'quote_single':
                    // workaround: for the query
                    // REVOKE SELECT ON `base2\_db`.* FROM 'user'@'%'
                    // the @ is incorrectly marked as alpha_variable
                    // in the parser, and here, the '%' gets a blank before,
                    // which is a syntax error
                    if ($typearr[1]!='alpha_variable') {
                        $before        .= ' ';
                    }
                    if ($infunction && $typearr[3] == 'punct_bracket_close_round') {
                        $after     .= ' ';
                    }
                    break;
                case 'quote_backtick':
                    if ($typearr[3] != 'punct_qualifier') {
                        $after     .= ' ';
                    }
                    if ($typearr[1] != 'punct_qualifier') {
                        $before    .= ' ';
                    }
                    break;
                default:
                    break;
            } // end switch ($typearr[2])

/*
            if ($typearr[3] != 'punct_qualifier') {
                $after             .= ' ';
            }
            $after                 .= "\n";
*/
            $str .= $before . ($mode=='color' ? PMA_SQP_formatHTML_colorize($arr[$i]) : $arr[$i]['data']). $after;
        } // end for
        if ($mode=='color') {
            $str .= '</span>';
        }

        return $str;
    } // end of the "PMA_SQP_formatHtml()" function


    /**
     * Builds a CSS rule used for html formatted SQL queries
     *
     * @param  string  The class name
     * @param  string  The property name
     * @param  string  The property value
     *
     * @return string  The CSS rule
     *
     * @access public
     *
     * @see    PMA_SQP_buildCssData()
     */
    function PMA_SQP_buildCssRule($classname, $property, $value)
    {
        $str     = '.' . $classname . ' {';
        if ($value != '') {
            $str .= $property . ': ' . $value . ';';
        }
        $str     .= '}' . "\n";

        return $str;
    } // end of the "PMA_SQP_buildCssRule()" function


    /**
     * Builds CSS rules used for html formatted SQL queries
     *
     * @return string  The CSS rules set
     *
     * @access public
     *
     * @global array   The current PMA configuration
     *
     * @see    PMA_SQP_buildCssRule()
     */
    function PMA_SQP_buildCssData()
    {
        global $cfg;

        $css_string     = '';
        while (list($key, $col) = each($cfg['SQP']['fmtColor'])) {
            $css_string .= PMA_SQP_buildCssRule('syntax_' . $key, 'color', $col);
        }
        for ($i = 0; $i < 8; $i++) {
            $css_string .= PMA_SQP_buildCssRule('syntax_indent' . $i, 'margin-left', ($i * $cfg['SQP']['fmtInd']) . $cfg['SQP']['fmtIndUnit']);
        }

        return $css_string;
    } // end of the "PMA_SQP_buildCssData()" function


    /**
     * Gets SQL queries with no format
     *
     * @param  array   The SQL queries list
     *
     * @return string  The SQL queries with no format
     *
     * @access public
     */
    function PMA_SQP_formatNone($arr)
    {
        $formatted_sql = htmlspecialchars($arr['raw']);
        $formatted_sql = ereg_replace("((\015\012)|(\015)|(\012)){3,}", "\n\n", $formatted_sql);

        return $formatted_sql;
    } // end of the "PMA_SQP_formatNone()" function


    /**
     * Gets SQL queries in text format
     *
     * @param  array   The SQL queries list
     *
     * @return string  The SQL queries in text format
     *
     * @access public
     */
    function PMA_SQP_formatText($arr)
    {
        /**
         * TODO WRITE THIS!
         */
         return PMA_SQP_formatNone($arr);
    } // end of the "PMA_SQP_formatText()" function

} // $__PMA_SQP_LIB__
