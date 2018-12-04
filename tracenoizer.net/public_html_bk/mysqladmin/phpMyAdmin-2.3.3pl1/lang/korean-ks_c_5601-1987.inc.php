<?php
/* $Id: korean-ks_c_5601-1987.inc.php,v 1.30 2002/11/28 09:15:35 rabus Exp $ */

/* Translated by WooSuhan <kjh@unews.co.kr> */

$charset = 'ks_c_5601-1987';
$text_dir = 'ltr';
$left_font_family = '"����", sans-serif';
$right_font_family = '"����", sans-serif';
$number_thousands_separator = ',';
$number_decimal_separator = '.';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('����Ʈ', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB');

$day_of_week = array('��', '��', 'ȭ', '��', '��', '��', '��');
$month = array('�ؿ�����', '�û���', '��������', '�ٻ���', 'Ǫ����', '������', '�߿������', 'Ÿ������', '���Ŵ�', '�ϴÿ���', '��ƴ��', '�ŵ��');
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%Y�� %B %d�� %p %I:%M ';

$strAPrimaryKey = ' %s�� �⺻(�����̸Ӹ�)Ű�� �߰��Ǿ����ϴ�';
$strAccessDenied = '������ �źεǾ����ϴ�.';
$strAction = '����';
$strAddDeleteColumn = '�ʵ� Į�� �߰�/����';
$strAddDeleteRow = 'Criteria ���ڵ�(��) �߰�/����';
$strAddNewField = '�ʵ� �߰��ϱ�';
$strAddPriv = '���� �߰��ϱ�';
$strAddPrivMessage = '�� ������ �߰��߽��ϴ�';
$strAddSearchConditions = '�˻� ���� �߰� ("where" ����):';
$strAddToIndex = '%sĮ���� �ε��� �߰�';
$strAddUser = '�� ����� �߰�';
$strAddUserMessage = '�� ����ڸ� �߰��߽��ϴ�.';
$strAffectedRows = '����� ���ڵ�(��):';
$strAfter = '%s ������';
$strAfterInsertBack = '�ǵ��ư���';
$strAfterInsertNewInsert = '�� ���ڵ�(��) �����ϱ�';
$strAlterOrderBy = '���� ������� ���̺� ����(����)';
$strAnIndex = '%s �� �ε����� �ɷȽ��ϴ�';
$strAnalyzeTable = '���̺� �м�';
$strAnd = '�׸���';
$strAnyColumn = '��� Į��';
$strAnyDatabase = '�ƹ� �����ͺ��̽�';
$strAnyHost = '�ƹ�������';
$strAnyTable = '��� ���̺�';
$strAnyUser = '�ƹ���';
$strAscending = '��������';
$strAtBeginningOfTable = '���̺��� ó��';
$strAtEndOfTable = '���̺��� ������';
$strAttr = '����';

$strBack = '�ڷ�';
$strBinary = '���̳ʸ�';
$strBinaryDoNotEdit = ' ���̳ʸ� - ���� ���� ';
$strBookmarkDeleted = '�ϸ�ũ�� �����߽��ϴ�.';
$strBookmarkQuery = '�ϸ�ũ�� SQL ����';
$strBookmarkThis = '�� SQL ������ �ϸ�ũ��';
$strBrowse = '����';
$strBzip = '"bz ����"';

$strCantLoadMySQL = 'MySQL Ȯ������ �ҷ��� �� �����ϴ�.<br />PHP ������ �˻��Ͻʽÿ�..';
$strCantRenameIdxToPrimary = '�ε��� �̸��� �⺻(�����̸Ӹ�)Ű�� �ٲ� �� �����ϴ�!';
$strCarriage = 'ĳ���� ����: \\r';
$strChange = '����';
$strChangePassword = '��ȣ ����';
$strCheckAll = '��� üũ';
$strCheckDbPriv = '�����ͺ��̽� ���� �˻�';
$strCheckTable = '���̺� �˻�';
$strColumn = 'Į��';
$strColumnNames = 'Į��(ĭ) �̸�';
$strCompleteInserts = '������ INSERT�� �ۼ�';
$strConfirm = '������ �� �۾��� �Ͻðڽ��ϱ�?';
$strCopyTable = '���̺� �����ϱ� (�����ͺ��̽���<b>.</b>���̺��):';
$strCopyTableOK = '%s ���̺��� %s ���� ����Ǿ����ϴ�.';
$strCreate = ' ����� ';
$strCreateIndex = '%s Į���� �ε��� ����� ';
$strCreateIndexTopic = '�� �ε��� �����';
$strCreateNewTable = '�����ͺ��̽� %s�� ���ο� ���̺��� ����ϴ�.';

$strData = '������';
$strDataOnly = '�����͸�';
$strDatabase = '�����ͺ��̽� ';
$strDatabaseHasBeenDropped = '�����ͺ��̽� %s �� �����߽��ϴ�.';
$strDatabaseWildcard = '�����ͺ��̽� (���ϵ�ī�幮�� ��� ����):';
$strDatabases = '�����ͺ��̽� ';
$strDatabasesStats = '�����ͺ��̽� ��뷮 ���';
$strDefault = '�⺻��';
$strDelete = '����';
$strDeleteUserMessage = '����� %s �� �����߽��ϴ�.';
$strDeleted = '������ ��(���ڵ�)�� ���� �Ͽ����ϴ�.';
$strDeletedRows = '������ ��(���ڵ�):';
$strDescending = '��������(����)';
$strDisplay = '����';
$strDisplayOrder = '��� ����:';
$strDoAQuery = '�������� ������ ����� (���ϵ�ī��: "%")';
$strDoYouReally = '������ ������ �����Ͻðڽ��ϱ�? ';
$strDocu = '����';
$strDrop = '����';
$strDropDB = '�����ͺ��̽� %s ����';
$strDropTable = '���̺� ����';
$strDumpXRows = '%s���� ���ڵ�(��)�� ���� (%s��° ���ڵ����).';
$strDumpingData = '���̺��� ���� ������';
$strDynamic = '����(���̳���)';

$strEdit = '����';
$strEditPrivileges = '���� ����';
$strEffective = '������';
$strEmpty = '����';
$strEmptyResultSet = '������� �����ϴ�. (�� ���ڵ� ����.)';
$strEnd = '������';
$strEnglishPrivileges = ' ����: MySQL ���� �̸��� ����� ǥ��Ǿ�� �մϴ�. ';
$strError = '����';
$strExtendedInserts = 'Ȯ��� inserts';
$strExtra = '�߰�';

$strField = '�ʵ�';
$strFieldHasBeenDropped = '�ʵ� %s �� �����߽��ϴ�';
$strFields = '�ʵ�';
$strFieldsEmpty = ' �ʵ� ������ �����ϴ�! ';
$strFieldsEnclosedBy = '�ʵ� ���α�';
$strFieldsEscapedBy = '�ʵ� Ư������(escape) ó��';
$strFieldsTerminatedBy = '�ʵ� ������ ';
$strFlushTable = '���̺� �ݱ�(ĳ�� ����)';
$strFunction = '�Լ�';

$strGenTime = 'ó���� �ð�';
$strGo = '����';
$strGrants = '���α���';
$strGzip = 'gz ����';

$strHasBeenAltered = '��(��) �����Ͽ����ϴ�.';
$strHasBeenCreated = '��(��) �ۼ��Ͽ����ϴ�.';
$strHaveToShow = '����Ϸ��� ��� 1�� �̻��� Į���� �����ؾ� �մϴ�.';
$strHome = '����������';
$strHomepageOfficial = 'phpMyAdmin ���� Ȩ';
$strHomepageSourceforge = '�ҽ����� phpMyAdmin �ٿ�ε�';
$strHost = 'ȣ��Ʈ';
$strHostEmpty = 'ȣ��Ʈ���� �����ϴ�!';

$strIfYouWish = '���̺� Į��(ĭ)�� �����͸� �߰��� ���� �ʵ� ����� �޸��� ������ �ֽʽÿ�. ';
$strIgnore = 'Ignore';
$strInUse = '�����';
$strIndex = '�ε���';
$strIndexHasBeenDropped = '�ε��� %s �� �����߽��ϴ�';
$strIndexName = '�ε��� �̸�:';
$strIndexType = '�ε��� ����:';
$strIndexes = '�ε���';
$strInsecureMySQL = '�������� ȯ�漳�������� MySQL ������ �⺻���� ���� ������ �����մϴ�(������ ��ȣ ����). �� �⺻�������� MySQL ������ �۵��Ѵٸ� ������ ħ���� �� �����Ƿ�, �� ���Ȼ� ������ ��ġ�ñ� �ٶ��ϴ�.';
$strInsert = '����';
$strInsertAsNewRow = '�� ���� �����մϴ�';
$strInsertNewRow = '�� ���� ����';
$strInsertTextfiles = '�ؽ�Ʈ������ �о ���̺� ������ ����';
$strInsertedRows = '���Ե� ��:';
$strInstructions = '����';
$strInvalidName = '"%s" �� ����� �ܾ��̹Ƿ� �����ͺ��̽�, ���̺�, �ʵ�� ����� �� �����ϴ�.';

$strKeepPass = '��ȣ�� �������� ����';
$strKeyname = 'Ű �̸�';
$strKill = 'Kill';

$strLength = '����';
$strLengthSet = '����/��*';
$strLimitNumRows = '�������� ���ڵ� ��';
$strLineFeed = '��(��)�ٲ� ����: \\n';
$strLines = '��(��)';
$strLinesTerminatedBy = '��(��) ������';
$strLocationTextfile = 'SQL �ؽ�Ʈ������ ��ġ';
$strLogPassword = '��ȣ:';
$strLogUsername = '����ڸ�:';
$strLogin = '�α���';
$strLogout = '�α׾ƿ�';

$strModifications = '������ ������ ����Ǿ����ϴ�.';
$strModify = '����';
$strModifyIndexTopic = '�ε��� ����';
$strMoveTable = '���̺� �ű�� (�����ͺ��̽���<b>.</b>���̺��):';
$strMoveTableOK = '���̺� %s �� %s �� �Ű���ϴ�.';
$strMySQLCharset = 'MySQL ���ڼ�';
$strMySQLReloaded = 'MySQL�� ��õ��߽��ϴ�.';
$strMySQLSaid = 'MySQL �޽���: ';
$strMySQLServerProcess = '%pma_s2% (MySQL %pma_s1%)�� %pma_s3% �������� ���Խ��ϴ�.';
$strMySQLShowProcess = 'MySQL ���μ��� ����';
$strMySQLShowStatus = 'MySQL ��Ÿ�� ���� ����';
$strMySQLShowVars = 'MySQL �ý��� ȯ�溯�� ����';

$strName = '�̸�';
$strNext = '����';
$strNo = ' �ƴϿ� ';
$strNoDatabases = '����Ÿ���̽��� �����ϴ�';
$strNoDescription = '������ �����ϴ�';
$strNoDropDatabases = '"DROP DATABASE" ������ ������� �ʽ��ϴ�.';
$strNoExplain = '�ؼ�(EXPLAIN) ����';
$strNoFrames = 'phpMyAdmin �� <b>�������� �����ϴ�</b> ���������� �� ���Դϴ�.';
$strNoIndex = '�ε����� �������� �ʾҽ��ϴ�!';
$strNoModification = '��ȭ ����';
$strNoPassword = '��ȣ ����';
$strNoPhp = 'PHP �ڵ� ���� ����';
$strNoPrivileges = '���� ����';
$strNoQuery = 'SQL ���� ����!';
$strNoRights = '��� �����̾��? ���� ���� ���� ������ �����ϴ�!';
$strNoTablesFound = '�����ͺ��̽��� ���̺��� �����ϴ�.';
$strNoUsersFound = '����ڰ� �����ϴ�.';
$strNone = 'None';
$strNotNumber = '�� ����(��ȣ)�� �ƴմϴ�!';
$strNotValidNumber = '�� �ùٸ� �� ��ȣ�� �ƴմϴ�!';

$strOptimizeTable = '���̺� ����ȭ';
$strOptionalControls = 'Ư������ �б�/���� �ɼ�';
$strOptionally = '�ɼ��Դϴ�.';
$strOptions = '���̺� �ɼ�';
$strOr = '�Ǵ�';
$strOverhead = '�δ�';

$strPHPVersion = 'PHP ����';
$strPageNumber = '������ ��ȣ:';
$strPassword = '��ȣ';
$strPasswordEmpty = '��ȣ�� ������ϴ�!';
$strPasswordNotSame = '��ȣ�� �������� �ʽ��ϴ�!';
$strPdfDbSchema = '"%s" ����Ÿ���̽��� ��Ŵ(����) - ������ %s';
$strPdfInvalidPageNum = 'PDF ������ ��ȣ�� �������� �ʾҽ��ϴ�!';
$strPdfInvalidTblName = '"%s" ���̺��� �������� �ʽ��ϴ�!';
$strPdfNoTables = '���̺��� �����ϴ�';
$strPhp = 'PHP �ڵ� ����';
$strPmaDocumentation = 'phpMyAdmin ����';
$strPmaUriError = 'ȯ�漳�� ���Ͽ��� <tt>$cfg[\'PmaAbsoluteUri\']</tt> �ּҸ� �����Ͻʽÿ�!';
$strPos1 = 'ó��';
$strPrevious = '����';
$strPrimary = '�⺻';
$strPrimaryKey = '�⺻(�����̸Ӹ�) Ű';
$strPrimaryKeyHasBeenDropped = '�⺻(�����̸Ӹ�)Ű�� �����߽��ϴ�';
$strPrimaryKeyName = '�⺻(�����̸Ӹ�)Ű�� �̸��� �ݵ�� PRIMARY���� �մϴ�!';
$strPrimaryKeyWarning = '("PRIMARY"�� <b>�ݵ��</b> �⺻(�����̸Ӹ�)Ű�� <b>������</b> �̸��̾�� �մϴ�!)';
$strPrintView = '�μ�� ����';
$strPrivileges = '����';
$strProperties = '�Ӽ�';

$strQBE = '���⿡�� ���� �����';
$strQBEDel = '����';
$strQBEIns = '����';
$strQueryOnDb = '�����ͺ��̽� <b>%s</b>�� SQL ����:';

$strReType = '���Է�';
$strRecords = '���ڵ��';
$strReferentialIntegrity = 'referential ���Ἲ �˻�:';
$strReloadFailed = 'MySQL ��õ��� �����Ͽ����ϴ�.';
$strReloadMySQL = 'MySQL ��õ�';
$strRememberReload = '������ ��õ��ϴ� ���� ����������.';
$strRenameTable = '���̺� �̸� �����ϱ�';
$strRenameTableOK = '���̺� %s��(��) %s(��)�� �����Ͽ����ϴ�.';
$strRepairTable = '���̺� ����';
$strReplace = '��ġ(Replace)';
$strReplaceTable = '���Ϸ� ���̺� ��ġ�ϱ�';
$strReset = '����Ʈ';
$strRevoke = '����';
$strRevokeGrant = '���� ����';
$strRevokeGrantMessage = '%s�� ���� ������ �����߽��ϴ�.';
$strRevokeMessage = '%s�� ������ �����߽��ϴ�.';
$strRevokePriv = '���� ����';
$strRowLength = '�� ����';
$strRowSize = ' Row size ';
$strRows = '��';
$strRowsFrom = '��. ����(��)��ġ';
$strRowsModeHorizontal = '����(����)';
$strRowsModeOptions = ' %s ���� (%s ĭ�� ������ ��� �ݺ�)';
$strRowsModeVertical = '����(����)';
$strRowsStatistic = '���ڵ�(��) ���';
$strRunQuery = '���� ����';
$strRunSQLQuery = '�����ͺ��̽� %s�� SQL ������ ����';
$strRunning = '�Դϴ�. (%s)';

$strSQL = 'SQL';
$strSQLParserUserError = 'SQL �������� ������ �ֽ��ϴ�. MySQL ������ ������ ���� ������ ����߽��ϴ�. �̰��� ������ �����ϴµ� ������ �� ���Դϴ�.';
$strSQLQuery = 'SQL ����';
$strSQLResult = 'SQL ���';
$strSQPBugInvalidIdentifer = '�߸��� �ĺ���(Identifer)';
$strSave = '����';
$strSearch = '�˻�';
$strSearchFormTitle = '����Ÿ���̽� �˻�';
$strSearchInTables = 'ã�� ���̺�:';
$strSearchNeedle = 'ã�� �ܾ�, �� (���ϵ�ī��: "%"):';
$strSearchOption1 = '�ƹ� �ܾ';
$strSearchOption2 = '��� �ܾ�';
$strSearchOption3 = '��Ȯ�� ����';
$strSearchOption4 = '����ǥ����';
$strSearchType = 'ã�� ���:';
$strSelect = '����';
$strSelectADb = '�����ͺ��̽��� �����ϼ���';
$strSelectAll = '��� ����';
$strSelectFields = '�ʵ� ���� (�ϳ� �̻�):';
$strSelectNumRows = '����(in query)';
$strSend = '���Ϸ� ����';
$strServerChoice = '���� ����';
$strServerVersion = '���� ����';
$strSetEnumVal = '�ʵ� ������ "enum"�̳� "set"�̸�, ������ ���� �������� ���� �Է��Ͻʽÿ�: \'a\',\'b\',\'c\'...<br />�� ���� ��������("\")�� ��������ǥ("\'")�� �־�� �Ѵٸ�, �������ø� ����Ͻʽÿ�. (��: \'\\\\xyz\' �Ǵ� \'a\\\'b\').';
$strShow = '����';
$strShowAll = '��� ����';
$strShowCols = 'Į��(ĭ) ����';
$strShowPHPInfo = 'PHP ���� ����';
$strShowTables = '���̺� ����';
$strShowThisQuery = ' �� ������ �ٽ� ������ ';
$strShowingRecords = '���ڵ�(��) ����';
$strSingly = '(�ܵ�����)';
$strSize = 'ũ��';
$strSort = '����';
$strSpaceUsage = '���� ��뷮';
$strSplitWordsWithSpace = '�ܾ�� �����̽�(" ")�� ���е˴ϴ�.';
$strStatement = '��';
$strStrucCSV = 'CSV ������';
$strStrucData = '������ ������ ���';
$strStrucDrop = '\'DROP TABLE\'�� �߰�';
$strStrucExcelCSV = 'MS���� CSV ������';
$strStrucOnly = '������';
$strStructPropose = '�����ϴ� ���̺� ����';
$strStructure = '����';
$strSubmit = 'Ȯ��';
$strSuccess = 'SQL ������ �ٸ��� ����Ǿ����ϴ�.';
$strSum = '��';

$strTable = '���̺� ';
$strTableComments = '���̺� ����';
$strTableEmpty = '���̺���� �����ϴ�!';
$strTableHasBeenDropped = '���̺� %s �� �����߽��ϴ�.';
$strTableHasBeenEmptied = '���̺� %s �� ������ϴ�';
$strTableHasBeenFlushed = '���̺� %s �� �ݾҽ��ϴ�(ĳ�� ����)';
$strTableMaintenance = '���̺� ��������';
$strTableStructure = '���̺� ����';
$strTableType = '���̺� ����';
$strTables = '���̺� %s ��';
$strTextAreaLength = ' �ʵ��� ���� ������,<br />�� �ʵ带 ������ �� �����ϴ� ';
$strTheContent = '���� ������ �����Ͽ����ϴ�.';
$strTheContents = '���� ������ ������ ���̺��� �����̸Ӹ� Ȥ�� ������ Ű�� ��ġ�ϴ� ���� ��ġ(����)��Ű�ڽ��ϴ�.';
$strTheTerminator = '�ʵ� ���� ��ȣ.';
$strTotal = '�հ�';
$strType = '����';

$strUncheckAll = '��� üũ����';
$strUnique = '������';
$strUnselectAll = '��� ���þ���';
$strUpdatePrivMessage = '%s �� ������ ������Ʈ�߽��ϴ�.';
$strUpdateProfile = '�������� ������Ʈ:';
$strUpdateProfileMessage = '���������� ������Ʈ�߽��ϴ�.';
$strUpdateQuery = '���� ������Ʈ';
$strUsage = '����(��)';
$strUseBackquotes = '���̺�, �ʵ�� ������(`) ���';
$strUseTables = '����� ���̺�';
$strUser = '�����';
$strUserEmpty = '����ڸ��� �����ϴ�!';
$strUserName = '����ڸ�';
$strUsers = '����ڵ�';

$strValue = '��';
$strViewDump = '���̺��� ����(��Ű��) ������ ����';
$strViewDumpDB = '�����ͺ��̽��� ����(��Ű��) ������ ����';

$strWelcome = '%s�� ���̽��ϴ�';
$strWithChecked = '������ ����:';
$strWrongUser = '����ڸ�/��ȣ�� Ʋ�Ƚ��ϴ�. ������ �źεǾ����ϴ�.';

$strYes = ' �� ';

$strZip = 'zip ����';

$strAll = 'All'; // To translate
$strAllTableSameWidth = '��� ���̺��� ���� �ʺ�� ����ұ��?';  //to translate
$strAny = 'Any'; // To translate

$strBeginCut = 'BEGIN CUT';  //to translate
$strBeginRaw = 'BEGIN RAW';  //to translate
$strBookmarkLabel = 'Label'; // To translate
$strBookmarkView = 'View only'; // To translate

$strCantLoadRecodeIconv = 'Can not load iconv or recode extension needed for charset conversion, configure php to allow using these extensions or disable charset conversion in phpMyAdmin.';  //to translate
$strCantUseRecodeIconv = 'Can not use iconv nor libiconv nor recode_string function while extension reports to be loaded. Check your php configuration.';  //to translate
$strCardinality = 'Cardinality'; // To translate
$strChangeDisplay = '����� �ʵ� ����';  //to translate
$strCharsetOfFile = '���� ���ڼ�:'; //to translate
$strChoosePage = '������ �������� �����ϼ���';  //to translate
$strColComFeat = 'Į�� �ڸ�Ʈ ����ϱ�';  //to translate
$strComments = 'Comments';  //to translate
$strCompression = 'Compression'; //to translate
$strConfigFileError = 'phpMyAdmin�� ȯ�漳�� ������ ���� �� �����ϴ�!<br />This might happen if php finds a parse error in it or php cannot find the file.<br />Please call the configuration file directly using the link below and read the php error message(s) that you recieve. In most cases a quote or a semicolon is missing somewhere.<br />If you recieve a blank page, everything is fine.'; //to translate
$strConfigureTableCoord = 'Please configure the coordinates for table %s';  //to translate
$strCookiesRequired = '��Ű ����� �����ؾ� �մϴ� past this point.'; // To translate
$strCreateNewDatabase = '�� �����ͺ��̽� �����'; // To translate
$strCreatePage = '�� ������ �����';  //to translate
$strCreatePdfFeat = 'Creation of PDFs';  //to translate
$strCriteria = 'Criteria'; // To translate

$strDataDict = 'Data Dictionary';  //to translate
$strDeleteFailed = 'Deleted Failed!'; // To translate
$strDisabled = 'Disabled';  //to translate
$strDisplayFeat = 'Display Features';  //to translate
$strDisplayPDF = 'Display PDF schema';  //to translate

$strEditPDFPages = 'PDF ������ ����';  //to translate
$strEnabled = 'Enabled';  //to translate
$strEndCut = 'END CUT';  //to translate
$strEndRaw = 'END RAW';  //to translate
$strExplain = 'SQL �ؼ�';  //to translate
$strExport = '��������';  //to translate
$strExportToXML = 'XML �������� ��������'; //to translate

$strFixed = 'fixed'; // To translate
$strFormEmpty = 'Missing value in the form !'; // To translate
$strFormat = 'Format'; // To translate
$strFullText = 'Full Texts'; // To translate

$strGenBy = 'Generated by'; //to translate
$strGeneralRelationFeat = 'General relation features';  //to translate

$strIdxFulltext = 'Fulltext'; // To translate
$strImportDocSQL = 'Import docSQL Files';  //to translate

$strLinkNotFound = 'Link not found';  //to translate
$strLinksTo = 'Links to';  //to translate

$strMissingBracket = 'Missing Bracket';  //to translate

$strNoIndexPartsDefined = 'No index parts defined!'; // To translate
$strNoValidateSQL = 'Skip Validate SQL';  //to translate
$strNotOK = 'not OK';  //to translate
$strNotSet = '<b>%s</b> table not found or not set in %s';  //to translate
$strNull = 'Null'; // To translate
$strNumSearchResultsInTable = '%s match(es) inside table <i>%s</i>';//to translate
$strNumSearchResultsTotal = '<b>Total:</b> <i>%s</i> match(es)';//to translate

$strOK = 'OK';  //to translate
$strOftenQuotation = 'Often quotation marks. �ɼ�(OPTIONALLY)�� char �� varchar �ʵ尪�� ����ǥ(")���ڷ� �ݴ´ٴ� ���� ���մϴ�.';  // To translate
$strOperations = '���̺� �۾�';  //to translate

$strPHP40203 = 'You are using PHP 4.2.3, which has a serious bug with multi-byte strings (mbstring). See PHP bug report 19404. This version of PHP is not recommended for use with phpMyAdmin.';  //to translate
$strPartialText = 'Partial Texts'; // To translate
$strPrint = 'Print';  //to translate
$strPutColNames = '��ó���� �ʵ� �̸��� ���';  //to translate

$strRelationNotWorking = 'linked Tables ���� �۵��ϴ� �ΰ������ ��������Ǿ����ϴ�. ������ �˷��� %s���⸦ Ŭ��%s�Ͻʽÿ�.';  //to translate
$strRelationView = 'Relation view';  //to translate

$strSQLParserBugMessage = 'There is a chance that you may have found a bug in the SQL parser. Please examine your query closely, and check that the quotes are correct and not mis-matched. Other possible failure causes may be that you are uploading a file with binary outside of a quoted text area. You can also try your query on the MySQL command line interface. The MySQL server error output below, if there is any, may also help you in diagnosing the problem. If you still have problems or if the parser fails where the command line interface succeeds, please reduce your SQL query input to the single query that causes problems, and submit a bug report with the data chunk in the CUT section below:';  //to translate
$strSQPBugUnclosedQuote = '����ǥ(quote)�� ������ �ʾ���';  //to translate
$strSQPBugUnknownPunctuation = 'Unknown Punctuation String';  //to translate
$strScaleFactorSmall = 'The scale factor is too small to fit the schema on one page';  //to translate
$strSearchResultsFor = 'Search results for "<i>%s</i>" %s:';//to translate
$strSelectTables = 'Select Tables';  //to translate
$strServer = '���� %s';  //to translate
$strShowColor = 'Show color';  //to translate
$strShowGrid = 'Show grid';  //to translate
$strShowTableDimension = 'Show dimension of tables';  //to translate

$strValidateSQL = 'Validate SQL'; // To Translate
$strValidatorError = 'The SQL validator could not be initialized. Please check if you have installed the necessary php extensions as described in the %sdocumentation%s.'; //to translate

$strWebServerUploadDirectory = '������ ���ε� ���丮';  //to translate
$strWebServerUploadDirectoryError = '���ε� ���丮�� ������ �� �����ϴ�';  //to translate

$strNumTables = 'Tables'; //to translate
$strTotalUC = 'Total'; //to translate
?>
