<?php
/* $Id: greek-iso-8859-7.inc.php,v 1.30 2002/11/28 09:15:30 rabus Exp $ */

/* Translated by Kyriakos Xagoraris <theremon at users.sourceforge.net> */

$charset = 'iso-8859-7';
$text_dir = 'ltr';
$left_font_family = 'verdana, arial, helvetica, geneva, sans-serif';
$right_font_family = 'tahoma, verdana, helvetica, geneva, sans-serif';
$number_thousands_separator = '.';
$number_decimal_separator = ',';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB');

$day_of_week = array('���', '���', '���', '���', '���', '���', '���');
$month = array('���', '���', '���', '���', '���', '����', '����', '���', '���', '���', '���', '���');
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%d %B %Y, ���� %I:%M %p';

// To Arrange

$strAccessDenied = '\'������ ���������';
$strAction = '��������';
$strAddDeleteColumn = '��������/�������� ������ ������';
$strAddDeleteRow = '��������/�������� ������� ���������';
$strAddNewField = '�������� ���� ������';
$strAddPriv = '�������� ���� ���������';
$strAddPrivMessage = '���������� ��� ��������.';
$strAddSearchConditions = '�������� ���� ���� (���� ��� "where" ��������):';
$strAddToIndex = '�������� ��� ��������� &nbsp;%s&nbsp;�������(��)';
$strAddUser = '�������� ���� ������';
$strAddUserMessage = '���������� ��� ��� ������.';
$strAffectedRows = '������������� ��������:';
$strAfter = '���� �� %s';
$strAfterInsertBack = '���������';
$strAfterInsertNewInsert = '�������� ���� ��������';
$strAll = '���';
$strAllTableSameWidth = '�������� ���� ��� ������� �� �� ���� ������;';
$strAlterOrderBy = '������ ����������� ������ ����';
$strAnalyzeTable = '������� ������';
$strAnd = '���';
$strAnIndex = '��� ��������� ���������� ��� %s';
$strAny = '�����������';
$strAnyColumn = '����������� �����';
$strAnyDatabase = '����������� ����';
$strAnyHost = '����������� �������';
$strAnyTable = '������������ �������';
$strAnyUser = '������������ �������';
$strAPrimaryKey = '��� �������� ������ ���������� ��� %s';
$strAscending = '�������';
$strAtBeginningOfTable = '���� ���� ��� ������';
$strAtEndOfTable = '��� ����� ��� ������';
$strAttr = '��������������';

$strBack = '���������';
$strBinary = '�������';
$strBinaryDoNotEdit = '������� - ����� ���������� ������������';
$strBookmarkDeleted = '� ������� ��������.';
$strBookmarkLabel = '�������';
$strBookmarkQuery = '������������ ������ SQL';
$strBookmarkThis = '���������� ����� ��� ������ SQL';
$strBookmarkView = '���� ��������';
$strBrowse = '���������';
$strBzip = '�������� �bzip�';

$strCantLoadMySQL = '��� ������ �� �������� � �������� MySQL,<br />�������� ������� ��� ��������� ��� PHP.';
$strCantRenameIdxToPrimary = '� ����������� ��� ���������� �� PRIMARY �� ����� ������!';
$strCardinality = '������������';
$strCarriage = '���������� ����������: \\r';
$strChange = '������';
$strChangePassword = '������ ������� ���������';
$strCheckAll = '������� ����';
$strCheckDbPriv = '������� ��������� �����';
$strCheckTable = '������� ������';
$strColComFeat = '�������� ������� ������';
$strColumn = '�����';
$strColumnNames = '������� ������';
$strCompleteInserts = '������������� ������� �Insert�';
$strConfirm = '���������� ������ �� �� ����������;';
$strCookiesRequired = '��� ���� �� ������ ������ �� ����� �������������� cookies.';
$strCopyTable = '��������� ������ �� (����<b>.</b>�������):';
$strCopyTableOK = '� ������� %s ����������� ��� %s.';
$strCreate = '����������';
$strCreateIndex = '���������� ���������� �� &nbsp;%s&nbsp;�����';
$strCreateIndexTopic = '���������� ���� ����������';
$strCreateNewDatabase = '���������� ���� �����';
$strCreateNewTable = '���������� ���� ������ ��� ���� %s';
$strCreatePdfFeat = '���������� ������� PDF';
$strCriteria = '��������';

