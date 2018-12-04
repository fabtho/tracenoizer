<?php
/* $Id: danish-iso-8859-1.inc.php,v 1.29 2002/11/28 09:15:26 rabus Exp $ */

$charset = 'iso-8859-1';
$text_dir = 'ltr';
$left_font_family = 'verdana, arial, helvetica, geneva, sans-serif';
$right_font_family = 'arial, helvetica, geneva, sans-serif';
$number_thousands_separator = ',';
$number_decimal_separator = '.';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB');

$day_of_week = array('S�n', 'Man', 'Tir', 'Ons', 'Tor', 'Fre', 'L�r');
$month = array('Jan', 'Feb', 'Mar', 'Apr', 'Maj', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dec');
// See http://www.php.net/manual/en/function.strftime.php
// to define the variable below
$datefmt = '%d/%m %Y kl. %H:%M:%S';

$strAccessDenied = 'Adgang N�gtet';
$strAction = 'Handling';
$strAddDeleteColumn = 'Tilf�j/Slet felt kolonne';
$strAddDeleteRow = 'Tilf�j/Slet kriterie r�kke';
$strAddNewField = 'Tilf�j nyt felt';
$strAddPriv = 'Tilf�j nyt privilegium';
$strAddPrivMessage = 'Du har tilf�jet et nyt privilegium.';
$strAddSearchConditions = 'Tilf�j s�gekriterier (kroppen af "WHERE" s�tningen):';
$strAddToIndex = 'F�j til indeks &nbsp;%s&nbsp;kolonne(r)';
$strAddUser = 'Tilf�j en ny bruger';
$strAddUserMessage = 'Du har tilf�jet en ny bruger.';
$strAffectedRows = 'Ber�rte r�kker:';
$strAfter = 'Efter %s';
$strAfterInsertBack = 'Retur';
$strAfterInsertNewInsert = 'Inds�t en ny record';
$strAll = 'Alle';
$strAlterOrderBy = 'Arranger r�kkeorden efter';
$strAnalyzeTable = 'Analyser tabel';
$strAnd = 'Og';
$strAnIndex = 'Der er tilf�jet et indeks til %s';
$strAny = 'Enhver';
$strAnyColumn = 'Enhver kolonne';
$strAnyDatabase = 'Enhver database';
$strAnyHost = 'Enhver v�rt';
$strAnyTable = 'Enhver tabel';
$strAnyUser = 'Enhver bruger';
$strAPrimaryKey = 'Der er f�jet en prim�r n�gle til %s';
$strAscending = 'Stigende';
$strAtBeginningOfTable = 'I begyndelsen af tabel';
$strAtEndOfTable = 'I slutningen af tabel';
$strAttr = 'Attributter';

$strBack = 'Tilbage';
$strBinary = ' Bin�rt ';
$strBinaryDoNotEdit = ' Bin�rt - m� ikke �ndres ';
$strBookmarkDeleted = 'Bogm�rket er fjernet.';
$strBookmarkLabel = 'Label';
$strBookmarkQuery = 'SQL-foresp�rgsel med bogm�rke';
$strBookmarkThis = 'Lav bogm�rke til denne SQL-foresp�rgsel';
$strBookmarkView = 'Kun oversigt';
$strBrowse = 'Vis';
$strBzip = '"bzipped"';

$strCantLoadMySQL = 'MySQL udvidelser kan ikke loades,<br />check PHP konfigurationen.';
$strCantRenameIdxToPrimary = 'Kan ikke omd�be indeks til PRIMARY!';
$strCardinality = 'Kardinalitet';
$strCarriage = 'Carriage return: \\r';
$strChange = '�ndre';
$strChangePassword = '�ndre password';
$strCheckAll = 'Afm�rk alt';
$strCheckDbPriv = 'Tjek database privilegier';
$strCheckTable = 'Tjek tabel';
$strColumn = 'Kolonne';
$strColumnNames = 'Kolonne navne';
$strCompleteInserts = 'Lav komplette inserts';
$strConfirm = 'Ikke du sikker p� at du vil g�re det?';
$strCookiesRequired = 'Herefter skal cookies v�re sat til.';
$strCopyTable = 'Kopier tabel til (database<b>.</b>tabel):';
$strCopyTableOK = 'Tabellen %s er nu kopieret til: %s.';
$strCreate = 'Opret';
$strCreateIndex = 'Dan et indeks p�&nbsp;%s&nbsp;kolonner';
$strCreateIndexTopic = 'Lav et nyt indeks';
$strCreateNewDatabase = 'Opret ny database';
$strCreateNewTable = 'Opret ny tabel i database %s';
$strCriteria = 'Kriterier';

$strData = 'Data';
$strDatabase = 'Database: ';
$strDatabaseHasBeenDropped = 'Database %s er slettet.';
$strDatabases = 'databaser';
$strDatabasesStats = 'Database statistik';
$strDatabaseWildcard = 'Database (jokertegn tilladt):';
$strDataOnly = 'Kun data';
$strDefault = 'Standardv�rdi';
$strDelete = 'Slet';
$strDeleted = 'R�kken er slettet!';
$strDeletedRows = 'Slettede r�kker:';
$strDeleteFailed = 'Kan ikke slette!';
$strDeleteUserMessage = 'Du har slettet brugeren %s.';
$strDescending = 'Faldende';
$strDisplay = 'Vis';
$strDisplayOrder = 'R�kkef�lge af visning:';
$strDoAQuery = 'K�r en foresp�rgsel p� felter (wildcard: "%")';
$strDocu = 'Dokumentation';
$strDoYouReally = 'Er du sikker p� at du vil ';
$strDrop = 'Slet';
$strDropDB = 'Slet database %s';
$strDropTable = 'Slet tabel';
$strDumpingData = 'Data dump for tabellen';
$strDynamic = 'dynamisk';

$strEdit = 'Ret';
$strEditPrivileges = 'Ret privilegier';
$strEffective = 'Effektiv';
$strEmpty = 'T�m';
$strEmptyResultSet = 'MySQL returnerede ingen data (fx ingen r�kker).';
$strEnd = 'Slut';
$strEnglishPrivileges = ' NB: Navne p� MySQL privilegier er p� engelsk ';
$strError = 'Fejl';
$strExtendedInserts = 'Udvidede inserts';
$strExtra = 'Ekstra';

$strField = 'Feltnavn';
$strFieldHasBeenDropped = 'Felt %s er slettet';
$strFields = 'Felter';
$strFieldsEmpty = ' Felttallet har ingen v�rdi! ';
$strFieldsEnclosedBy = 'Felter indrammet med';
$strFieldsEscapedBy = 'Felter escaped med';
$strFieldsTerminatedBy = 'Felter afsluttet med';
$strFixed = 'ordnet';
$strFlushTable = 'Flush tabellen ("FLUSH")';
$strFormat = 'Format';
$strFormEmpty = 'Ingen v�rdi i formularen !';
$strFullText = 'Komplette tekster';
$strFunction = 'Funktion';

$strGenTime = 'Genereringstidspunkt';
$strGo = 'Udf�r';
$strGrants = 'Tildelinger';
$strGzip = '"gzipped"';

$strHasBeenAltered = 'er �ndret.';
$strHasBeenCreated = 'er oprettet.';
$strHome = 'Hjem';
$strHomepageOfficial = 'Officiel phpMyAdmin hjemmeside ';
$strHomepageSourceforge = 'Ny phpMyAdmin hjemmeside ';
$strHost = 'V�rt';
$strHostEmpty = 'Der er intet v�rtsnavn!';

$strIdxFulltext = 'Fuldtekst';
$strIfYouWish = 'Hvis du kun �nsker at importere nogle af tabellens kolonner, angives de med en kommasepareret felt liste.';
$strIgnore = 'Ignorer';
$strIndex = 'Indeks';
$strIndexes = 'Indekser';
$strIndexHasBeenDropped = 'Indeks %s er blevet slettet';
$strIndexName = 'Indeks navn&nbsp;:';
$strIndexType = 'Indeks type&nbsp;:';
$strInsert = 'Inds�t';
$strInsertAsNewRow = 'Inds�t som ny r�kke';
$strInsertedRows = 'Indsatte r�kker:';
$strInsertNewRow = 'Inds�t ny r�kke';
$strInsertTextfiles = 'Importer tekstfil til tabellen';
$strInstructions = 'Instruktioner';
$strInUse = 'i brug';
$strInvalidName = '"%s" er et reserveret ord, du kan ikke bruge det som database-, tabel- eller feltnavn.';

$strKeepPass = 'Password m� ikke �ndres';
$strKeyname = 'N�gle';
$strKill = 'Kill';

$strLength = 'L�ngde';
$strLengthSet = 'L�ngde/V�rdi*';
$strLimitNumRows = 'poster pr. side';
$strLineFeed = 'Linefeed: \\n';
$strLines = 'Linier';
$strLinesTerminatedBy = 'Linier afsluttet med';
$strLocationTextfile = 'Tekstfilens placering';
$strLogin = 'Login';
$strLogout = 'Log af';
$strLogPassword = 'Password:';
$strLogUsername = 'Brugernavn:';

$strModifications = 'Rettelserne er gemt!';
$strModify = 'Ret';
$strModifyIndexTopic = '�ndring af et indeks';
$strMoveTable = 'Flyt tabel til (database<b>.</b>tabel):';
$strMoveTableOK = 'Tabel %s er flyttet til %s.';
$strMySQLReloaded = 'MySQL genstartet.';
$strMySQLSaid = 'MySQL returnerede: ';
$strMySQLServerProcess = 'MySQL %pma_s1% k�rer p� %pma_s2% som %pma_s3%';
$strMySQLShowProcess = 'Vis tr�de';
$strMySQLShowStatus = 'Vis MySQL runtime information';
$strMySQLShowVars = 'Vis MySQL system variable';

$strName = 'Navn';
$strNext = 'N�ste';
$strNo = 'Nej';
$strNoDatabases = 'Ingen databaser';
$strNoDropDatabases = '"DROP DATABASE" erkl�ringer kan ikke bruges.';
$strNoFrames = 'phpMyAdmin er mere brugervenlig med en browser, der kan klare <b>frames</b>.';
$strNoIndex = 'Intet indeks defineret!';
$strNoIndexPartsDefined = 'Ingen dele af indeks er definerede!';
$strNoModification = 'Ingen �ndring';
$strNone = 'Intet';
$strNoPassword = 'Intet password';
$strNoPrivileges = 'Ingen privilegier';
$strNoQuery = 'Ingen SQL foresp�rgsel!';
$strNoRights = 'Du har ikke tilstr�kkelige rettigheder til at v�re her!';
$strNoTablesFound = 'Ingen tabeller fundet i databasen.';
$strNotNumber = 'Dette er ikke et tal!';
$strNotValidNumber = ' er ikke et gyldigt r�kkenummer!';
$strNoUsersFound = 'Ingen bruger(e) fundet.';
$strNull = 'Nulv�rdi';

$strOftenQuotation = 'Ofte anf�rselstegn. OPTIONALLY betyder at kun char og varchar felter er omsluttet med det valgte "tekstkvalifikator"-tegn.'; //skal muligvis �ndres
$strOptimizeTable = 'Optimer tabel';
$strOptionalControls = 'Valgfrit. Kontrollerer hvordan specialtegn skrives eller l�ses.';
$strOptionally = 'OPTIONALLY';
$strOr = 'Eller';
$strOverhead = 'Overhead';

$strPartialText = 'Delvise tekster';
$strPassword = 'Password';
$strPasswordEmpty = 'Der er ikke angivet noget password!';
$strPasswordNotSame = 'De to passwords er ikke ens!';
$strPHPVersion = 'PHP version';
$strPmaDocumentation = 'phpMyAdmin dokumentation';
$strPmaUriError = '<tt>$cfg[\'PmaAbsoluteUri\']</tt> direktivet SKAL v�re sat i konfigurationsfilen!';
$strPos1 = 'Start';
$strPrevious = 'Forrige';
$strPrimary = 'Prim�r';
$strPrimaryKey = 'Prim�r n�gle';
$strPrimaryKeyHasBeenDropped = 'Prim�rn�glen er slettet';
$strPrimaryKeyName = 'Navnet p� prim�rn�glen skal v�re... PRIMARY!';
$strPrimaryKeyWarning = '("PRIMARY" <b>skal</b> v�re navnet p� og <b>kun p�</b> en prim�r n�gle!)';
$strPrintView = 'Vis (udskriftvenlig)';
$strPrivileges = 'Privilegier';
$strProperties = 'Egenskaber';

$strQBE = 'Query by Example';
$strQBEDel = 'Del';
$strQBEIns = 'Ins';
$strQueryOnDb = 'SQL-foresp�rgsel til database <b>%s</b>:';

$strRecords = 'Poster';
$strReferentialIntegrity = 'Check reference integriteten';
$strReloadFailed = 'Genstart af MySQL fejlede.';
$strReloadMySQL = 'Genstart MySQL';
$strRememberReload = 'Husk at indl�se serveren.';
$strRenameTable = 'Omd�b tabel til';
$strRenameTableOK = 'Tabellen %s er nu omd�bt til: %s';
$strRepairTable = 'Reparer tabel';
$strReplace = 'Erstat';
$strReplaceTable = 'Erstat data i tabellen med filens data';
$strReset = 'Nulstil';
$strReType = 'Skriv igen';
$strRevoke = 'Tilbagekald';
$strRevokeGrant = 'Tilbagekald tildeling';
$strRevokeGrantMessage = 'Du har tilbagekaldt det tildelte privilegium for %s';
$strRevokeMessage = 'Du har tilbagekaldt privilegierne for %s';
$strRevokePriv = 'Tilbagekald privilegier';
$strRowLength = 'R�kke l�ngde';
$strRows = 'R�kker';
$strRowsFrom = 'r�kker startende fra';
$strRowSize = ' R�kke st�rrelse ';
$strRowsModeHorizontal = 'vandret';
$strRowsModeOptions = '%s og gentag overskrifter efter %s celler';
$strRowsModeVertical = 'lodret';
$strRowsStatistic = 'R�kke statistik';
$strRunning = 'k�rer p� %s';
$strRunQuery = 'Send foresp�rgsel';
$strRunSQLQuery = 'K�r SQL forsp�rgsel(er) p� database %s';

$strSave = 'Gem';
$strSelect = 'V�lg';
$strSelectADb = 'V�lg en database';
$strSelectAll = 'V�lg alle';
$strSelectFields = 'V�lg mindst eet felt:';
$strSelectNumRows = 'i foresp�rgsel';
$strSend = 'Send';
$strServerChoice = 'Server valg';
$strServerVersion = 'Server version';
$strSetEnumVal = 'Hvis et felt er af typen "enum" eller "set", skal v�rdierne angives p� formen: \'a\',\'b\',\'c\'...<br />Skulle du f� brug for en backslash ("\") eller et enkelt anf�rselstegn ("\'") blandt disse v�rdier, s� tilf�j en ekstra backslash (fx \'\\\\xyz\' or \'a\\\'b\').';
$strShow = 'Vis';
$strShowAll = 'Vis alt';
$strShowCols = 'Vis kolonner';
$strShowingRecords = 'Viser poster ';
$strShowPHPInfo = 'Vis PHP information';
$strShowTables = 'Vis tabeller';
$strShowThisQuery = ' Vis foresp�rgslen her igen ';
$strSingly = '(enkeltvis)';
$strSize = 'St�rrelse';
$strSort = 'Sorter';
$strSpaceUsage = 'Pladsforbrug';
$strSQLQuery = 'SQL-foresp�rgsel';
$strStatement = 'Erkl�ringer';
$strStrucCSV = 'CSV data';
$strStrucData = 'Struturen og data';
$strStrucDrop = 'Tilf�j \'DROP TABLE\'';
$strStrucExcelCSV = 'CSV for Ms Excel data';
$strStrucOnly = 'Kun strukturen';
$strSubmit = 'Send';
$strSuccess = 'Din SQL-foresp�rgsel blev udf�rt korrekt';
$strSum = 'Sum';

$strTable = 'Tabel';
$strTableComments = 'Tabel kommentarer';
$strTableEmpty = 'Intet tabelnavn!';
$strTableHasBeenDropped = 'Tabel %s er slettet';
$strTableHasBeenEmptied = 'Tabel %s er t�mt';
$strTableHasBeenFlushed = 'Tabel %s er blevet flushet';
$strTableMaintenance = 'Tabel vedligehold';
$strTables = '%s tabel(ler)';
$strTableStructure = 'Struktur dump for tabellen';
$strTableType = 'Tabel type';
$strTextAreaLength = ' P� grund af feltets l�ngde,<br /> kan det muligvis ikke �ndres ';
$strTheContent = 'Filens indhold er importeret.';
$strTheContents = 'Filens indhold erstatter den valgte tabels r�kker for r�kker med identisk prim�r eller unik n�gle.';
$strTheTerminator = 'Felterne afgr�nses af dette tegn.';
$strTotal = 'total';
$strType = 'Datatype';

$strUncheckAll = 'Fjern alle m�rker';
$strUnique = 'Unik';
$strUnselectAll = 'Frav�lg alle';
$strUpdatePrivMessage = 'Du har opdateret privilegierne for %s.';
$strUpdateProfile = 'Opdater profil:';
$strUpdateProfileMessage = 'Profilen er blevet opdateret.';
$strUpdateQuery = 'Opdater foresp�rgsel';
$strUsage = 'Benyttelse';
$strUseBackquotes = 'Use backquotes with tables and fields\' names';
$strUser = 'Bruger';
$strUserEmpty = 'Intet brugernavn!';
$strUserName = 'Brugernavn';
$strUsers = 'Brugere';
$strUseTables = 'Benyt tabeller';

$strValue = 'V�rdi';
$strViewDump = 'Vis dump (skema) over tabel';
$strViewDumpDB = 'Vis dump (skema) af database';

$strWelcome = 'Velkommen til %s';
$strWithChecked = 'Med det afm�rkede:';
$strWrongUser = 'Forkert brugernavn/kodeord. Adgang n�gtet.';

$strYes = 'Ja';

$strZip = '"zipped"';

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
