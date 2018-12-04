<?php
/* $Id: hindi-utf-8.inc.php,v 1.20 2002/11/28 09:15:31 rabus Exp $ */

// Hindi translation
// 1st release   :   by Girish Nair <girishn@nagpur.dot.net.in> : 08-Aug-2002
// 2nd updates   :   by Girish Nair <girishn@nagpur.dot.net.in> : 23-Aug-2002
// 3rd updates   :   by Girish Nair <girishn@nagpur.dot.net.in> : 09-Sep-2002
// 4th updates   :   by Girish Nair <girishn@nagpur.dot.net.in> : 15-Nov-2002

$charset = 'utf-8';
$allow_recoding = TRUE;
$text_dir = 'ltr'; // ('ltr' for left to right, 'rtl' for right to left)
$left_font_family = 'verdana, arial, helvetica, geneva, sans-serif';
$right_font_family = 'arial, helvetica, geneva, sans-serif';
$number_thousands_separator = ',';
$number_decimal_separator = '.';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
//$byteUnits = array('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB');
$byteUnits = array(' बैट्स', ' केबी', ' एमबी', ' जीबी','टीबी','पीबी','ईबी');

$day_of_week = array('रवी', 'सोम', 'मन्गल', 'बुध', 'गुरु', 'शुक्र', 'शनि');
$month = array('जनवरी', 'फरवरी', 'मार्च', 'अप्रैल', 'मई', 'जून', 'जुलाई', 'अगस्त', ' सितम्बर', 'अक्तूबर', 'नवम्बर', 'दिसमबर');
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%d %B, %Y को %I:%M %p';

$strAPrimaryKey = ' %s  पर एक प्राईमरी की बनाया';
$strAccessDenied = 'प्रवेश निषेध';
$strAction = ' कार्य';
$strAddNewField = 'नया फील्ड जोडो';
$strAddPriv = 'नया प्रिविलेज जोडो';
$strAddPrivMessage = 'आपने नया प्रिविलेज जोड लिया ।';
$strAddUser = 'नया यूसर बनाओ';
$strAddUserMessage = 'आपने नया यूसर बना लिया ।';
$strAfter = '%s के बाद में';
$strAfterInsertBack = 'पिछले पृष्ट पर वापस जाओ';
$strAfterInsertNewInsert = ' अगला नया रौ जोडे';
$strAll = 'सभी';
$strAlterOrderBy = ' टेबल ओरडर को बदलिये ';
$strAnIndex = ' %s पर एक इन्डेक्स बनाया';
$strAnalyzeTable = ' टेबल अनालैज करें';
$strAnd = 'और';
$strAny = 'कोई';
$strAnyColumn = 'कोई भी कोलम';
$strAnyDatabase = 'कोई भी  डाटाबेस';
$strAnyHost = 'कोई भी  होस्ट';
$strAnyTable = 'कोई भी  टेबल';
$strAnyUser = 'कोई भी  यूसर';
$strAtBeginningOfTable = ' टेबल के शुरू  में';
$strAtEndOfTable = ' टेबल के आखिर में';
$strAttr = ' विशेषता';

$strBack = 'वापस';
$strBinary = 'बइनरी';
$strBinaryDoNotEdit = 'बइनरी - एडिट मत करिये';
$strBookmarkLabel = 'लेबल';
$strBookmarkView = 'केवल देखिये';
$strBrowse = ' ब्रौस';