$strData = '��������';
$strDatabase = '���� ';
$strDatabaseHasBeenDropped = '� ���� ��������� %s ��������.';
$strDatabases = '������';
$strDatabasesStats = '���������� �����';
$strDatabaseWildcard = '���� ��������� (������������ wildcards):';
$strDataOnly = '���� �� ��������';
$strDefault = '��������������';
$strDelete = '��������';
$strDeleted = '� ������� ���� ���������';
$strDeletedRows = '������������ ��������:';
$strDeleteFailed = '� �������� �������';
$strDeleteUserMessage = '���������� ��� ������ %s.';
$strDescending = '��������';
$strDisabled = '����������������';
$strDisplay = '��������';
$strDisplayFeat = '����������� ���������';
$strDisplayOrder = '����� ���������:';
$strDoAQuery = '�������� ��� ���������� ���� ���������� (���������� ��������� "%")';
$strDocu = '����������';
$strDoYouReally = '������ �� ���������� ��� ������';
$strDrop = '��������';
$strDropDB = '�������� ����� %s';
$strDropTable = '�������� ������';
$strDumpingData = '\'�������� ��������� ��� ������';
$strDynamic = '��������';

$strEdit = '�����������';
$strEditPrivileges = '����������� ���������';
$strEffective = '���������������';
$strEmpty = '\'��������';
$strEmptyResultSet = '� MySQL ��������� ��� ����� ������ ������������� (�.�. ������ �������).';
$strEnabled = '��������������';
$strEnd = '�����';
$strEnglishPrivileges = ' ��������: �� ������� ��������� ��� MySQL ����������� ��� ������� ';
$strError = '�����';
$strExtendedInserts = '����������� ������� �Insert�';
$strExtra = '��������';

$strField = '�����';
$strFieldHasBeenDropped = '�� ����� %s ��������';
$strFields = '�����';
$strFieldsEmpty = ' � ���������� ��� ������ ����� ����! ';
$strFieldsEnclosedBy = '����� ��� ������������� ��';
$strFieldsEscapedBy = '�� ����� ������������� �� ��������� �������� ';
$strFieldsTerminatedBy = '����� ��� ���������� ��';
$strFixed = '��������������� ������';
$strFlushTable = '���������� ("FLUSH") ������';
$strFormat = '�����������';
$strFormEmpty = '�������� ���� ��� ����� !';
$strFullText = '����� �������';
$strFunction = '�������';

$strGeneralRelationFeat = '������� ����������� ����������';
$strGenTime = '������ �����������';
$strGo = '��������';
$strGrants = '������������';
$strGzip = '�������� �gzip�';

$strHasBeenAltered = '���� ��������.';
$strHasBeenCreated = '���� ������������.';
$strHome = '�������� ������';
$strHomepageOfficial = '������� ������ ��� phpMyAdmin';
$strHomepageSourceforge = '������ ��� Sourceforge ��� ��� �������� ��� phpMyAdmin';
$strHost = '�������';
$strHostEmpty = '�� ����� ��� ���������� ����� ����!';

$strIdxFulltext = '������ �������';
$strIfYouWish = '�� ������������ �� ��������� ���� ������� ��� ��� ������ ��� ������, ��������� ��� ����� ������ ������������ �� �����.';
$strIgnore = '��������';
$strIndex = '���������';
$strIndexes = '���������';
$strIndexHasBeenDropped = '�� ��������� %s ��������';
$strIndexName = '����� ����������&nbsp;:';
$strIndexType = '����� ����������&nbsp;:';
$strInsert = '��������';
$strInsertAsNewRow = '�������� �� ��� ��������';
$strInsertedRows = '����������� ��������:';
$strInsertNewRow = '�������� ���� ��������';
$strInsertTextfiles = '�������� ������� �������� ���� ������';
$strInstructions = '�������';
$strInUse = '�� �����';
$strInvalidName = '� �%s� ����� ���������� ����, ��� �������� �� ��� ��������������� �� ����� ��� ����, ������ � �����.';

