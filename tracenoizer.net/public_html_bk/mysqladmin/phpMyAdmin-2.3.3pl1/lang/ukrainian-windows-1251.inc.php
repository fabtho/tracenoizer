<?php
/* $Id: ukrainian-windows-1251.inc.php,v 1.31 2002/11/28 09:15:43 rabus Exp $ */

$charset = 'windows-1251';
$text_dir = 'ltr';
$left_font_family = 'verdana, arial, helvetica, geneva, sans-serif';
$right_font_family = 'arial, helvetica, geneva, sans-serif';
$number_thousands_separator = ',';
$number_decimal_separator = '.';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('����', '��', '��', '��');

$day_of_week = array('��', '��', '��', '��', '��', '��', '��');
$month = array('ѳ�', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���');
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%B %d %Y �., %H:%M';

$strAPrimaryKey = '���� ������ ��������� ���� �� %s';
$strAccessDenied = '������ ����������';
$strAction = 'ĳ�';
$strAddDeleteColumn = '������/������� ������� �������';
$strAddDeleteRow = '������/������� ����� �������';
$strAddNewField = '������ ���� ����';
$strAddPriv = '������ ��� ������';
$strAddPrivMessage = '���� ������ ����� �������';
$strAddSearchConditions = '������ ����� ������ (��� ��� ����� "where"):';
$strAddToIndex = '������ �� �������&nbsp;%s&nbsp;��������(�)';
$strAddUser = '������ ������ �����������';
$strAddUserMessage = '���� ������ ������ �����������.';
$strAffectedRows = '������ �����:';
$strAfter = 'ϳ��� %s';
$strAfterInsertBack = '�����������';
$strAfterInsertNewInsert = '�������� ����� �����';
$strAll = '���';
$strAllTableSameWidth = '���������� �� ������� �������� ������?';
$strAlterOrderBy = '������ ������� �������';
$strAnIndex = '���� ������ ������ ��� %s';
$strAnalyzeTable = '����� �������';
$strAnd = '�';
$strAny = '��������';
$strAnyColumn = '������� �������';
$strAnyDatabase = '������ ���� �����';
$strAnyHost = '�������� ����';
$strAnyTable = '������� �������';
$strAnyUser = '�������� ����������';
$strAscending = '����������';
$strAtBeginningOfTable = '�� ������� �������';
$strAtEndOfTable = '� ���� �������';
$strAttr = '��������';

$strBack = '�����';
$strBeginCut = 'BEGIN CUT';
$strBeginRaw = 'BEGIN RAW';
$strBinary = ' �������� ';
$strBinaryDoNotEdit = ' ������ ���� - �� ����������� ';
$strBookmarkDeleted = '�������� ���� ��������.';
$strBookmarkLabel = '̳���';
$strBookmarkQuery = '�������� �� SQL-�����';
$strBookmarkThis = '�������� �� ����� SQL-�����';
$strBookmarkView = '���� ��������';
$strBrowse = '�����������';
$strBzip = '���������� � "bzip"';

$strCantLoadMySQL = '���������� MySQL �� �����������,<br />�������� ������������ PHP.';
$strCantLoadRecodeIconv = '�� ���� ����������� iconv �� recode extension ��������� ��� ���� charset-�, ������������� php ���, ��� ����� ���� ��������������� �� extensions, ��� ���������� ���� charset-� � phpMyAdmin.';
$strCantRenameIdxToPrimary = '��������� ������������� ������ � PRIMARY!';
$strCantUseRecodeIconv = '�� ����  ����������� ��/��� iconv, ��/��� libiconv, ��/��� ������� recode_string ���� ���� ����������� extension reports. �������� ���� php ������������.';
$strCardinality = 'ʳ������ ��������';
$strCarriage = '���������� �������: \\r';
$strChange = '������';
$strChangeDisplay = '������� ���� ��� �����������';
$strChangePassword = '������ ������';
$strCharsetOfFile = '��������� �����:';
$strCheckAll = '³������ ���';
$strCheckDbPriv = '��������� ������ ���� �����';
$strCheckTable = '��������� �������';
$strChoosePage = '����� ������� ������� ��� �����������';
$strColComFeat = '���������� �������� ��������';
$strColumn = '�������';
$strColumnNames = '����� �������';
$strComments = '��������';
$strCompleteInserts = '����� �������';
$strConfigFileError = 'phpMyAdmin �� ���� ��������� ��������������� ���� <br />�� ���� ������� � ���� �������, ���� php ��������� �� ����������� ������� (parse error) � �����, ��� �� ���� ������ ������ �����.<br />���������� ��������������� ���� ������������� �� ��������� ��������� �������� ����� � ���������� �������� ����������� ��� ������� (php error messages). ��������� ���� � ���� ������ ����� ����� �� ���������.  <br />���� �� �������� ������� �������, - ������� ��� � �������.';
$strConfigureTableCoord = '����� �������������� ���������� ������� %s';
$strConfirm = '�� �������� ������ �� �������?';
$strCookiesRequired = '� ����� ������� Cookies ������� ���� ���������.';
$strCopyTable = '��������� ������� � (���� �����<b>.</b>�������):';
$strCopyTableOK = '������� %s ���� ���������� � %s.';
$strCreate = '��������';
$strCreateIndex = '�������� ������ ��&nbsp;%s&nbsp;��������';
$strCreateIndexTopic = '�������� ����� ������';
$strCreateNewDatabase = '�������� ���� ��';
$strCreateNewTable = '�������� ���� ������� � �� %s';
$strCreatePage = '�������� ���� �������';
$strCreatePdfFeat = '�������� PDF-����';
$strCriteria = '�������';

$strData = '����';
$strDataDict = '������� �����';
$strDataOnly = '���� ����';
$strDatabase = '�� ';
$strDatabaseHasBeenDropped = '���� ����� %s �������.';
$strDatabaseWildcard = '���� ����� (��������� ������������ ��������):';
$strDatabases = '���� �����';
$strDatabasesStats = '���������� ��� �����';
$strDefault = '�� ������������';
$strDelete = '��������';
$strDeleteFailed = '��������� �� �������!';
$strDeleteUserMessage = '�������� ����������� %s.';
$strDeleted = '����� ��������';
$strDeletedRows = '�������� �������� �����:';
$strDescending = '���������';
$strDisabled = '�����������';
$strDisplay = '��������';
$strDisplayFeat = '�������� ���������';
$strDisplayOrder = '������� ���������:';
$strDisplayPDF = '�������� PDF �����';
$strDoAQuery = '�������� "����� ����� ��������" (������ �����������: "%")';
$strDoYouReally = '�� �������� ������ ';
$strDocu = '������������';
$strDrop = '�������';
$strDropDB = '������� �� %s';
$strDropTable = '�������� �������';
$strDumpXRows = 'Ǵ��������� ���� %s ����� ��������� � %s -��.';
$strDumpingData = '���� ����� �������';
$strDynamic = '���������';

$strEdit = '����������';
$strEditPDFPages = '���������� PDF �������';
$strEditPrivileges = '����������� �������';
$strEffective = '������������';
$strEmpty = '��������';
$strEmptyResultSet = 'MySQL ��������� ������ ��������� (����� ���� �����).';
$strEnabled = '���������';
$strEnd = 'ʳ����';
$strEndCut = 'END CUT';
$strEndRaw = 'END RAW';
$strEnglishPrivileges = ' ����������: ������ MySQL ��������� ��-��������� ';
$strError = '�������';
$strExplain = '��������� SQL';
$strExport = '�������';
$strExportToXML = '������������ � XML ������';
$strExtendedInserts = '��������� �������';
$strExtra = '���������';

$strField = '����';
$strFieldHasBeenDropped = '���� %s ���� ��������';
$strFields = '����';
$strFieldsEmpty = ' �������� ������ ����! ';
$strFieldsEnclosedBy = '���� ����� �';
$strFieldsEscapedBy = '���� �����������';
$strFieldsTerminatedBy = '���� ��������';
$strFixed = '����������';
$strFlushTable = '�������� ��� ������� ("FLUSH")';
$strFormEmpty = '�� ������ �������� ��� �����!';
$strFormat = '������';
$strFullText = '����� ������';
$strFunction = '�������';

$strGenBy = '�����������';
$strGenTime = '��� ���������';
$strGeneralRelationFeat = '�������� ���������';
$strGo = '������';
$strGrants = '�����';
$strGzip = '���������� � "gzip"';

$strHasBeenAltered = '���� ������.';
$strHasBeenCreated = '���� ��������.';
$strHaveToShow = '��������� ������� ������� ���� �������� ��� ������';
$strHome = '�� �������';
$strHomepageOfficial = '�������� ������� phpMyAdmin';
$strHomepageSourceforge = '������������ phpMyAdmin � Sourceforge';
$strHost = '����';
$strHostEmpty = '������� ��\'� �����!';

$strIdxFulltext = '���������';
$strIfYouWish = '���� �� ������ ����������� ���� ���� ������� �������, ������� ��������� ������ ������ ����.';
$strIgnore = '������������';
$strImportDocSQL = '����������� docSQL �����';
$strInUse = '���������������';
$strIndex = '������';
$strIndexHasBeenDropped = '������ %s ���� �������';
$strIndexName = '����� �������&nbsp;:';
$strIndexType = '��� �������&nbsp;:';
$strIndexes = '�������';
$strInsecureMySQL = '��� ���� ������������ ������ ��������� (root ��� ������) �� ���������� �������������� ����������� MySQL. ��� MySQL ������ � ����� ������� �������� ��� ���������� � ���� ��� ����\'������ ��� ��������� �� ��������� � �������.';
$strInsert = '��������';
$strInsertAsNewRow = '�������� �� ����� �����';
$strInsertNewRow = '�������� ����� �����';
$strInsertTextfiles = '�������� ������� ����� � �������';
$strInsertedRows = '������ �����:';
$strInstructions = '����������';
$strInvalidName = '"%s" - ������������� �����, �� �� ������ ��������������� ���� ��� ����� ���� �����/�������/����.';

$strKeepPass = '�� �������� ������';
$strKeyname = '��\'� �����';
$strKill = '�����';

$strLength = '�������';
$strLengthSet = '�������/��������*';
$strLimitNumRows = '������ �� �������';
$strLineFeed = '������ ���� �����: \\n';
$strLines = '�����';
$strLinesTerminatedBy = '����� ��������';
$strLinkNotFound = '˳�� �� ��������';
$strLinksTo = '˳��� ��';
$strLocationTextfile = '������ ������������ ���������� �����';
$strLogPassword = '������:';
$strLogUsername = '��\'� �����������:';
$strLogin = '���� � �������';
$strLogout = '����� � �������';

$strMissingBracket = '����� �����';
$strModifications = '����������� ���� ���������';
$strModify = '������';
$strModifyIndexTopic = '������ ������';
$strMoveTable = '��������� ������� � (���� �����<b>.</b>�������):';
$strMoveTableOK = '������� %s ���� ���������� � %s.';
$strMySQLCharset = 'MySQL Charset';
$strMySQLReloaded = 'MySQL ���������������.';
$strMySQLSaid = '³������ MySQL: ';
$strMySQLServerProcess = 'MySQL %pma_s1% �� %pma_s2% �� %pma_s3%';
$strMySQLShowProcess = '�������� �������';
$strMySQLShowStatus = '�������� ���� MySQL';
$strMySQLShowVars = '�������� �������� ����� MySQL';

$strName = '�����';
$strNext = '������';
$strNo = 'ͳ';
$strNoDatabases = '�� �������';
$strNoDescription = '��� �����';
$strNoDropDatabases = '��������� "DROP DATABASE" ����������.';
$strNoExplain = '�� ��������� SQL';
$strNoFrames = '��� ������ phpMyAdmin ������� ������� � ��������� <b>������</b>.';
$strNoIndex = '������ �� ���������!';
$strNoIndexPartsDefined = '�� ��������� ������� �������!';
$strNoModification = '��� ����';
$strNoPassword = '��� ������';
$strNoPhp = '��� PHP ����';
$strNoPrivileges = '��� �������';
$strNoQuery = '�� ������ SQL-�����!';
$strNoRights = '�� ��� ����� ���� ����������� ����!';
$strNoTablesFound = '� �� �� �������� �������.';
$strNoUsersFound = '�� �������� �����������.';
$strNoValidateSQL = '�� ��������� SQL';
$strNone = '����';
$strNotNumber = '�� �� �����!';
$strNotOK = '�� OK';
$strNotSet = '������� <b>%s</b> �� �������� ��� �� ��������� � %s';
$strNotValidNumber = ' ����������� ������� �����!';
$strNull = '����';
$strNumSearchResultsInTable = '%s ��������� � ������� <i>%s</i>';
$strNumSearchResultsTotal = '<b>�����:</b> <i>%s</i> ���������';

$strOK = 'OK';
$strOftenQuotation = '�������� �����. �� ������ ������, �� ���� ���� char � varchar �������� � �����.';
$strOperations = '��������';
$strOptimizeTable = '����������� �������';
$strOptionalControls = '�� ������. ��������� ������� �� ��������� ����������� �������.';
$strOptionally = '�� ������';
$strOptions = '���������';
$strOr = '���';
$strOverhead = '������� �������';

$strPHP40203 = '�� ������������� ����� PHP 4.2.3, ��� �� �������� ������� ��� ����� � multi-byte strings (mbstring). ��� PHP bug report 19404. �� ����� PHP �� ������������� ��������������� � phpMyAdmin.';
$strPHPVersion = '����� PHP';
$strPageNumber = '����� �������:';
$strPartialText = '������� ������';
$strPassword = '������';
$strPasswordEmpty = '�������� ������!';
$strPasswordNotSame = '����� �� �������!';
$strPdfDbSchema = '����� ���� ����� "%s" - ������� %s';
$strPdfInvalidPageNum = '�� ����������� ����� PDF �������!';
$strPdfInvalidTblName = '������� "%s" �� ����!';
$strPdfNoTables = '������� ����';
$strPhp = '�������� PHP ���';
$strPmaDocumentation = '������������ �� phpMyAdmin';
$strPmaUriError = '����� <tt>$cfg[\'PmaAbsoluteUri\']</tt> ������� ���� ����������� � ������ ���������������� ����!';
$strPos1 = '�������';
$strPrevious = '�����';
$strPrimary = '���������';
$strPrimaryKey = '��������� ����';
$strPrimaryKeyHasBeenDropped = '��������� ���� ���� �������';
$strPrimaryKeyName = '��\'� ���������� ����� ������� ���� PRIMARY!';
$strPrimaryKeyWarning = '("PRIMARY" <b>�������</b> ���� ������ <b>����</b> ���������� �����!)';
$strPrint = '����';
$strPrintView = '����� ��� �����';
$strPrivileges = '������';
$strProperties = '����������';
$strPutColNames = '���� ����� ���� � ������� �����';

$strQBE = '����� ����� ��������';
$strQBEDel = '��������';
$strQBEIns = '��������';
$strQueryOnDb = 'SQL-����� �� �� <b>%s</b>:';

$strReType = 'ϳ�����������';
$strRecords = '������';
$strReferentialIntegrity = '������ ��������� ����� �� ���� ��������:';
$strRelationNotWorking = '��������� ��������� ������ �� ������������ ��������� ������������. ��� ����, ��� ��������� ����, ��������� %s���%s.';
$strRelationView = '�������� �����������';
$strReloadFailed = '�� ������� ��������������� MySQL.';
$strReloadMySQL = '��������������� MySQL';
$strRememberReload = '�� �������� ��������������� ������.';
$strRenameTable = '������������� ������� �';
$strRenameTableOK = '������� %s ���� ������������� � %s';
$strRepairTable = '����������� �������';
$strReplace = '�������';
$strReplaceTable = '������� ���� ������� ������ � �����';
$strReset = '��������������';
$strRevoke = '³������';
$strRevokeGrant = '³������ ������� ����';
$strRevokeGrantMessage = '���� ������� ������� ���� ��� %s';
$strRevokeMessage = '�� ������ ������ ��� %s';
$strRevokePriv = '³������ ������';
$strRowLength = '������� �����';
$strRowSize = ' ����� ����� ';
$strRows = '�����';
$strRowsFrom = '����� �';
$strRowsModeHorizontal = ' ������������� ';
$strRowsModeOptions = '-�� %s � ��������� ��������� ����� ����� %s ����� ';
$strRowsModeVertical = ' ����������� ';
$strRowsStatistic = '���������� �����';
$strRunQuery = '�������� �����';
$strRunSQLQuery = '�������� SQL �����(�) �� �� %�';
$strRunning = '�� %s';

$strSQL = 'SQL';
$strSQLParserBugMessage = '������� �� ������� ������� � ������ SQL. ����� ���������� ��������� �� �������� ���� � �� ��������� ����� � ������ �����. ����� �������� �������� ������� ���� ���� �� �� �� ����������� ���� � ��������� ������ ���������� ���� ������ � ����� �������. ��������� �������� ��� ����� �� ��������� �������� MySQL � �������� ������. ����������� MySQL ������� ��� ������� ������ ����� (���� � ����) ����� ���� ��������� ��� � ���������� ��������. ���� � ��� ��� �� ��������� �������� �� ������ ���� �������, � � �������� ������ ������ �����������, ����� ��������� ��� ������ SQL ����� �� ������ ������, ���� ������ � ������� ��������, � ������ ����������� ��� ������� � ������� ����� � ����� CUT �����:';
$strSQLParserUserError = 'There seems to be an error in your SQL query. ����������� MySQL ������� ��� ������� ������ ����� (���� � ����) ����� ���� ��������� ��� � ���������� ��������.';
$strSQLQuery = 'SQL-�����';
$strSQLResult = 'SQL result';
$strSQPBugInvalidIdentifer = '����������� �������������';
$strSQPBugUnclosedQuote = '�� ������ �����';
$strSQPBugUnknownPunctuation = '�������� ������ ����������';
$strSave = '��������';
$strScaleFactorSmall = '������� ����� ������� ��� ����� ������� ���� �������';
$strSearch = '������';
$strSearchFormTitle = '������ � ��� �����';
$strSearchInTables = '��������� �������:';
$strSearchNeedle = '����� �� ��������, �� ������� ������ (�����: "%"):';
$strSearchOption1 = '������� ���� � ���';
$strSearchOption2 = '�� �����';
$strSearchOption3 = '����� �����';
$strSearchOption4 = '���������� �����';
$strSearchResultsFor = '���������� ������ "<i>%s</i>" %s:';
$strSearchType = '������:';
$strSelect = '�������';
$strSelectADb = '����� ������� ��';
$strSelectAll = '³������ ���';
$strSelectFields = '������� ���� (���������� ����):';
$strSelectNumRows = '�� ������';
$strSelectTables = '������� �������';
$strSend = '³������';
$strServer = '������ %s';
$strServerChoice = '���� �������';
$strServerVersion = '����� �������';
$strSetEnumVal = '��� ���� ���� "enum" �� "set", ������ �������� ����� ������ �������: \'a\',\'b\',\'c\'...<br />���� ��� ���� ������� ������ �������� ���� ����� ("\"") ��� �������� ����� ("\'") ������� ��� �������, �������� ����� ���� �������� ���� ����� (���������, \'\\\\xyz\' �� \'a\\\'b\').';
$strShow = '��������';
$strShowAll = '�������� ���';
$strShowColor = '�������� ����';
$strShowCols = '�������� �������';
$strShowGrid = '�������� ����';
$strShowPHPInfo = '�������� ���������� ��� PHP';
$strShowTableDimension = '�������� ������ �������';
$strShowTables = '�������� �������';
$strShowThisQuery = ' �������� ����� ����� ����� ';
$strShowingRecords = '�������� ������ ';
$strSingly = '(������)';
$strSize = '�����';
$strSort = '�����������';
$strSpaceUsage = '������, �� ���������������';
$strSplitWordsWithSpace = '����� �������� ������� (" ").';
$strStatement = '��������';
$strStrucCSV = 'CSV ����';
$strStrucData = '��������� � ����';
$strStrucDrop = '������ ��������� �������';
$strStrucExcelCSV = 'CSV ��� ����� MS Excel';
$strStrucOnly = '���� ���������';
$strStructPropose = '������������� ��������� �������';
$strStructure = '���������';
$strSubmit = '��������';
$strSuccess = '��� SQL-����� ���� ������ ��������';
$strSum = '������';

$strTable = '������� ';
$strTableComments = '�������� �� �������';
$strTableEmpty = '������� ����� �������!';
$strTableHasBeenDropped = '������� %s ���� �������';
$strTableHasBeenEmptied = '������� %s ���� �������';
$strTableHasBeenFlushed = '���� ������� ��� ������� %s';
$strTableMaintenance = '������������� �������';
$strTableStructure = '��������� �������';
$strTableType = '��� �������';
$strTables = '%s ������(�)';
$strTextAreaLength = ' ����� ������ �������,<br /> �� ���� �� ���� ���� ������������ ';
$strTheContent = '���� ����� ���� �����������.';
$strTheContents = '���� ����� ������ ���� ������� ��� ����� � ����������� ��������� ��� ����������� �������.';
$strTheTerminator = '������ ��������� ����.';
$strTotal = '������';
$strType = '���';

$strUncheckAll = '����� �� ������';
$strUnique = '���������';
$strUnselectAll = '����� �� ������';
$strUpdatePrivMessage = '���� ������ ������ ���';
$strUpdateProfile = '�������� �������:';
$strUpdateProfileMessage = '������� ���� ���������.';
$strUpdateQuery = '��������� �����';
$strUsage = '������������';
$strUseBackquotes = '�������� ����� � ������ ������� � ����';
$strUseTables = '��������������� �������';
$strUser = '����������';
$strUserEmpty = '������� �\'�� �����������!';
$strUserName = '��\'� �����������';
$strUsers = '�����������';

$strValidateSQL = '��������� SQL';
$strValidatorError = '�� ���� ��������� �������� SQL. ����� ��������������� �� ������������� ��������� php extensions �� ������� � %s������������%s.';
$strValue = '��������';
$strViewDump = '����������� ���� (�����) �������';
$strViewDumpDB = '����������� ���� (�����) ��';

$strWebServerUploadDirectory = '������� ���-������� ��� ������������ ����� (upload directory)';
$strWebServerUploadDirectoryError = '������������ ���� ������� ��� ������������ ����� �����������';
$strWelcome = '������� ������� �� %s';
$strWithChecked = '� ���������:';
$strWrongUser = '������� ����/������. ������ �� ���������.';

$strYes = '���';

$strZip = '���������� � "zip"';
// To translate

$strCompression = 'Compression'; //to translate
$strNumTables = 'Tables'; //to translate
$strTotalUC = 'Total'; //to translate
?>