$strCantRenameIdxToPrimary = 'इन्डेक्स को PRIMARY नाम मे नहीं बदल सकते!';
$strChange = 'बदलिये';
$strChangePassword = 'पासव्रड बदलिये';
$strCheckAll = 'सभी को चेक करें';
$strCheckDbPriv = 'डाटाबेस   प्रिविलेजस  को चेक करें';
$strCheckTable = ' टेबल  को चेक करें';
$strChoosePage = ' एडिट करने के लिये पेज़ चुने';
$strColumn = 'कोलम';
$strColumnNames = 'कोलम के नाम';
$strComments = ' टिप्पणी';
$strCompleteInserts = 'पूरा इनसर्टस';
$strConfirm = 'क्या आप सचमुच यह करना चाहते है?';
$strCopyTable = ' (database<b>.</b>table) में टेबल को कापी करें:';
$strCopyTableOK = ' %s टेबल को %s में कापी कर दिया.';
$strCreate = 'बनाइये';
$strCreateIndex = ' &nbsp;%s&nbsp; कोलम पर इन्डेक्स बनाऐं ';
$strCreateIndexTopic = 'एक नया इन्डेक्स बनाऐं';
$strCreateNewDatabase = ' नया डाटाबेस बनाओ';
$strCreateNewTable = ' डाटाबेस मे नया टेबल बनाओ';
$strCreatePage = 'नया पेज़ बनाऐं';

$strData = ' डाटा';
$strDataOnly = 'केवल डाटा';
$strDatabase = ' डाटाबेस';
$strDatabaseHasBeenDropped = 'डाटाबेस %s को ड्रोप कर दिया ।';
$strDatabases = ' डाटाबेस';
$strDatabasesStats = ' डाटाबेसों के आँकडे';
$strDefault = 'Default';
$strDelete = 'डिलीट';
$strDeleteFailed = ' डिलीट फैल हो गया!';
$strDeleteUserMessage = 'आपने %s यूसर डिलीट कर दिया।';
$strDeleted = 'रौ को डिलीट कर दिया';
$strDeletedRows = 'रौ डिलीट किया:';
$strDisplay = ' दिखाओ';
$strDisplayFeat = 'फीचरस दिखाओ';
$strDisplayOrder = 'क्रम से दिखाओ:';
$strDisplayPDF = 'PDF schema दिखाओ';
$strDoYouReally = 'क्या आप सचमुच चाहते है की';
$strDocu = 'डोक्युमेंटेशन';
$strDrop = ' ड्रोप';
$strDropDB = ' डाटाबेस ड्रोप करे %s';
$strDropTable = ' टेबल  ड्रोप करे';

$strEdit = 'एडिट';
$strEditPDFPages = 'PDF पेज एडिट करें';
$strEditPrivileges = ' प्रिविलेज एडिट करें';
$strEffective = ' वास्तविक';
$strEmpty = 'खाली करें';
$strEnd = 'आखरी';
$strError = 'गल्ती';
$strExplain = 'SQL की   व्याख्या ';
$strExport = 'एक्सपोर्ट';
$strExportToXML = ' XML format में एक्सपोर्ट करें';
$strExtendedInserts = 'विस्तृत इनसर्टस';
$strExtra = ' अतिरिक्त';

$strField = ' फील्ड';
$strFieldHasBeenDropped = ' फील्ड %s ड्रोप कर दिया';
$strFields = ' फील्डस';
$strFlushTable = ' टेबल को Flush करें ("FLUSH")';

$strGrants = 'ग्रान्टस';

$strHome = 'होम';
$strHomepageOfficial = 'phpMyAdmin का आधिकारिक होमपेज';
$strHost = 'होस्ट';

$strInsert = 'इनसर्ट';
$strInsertNewRow = 'नया रौ इनसर्ट करिये';
$strInstructions = 'निर्देष';

$strLength = 'लंबाई';
$strLengthSet = 'लंबाई/अर्थ*';
$strLimitNumRows = 'प्रति पृष्ट कितने रौ';
$strLines = 'लाईनस';
$strLinesTerminatedBy = 'लाईन समाप्त होता है';
$strLogPassword = 'पासव्रड:';
$strLogUsername = 'यूसरनेम:';
$strLogin = 'लोगिन';
$strLogout = 'लोग औट';

$strMoveTable = ' टेबल को (database<b>.</b>table) में  मूव करें:';
$strMoveTableOK = ' %s टेबल को %s में मूव कर दिया.';
$strMySQLServerProcess = 'MySQL %pma_s1%  %pma_s3% से %pma_s2% पर चल रहा है';
$strMySQLShowProcess = 'प्रोसेस दिखाओ';
$strMySQLShowStatus = 'MySQL के runtime जानकारी  दिखाओ';
$strMySQLShowVars = 'MySQL के  system variables दिखाओ';