$strKeepPass = '��������� ������� ���������';
$strKeyname = '����� ��������';
$strKill = '�����������';

$strLength = '�����';
$strLengthSet = '�����/�����*';
$strLimitNumRows = '�������� ��� ������';
$strLineFeed = '���������� ��������� �������: \\n';
$strLines = '�������';
$strLinesTerminatedBy = '������� ��� ���������� ��';
$strLocationTextfile = '��������� ��� ������� ��������';
$strLogin = '�������';
$strLogout = '����������';
$strLogPassword = '������� ���������:';
$strLogUsername = '����� ������:';

$strModifications = '�� ������� �������������';
$strModify = '�����������';
$strModifyIndexTopic = '������ ���� ����������';
$strMoveTable = '�������� ������ �� (����<b>.</b>�������):';
$strMoveTableOK = '� ������� %s ����������� ��� %s.';
$strMySQLReloaded = '� MySQL ��������������.';
$strMySQLSaid = '� MySQL ��������� �� ������: ';
$strMySQLServerProcess = '� MySQL %pma_s1% ���������� ���� %pma_s2% �� %pma_s3%';
$strMySQLShowProcess = '�������� ����������';
$strMySQLShowStatus = '�������� ���������� ��������� ��� MySQL';
$strMySQLShowVars = '�������� ���������� ��� MySQL';

$strName = '�����';
$strNext = '�������';
$strNo = '���';
$strNoDatabases = '��� �������� ������ ���������';
$strNoDropDatabases = '�� ������� �DROP DATABASE� ����� ���������������.';
$strNoFrames = '�� phpMyAdmin ����� ��� ������ �� ���� browser <b>��� ����������� frames</b>.';
$strNoIndex = '��� �������� ���������!';
$strNoIndexPartsDefined = '��� ��������� �� �������� ��� ����������!';
$strNoModification = '����� ������';
$strNone = '������';
$strNoPassword = '����� ������ ���������';
$strNoPrivileges = '����� ��������';
$strNoQuery = '��� ������� ������ SQL!';
$strNoRights = '��� ����� ������ ���������� �� ������� ��� ����!';
$strNoTablesFound = '��� �������� ������� ��� ����.';
$strNotNumber = '���� ��� ����� �������!';
$strNotOK = '�����';
$strNotValidNumber = ' ��� ����� �������� ������� ��������!';
$strNoUsersFound = '��� �������� �������.';
$strNull = '����';

$strOftenQuotation = '����� ����������. �� OPTIONALLY �������� ��� ���� �� ����� char ��� varchar ������������� �� ��� ��������� ���������������� ����.';
$strOK = 'OK';
$strOptimizeTable = '�������������� ������';
$strOptionalControls = '�����������. �������� ��� �� ������� � �������� ��� � ������� ������� ����������.';
$strOptionally = '�����������';
$strOr = '�';
$strOverhead = '����������';

$strPartialText = '��������� �������';
$strPassword = '������� ���������';
$strPasswordEmpty = '� ������� ��������� ����� �����!';
$strPasswordNotSame = '�� ������� ��������� ��� ����� �����!';
$strPdfNoTables = '��� �������� �������';
$strPHPVersion = '������ PHP';
$strPmaDocumentation = '���������� phpMyAdmin';
$strPmaUriError = '� ������ <tt>$cfg[\'PmaAbsoluteUri\']</tt> ������ �� ������� ��� ������ �����������!';
$strPos1 = '����';
$strPrevious = '�����������';
$strPrimary = '��������';
$strPrimaryKey = '�������� ������';
$strPrimaryKeyHasBeenDropped = '�� �������� ������ ��������';
$strPrimaryKeyName = '�� ����� ��� ����������� �������� ������ �� �����... PRIMARY!';
$strPrimaryKeyWarning = '("PRIMARY" <b>������</b> �� ����� �� ����� ��� ����������� �������� ��� <b>���� �����</b> !)';
$strPrintView = '�������� ��� ��������';
$strPrivileges = '��������';
$strProperties = '���������';

