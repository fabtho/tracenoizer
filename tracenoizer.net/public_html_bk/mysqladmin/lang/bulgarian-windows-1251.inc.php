<?php
/* $Id: bulgarian-windows-1251.inc.php,v 1.29 2002/11/28 09:15:20 rabus Exp $ */

/**
 * Translated by Georgi Georgiev <chutz at chubaka.homeip.net>
 */

$charset = 'windows-1251';
$text_dir = 'ltr';
$left_font_family = 'sans-serif';
$right_font_family = 'sans-serif';
$number_thousands_separator = ',';
$number_decimal_separator = '.';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('�����', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB');

$day_of_week = array('���', '���', '��', '��', '���', '���', '���');
$month = array('������', '��������', '����', '�����', '���', '���', '���', '������', '���������', '�������', '�������', '��������');
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%e %B %Y � %H:%M';

$strAccessDenied = '������� ������';
$strAction = '��������';
$strAddDeleteColumn = '������/������ ������ �� ��������';
$strAddDeleteRow = '������/������ ��� �� ��������';
$strAddNewField = '������ ���� ����';
$strAddPriv = '�������� �� ���� ����������';
$strAddPrivMessage = '��� ��������� ���� ����������.';
$strAddSearchConditions = '������ ������� �� ������� (���� �� "where" �������):';
$strAddToIndex = ' &nbsp;%s&nbsp;������(�) ���� �������� ��� ������� ';
$strAddUser = '�������� �� ��� ����������.';
$strAddUserMessage = '��� ��������� ��� ����������.';
$strAffectedRows = '��������� ����:';
$strAfter = '���� %s';
$strAfterInsertBack = '�� �����';
$strAfterInsertNewInsert = '������ ��� �����';
$strAll = '������';
$strAlterOrderBy = '������� ��������� ��';
$strAnalyzeTable = '����������� �� ���������';
$strAnd = '�';
$strAnIndex = '���� ������� ������ �� %s';
$strAny = '�����';
$strAnyColumn = '����� ������';
$strAnyDatabase = '����� ���� �����';
$strAnyHost = '����� ����';
$strAnyTable = '����� �������';
$strAnyUser = '����� ����������';
$strAPrimaryKey = '�e�e ������� ������ ���� ��� ';
$strAscending = '���������';
$strAtBeginningOfTable = '�� �������� �� ���������';
$strAtEndOfTable = '�� ���� �� ���������';
$strAttr = '��������';

$strBack = '�����';
$strBinary = ' ������� ';
$strBinaryDoNotEdit = ' ������� - �� �� ��������� ';
$strBookmarkDeleted = 'Bookmark ���� ������.';
$strBookmarkLabel = '������';
$strBookmarkQuery = '��������� �� SQL-���������';
$strBookmarkThis = '������ ���� SQL-���������';
$strBookmarkView = '���� ���������';
$strBrowse = '��������';
$strBzip = '"bzip-����"';

$strCantLoadMySQL = '�� ���� �� ������ MySQL ������������,<br />���� ��������� �������������� �� PHP.';
$strCantRenameIdxToPrimary = '�� ���� �� ����������� ������� �� PRIMARY!';
$strCardinality = '����������';
$strCarriage = '������ �� ���� �� ���: \\r';
$strChange = '�������';
$strChangePassword = '����� �� ��������';
$strCheckAll = '�������� ������';
$strCheckDbPriv = '������� ������������ �� ��';
$strCheckTable = '�������� �� ���������';
$strColumn = '������';
$strColumnNames = '��� �� ������';
$strCompleteInserts = '����� INSERT-�';
$strConfirm = '������������ �� ������� �� �� ���������?';
$strCookiesRequired = '����� ������� �� ���������� "Cookies".';
$strCopyTable = '�������� �� ������� (���� �� �����<b>.</b>�������):';
$strCopyTableOK = '������� %s ���� �������� � %s.';
$strCreate = '������';
$strCreateIndex = '������ ������ ����� &nbsp;%s&nbsp;������';
$strCreateIndexTopic = '������ ��� ������';
$strCreateNewDatabase = '������ ���� ��';
$strCreateNewTable = '������ ���� ������� � �� %s';
$strCriteria = '��������';

$strData = '�����';
$strDatabase = ' �� ';
$strDatabaseHasBeenDropped = '������ ����� %s ���� �������.';
$strDatabases = '���� �� �����';
$strDatabasesStats = ' ���������� �� ������ �����';
$strDatabaseWildcard = '���� ����� (���� � � wildcard):';
$strDataOnly = '���� �����';
$strDefault = '�� ������������';
$strDelete = '������';
$strDeleted = '����� ���� ������';
$strDeletedRows = '������� ������:';
$strDeleteFailed = '��������� ���������!';
$strDeleteUserMessage = '��� �������� ���������� %s.';
$strDescending = '���������';
$strDisplay = '������';
$strDisplayOrder = '������ ��������:';
$strDoAQuery = '������� "��������� �� ������" (������ ��  ����������: "%")';
$strDocu = '������������';
$strDoYouReally = '������������ �� ������� ��';
$strDrop = '�������';
$strDropDB = '������� �� %s';
$strDropTable = '������ ���������';
$strDumpingData = '���� (�����) �� ������� � ���������';
$strDynamic = '���������';

$strEdit = '�����������';
$strEditPrivileges = '����������� �� ������������';
$strEffective = '���������';
$strEmpty = '��������';
$strEmptyResultSet = 'MySQL ����� ������ �������� (�.�. ���� ������).';
$strEnd = '����';
$strEnglishPrivileges = ' ���������: ������� �� ������������ �� MySQL �� �������� �� ���������. ';
$strError = '������';
$strExtendedInserts = '��������� INSERT-�';
$strExtra = '������������';

$strField = '����';
$strFieldHasBeenDropped = '������ %s ���� �������';
$strFields = '������';
$strFieldsEmpty = ' ������ �� �������� � ������! ';
$strFieldsEnclosedBy = '�������� �� �������� ���';
$strFieldsEscapedBy = '���������� ���� ����������� �������';
$strFieldsTerminatedBy = '�������� ��������� ���';
$strFixed = '��������';
$strFlushTable = '�������� ���� �� ��������� ("FLUSH")';
$strFormat = '������';
$strFormEmpty = '������ �������� ��� �������!';
$strFullText = '����� ��������';
$strFunction = '�������';

$strGenTime = '����� �� ����������';
$strGo = '�������';
$strGrants = 'Grant&nbsp;����.';
$strGzip = '"gzip-����"';

$strHasBeenAltered = '���� ���������.';
$strHasBeenCreated = '���� ���������.';
$strHome = '������';
$strHomepageOfficial = '��������� phpMyAdmin ��� ��������';
$strHomepageSourceforge = 'phpMyAdmin �������� �� Sourceforge';
$strHost = '����';
$strHostEmpty = '����� �� ����� � ������!';

$strIdxFulltext = '�������������';
$strIfYouWish = '��� ������� �� �������� ���� ����� ������ �� ���������, ������� ������ �� �������� ��������� ��� �������.';
$strIgnore = '���������';
$strIndex = '������';
$strIndexes = '�������';
$strIndexHasBeenDropped = '������� %s ���� ������';
$strIndexName = '��� �� �������&nbsp;:';
$strIndexType = '��� �� �������&nbsp;:';
$strInsert = '������';
$strInsertAsNewRow = '������ ���� ��� ���';
$strInsertedRows = '�������� ����:';
$strInsertNewRow = '������ ��� ���';
$strInsertTextfiles = '������ �������� ������� � ���������';
$strInstructions = '����������';
$strInUse = '�����';
$strInvalidName = '"%s" � �������� ���� � ��� �� ������ �� � ���������� �� ��� �� ���� �� �����,������� ��� ����. ';

$strKeepPass = '�� �� �� ����� ��������';
$strKeyname = '��� �� �����';
$strKill = '����';

$strLength = '�������';
$strLengthSet = '�������/��������*';
$strLimitNumRows = '���� �� ��������';
$strLineFeed = '������ �� ���� �� ���: \\n';
$strLines = '������';
$strLinesTerminatedBy = '������� ��������� �';
$strLocationTextfile = '�������������� �� ��������� ����';
$strLogin = '����';
$strLogout = '����� �� ���������';
$strLogPassword = '������:';
$strLogUsername = '���:';

$strModifications = '��������� ���� ���������';
$strModify = '�������';
$strModifyIndexTopic = '������� �� ������';
$strMoveTable = '����������� �� ������� ��� (���� �� �����<b>.</b>�������):';
$strMoveTableOK = '��������� %s ���� ���������� ��� %s.';
$strMySQLReloaded = 'MySQL � ����������.';
$strMySQLSaid = 'MySQL ��������: ';
$strMySQLServerProcess = 'MySQL %pma_s1% � ��������� �� %pma_s2% ���� %pma_s3%';
$strMySQLShowProcess = '������ ���������';
$strMySQLShowStatus = '������ ����������� �� MySQL';
$strMySQLShowVars = '������ ���������� ���������� �� MySQL';

$strName = '���';
$strNext = '�������';
$strNo = '��';
$strNoDatabases = '���� ���� �� �����';
$strNoDropDatabases = '"DROP DATABASE" ������� � ���������.';
$strNoFrames = 'phpMyAdmin � �� ���������� ��� ���������� �������, ����� �������� <b>frames</b>.';
$strNoIndex = '�� � ��������� ������!';
$strNoIndexPartsDefined = '�� �� ���������� ����� �� ������!';
$strNoModification = '���� �������';
$strNone = '����';
$strNoPassword = '���� ������';
$strNoPrivileges = '���� ����������';
$strNoQuery = '���� SQL ������!';
$strNoRights = '� ������� �� ����������� � ���������� ����� �� �� �� �������� ���!';
$strNoTablesFound = '� ������ ����� ���� �������.';
$strNotNumber = '���� �� � �����!';
$strNotValidNumber = ' �� � ������� ����� �� ���!';
$strNoUsersFound = '���� ����������(�).';
$strNull = '������';

$strOffSet = '����������';
$strOftenQuotation = '���������� �������. �� ����� ��������, �� ���� ������ char � varchar �� ��������� � �������.';
$strOptimizeTable = '������������ �� ���������';
$strOptionalControls = '�� �����. ���������� ��� �� �� ����� ��� ����� ��������� �������.';
$strOptionally = '�� �����';
$strOr = '���';
$strOverhead = '�������� �����';

$strPartialText = '�������� ��������';
$strPassword = '������';
$strPasswordEmpty = '�������� � ������!';
$strPasswordNotSame = '�������� �� � ������!';
$strPHPVersion = '������ �� PHP ';
$strPmaDocumentation = 'phpMyAdmin ������������';
$strPmaUriError = '�� <tt>$cfg[\'PmaAbsoluteUri\']</tt> ������ �� �� ������ �������� � ���������������� ����!';
$strPos1 = '������';
$strPrevious = '��������';
$strPrimary = 'PRIMARY';
$strPrimaryKey = '������ ����';
$strPrimaryKeyHasBeenDropped = ' ������� ���� ���� ������.';
$strPrimaryKeyName = '����� �� ������� ���� ������ �� �... PRIMARY!';
$strPrimaryKeyWarning = '("PRIMARY" <b>������</b> �� � ����� �� <b>� ���������� ��</b> ������� ����!)';
$strPrintView = '������ �� �����';
$strPrivileges = '����������';
$strProperties = '��������';

$strQBE = '��������� �� ������';
$strQBEDel = '������';
$strQBEIns = '������';
$strQueryOnDb = 'SQL-������ ��� ������ �� ����� <b>%s</b>:';

$strRecords = '������';
$strReferentialIntegrity = '�������� �� ����������� �� ��������';
$strReloadFailed = '��������� ���� �� ������������ �� MySQL.';
$strReloadMySQL = '��������� MySQL';
$strRememberReload = '�� ���������� �� ����������� �������.';
$strRenameTable = '����������� ��������� ��';
$strRenameTableOK = '������� %s ���� ������������ �� %s';
$strRepairTable = '��������� �� ���������';
$strReplace = '�������';
$strReplaceTable = '������� ������� �� ��������� � ������� �� �����';
$strReset = '�������';
$strReType = '������';
$strRevoke = '������';
$strRevokeGrant = '�������� �� Grant&nbsp;����.';
$strRevokeGrantMessage = '��� ����������� Grant ������������ �� %s';
$strRevokeMessage = '��� ��������� ������������ �� %s';
$strRevokePriv = '������ �� ����������';
$strRowLength = '������� �� ����';
$strRows = '������';
$strRowsFrom = '���� ���������� ��';
$strRowSize = ' ������ �� ��� ';
$strRowsModeHorizontal = '������������';
$strRowsModeOptions = '� %s ��� � �������� ������� �� �������� ���� ����� %s<br />';
$strRowsModeVertical = '����������';
$strRowsStatistic = '���������� �� ��������';
$strRunning = '������ �� %s';
$strRunQuery = '������� ��������';
$strRunSQLQuery = '���������� SQL ������/������ ��� ���� �� ����� %s';

$strSave = '������';
$strSelect = '������';
$strSelectADb = '���� �������� ���� �����';
$strSelectAll = '���������� ������';
$strSelectFields = '������ ���� (������� ����):';
$strSelectNumRows = '� �����������';
$strSend = '�������';
$strServerChoice = '����� �� ������';
$strServerVersion = '������ �� �������';
$strSetEnumVal = '��� ���� �� ������ � "enum" ��� "set", ���� �������� ����������� ����������� ���� ������: \'a\',\'b\',\'c\'...<br />��� � ���������� �� ������� ������� ����� ("\") ��� �������� ("\'") ����� ���� ���������, ������� ������� ����� ���� ��� (��������:  \'\\\\xyz\' ��� \'a\\\'b\').';
$strShow = '������';
$strShowAll = '������ ������';
$strShowCols = '������ ��������';
$strShowingRecords = '������� ������ ';
$strShowPHPInfo = '������ ���������� �� PHP ';
$strShowTables = '������ ���������';
$strShowThisQuery = ' ������ ���� ������ ������ ';
$strSingly = '(����������)';
$strSize = '������';
$strSort = '���������';
$strSpaceUsage = '���������� �����';
$strSQLQuery = 'SQL-���������';
$strStatement = '���������';
$strStrucCSV = 'CSV �����';
$strStrucData = '����������� � �������';
$strStrucDrop = '������ \'������ ���������\'';
$strStrucExcelCSV = 'CSV �� Ms Excel �����';
$strStrucOnly = '���� �����������';
$strSubmit = '�������';
$strSuccess = '������ SQL-��������� ���� ��������� �������';
$strSum = '����';

$strTable = '������� ';
$strTableComments = '��������� ��� ���������';
$strTableEmpty = '����� �� ��������� � ������!';
$strTableHasBeenDropped = '��������� %s ���� �������';
$strTableHasBeenEmptied = '��������� %s ���� ����������';
$strTableHasBeenFlushed = '���� �� ������� %s ���� ���������';
$strTableMaintenance = '��������� �� ���������';
$strTables = '%s �������(�)';
$strTableStructure = '��������� �� �������';
$strTableType = '��� �� ���������';
$strTextAreaLength = ' ������ ��������� ��,<br /> ���� ���� ���� �� �� � ������������ ';
$strTheContent = '������������ �� ����� ���� �����������.';
$strTheContents = '������������ �� ����� �������� ������������ �� ��������� �� ������ � ��������� �������� ��� �������� �������.';
$strTheTerminator = '������ �� ���� �� ����.';
$strTotal = '������';
$strType = '���';

$strUncheckAll = '����������� ������';
$strUnique = '��������';
$strUnselectAll = '������������ ������';
$strUpdatePrivMessage = '��� ���������� ������������ �� %s.';
$strUpdateProfile = '���������� �� ������:';
$strUpdateProfileMessage = '������� ���� �������.';
$strUpdateQuery = '������� �����������';
$strUsage = '����������';
$strUseBackquotes = '��������� ������� ������� ����� ����� �� ������� � ������';
$strUser = '����������';
$strUserEmpty = '��������������� ��� � ������!';
$strUserName = '������������� ���';
$strUsers = '�����������';
$strUseTables = '��������� ���������';

$strValue = '��������';
$strViewDump = '������ ���� (�����) �� ���������';
$strViewDumpDB = '������ ���� (�����) �� ��';

$strWelcome = '����� ����� � %s';
$strWithChecked = '������ ��� �������:';
$strWrongUser = '������ ���/������. ������� ������.';

$strYes = '��';

$strZip = '"zip-����"';
// To translate

$strAllTableSameWidth = 'display all Tables with same width?';  //to translate

$strBeginCut = 'BEGIN CUT';  //to translate
$strBeginRaw = 'BEGIN RAW';  //to translate

$strCantLoadRecodeIconv = 'Can not load iconv or recode extension needed for charset conversion, configure php to allow using these extensions or disable charset conversion in phpMyAdmin.';  //to translate
$strCantUseRecodeIconv = 'Can not use iconv nor libiconv nor recode_string function while extension reports to be loaded. Check your php configuration.';  //to translate
$strChangeDisplay = 'Choose Field to display';  //to translate
$strCharsetOfFile = 'Character set of the file:'; //to translate
$strChoosePage = 'Please choose a Page to edit';  //to translate
$strColComFeat = 'Displaying Column Comments';  //to translate
$strComments = 'Comments';  //to translate
$strConfigFileError = 'phpMyAdmin was unable to read your configuration file!<br />This might happen if php finds a parse error in it or php cannot find the file.<br />Please call the configuration file directly using the link below and read the php error message(s) that you recieve. In most cases a quote or a semicolon is missing somewhere.<br />If you recieve a blank page, everything is fine.'; //to translate
$strConfigureTableCoord = 'Please configure the coordinates for table %s';  //to translate
$strCreatePage = 'Create a new Page';  //to translate
$strCreatePdfFeat = 'Creation of PDFs';  //to translate

$strDisabled = 'Disabled';  //to translate
$strDisplayFeat = 'Display Features';  //to translate
$strDisplayPDF = 'Display PDF schema';  //to translate
$strDumpXRows = 'Dump %s rows starting at row %s.'; //to translate

$strEditPDFPages = 'Edit PDF Pages';  //to translate
$strEnabled = 'Enabled';  //to translate
$strEndCut = 'END CUT';  //to translate
$strEndRaw = 'END RAW';  //to translate
$strExplain = 'Explain SQL';  //to translate
$strExport = 'Export';  //to translate
$strExportToXML = 'Export to XML format'; //to translate

$strGenBy = 'Generated by'; //to translate
$strGeneralRelationFeat = 'General relation features';  //to translate

$strHaveToShow = 'You have to choose at least one Column to display';  //to translate

$strLinkNotFound = 'Link not found';  //to translate
$strLinksTo = 'Links to';  //to translate

$strMissingBracket = 'Missing Bracket';  //to translate
$strMySQLCharset = 'MySQL Charset';  //to translate

$strNoDescription = 'no Description';  //to translate
$strNoExplain = 'Skip Explain SQL';  //to translate
$strNoPhp = 'without PHP Code';  //to translate
$strNotOK = 'not OK';  //to translate
$strNotSet = '<b>%s</b> table not found or not set in %s';  //to translate
$strNoValidateSQL = 'Skip Validate SQL';  //to translate
$strNumSearchResultsInTable = '%s match(es) inside table <i>%s</i>';//to translate
$strNumSearchResultsTotal = '<b>Total:</b> <i>%s</i> match(es)';//to translate

$strOK = 'OK';  //to translate
$strOperations = 'Operations';  //to translate
$strOptions = 'Options';  //to translate

$strPageNumber = 'Page number:';  //to translate
$strPdfDbSchema = 'Schema of the the "%s" database - Page %s';  //to translate
$strPdfInvalidPageNum = 'Undefined PDF page number!';  //to translate
$strPdfInvalidTblName = 'The "%s" table does not exist!';  //to translate
$strPdfNoTables = 'No tables';  //to translate
$strPhp = 'Create PHP Code';  //to translate

$strRelationNotWorking = 'The additional Features for working with linked Tables have been deactivated. To find out why click %shere%s.';  //to translate
$strRelationView = 'Relation view';  //to translate

$strScaleFactorSmall = 'The scale factor is too small to fit the schema on one page';  //to translate
$strSearch = 'Search';//to translate
$strSearchFormTitle = 'Search in database';//to translate
$strSearchInTables = 'Inside table(s):';//to translate
$strSearchNeedle = 'Word(s) or value(s) to search for (wildcard: "%"):';//to translate
$strSearchOption1 = 'at least one of the words';//to translate
$strSearchOption2 = 'all words';//to translate
$strSearchOption3 = 'the exact phrase';//to translate
$strSearchOption4 = 'as regular expression';//to translate
$strSearchResultsFor = 'Search results for "<i>%s</i>" %s:';//to translate
$strSearchType = 'Find:';//to translate
$strSelectTables = 'Select Tables';  //to translate
$strShowColor = 'Show color';  //to translate
$strShowGrid = 'Show grid';  //to translate
$strShowTableDimension = 'Show dimension of tables';  //to translate
$strSplitWordsWithSpace = 'Words are seperated by a space character (" ").';//to translate
$strSQL = 'SQL'; //to translate
$strSQLParserBugMessage = 'There is a chance that you may have found a bug in the SQL parser. Please examine your query closely, and check that the quotes are correct and not mis-matched. Other possible failure causes may be that you are uploading a file with binary outside of a quoted text area. You can also try your query on the MySQL command line interface. The MySQL server error output below, if there is any, may also help you in diagnosing the problem. If you still have problems or if the parser fails where the command line interface succeeds, please reduce your SQL query input to the single query that causes problems, and submit a bug report with the data chunk in the CUT section below:';  //to translate
$strSQLParserUserError = 'There seems to be an error in your SQL query. The MySQL server error output below, if there is any, may also help you in diagnosing the problem';  //to translate
$strSQLResult = 'SQL result'; //to translate
$strSQPBugInvalidIdentifer = 'Invalid Identifer';  //to translate
$strSQPBugUnclosedQuote = 'Unclosed quote';  //to translate
$strSQPBugUnknownPunctuation = 'Unknown Punctuation String';  //to translate
$strStructPropose = 'Propose table structure';  //to translate
$strStructure = 'Structure';  //to translate

$strValidateSQL = 'Validate SQL';  //to translate

$strInsecureMySQL = 'Your configuration file contains settings (root with no password) that correspond to the default MySQL privileged account. Your MySQL server is running with this default, is open to intrusion, and you really should fix this security hole.';  //to translate
$strWebServerUploadDirectory = 'web-server upload directory';  //to translate
$strWebServerUploadDirectoryError = 'The directory you set for upload work cannot be reached';  //to translate
$strValidatorError = 'The SQL validator could not be initialized. Please check if you have installed the necessary php extensions as described in the %sdocumentation%s.'; //to translate
$strServer = 'Server %s';  //to translate
$strPutColNames = 'Put fields names at first row';  //to translate
$strImportDocSQL = 'Import docSQL Files';  //to translate
$strDataDict = 'Data Dictionary';  //to translate
$strPrint = 'Print';  //to translate
$strPHP40203 = 'You are using PHP 4.2.3, which has a serious bug with multi-byte strings (mbstring). See PHP bug report 19404. This version of PHP is not recommended for use with phpMyAdmin.';  //to translate
$strCompression = 'Compression'; //to translate
$strNumTables = 'Tables'; //to translate
$strTotalUC = 'Total'; //to translate
?>