$strName = 'नाम';
$strNext = ' अगला';
$strNo = 'नहीं';
$strNoDatabases = 'कोइ डाटाबेस नहिं';
$strNoTablesFound = 'डाटाबेस में कोई टेबल नहीं।';
$strNoUsersFound = 'कोई यूसर नहीं।';

$strOperations = 'कार्रवाई';
$strOptimizeTable = ' टेबल को Optimize करें';
$strOptions = ' विकल्प';
$strOr = 'अथवा';

$strPdfNoTables = ' कोई टेबल नहीं';
$strPhp = 'PHP Code बनाओ';
$strPmaDocumentation = 'phpMyAdmin डोक्युमेंटेशन';
$strProperties = ' विशेषता';

$strQBE = 'क्वरी';

$strRepairTable = ' टेबल को टीक करें';
$strRevoke = 'वापस लो';
$strRevokeGrant = 'Grant वापस लो';
$strRevokeGrantMessage = 'आपने %s का Grant privilege वापस ले लिया ';
$strRevokeMessage = 'आपने %s के privileges वापस ले लिया ';
$strRevokePriv = 'Privileges वापस लो';
$strRowLength = ' रौ की लंबाई';
$strRowsFrom = 'रौ,  इस  record  से #';
$strRowsModeHorizontal = 'समतल';
$strRowsModeOptions = ' %s रूप में और %s सेल के बाद शीर्षक को दोहराईये';
$strRowsModeVertical = 'खडा';
$strRunSQLQuery = 'डाटाबेस %s में SQL query/queries चलाइये ';
$strRunning = ' %s पर चल रहा है';

$strSearch = 'सर्च';
$strSearchFormTitle = 'डाटाबेस में सर्च करें';
$strSearchInTables = ' टेबल में:';
$strSearchNeedle = 'शब्द अथवा वेल्यु जिसे सर्च करना है (wildcard: "%"):';
$strSearchOption1 = 'कोई भी एक शब्द';
$strSearchOption2 = 'सभी शब्द';
$strSearchOption3 = 'यथार्थ वाक्यांश';
$strSearchResultsFor = '"<i>%s</i>" %s के लिये सर्च के परिणाम :';
$strSearchType = 'खोजो:';
$strSelect = 'चुनिये';
$strSelectADb = 'कृपया एक डाटाबेस चुनिये ';
$strSelectAll = ' सभी को सेल्कट करें';
$strSelectTables = ' टेबल चुनिये';
$strSend = 'फाईल मे सेव करें';
$strServerChoice = 'Server चुनिये';
$strShow = 'दिखाओ';
$strShowAll = 'सभी दिखाओ';
$strShowColor = 'रंगीन दिखाओ';
$strShowCols = 'कोलम दिखाओ';
$strShowGrid = 'grid दिखाओ';
$strShowPHPInfo = 'PHP कि जानकारी  दिखाओ';
$strShowTableDimension = ' टेबल के परिमाण दिखाओ';
$strShowTables = ' टेबल दिखाओ';
$strShowThisQuery = ' यह query वापस यहीं दिखायें ';
$strShowingRecords = 'रौ देखिये';
$strSplitWordsWithSpace = 'शब्दों में space (" ")  से अंतर करें.';
$strStrucData = 'संरचना और डाटा';
$strStrucOnly = 'केवल संरचना';
$strStructure = 'संरचना';
$strSuccess = 'आपकी SQL-query सफलता से पूरा किया';
$strSum = 'जोड';

$strTable = '  टेबल ';
$strTableComments = ' टेबल  की टिप्पणि';
$strTableEmpty = ' टेबल का नाम खाली है!';
$strTableHasBeenDropped = ' टेबल %s को ड्रोप किया';
$strTableHasBeenEmptied = ' टेबल %s को खाली किया';
$strTableHasBeenFlushed = ' टेबल %s को flush किया';
$strTableMaintenance = ' टेबल  रख-रखाव';
$strTableType = ' टेबल के प्रकार';
$strTables = ' %s  टेबल(s)';
$strTotal = ' कुल';
$strType = ' प्रकार';