$strQBE = '��������� ���� ����������';
$strQBEDel = '��������';
$strQBEIns = '��������';
$strQueryOnDb = '������ SQL ��� ���� <b>%s</b>:';

$strRecords = '��������';
$strReferentialIntegrity = '������� ������������ �������:';
$strRelationNotWorking = '�� ������������ ����������� ��� ������� �� �������������� ������� ����� ���������������. ��� �� ������ �����, ������� %s���%s.';
$strReloadFailed = '� ������������ ��� MySQL �������.';
$strReloadMySQL = '������������ ��� MySQL';
$strRememberReload = '�������� ��� ������������� ��� ����������.';
$strRenameTable = '����������� ������ ��';
$strRenameTableOK = '� ������� %s ������������� �� %s';
$strRepairTable = '����������� ������';
$strReplace = '�������������';
$strReplaceTable = '������������� ��������� ������ �� �� ������';
$strReset = '���������';
$strReType = '�������������';
$strRevoke = '��������';
$strRevokeGrant = '�������� �����������';
$strRevokeGrantMessage = '����������� �� �������� ����������� ��� %s';
$strRevokeMessage = '����������� �� �������� ��� %s';
$strRevokePriv = '�������� ����������';
$strRowLength = '������� �������';
$strRows = '��������';
$strRowsFrom = '�������� ���������� ��� ��� �������';
$strRowSize = ' ������� �������� ';
$strRowsModeHorizontal = '���������';
$strRowsModeOptions = '�� %s ����� �� ��������� ������������ ��� %s �����';
$strRowsModeVertical = '������';
$strRowsStatistic = '���������� ��������';
$strRunning = '��� ���������� ��� %s';
$strRunQuery = '������� ����������';
$strRunSQLQuery = '�������� �������/������� SQL ��� ���� ��������� %s';

$strSave = '����������';
$strSelect = '�������';
$strSelectADb = '�������� �������� ��� ���� ���������';
$strSelectAll = '������� ����';
$strSelectFields = '������� ������ (����������� ���)';
$strSelectNumRows = '���� ������';
$strSend = '��������';
$strServerChoice = '������� ����������';
$strServerVersion = '������ ����������';
$strSetEnumVal = '�� � ����� ��� ������ ����� �enum� � �set�, �������� �������� ��� ����� ��������������� ��� ���� �����������: \'�\',\'�\',\'�\'...<br /> �� ���������� �� �������� ��� ������� ������ ("\") � ���� ���������� ("\'"), �������� �� �� ������� ������ ���� ���� (��� ���������� \'\\\\���\' � \'�\\\'�\').';
$strShow = '��������';
$strShowAll = '�������� ����';
$strShowCols = '�������� ������';
$strShowingRecords = '�������� �������� ';
$strShowPHPInfo = '�������� ����������� ��� PHP';
$strShowTables = '�������� �������';
$strShowThisQuery = ' �������� ��� ���� ����� ��� ������ ';
$strSingly = '(��������)';
$strSize = '�������';
$strSort = '����������';
$strSpaceUsage = '����� �����';
$strSQLQuery = '������ SQL';
$strStatement = '��������';
$strStrucCSV = '�������� CSV';
$strStrucData = '���� ��� ��������';
$strStrucDrop = '�������� �Drop Table�';
$strStrucExcelCSV = '����� CSV ��� �������� Ms Excel';
$strStrucOnly = '���� � ����';
$strSubmit = '��������';
$strSuccess = '� SQL ������ ��� ����������� ��������';
$strSum = '������';

