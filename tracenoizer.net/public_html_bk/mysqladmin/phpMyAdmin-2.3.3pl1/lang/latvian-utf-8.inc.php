<?php
/* $Id: latvian-utf-8.inc.php,v 1.29 2002/11/28 09:15:35 rabus Exp $ */

/**
 * Latvian language file by Sandis Jērics <sandisj at parks.lv>
 */

$charset = 'utf-8';
$allow_recoding = TRUE;
$text_dir = 'ltr'; // ('ltr' for left to right, 'rtl' for right to left)
$left_font_family = 'verdana, arial, helvetica, geneva, sans-serif';
$right_font_family = 'arial, helvetica, geneva, sans-serif';
$number_thousands_separator = ',';
$number_decimal_separator = '.';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('baiti', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB');

$day_of_week = array('Sv', 'Pr', 'Ot', 'Tr', 'Ce', 'Pt', 'Se');
$month = array('Jan', 'Feb', 'Mar', 'Apr', 'Mai', 'Jūn', 'Jūl', 'Aug', 'Sep', 'Okt', 'Nov', 'Dec');
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%d%m.%Y %H:%M';

$strAccessDenied = 'Pieeja aizliegta';
$strAction = 'Darbība';
$strAddDeleteColumn = 'Pievienot/Dzēst laukus (kolonnas)';
$strAddDeleteRow = 'Pievienot/Dzēst ierakstu';
$strAddNewField = 'Pievienot jaunu lauku';
$strAddPriv = 'Pievienot jaunu privilēģiju';
$strAddPrivMessage = 'Jūs pievienojāt jaunu privilēģiju.';
$strAddSearchConditions = 'Pievienot meklēšanas nosacījumus ("where" izteiksmes ķermenis):';
$strAddToIndex = 'Pievienot indeksam &nbsp;%s&nbsp;kolonn(u/as)';
$strAddUser = 'Pievienot jaunu lietotāju';
$strAddUserMessage = 'Jūs pievienojāt jaunu lietotāju.';
$strAffectedRows = 'Ietekmēto rindu skaits:';
$strAfter = 'Pēc %s';
$strAfterInsertBack = 'Atgriezties iepriekšējā lapā atpakaļ';
$strAfterInsertNewInsert = 'Ievietot vēl vienu rindu';
$strAll = 'Visi';
$strAlterOrderBy = 'Mainīt datu kārtošanas laukus';
$strAnalyzeTable = 'Analizēt tabulu';
$strAnd = 'Un';
$strAnIndex = 'Indekss tieka pievienots uz %s';
$strAny = 'Jebkurš';
$strAnyColumn = 'Jebkura kolonna';
$strAnyDatabase = 'Jebkura datubāze';
$strAnyHost = 'Jebkurš hosts';
$strAnyTable = 'Jebkura tabula';
$strAnyUser = 'Jebkurš lietotājs';
$strAPrimaryKey = 'Primārā atslēga pievienota uz lauka %s';
$strAscending = 'Augošā secībā';
$strAtBeginningOfTable = 'Tabulas sākumā';
$strAtEndOfTable = 'Tabulas beigās';
$strAttr = 'Atribūti';

$strBack = 'Atpakaļ';
$strBinary = 'Binārais';
$strBinaryDoNotEdit = 'Binārais - netiek labots';
$strBookmarkDeleted = 'Ieraksts tika dzēsts.';
$strBookmarkLabel = 'Nosaukums';
$strBookmarkQuery = 'Saglabātie SQL-vaicājumi';
$strBookmarkThis = 'Saglabāt šo SQL-vaicājumu';
$strBookmarkView = 'Tikai apskatīt';
$strBrowse = 'Apskatīt';
$strBzip = 'saarhivēts ar bzip';

$strCantLoadMySQL = 'nevar ielādēt MySQL paplašinājumu,<br />lūdzu pārbaudiet PHP konfigurāciju.';
$strCantRenameIdxToPrimary = 'Nevar pārsaukt indeksu par PRIMARY!';
$strCardinality = 'Kardinalitāte';
$strCarriage = 'Rindas nobeiguma simbols: \\r';
$strChange = 'Labot';
$strChangePassword = 'Mainīt paroli';
$strCheckAll = 'Iezīmēt visu';
$strCheckDbPriv = 'Pārbaudīt privilēģijas uz datubāzi';
$strCheckTable = 'Pārbaudīt tabulu';
$strColumn = 'Kolonna';
$strColumnNames = 'Kolonnu nosaukumi';
$strCompleteInserts = 'Pilnas INSERT izteiksmes';
$strConfirm = 'Vai Jūs tiešām gribat to darīt?';
$strCookiesRequired = 'Šī lapa nestrādās korekti, ja \'Cookies\' ir atslēgtas jūsu pārlūkprogrammas konfigurācijā.';
$strCopyTable = 'Kopēt tabulu uz (datubāze<b>.</b>tabula):';
$strCopyTableOK = 'Tabula %s tika pārkopēta uz %s.';
$strCreate = 'Izveidot';
$strCreateIndex = 'Izveidot indeksu uz&nbsp;%s&nbsp;laukiem';
$strCreateIndexTopic = 'Izveidot jaunu indeksu';
$strCreateNewDatabase = 'Izveidot jaunu datubāzi';
$strCreateNewTable = 'Izveidot jaunu tabulu datubāzē %s';
$strCriteria = 'Kritērijs';

$strData = 'Dati';
$strDatabase = 'Datubāze ';
$strDatabaseHasBeenDropped = 'Datubāze %s tika izdzēsta.';
$strDatabases = 'datubāzes';
$strDatabasesStats = 'Datubāzu statistika';
$strDatabaseWildcard = 'Datubāze (var lietot aizstājējzīmes):';
$strDataOnly = 'Tikai dati';
$strDefault = 'Noklusēts';
$strDelete = 'Dzēst';
$strDeleted = 'Ieraksts tika dzēsts';
$strDeletedRows = 'Ieraksti dzēsti:';
$strDeleteFailed = 'Dzēšana nenotika!';
$strDeleteUserMessage = 'Jūs nodzēsāt lietotāju %s.';
$strDescending = 'Dilstošā secībā';
$strDisplay = 'Attēlot';
$strDisplayOrder = 'Attēlošanas secība:';
$strDoAQuery = 'Izpildīt "vaicājumu pēc parauga" (aizstājējzīme: "%")';
$strDocu = 'Dokumentācija';
$strDoYouReally = 'Vai Jūs tiešām gribat ';
$strDrop = 'Likvidēt';
$strDropDB = 'Likvidēt datubāzi %s';
$strDropTable = 'Likvidēt tabulu';
$strDumpingData = 'Dati tabulai';
$strDynamic = 'dinamisks';

$strEdit = 'Labot';
$strEditPrivileges = 'Mainīt privilēģijas';
$strEffective = 'Efektīvs';
$strEmpty = 'Iztukšot';
$strEmptyResultSet = 'MySQL atgrieza tukšo rezultātu (0 rindas).';
$strEnd = 'Beigas';
$strEnglishPrivileges = ' Piezīme: MySQL privilēģiju apzīmējumi tiek rakstīti angļu valodā ';
$strError = 'Kļūda';
$strExtendedInserts = 'Paplašinātās INSERT izteiksmes';
$strExtra = 'Ekstras';

$strField = 'Lauks';
$strFieldHasBeenDropped = 'Lauks %s tika izdzēsts';
$strFields = 'Lauku skaits';
$strFieldsEmpty = ' Lauku skaits ir nulle! ';
$strFieldsEnclosedBy = 'Lauki iekļauti iekš';
$strFieldsEscapedBy = 'Glābjošā (escape) rakstzīme ir';
$strFieldsTerminatedBy = 'Lauki atdalīti ar';
$strFixed = 'fiksēts';
$strFlushTable = 'Atsvaidzināt tabulu ("FLUSH")';
$strFormat = 'Formats';
$strFormEmpty = 'Formā trūkst vērtību!';
$strFullText = 'Pilni teksti';
$strFunction = 'Funkcija';

$strGenTime = 'Izveidošanas laiks';
$strGo = 'Aiziet!';
$strGrants = 'Tiesības';
$strGzip = 'saarhivēts ar gzip';

$strHasBeenAltered = 'tika modificēta.';
$strHasBeenCreated = 'tika izveidota.';
$strHome = 'Sākumlapa';
$strHomepageOfficial = 'Oficiālā phpMyAdmin mājaslapa';
$strHomepageSourceforge = 'phpMyAdmin lejuplādes lapa iekš Sourceforge';
$strHost = 'Hosts';
$strHostEmpty = 'Hosts nav norādīts!';

$strIdxFulltext = 'Pilni teksti';
$strIfYouWish = 'Ja Jūs vēlaties ielādēt tikai dažas tabulas kolonnas, norādiet to nosaukumus, atdalot tos ar komatu.';
$strIgnore = 'Ignorēt';
$strIndex = 'Indekss';
$strIndexes = 'Indeksi';
$strIndexHasBeenDropped = 'Indekss %s tika izdzēsts';
$strIndexName = 'Indeksa nosaukums&nbsp;:';
$strIndexType = 'Indeksa tips&nbsp;:';
$strInsert = 'Pievienot';
$strInsertAsNewRow = 'Ievietot kā jaunu rindu';
$strInsertedRows = 'Rindas pievienotas:';
$strInsertNewRow = 'Pievienot jaunu rindu';
$strInsertTextfiles = 'Ievietot tabulā datus no teksta faila';
$strInstructions = 'Instrukcijas';
$strInUse = 'lietošanā';
$strInvalidName = '"%s" ir rezervēts vārds, Jūs nevarat lietot to kā datubāzes/tabulas/lauka nosaukumu.';

$strKeepPass = 'Nemainīt paroli';
$strKeyname = 'Atslēgas nosaukums';
$strKill = 'Nogalināt';

$strLength = 'Garums';
$strLengthSet = 'Garums/Vērtības*';
$strLimitNumRows = 'Rindu skaits vienā lapā';
$strLineFeed = 'Rindas beigu simbols: \\n';
$strLines = 'Rindas';
$strLinesTerminatedBy = 'Rindas atdalītas ar';
$strLocationTextfile = 'Teksta faila atrašanās vieta';
$strLogin = 'Ieiet';
$strLogout = 'Iziet';
$strLogPassword = 'Parole:';
$strLogUsername = 'Lietotājvārds:';

$strModifications = 'Grozījumi tika saglabāti';
$strModify = 'Modificēt';
$strModifyIndexTopic = 'Modificēt indeksu';
$strMoveTable = 'Pārvietot tabulu uz (datubāze<b>.</b>tabula):';
$strMoveTableOK = 'Tabula %s tika pārvietota uz %s.';
$strMySQLReloaded = 'MySQL serveris tika pārlādēts.';
$strMySQLSaid = 'MySQL teica: ';
$strMySQLServerProcess = 'MySQL %pma_s1% strādā uz %pma_s2% kā %pma_s3%';
$strMySQLShowProcess = 'Parādīt procesus';
$strMySQLShowStatus = 'Parādīt MySQL izpildes laika informāciju';
$strMySQLShowVars = 'Parādīt MySQL sistēmas mainīgos';

$strName = 'Nosaukums';
$strNext = 'Nākamais';
$strNo = 'Nē';
$strNoDatabases = 'Nav datubāzu';
$strNoDropDatabases = '"DROP DATABASE" komanda ir aizliegta.';
$strNoFrames = 'phpMyAdmin ir vairāk draudzīgs <b>freimu atbalstošu</b> pārlūkprogrammu.';
$strNoIndex = 'Nav definēti indeksi!';
$strNoIndexPartsDefined = 'Nav definēto indeksa daļu!';
$strNoModification = 'Netika labots';
$strNone = 'Nekas';
$strNoPassword = 'Nav paroles';
$strNoPrivileges = 'Nav privilēģiju';
$strNoQuery = 'Nav SQL vaicājuma!';
$strNoRights = 'Jums nav pietiekoši tiesību, lai atrastos šeit tagad!';
$strNoTablesFound = 'Tabulas nav atrastas šajā datubāzē.';
$strNotNumber = 'Tas nav numurs!';
$strNotValidNumber = ' nav derīgs lauku skaits!';
$strNoUsersFound = 'Lietotāji netika atrasti.';
$strNull = 'Nulle';

$strOftenQuotation = 'Parasti pēdiņas. NEOBLIGĀTS nozīmē, ka tikai \'char\' un \'varchar\' tipa lauki tiek norobežoti ar šo simbolu.';
$strOptimizeTable = 'Optimizēt tabulu';
$strOptionalControls = 'Neobligāts. Nosaka, kā rakstīt vai lasīt speciālās rakstzīmes.';
$strOptionally = 'NEOBLIGĀTS';
$strOr = 'Vai';
$strOverhead = 'Pārtēriņš';

$strPartialText = 'Daļēji teksti';
$strPassword = 'Parole';
$strPasswordEmpty = 'Parole nav norādīta!';
$strPasswordNotSame = 'Paroles nesakrīt!';
$strPHPVersion = 'PHP Versija';
$strPmaDocumentation = 'phpMyAdmin dokumentācija';
$strPmaUriError = '<tt>$cfg[\'PmaAbsoluteUri\']</tt> direktīvai ir JĀBŪT nodefinētai Jūsu konfigurācijas failā!';
$strPos1 = 'Sākums';
$strPrevious = 'Iepriekšējie';
$strPrimary = 'Primārā';
$strPrimaryKey = 'Primārā atslēga';
$strPrimaryKeyHasBeenDropped = 'Primārā atslēga tika izdzēsta';
$strPrimaryKeyName = 'Primārās atslēgas nosaukumam jābūt... PRIMARY!';
$strPrimaryKeyWarning = '("PRIMARY" <b>jābūt</b> tikai un <b>vienīgi</b> primārās atslēgas indeksa nosaukumam!)';
$strPrintView = 'Izdrukas versija';
$strPrivileges = 'Privilēģijas';
$strProperties = 'Īpašības';

$strQBE = 'Vaicājums pēc parauga';
$strQBEDel = 'Dzēst';
$strQBEIns = 'Ielikt';
$strQueryOnDb = 'SQL-vaicājums uz datubāzes <b>%s</b>:';

$strRecords = 'Ieraksti';
$strReferentialIntegrity = 'Pārbaudīt referenciālo integritāti:';
$strReloadFailed = 'Nesanāca pārlādēt MySQL serveri.';
$strReloadMySQL = 'Pārlādēt MySQL serveri';
$strRememberReload = 'Neaizmirstiet pārlādēt serveri.';
$strRenameTable = 'Pārsaukt tabulu uz';
$strRenameTableOK = 'Tabula %s tika pārsaukta par %s';
$strRepairTable = 'Restaurēt tabulu';
$strReplace = 'Aizvietot';
$strReplaceTable = 'Aizvietot tabulas datus ar datiem no faila';
$strReset = 'Atcelt';
$strReType = 'Atkārtojiet';
$strRevoke = 'Atsaukt';
$strRevokeGrant = 'Atņemt \'Grant\' tiesības';
$strRevokeGrantMessage = 'Jūs atņēmāt \'Grant\' tiesības lietotājam %s';
$strRevokeMessage = 'Jūs atņēmāt privilēgijas lietotājam %s';
$strRevokePriv = 'Atņemt privilēģijas';
$strRowLength = 'Rindas garums';
$strRows = 'Rindas';
$strRowsFrom = 'rindas sākot no';
$strRowSize = ' Rindas izmērs ';
$strRowsModeHorizontal = 'horizontālā';
$strRowsModeOptions = '%s skatā un atkārtot virsrakstus ik pēc %s rindām';
$strRowsModeVertical = 'vertikālā';
$strRowsStatistic = 'Rindas statistika';
$strRunning = 'atrodas uz %s';
$strRunQuery = 'Izpildīt vaicājumu';
$strRunSQLQuery = 'Izpildīt SQL-vaicājumu(s) uz datubāzes %s';

$strSave = 'Saglabāt';
$strSelect = 'Atlasīt';
$strSelectADb = 'Lūdzu izvēlieties datubāzi';
$strSelectAll = 'Iezīmēt visu';
$strSelectFields = 'Izvēlieties laukus (kaut vienu):';
$strSelectNumRows = 'vaicājumā';
$strSend = 'Saglabāt kā failu';
$strServerChoice = 'Servera izvēle';
$strServerVersion = 'Servera versija';
$strSetEnumVal = 'Ja lauka tips ir "enum" vai "set", lūdzu ievadiet vērtības atbilstoši šim formatam: \'a\',\'b\',\'c\'...<br />Ja Jums vajag ielikt atpakaļējo slīpsvītru (\) vai vienkāršo pēdiņu (\') kādā no šīm vērtībām, lieciet tās priekšā atpakaļējo slīpsvītru (piemēram, \'\\\\xyz\' vai \'a\\\'b\').';
$strShow = 'Rādīt';
$strShowAll = 'Rādīt visu';
$strShowCols = 'Rādīt kolonnas';
$strShowingRecords = 'Parādu rindas';
$strShowPHPInfo = 'Parādīt PHP informāciju';
$strShowTables = 'Rādīt tabulas';
$strShowThisQuery = ' Rādīt šo vaicājumu šeit atkal ';
$strSingly = '(vienkārši)';
$strSize = 'Izmērs';
$strSort = 'Kārtošana';
$strSpaceUsage = 'Diska vietas lietošana';
$strSQLQuery = 'SQL-vaicājums';
$strStatement = 'Parametrs';
$strStrucCSV = 'CSV dati';
$strStrucData = 'Struktūra un dati';
$strStrucDrop = 'Pievienot tabulu dzēšanas komandas';
$strStrucExcelCSV = 'CSV dati MS Excel formātā';
$strStrucOnly = 'Tikai struktūra';
$strSubmit = 'Nosūtīt';
$strSuccess = 'Jūsu SQL-vaicājums tika veiksmīgi izpildīts';
$strSum = 'Kopumā';

$strTable = 'Tabula';
$strTableComments = 'Komentārs tabulai';
$strTableEmpty = 'Tabulas nosaukums nav norādīts!';
$strTableHasBeenDropped = 'Tabula %s tika izdzēsta';
$strTableHasBeenEmptied = 'Tabula %s tika iztukšota';
$strTableHasBeenFlushed = 'Tabula %s tika atsvaidzināta';
$strTableMaintenance = 'Tabulas apkalpošana';
$strTables = '%s tabula(s)';
$strTableStructure = 'Tabulas struktūra tabulai';
$strTableType = 'Tabulas tips';
$strTextAreaLength = ' Sava garuma dēļ,<br /> šis lauks var būt nerediģējams ';
$strTheContent = 'Jūsu faila saturs tika ievietots.';
$strTheContents = 'Faila saturs aizvieto izvēlētās tabulas saturu rindiņām ar identisko primārās vai unikālās atslēgas vērtību.';
$strTheTerminator = 'Lauku atdalītājs.';
$strTotal = 'kopā';
$strType = 'Tips';

$strUncheckAll = 'Neiezīmēt neko';
$strUnique = 'Unikālais';
$strUnselectAll = 'Neiezīmēt neko';
$strUpdatePrivMessage = 'Jūs modificējāt privilēģijas objektam %s.';
$strUpdateProfile = 'Modificēt profilu:';
$strUpdateProfileMessage = 'Profils tika modificēts.';
$strUpdateQuery = 'Modificēšanas vaicājums';
$strUsage = 'Aizņem';
$strUseBackquotes = 'Lietot apostrofa simbolu [`] tabulu un lauku nosaukumiem';
$strUser = 'Lietotājs';
$strUserEmpty = 'Lietotāja vārds nav norādīts!';
$strUserName = 'Lietotājvārds';
$strUsers = 'Lietotāji';
$strUseTables = 'Lietot tabulas';

$strValue = 'Vērtība';
$strViewDump = 'Apskatīt tabulas dampu (shēmu)';
$strViewDumpDB = 'Apskatīt datubāzes dampu (shēmu)';

$strWelcome = 'Laipni lūgti %s';
$strWithChecked = 'Ar iezīmēto:';
$strWrongUser = 'Kļūdains lietotājvārds/parole. Pieeja aizliegta.';

$strYes = 'Jā';

$strZip = 'arhivēts ar zip';
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