$strUncheckAll = ' सभी को अनचेक करें';
$strUnselectAll = ' सभी को अनसेल्कट करें';
$strUpdatePrivMessage = 'आपने %s के प्रिविलेज अपडेट कर दिया ।';
$strUpdateProfile = 'प्रोफाइल अपडेट करो:';
$strUpdateProfileMessage = 'प्रोफाइल अपडेट कर दिया ।';
$strUpdateQuery = ' क्वरी अपडेट करो';
$strUsage = 'उपयोग';
$strUseBackquotes = ' टेबल और फील्ड के नाम को backquotes से Enclose करें';
$strUseTables = ' टेबल का उपयोग करो';
$strUser = 'यूसर';
$strUserEmpty = 'यूसरनेम खाली है!';
$strUserName = 'यूसर नेम';
$strUsers = 'यूसरस';

$strValue = 'मूल्य';

$strWelcome = ' %s मे स्वागत है';
$strWithChecked = 'चुने हुओं को:';
$strWrongUser = 'यूसरनेम/पासवर्ड गलत है।  Access denied.';

$strYes = 'हाँ ';

// To translate

$strAddDeleteColumn = 'Add/Delete Field Columns'; //to translate
$strAddDeleteRow = 'Add/Delete Criteria Row'; //to translate
$strAddSearchConditions = 'Add search conditions (body of the "where" clause):'; //to translate
$strAddToIndex = 'Add to index &nbsp;%s&nbsp;column(s)'; //to translate
$strAffectedRows = 'Affected rows:'; //to translate
$strAllTableSameWidth = 'display all Tables with same width?'; //to translate
$strAscending = 'Ascending'; //to translate

$strBeginCut = 'BEGIN CUT'; //to translate
$strBeginRaw = 'BEGIN RAW'; //to translate
$strBookmarkDeleted = 'The bookmark has been deleted.'; //to translate
$strBookmarkQuery = 'Bookmarked SQL-query'; //to translate
$strBookmarkThis = 'Bookmark this SQL-query'; //to translate
$strBzip = '"bzipped"'; //to translate

$strCantLoadMySQL = 'cannot load MySQL extension,<br />please check PHP Configuration.'; //to translate
$strCantLoadRecodeIconv = 'Can not load iconv or recode extension needed for charset conversion, configure php to allow using these extensions or disable charset conversion in phpMyAdmin.'; //to translate
$strCantUseRecodeIconv = 'Can not use iconv nor libiconv nor recode_string function while extension reports to be loaded. Check your php configuration.'; //to translate
$strCardinality = 'Cardinality'; //to translate
$strCarriage = 'Carriage return: \\r'; //to translate
$strChangeDisplay = 'Choose Field to display'; //to translate
$strCharsetOfFile = 'Character set of the file:'; //to translate
$strColComFeat = 'Displaying Column Comments'; //to translate
$strCompression = 'Compression'; //to translate
$strConfigFileError = 'phpMyAdmin was unable to read your configuration file!<br />This might happen if php finds a parse error in it or php cannot find the file.<br />Please call the configuration file directly using the link below and read the php error message(s) that you recieve. In most cases a quote or a semicolon is missing somewhere.<br />If you recieve a blank page, everything is fine.'; //to translate
$strConfigureTableCoord = 'Please configure the coordinates for table %s'; //to translate
$strCookiesRequired = 'Cookies must be enabled past this point.'; //to translate
$strCreatePdfFeat = 'Creation of PDFs'; //to translate
$strCriteria = 'Criteria'; //to translate