$strTable = '������� ';
$strTableComments = '������ ������';
$strTableEmpty = '�� ����� ��� ������ ����� ����!';
$strTableHasBeenDropped = '� ������� %s ��������';
$strTableHasBeenEmptied = '� ������� %s �������';
$strTableHasBeenFlushed = '� ������� %s ������������� ("FLUSH")';
$strTableMaintenance = '��������� ������';
$strTables = '%s �������/�������';
$strTableStructure = '���� ������ ��� ��� ������';
$strTableType = '����� ������';
$strTextAreaLength = ' �������� ��� ������� ���,<br /> ���� �� ����� ������ �� �� ������ �� ��������� ';
$strTheContent = '�� ����������� ��� ������� ��� ����� ���������.';
$strTheContents = '�� ����������� ��� ������� ������������� �� ����������� ��� ����������� ������ ��� ������� �� ���� �������� � �������� ������.';
$strTheTerminator = '� ���������� ���������� ��� ������.';
$strTotal = '��������';
$strType = '�����';

$strUncheckAll = '��������� ����';
$strUnique = '��������';
$strUnselectAll = '��������� ����';
$strUpdatePrivMessage = '�� �������� ��� ������ %s ������������.';
$strUpdateProfile = '��������� ���������:';
$strUpdateProfileMessage = '�� �������� �����������.';
$strUpdateQuery = '��������� ��� �������';
$strUsage = '�����';
$strUseBackquotes = '����� �������� ����������� ��� ������� ��� ������� ��� ��� ������';
$strUser = '�������';
$strUserEmpty = '�� ����� ��� ������ ����� ����!';
$strUserName = '����� ������';
$strUsers = '�������';
$strUseTables = '����� �������';

$strValue = '����';
$strViewDump = '�������� �������� ��� ������';
$strViewDumpDB = '�������� �������� ��� �����';

$strWelcome = '����������� ��� %s';
$strWithChecked = '�� ���� ������������:';
$strWrongUser = '���������� ����� ������/������� ���������. \'������ ���������.';

$strYes = '���';

$strZip = '�������� �zip�';
// To Translate

$strBeginCut = 'BEGIN CUT';  //to translate
$strBeginRaw = 'BEGIN RAW';  //to translate

$strCantLoadRecodeIconv = '��� ����� ������ � ������� ��� ��������� iconv � recode ��� ���������� ��� ��� ��������� ��� ��� ����������. �������� ��� php �� ��������� ��� ����� ����� ��� ���������� � ��������������� ��� ��������� ���������� ��� phpMyAdmin.';  //to translate
$strCantUseRecodeIconv = '��� ����� ������ � ����� ��� ��������� iconv ���� ��� libiconv ���� ��� �������� recode_string, ��� � �������� ���� ��������. ������ ��� ��������� ��� php.';  //to translate
$strChangeDisplay = '�������� ����� ��� ��������';  //to translate
$strCharsetOfFile = 'Character set of the file:'; //to translate
$strChoosePage = '�������� �������� ������ ��� ������';  //to translate
$strComments = '������';  //to translate
$strConfigFileError = '�� phpMyAdmin ��� ������� �� �������� �� ������ ���������!<br />���� ������ �� ������ ��� � php ���� ������ ����� ��� ������ � ��� � php ��� ������ �� ���� �� ������.<br />�������� ������� �� ������ ��������� ��\' ������� ��������������� �� �������� link ��� �������� �� �������� ������ ��� �� ���������� � php. ���� ������������ ����������� ����� ������� ���������� (") � ����������� (;).<br />��� � php ���������� ��� ����� ������, ��� ����� �����.'; //to translate
$strConfigureTableCoord = '�������� ������ ��� ������������� ��� ��� ������ %s';  //to translate
$strCreatePage = '���������� ���� �������';  //to translate

$strDisplayPDF = '�������� �������� PDF';  //to translate
$strDumpXRows = '�������� %s �������� ���������� ��� ��� ������� %s.'; //to translate