$strDataDict = 'Data Dictionary';  //to translate
$strDatabaseWildcard = 'Database (wildcards allowed):'; //to translate
$strDescending = 'Descending'; //to translate
$strDisabled = 'Disabled'; //to translate
$strDoAQuery = 'Do a "query by example" (wildcard: "%")'; //to translate
$strDumpXRows = 'Dump %s row(s) starting at record # %s.'; //to translate
$strDumpingData = 'Dumping data for table'; //to translate
$strDynamic = 'dynamic'; //to translate

$strEmptyResultSet = 'MySQL returned an empty result set (i.e. zero rows).'; //to translate
$strEnabled = 'Enabled'; //to translate
$strEndCut = 'END CUT'; //to translate
$strEndRaw = 'END RAW'; //to translate
$strEnglishPrivileges = ' Note: MySQL privilege names are expressed in English '; //to translate

$strFieldsEmpty = ' The field count is empty! '; //to translate
$strFieldsEnclosedBy = 'Fields enclosed by'; //to translate
$strFieldsEscapedBy = 'Fields escaped by'; //to translate
$strFieldsTerminatedBy = 'Fields terminated by'; //to translate
$strFixed = 'fixed'; //to translate
$strFormEmpty = 'Missing value in the form !'; //to translate
$strFormat = 'Format'; //to translate
$strFullText = 'Full Texts'; //to translate
$strFunction = 'Function'; //to translate

$strGenBy = 'Generated by'; //to translate
$strGenTime = 'Generation Time'; //to translate
$strGeneralRelationFeat = 'General relation features'; //to translate
$strGo = 'Go'; //to translate
$strGzip = '"gzipped"'; //to translate

$strHasBeenAltered = 'has been altered.'; //to translate
$strHasBeenCreated = 'has been created.'; //to translate
$strHaveToShow = 'You have to choose at least one Column to display'; //to translate
$strHomepageSourceforge = 'Sourceforge phpMyAdmin Download Page'; //to translate
$strHostEmpty = 'The host name is empty!'; //to translate

$strIdxFulltext = 'Fulltext'; //to translate
$strIfYouWish = 'If you wish to load only some of a table\'s columns, specify a comma separated field list.'; //to translate
$strIgnore = 'Ignore'; //to translate
$strImportDocSQL = 'Import docSQL Files';  //to translate
$strInUse = 'in use'; //to translate
$strIndex = 'Index'; //to translate
$strIndexHasBeenDropped = 'Index %s has been dropped'; //to translate
$strIndexName = 'Index name&nbsp;:'; //to translate
$strIndexType = 'Index type&nbsp;:'; //to translate
$strIndexes = 'Indexes'; //to translate
$strInsecureMySQL = 'Your configuration file contains settings (root with no password) that correspond to the default MySQL privileged account. Your MySQL server is running with this default, is open to intrusion, and you really should fix this security hole.';  //to translate
$strInsertAsNewRow = 'Insert as a new row'; //to translate
$strInsertTextfiles = 'Insert data from a textfile into table'; //to translate
$strInsertedRows = 'Inserted rows:'; //to translate
$strInvalidName = '"%s" is a reserved word, you can\'t use it as a database/table/field name.'; //to translate

$strKeepPass = 'Do not change the password'; //to translate
$strKeyname = 'Keyname'; //to translate
$strKill = 'Kill'; //to translate

$strLineFeed = 'Linefeed: \\n'; //to translate
$strLinkNotFound = 'Link not found'; //to translate
$strLinksTo = 'Links to'; //to translate
$strLocationTextfile = 'Location of the textfile'; //to translate

$strMissingBracket = 'Missing Bracket'; //to translate
$strModifications = 'Modifications have been saved'; //to translate
$strModify = 'Modify'; //to translate
$strModifyIndexTopic = 'Modify an index'; //to translate
$strMySQLCharset = 'MySQL charset'; //to translate
$strMySQLReloaded = 'MySQL reloaded.'; //to translate
$strMySQLSaid = 'MySQL said: '; //to translate

$strNoDescription = 'no Description'; //to translate
$strNoDropDatabases = '"DROP DATABASE" statements are disabled.'; //to translate
$strNoExplain = 'Skip Explain SQL'; //to translate
$strNoFrames = 'phpMyAdmin is more friendly with a <b>frames-capable</b> browser.'; //to translate
$strNoIndex = 'No index defined!'; //to translate
$strNoIndexPartsDefined = 'No index parts defined!'; //to translate
$strNoModification = 'No change'; //to translate
$strNoPassword = 'No Password'; //to translate
$strNoPhp = 'Without PHP Code'; //to translate
$strNoPrivileges = 'No Privileges'; //to translate
$strNoQuery = 'No SQL query!'; //to translate
$strNoRights = 'You don\'t have enough rights to be here right now!'; //to translate
$strNoValidateSQL = 'Skip Validate SQL'; //to translate
$strNone = 'None'; //to translate
$strNotNumber = 'This is not a number!'; //to translate
$strNotOK = 'not OK'; //to translate
$strNotSet = '<b>%s</b> table not found or not set in %s'; //to translate
$strNotValidNumber = ' is not a valid row number!'; //to translate
$strNull = 'Null'; //to translate
$strNumSearchResultsInTable = '%s match(es) inside table <i>%s</i>'; //to translate
$strNumSearchResultsTotal = '<b>Total:</b> <i>%s</i> match(es)'; //to translate

$strOK = 'OK'; //to translate
$strOftenQuotation = 'Often quotation marks. OPTIONALLY means that only char and varchar fields are enclosed by the "enclosed by"-character.'; //to translate
$strOptionalControls = 'Optional. Controls how to write or read special characters.'; //to translate
$strOptionally = 'OPTIONALLY'; //to translate
$strOverhead = 'Overhead'; //to translate

$strPHP40203 = 'You are using PHP 4.2.3, which has a serious bug with multi-byte strings (mbstring). See PHP bug report 19404. This version of PHP is not recommended for use with phpMyAdmin.';  //to translate
$strPHPVersion = 'PHP Version'; //to translate
$strPageNumber = 'Page number:'; //to translate
$strPartialText = 'Partial Texts'; //to translate
$strPassword = 'Password'; //to translate
$strPasswordEmpty = 'The password is empty!'; //to translate
$strPasswordNotSame = 'The passwords aren\'t the same!'; //to translate
$strPdfDbSchema = 'Schema of the the "%s" database - Page %s'; //to translate
$strPdfInvalidPageNum = 'Undefined PDF page number!'; //to translate
$strPdfInvalidTblName = 'The "%s" table doesn\'t exist!'; //to translate
$strPmaUriError = 'The <tt>$cfg[\'PmaAbsoluteUri\']</tt> directive MUST be set in your configuration file!'; //to translate
$strPos1 = 'Begin'; //to translate
$strPrevious = 'Previous'; //to translate
$strPrimary = 'Primary'; //to translate
$strPrimaryKey = 'Primary key'; //to translate
$strPrimaryKeyHasBeenDropped = 'The primary key has been dropped'; //to translate
$strPrimaryKeyName = 'The name of the primary key must be... PRIMARY!'; //to translate
$strPrimaryKeyWarning = '("PRIMARY" <b>must</b> be the name of and <b>only of</b> a primary key!)'; //to translate
$strPrint = 'Print';  //to translate
$strPrintView = 'Print view'; //to translate
$strPrivileges = 'Privileges'; //to translate
$strPutColNames = 'Put fields names at first row';  //to translate

$strQBEDel = 'Del'; //to translate
$strQBEIns = 'Ins'; //to translate
$strQueryOnDb = 'SQL-query on database <b>%s</b>:'; //to translate