$strEditPDFPages = '������ ������� PDF';  //to translate
$strEndCut = 'END CUT';  //to translate
$strEndRaw = 'END RAW';  //to translate
$strExplain = 'Explain SQL';  //to translate
$strExport = '�������';  //to translate
$strExportToXML = 'Export to XML format'; //to translate

$strGenBy = '������������� ���:'; //to translate

$strHaveToShow = '������ �� ��������� ����������� ��� ����� ��� ��������';  //to translate

$strLinkNotFound = '��� ������� � �������';  //to translate
$strLinksTo = '������� ��';  //to translate

$strMissingBracket = '������ ��� ������';  //to translate
$strMySQLCharset = '��� ���������� ��� MySQL';  //to translate

$strNoDescription = '����� ���������';  //to translate
$strNoExplain = 'Skip Explain SQL';  //to translate
$strNoPhp = '����� ������ PHP';  //to translate
$strNotSet = '� ������� <b>%s</b> ��� ������� � ��� �������� ��� %s';  //to translate
$strNoValidateSQL = 'Skip Validate SQL';  //to translate
$strNumSearchResultsInTable = '%s ������������ ���� ������ <i>%s</i>';//to translate
$strNumSearchResultsTotal = '<b>������:</b> <i>%s</i> ������������';//to translate

$strOperations = '�����������';  //to translate
$strOptions = '��������';  //to translate

$strPageNumber = '������:';  //to translate
$strPdfDbSchema = '����� ��� ����� "%s" - ������ %s';  //to translate
$strPdfInvalidPageNum = '��� �������� ������� ������� PDF!';  //to translate
$strPdfInvalidTblName = '� ������� "%s" ��� �������!';  //to translate
$strPhp = '���������� ������ PHP';  //to translate

$strRelationView = '�������� �������';  //to translate

$strScaleFactorSmall = '� ������� ����� ���� ����� ��� �� ���������� �� ����� �� ��� ������';  //to translate
$strSearch = '���������';//to translate
$strSearchFormTitle = '��������� ��� ����';//to translate
$strSearchInTables = '���� ����� �������:';//to translate
$strSearchNeedle = '���� � ����� ��� ��������� (���������: "%"):';//to translate
$strSearchOption1 = '����������� ���� ��� ���� �����';//to translate
$strSearchOption2 = '����� ���� �����';//to translate
$strSearchOption3 = '��� ������ �����';//to translate
$strSearchOption4 = '�� regular expression';//to translate
$strSearchResultsFor = '������������ ���������� ��� "<i>%s</i>" %s:';//to translate
$strSearchType = '������:';//to translate
$strSelectTables = '������� �������';  //to translate
$strShowColor = '�������� ��������';  //to translate
$strShowGrid = '�������� ���������';  //to translate
$strShowTableDimension = '�������� ���������� �������';  //to translate
$strSplitWordsWithSpace = '�� ������ ���������� ��� ��� ��������� ����������� (" ").';//to translate
$strSQL = 'SQL'; //to translate
$strSQLParserBugMessage = 'There is a chance that you may have found a bug in the SQL parser. Please examine your query closely, and check that the quotes are correct and not mis-matched. Other possible failure causes may be that you are uploading a file with binary outside of a quoted text area. You can also try your query on the MySQL command line interface. The MySQL server error output below, if there is any, may also help you in diagnosing the problem. If you still have problems or if the parser fails where the command line interface succeeds, please reduce your SQL query input to the single query that causes problems, and submit a bug report with the data chunk in the CUT section below:';  //to translate
$strSQLParserUserError = 'There seems to be an error in your SQL query. The MySQL server error output below, if there is any, may also help you in diagnosing the problem';  //to translate
$strSQLResult = '���������� SQL'; //to translate
$strSQPBugInvalidIdentifer = 'Invalid Identifer';  //to translate
$strSQPBugUnclosedQuote = 'Unclosed quote';  //to translate
$strSQPBugUnknownPunctuation = 'Unknown Punctuation String';  //to translate
$strStructPropose = '������������ ���� ������';  //to translate
$strStructure = '����';  //to translate

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