$strReType = 'Re-type'; //to translate
$strRecords = 'Records'; //to translate
$strReferentialIntegrity = 'Check referential integrity:'; //to translate
$strRelationNotWorking = 'The additional Features for working with linked Tables have been deactivated. To find out why click %shere%s.'; //to translate
$strRelationView = 'Relation view'; //to translate
$strReloadFailed = 'MySQL reload failed.'; //to translate
$strReloadMySQL = 'Reload MySQL'; //to translate
$strRememberReload = 'Remember reload the server.'; //to translate
$strRenameTable = 'Rename table to'; //to translate
$strRenameTableOK = 'Table %s has been renamed to %s'; //to translate
$strReplace = 'Replace'; //to translate
$strReplaceTable = 'Replace table data with file'; //to translate
$strReset = 'Reset'; //to translate
$strRowSize = ' Row size '; //to translate
$strRows = 'Rows'; //to translate
$strRowsStatistic = 'Row Statistic'; //to translate
$strRunQuery = 'Submit Query'; //to translate

$strSQL = 'SQL'; //to translate
$strSQLParserBugMessage = 'There is a chance that you may have found a bug in the SQL parser. Please examine your query closely, and check that the quotes are correct and not mis-matched. Other possible failure causes may be that you are uploading a file with binary outside of a quoted text area. You can also try your query on the MySQL command line interface. The MySQL server error output below, if there is any, may also help you in diagnosing the problem. If you still have problems or if the parser fails where the command line interface succeeds, please reduce your SQL query input to the single query that causes problems, and submit a bug report with the data chunk in the CUT section below:'; //to translate
$strSQLParserUserError = 'There seems to be an error in your SQL query. The MySQL server error output below, if there is any, may also help you in diagnosing the problem'; //to translate
$strSQLQuery = 'SQL-query'; //to translate
$strSQLResult = 'SQL result'; //to translate
$strSQPBugInvalidIdentifer = 'Invalid Identifer'; //to translate
$strSQPBugUnclosedQuote = 'Unclosed quote'; //to translate
$strSQPBugUnknownPunctuation = 'Unknown Punctuation String'; //to translate
$strSave = 'Save'; //to translate
$strScaleFactorSmall = 'The scale factor is too small to fit the schema on one page'; //to translate
$strSearchOption4 = 'as regular expression'; //to translate
$strSelectFields = 'Select fields (at least one):'; //to translate
$strSelectNumRows = 'in query'; //to translate
$strServer = 'Server %s';  //to translate
$strServerVersion = 'Server version'; //to translate
$strSetEnumVal = 'If field type is "enum" or "set", please enter the values using this format: \'a\',\'b\',\'c\'...<br />If you ever need to put a backslash ("\") or a single quote ("\'") amongst those values, backslashes it (for example \'\\\\xyz\' or \'a\\\'b\').'; //to translate
$strSingly = '(singly)'; //to translate
$strSize = 'Size'; //to translate
$strSort = 'Sort'; //to translate
$strSpaceUsage = 'Space usage'; //to translate
$strStatement = 'Statements'; //to translate
$strStrucCSV = 'CSV data'; //to translate
$strStrucDrop = 'Add \'drop table\''; //to translate
$strStrucExcelCSV = 'CSV for Ms Excel data'; //to translate
$strStructPropose = 'Propose table structure'; //to translate
$strSubmit = 'Submit'; //to translate

$strTableStructure = 'Table structure for table'; //to translate
$strTextAreaLength = ' Because of its length,<br /> this field might not be editable '; //to translate
$strTheContent = 'The content of your file has been inserted.'; //to translate
$strTheContents = 'The contents of the file replaces the contents of the selected table for rows with identical primary or unique key.'; //to translate
$strTheTerminator = 'The terminator of the fields.'; //to translate

$strUnique = 'Unique';  //to translate

$strValidateSQL = 'Validate SQL';  //to translate
$strValidatorError = 'The SQL validator could not be initialized. Please check if you have installed the necessary php extensions as described in the %sdocumentation%s.'; //to translate
$strViewDump = 'View dump (schema) of table';  //to translate
$strViewDumpDB = 'View dump (schema) of database';  //to translate

$strWebServerUploadDirectory = 'web-server upload directory';  //to translate
$strWebServerUploadDirectoryError = 'The directory you set for upload work cannot be reached';  //to translate

$strZip = '"zipped"' ;  //to translate

$strNumTables = 'Tables'; //to translate
$strTotalUC = 'Total'; //to translate
?>
