<?php
/* $Id: albanian-utf-8.inc.php,v 1.36 2002/11/28 09:15:18 rabus Exp $ */

/**
 * Translated by: Laurent Dhima <laurenti at users.sourceforge.net>
 * Rishikuar nga: Arben Çokaj <acokaj@t-online.de>
 */

$charset = 'utf-8';
$allow_recoding = TRUE;
$text_dir = 'ltr';
$left_font_family = 'verdana, arial, helvetica, geneva, sans-serif';
$right_font_family = 'arial, helvetica, geneva, sans-serif';
$number_thousands_separator = '.';
$number_decimal_separator = ',';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB');

$day_of_week = array('Djl', 'Hën', 'Mar', 'Mër', 'Enj', 'Pre', 'Sht'); //albanian days
$month = array('Jan', 'Shk', 'Mar', 'Pri', 'Maj', 'Qer', 'Kor', 'Gsh', 'Sht', 'Tet', 'Nën', 'Dhj'); //albanian months
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%d %B, %Y at %I:%M %p'; //albanian time



$strAPrimaryKey = 'Një kyç primar u shtua tek %s';
$strAccessDenied = 'Hyrja nuk u pranua';
$strAction = 'Aksioni';
$strAddDeleteColumn = 'Shto/Fshi fushën';
$strAddDeleteRow = 'Shto/Fshi kriterin';
$strAddNewField = 'Shto një fushë të re';
$strAddPriv = 'Shto një privilegj të ri';
$strAddPrivMessage = 'Ke shtuar një privilegj të ri.';
$strAddSearchConditions = 'Shto kushte kërkimi (trupi i specifikimit "where"):';
$strAddToIndex = 'Shto tek treguesi i &nbsp;%s&nbsp;kolonës(ave)';
$strAddUser = 'Shto një përdorues të ri';
$strAddUserMessage = 'Ke shtuar një përdorues të ri.';
$strAffectedRows = 'Rreshtat e ndikuar:';
$strAfter = 'Mbas %s';
$strAfterInsertBack = 'Mbrapa';
$strAfterInsertNewInsert = 'Shto një record të ri';
$strAll = 'Të gjithë';
$strAllTableSameWidth = 'vizualizon të gjitha tabelat me të njëjtën gjërësi?';
$strAlterOrderBy = 'Transformo tabelën e renditur sipas';
$strAnIndex = 'Një tregues u shtua tek %s';
$strAnalyzeTable = 'Analizo tabelën';
$strAnd = 'Dhe';
$strAny = 'Çfarëdo';
$strAnyColumn = 'Çfarëdo kolone';
$strAnyDatabase = 'Çfarëdo databazë';
$strAnyHost = 'Çfarëdo host';
$strAnyTable = 'Çfarëdo tabelë';
$strAnyUser = 'Çfarëdo përdorues';
$strAscending = 'Ngjitje';
$strAtBeginningOfTable = 'Në fillim të tabelës';
$strAtEndOfTable = 'Në fund të tabelës';
$strAttr = 'Pronësi';

$strBack = 'Mbrapa';
$strBeginCut = 'FILLIMI I CUT';
$strBeginRaw = 'FILLIMI I RAW';
$strBinary = 'Binar';
$strBinaryDoNotEdit = 'Të dhëna të tipit binar - mos modifiko';
$strBookmarkDeleted = 'Bookmark u fshi.';
$strBookmarkLabel = 'Etiketë';
$strBookmarkQuery = 'Query SQL shtuar të preferuarve';
$strBookmarkThis = 'Shtoja të preferuarve këtë query SQL';
$strBookmarkView = 'Vizualizo vetëm';
$strBrowse = 'Shfaq';
$strBzip = '"kompresuar me bzip2"';

$strCantLoadMySQL = 'nuk arrij të ngarkoj ekstensionin MySQL,<br />kontrollo konfigurimin e PHP.';
$strCantLoadRecodeIconv = 'I pamundur ngarkimi i ekstensionit iconv apo recode të nevoitshëm për konvertimin e karaktereve, konfiguroni php për të lejuar përdorimin e këtyre ekstensioneve ose disaktivoni konvertimin e set të karaktereve në phpMyAdmin.';
$strCantRenameIdxToPrimary = 'I pamundur riemërtimi i treguesit në PRIMAR!';
$strCantUseRecodeIconv = 'I pamundur përdorimi i funksioneve iconv apo libiconv apo recode_string për shkak se ekstensioni duhet të ngarkohet. Kontrolloni konfigurimin e php.';
$strCardinality = '';
$strCarriage = 'Kthimi në fillim: \\r';
$strChange = 'Modifiko';
$strChangeDisplay = 'Zgjidh fushën që dëshiron të shohësh';
$strChangePassword = 'Ndrysho password';
$strCharsetOfFile = 'Set karakteresh të file:';
$strCheckAll = 'Seleksionoi të gjithë';
$strCheckDbPriv = 'Kontrollo të drejtat e databazë';
$strCheckTable = 'Kontrollo tabelën';
$strChoosePage = 'Ju lutem zgjidhni faqen që dëshironi të modifikoni';
$strColComFeat = 'Vizualizimi i komenteve të kollonave';
$strColumn = 'Kollona';
$strColumnNames = 'Emrat e kollonave';
$strComments = 'Komente';
$strCompleteInserts = 'Të shtuarat komplet';
$strConfigFileError = 'phpMyAdmin nuk arrin të lexojë file e konfigurimit!<br />Kjo mund të ndodhë kur php gjen një parse error në të apo kur php nuk arrin ta gjejë këtë file.<br />Ju lutem ngarkoheni direkt file e konfigurimit duke përdorur link-un e mëposhtëm dhe lexoni mesazhin(et) e gabimeve php që merrni. Në shumicën e rasteve mund t\'ju mungojë një apostrofë apo një presje.<br />Nëse faqja që do t\'ju hapet është bosh (e bardhë), atëhere gjithçka është në rregull.';
$strConfigureTableCoord = 'Ju lutem, konfiguroni koordinatat për tabelën %s';
$strConfirm = 'I sigurt që dëshiron ta bësh?';
$strCookiesRequired = 'Nga kjo pikë e tutje, cookies duhet të jenë të aktivuara.';
$strCopyTable = 'Kopjo tabelën tek (databazë<b>.</b>tabela):';
$strCopyTableOK = 'Tabela %s u kopjua tek %s.';
$strCreate = 'Krijo';
$strCreateIndex = 'Krijo një tregues tek &nbsp;%s&nbsp;columns';
$strCreateIndexTopic = 'Krijo një tregues të ri';
$strCreateNewDatabase = 'Krijo një databazë të re';
$strCreateNewTable = 'Krijo një tabelë të re tek databazë %s';
$strCreatePage = 'Krijo një faqe të re';
$strCreatePdfFeat = 'Krijimi i PDF-ve';
$strCriteria = 'Kriteri';

$strData = 'Të dhëna';
$strDataDict = 'Data Dictionary';
$strDataOnly = 'Vetëm të dhëna';
$strDatabase = 'Databazë ';
$strDatabaseHasBeenDropped = 'Databaza %s u eleminua.';
$strDatabaseWildcard = 'Database (wildcards e lejuara):';
$strDatabases = 'databazë';
$strDatabasesStats = 'Statistikat e databazës';
$strDefault = 'Paracaktuar';
$strDelPassMessage = 'Ke fshirë password për';
$strDelete = 'Fshi';
$strDeleteFailed = 'Fshirja dështoi!';
$strDeleteUserMessage = 'Ke fshirë përdoruesin %s.';
$strDeleted = 'rreshti u fshi';
$strDeletedRows = 'rreshtat e fshirë:';
$strDescending = 'Zbritës';
$strDisabled = 'Disaktivuar';
$strDisplay = 'Vizualizo';
$strDisplayFeat = 'Vizualizo karakteristikat';
$strDisplayOrder = 'Mënyra e vizualizimit:';
$strDisplayPDF = 'Shfaq skemën e PDF';
$strDoAQuery = 'Zbato "query nga shembull" (karakteri jolly: "%")';
$strDoYouReally = 'Konfermo: ';
$strDocu = 'Dokumentet';
$strDrop = 'Elemino';
$strDropDB = 'Elemino databazën %s';
$strDropTable = 'Elemino tabelën';
$strDumpXRows = 'Dump i %s rreshta duke filluar nga rreshti %s.';
$strDumpingData = 'Dump i të dhënave për tabelën';
$strDynamic = 'dinamik';

$strEdit = 'Modifiko';
$strEditPDFPages = 'Modifiko Faqe PDF';
$strEditPrivileges = 'Modifiko Privilegjet';
$strEffective = 'Efektiv';
$strEmpty = 'Zbraz';
$strEmptyResultSet = 'MySQL ka kthyer një të përbashkët boshe (p.sh. zero rreshta).';
$strEnabled = 'Aktivuar';
$strEnd = 'Fund';
$strEndCut = 'FUNDI I CUT';
$strEndRaw = 'FUNDI I RAW';
$strEnglishPrivileges = 'Shënim: emrat e privilegjeve të MySQL janë në Anglisht';
$strError = 'Gabim';
$strExplain = 'Shpjego SQL';
$strExport = 'Eksporto';
$strExportToXML = 'Eksporto në formatin XML';
$strExtendedInserts = 'Të shtuara të zgjeruara';
$strExtra = 'Extra';

$strField = 'Fushë';
$strFieldHasBeenDropped = 'Fusha %s u eleminua';
$strFields = 'Fusha';
$strFieldsEmpty = ' Numratori i fushave është bosh! ';
$strFieldsEnclosedBy = 'Fushë e përbërë nga';
$strFieldsEscapedBy = 'Fushë e kufizuar nga';
$strFieldsTerminatedBy = 'Fushë e mbaruar nga';
$strFixed = 'fiks';
$strFlushTable = 'Rifillo ("FLUSH") tabelën';
$strFormEmpty = 'Mungon një vlerë në form!';
$strFormat = 'Formati';
$strFullText = 'Teksti i plotë';
$strFunction = 'Funksion';

$strGenBy = 'Gjeneruar nga';
$strGenTime = 'Gjeneruar më';
$strGeneralRelationFeat = 'Karakteristikat e përgjithshme të relacionit';
$strGo = 'Zbato';
$strGrants = 'Lejo';
$strGzip = '"kompresuar me gzip"';

$strHasBeenAltered = 'u modifikua.';
$strHasBeenCreated = 'u krijua.';
$strHaveToShow = 'Zgjidh të paktën një kolonë për t\'a vizualizuar';
$strHome = 'Home';
$strHomepageOfficial = 'Home page zyrtare e phpMyAdmin';
$strHomepageSourceforge = 'Home page e phpMyAdmin tek sourceforge.net';
$strHost = 'Host';
$strHostEmpty = 'Emri i host është bosh!';

$strIdxFulltext = 'Teksti komplet';
$strIfYouWish = 'Për të ngarkuar të dhënat vetëm për disa kollona të tabelës, specifiko listën e fushave (të ndara me presje).';
$strIgnore = 'Injoro';
$strImportDocSQL = 'Importo files docSQL';
$strInUse = 'në përdorim';
$strIndex = 'Treguesi';
$strIndexHasBeenDropped = 'Treguesi %s u eleminua';
$strIndexName = 'Emri i treguesit&nbsp;:';
$strIndexType = 'Tipi i treguesit&nbsp;:';
$strIndexes = 'Tregues';
$strInsecureMySQL = 'File i konfigurimit në përdorim përmban zgjedhje (root pa asnjë password) që korrispondojnë me të drejtat e account MySQL të paracaktuar. Një server MySQL funksionues me këto zgjedhje është i pambrojtur ndaj sulmeve, dhe ju duhet patjetër të korrigjoni këtë vrimë në siguri.';
$strInsert = 'Shto';
$strInsertAsNewRow = 'Shto një rresht të ri';
$strInsertNewRow = 'Shto një rresht të ri';
$strInsertTextfiles = 'Shto një file teksti në tabelë';
$strInsertedRows = 'Rreshta të shtuar:';
$strInstructions = 'Instruksione';
$strInvalidName = '"%s" është një fjalë e rezervuar; nuk mund ta përdorësh si emër për databazë/tabelë/fushë.';

$strKeepPass = 'Mos ndrysho password';
$strKeyname = 'Emri i kyçit';
$strKill = 'Hiq';

$strLength = 'Gjatësia';
$strLengthSet = 'Gjatësia/Set*';
$strLimitNumRows = 'record për faqe';
$strLineFeed = 'Fundi i rreshtit: \\n';
$strLines = 'Record';
$strLinesTerminatedBy = 'Rreshta që mbarojnë me';
$strLinkNotFound = 'Link nuk u gjet';
$strLinksTo = 'Lidhje me';
$strLocationTextfile = 'Pozicioni i file';
$strLogPassword = 'Password:';
$strLogUsername = 'Emri i përdoruesit:';
$strLogin = 'Lidh';
$strLogout = 'Shkëput';

$strMissingBracket = 'Mungojnë thonjëza';
$strModifications = 'Ndryshimet u shpëtuan';
$strModify = 'Modifiko';
$strModifyIndexTopic = 'Modifiko një tregues';
$strMoveTable = 'Sposto tabelën në (databazë<b>.</b>tabela):';
$strMoveTableOK = 'Tabela %s u spostua tek %s.';
$strMySQLCharset = 'Set karakteresh MySQL';
$strMySQLReloaded = 'MySQL u rifillua.';
$strMySQLSaid = 'Mesazh nga MySQL: ';
$strMySQLServerProcess = 'MySQL %pma_s1% në ekzekutim tek %pma_s2% si %pma_s3%';
$strMySQLShowProcess = 'Vizualizo proceset në ekzekutim';
$strMySQLShowStatus = 'Vizualizo informacionet e runtime të MySQL';
$strMySQLShowVars = 'Vizualizo të ndryshueshmet e sistemit të MySQL';

$strName = 'Emri';
$strNext = 'Në vazhdim';
$strNo = ' Jo ';
$strNoDatabases = 'Asnjë databazë';
$strNoDescription = 'asnjë Përshkrim';
$strNoDropDatabases = 'Komandat "DROP DATABASE" janë disaktivuar.';
$strNoExplain = 'Mos Shpjego SQL';
$strNoFrames = 'phpMyAdmin funksionon më mirë me browser që suportojnë frames';
$strNoIndex = 'Asnjë tregues i përcaktuar!';
$strNoIndexPartsDefined = 'Asnjë pjesë e treguesit është përcaktuar!';
$strNoModification = 'Asnjë ndryshim';
$strNoPassword = 'Asnjë password';
$strNoPhp = 'pa kod PHP';
$strNoPrivileges = 'Asnjë privilegj';
$strNoQuery = 'Asnjë query SQL!';
$strNoRights = 'Nuk ke të drejta të mjaftueshme për të kryer këtë operacion!';
$strNoTablesFound = 'Nuk gjenden tabela në databazë.';
$strNoUsersFound = 'Nuk u gjet asnjë përdorues.';
$strNoValidateSQL = 'Mos vleftëso SQL';
$strNone = 'Askush';
$strNotNumber = 'Ky nuk është një numër!';
$strNotOK = 'jo OK';
$strNotSet = '<b>%s</b> tabela nuk u gjet ose nuk është përcaktuar tek %s';
$strNotValidNumber = ' nuk është një rresht i vlefshëm!';
$strNull = 'Null';
$strNumSearchResultsInTable = '%s korrispondon(jnë) tek tabela <i>%s</i>';
$strNumSearchResultsTotal = '<b>Gjithsej:</b> <i>%s</i> korrispondues(ë)';

$strOK = 'OK';
$strOftenQuotation = 'Zakonisht nga dopjo thonjza. ME DËSHIRË tregon që vetëm fushat <I>char</I> dhe <I>varchar</I> duhet të delimitohen nga karakteri i treguar.';
$strOperations = 'Operacione';
$strOptimizeTable = 'Optimizo tabelën';
$strOptionalControls = 'Me dëshirë. Ky karakter kontrollon si të shkruash apo lexosh karakteret specialë.';
$strOptionally = 'ME DËSHIRË';
$strOptions = 'Mundësi';
$strOr = 'Ose';
$strOverhead = 'Tejkalim';

$strPHP40203 = 'Është në përdorim PHP 4.2.3, që përmban një bug serioz me stringat multi-byte strings (mbstring). Shiko raportin 19404 të bug PHP. Ky version i PHP nuk rekomandohet për t\'u përdorur me phpMyAdmin.';
$strPHPVersion = 'Versioni i PHP';
$strPageNumber = 'Numri i faqes:';
$strPartialText = 'Tekst i pjesëshëm';
$strPassword = 'Password';
$strPasswordEmpty = 'Password është bosh!';
$strPasswordNotSame = 'Password nuk korrispondon!';
$strPdfDbSchema = 'Skema e databazë "%s" - Faqja %s';
$strPdfInvalidPageNum = 'Numri i faqes së PDF i papërcaktuar!';
$strPdfInvalidTblName = 'Tabela "%s" nuk ekziston!';
$strPdfNoTables = 'Asnjë tabelë';
$strPhp = 'Krijo kodin PHP';
$strPmaDocumentation = 'Dokumente të phpMyAdmin';
$strPmaUriError = 'Direktiva <tt>$cfg[\'PmaAbsoluteUri\']</tt> DUHET të përcaktohet tek file i konfigurimit!';
$strPos1 = 'Fillim';
$strPrevious = 'Paraardhësi';
$strPrimary = 'Primar';
$strPrimaryKey = 'Kyç primar';
$strPrimaryKeyHasBeenDropped = 'Kyçi primar u eleminua';
$strPrimaryKeyName = 'Emri i kyçit primar duhet të jetë... PRIMARY!';
$strPrimaryKeyWarning = '("PRIMARY" <b>duhet</b> të jetë emri i, dhe <b>vetëm i</b>, një kyçi primar!)';
$strPrint = 'Printo';
$strPrintView = 'Vizualizo për printim';
$strPrivileges = 'Privilegje';
$strProperties = 'Pronësi';
$strPutColNames = 'Vendos emrat e kollonave tek rreshti i parë';

$strQBE = 'Query nga shembull';
$strQBEDel = 'Fshi';
$strQBEIns = 'Shto';
$strQueryOnDb = 'SQL-query tek databazë <b>%s</b>:';

$strReType = 'Rifut';
$strRecords = 'Record';
$strReferentialIntegrity = 'Kontrollo integritetin e informacioneve:';
$strRelationNotWorking = 'Karakteristikat shtesë janë disaktivuar për sa i takon funksionimit me tabelat e link-uara. Për të zbuluar përse, klikoni %skëtu%s.';
$strRelationView = 'Shiko relacionin';
$strReloadFailed = 'Rinisja e MySQL dështoi.';
$strReloadMySQL = 'Rifillo MySQL';
$strRememberReload = 'Kujtohu të rinisësh MySQL.';
$strRenameTable = 'Riemërto tabelën në';
$strRenameTableOK = 'Tabela %s u riemërtua %s';
$strRepairTable = 'Riparo tabelën';
$strReplace = 'Zëvëndëso';
$strReplaceTable = 'Zëvëndëso të dhënat e tabelës me file';
$strReset = 'Rinis';
$strRevoke = 'Hiq';
$strRevokeGrant = 'Hiq të drejtat';
$strRevokeGrantMessage = 'Ke hequr privilegjet e të drejtave për %s';
$strRevokeMessage = 'Ke anulluar privilegjet për %s';
$strRevokePriv = 'Anullo privilegjet';
$strRowLength = 'Gjatësia e rreshtit';
$strRowSize = 'Dimensioni i rreshtit';
$strRows = 'rreshta';
$strRowsFrom = 'rreshta duke filluar nga';
$strRowsModeHorizontal = ' horizontal ';
$strRowsModeOptions = ' në modalitetin %s dhe përsërit headers mbas %s qeli ';
$strRowsModeVertical = ' vertikal ';
$strRowsStatistic = 'Statistikat e rreshtave';
$strRunQuery = 'Dërgo Query';
$strRunSQLQuery = 'Zbato query SQL tek databazë %s';
$strRunning = 'në ekzekutim tek %s';

$strSQL = 'SQL';
$strSQLParserBugMessage = 'Ka mundësi që ka një bug tek parser SQL. Ju lutem, kontrolloni query tuaj me kujdes, dhe kontrolloni që presjet të jenë ku duhet dhe jo të gabuara. Një shkak tjetër i mundshëm i gabimit mund të jetë që po mundoheni të uploadoni një file binar jashtë një zone teksti të kufizuar me presje. Mund edhe të provoni query tuaj MySQL nga interfaqja e shkruar e komandave. Gabimi i mëposhtëm i kthyer nga server-i MySQL, nëse ekziston një i tillë, mund tju ndihmojë në diagnostikimin e problemit. Nëse ka akoma probleme, apo n.q.s. parser-i SQL i phpMyAdmin gabon kur përkundrazi nga interfaqja e komandave të thjeshta nuk rezultojnë probleme, ju lutem zvogëloni query tuaj SQL në hyrje në query e vetme që shkakton probleme, dhe dërgoni një bug raportim me të dhënat rezultuese nga seksioni CUT i mëposhtëm:';
$strSQLParserUserError = 'Mesa duket ekziston një gabim tek query juaj SQL e futur. Gabimi i server-it MySQL i treguar më poshtë, nëse ekziston, mund t\'ju ndihmojë në diagnostikimin e problemit';
$strSQLQuery = 'query SQL';
$strSQLResult = 'Rezultati SQL';
$strSQPBugInvalidIdentifer = 'Identifikues i pavlefshëm';
$strSQPBugUnclosedQuote = 'Thonjëza të pambyllura';
$strSQPBugUnknownPunctuation = 'Stringë Punctuation e panjohur';
$strSave = 'Shpëto';
$strScaleFactorSmall = 'Faktori i shkallës është shumë i vogël për të plotësuar skemën në faqe';
$strSearch = 'Kërko';
$strSearchFormTitle = 'Kërko në databazë';
$strSearchInTables = 'Tek tabela(at):';
$strSearchNeedle = 'Fjala(ë) apo vlera(at) për t\'u kërkuar (karakteri Jolly: "%"):';
$strSearchOption1 = 'të paktën njërën nga fjalët';
$strSearchOption2 = 'të gjitha fjalët';
$strSearchOption3 = 'fraza precize';
$strSearchOption4 = 'si ekspresion i rregullt';
$strSearchResultsFor = 'Kërko rezultatet për "<i>%s</i>" %s:';
$strSearchType = 'Gjej:';
$strSelect = 'Seleksiono';
$strSelectADb = 'Të lutem, seleksiono një databazë';
$strSelectAll = 'Seleksiono Gjithçka';
$strSelectFields = 'Seleksiono fushat (të paktën një):';
$strSelectNumRows = 'tek query';
$strSelectTables = 'Seleksiono Tabelat';
$strSend = 'Shpëtoje me emër...';
$strServer = 'Server %s';
$strServerChoice = 'Zgjedhja e server';
$strServerVersion = 'Versioni i MySQL';
$strSetEnumVal = 'N.q.s. fusha është "enum" apo "set", shtoni të dhënat duke përdorur formatin: \'a\',\'b\',\'c\'...<br />Nëse megjithatë do t\'u duhet të vini backslashes ("\") apo single quote ("\'") para këtyre vlerave, backslash-ojini (për shembull \'\\\\xyz\' o \'a\\\'b\').';
$strShow = 'Shfaq';
$strShowAll = 'Shfaqi të gjithë';
$strShowColor = 'Shfaq ngjyrën';
$strShowCols = 'Shfaq kollonat';
$strShowGrid = 'Shfaq rrjetën';
$strShowPHPInfo = 'Trego info mbi PHP';
$strShowTableDimension = 'Trego dimensionin e tabelave';
$strShowTables = 'Shfaq tabelat';
$strShowThisQuery = 'Tregoje përsëri këtë query';
$strShowingRecords = 'Vizualizimi i record ';
$strSingly = '(një nga një)';
$strSize = 'Dimensioni';
$strSort = 'rreshtimi';
$strSpaceUsage = 'Hapësira e përdorur';
$strSplitWordsWithSpace = 'Fjalët janë të ndara nga një hapsirë (" ").';
$strStatement = 'Instruksione';
$strStrucCSV = 'të dhëna CSV';
$strStrucData = 'Struktura dhe të dhëna';
$strStrucDrop = 'Shto \'drop table\'';
$strStrucExcelCSV = 'CSV për të dhëna Ms Excel';
$strStrucOnly = 'Vetëm struktura';
$strStructPropose = 'Propozo strukturën e tabelës';
$strStructure = 'Struktura';
$strSubmit = 'Dërgoje';
$strSuccess = 'Query u zbatua me sukses';
$strSum = 'Gjithsej';

$strTable = 'Tabela';
$strTableComments = 'Komente mbi tabelën';
$strTableEmpty = 'Emri i tabelës është bosh!';
$strTableHasBeenDropped = 'Tabela %s u eleminua';
$strTableHasBeenEmptied = 'Tabela %s u zbraz';
$strTableHasBeenFlushed = 'Tabela %s u rifreskua';
$strTableMaintenance = 'Administrimi i tabelës';
$strTableStructure = 'Struktura e tabelës';
$strTableType = 'Tipi i tabelës';
$strTables = '%s tabela(at)';
$strTextAreaLength = ' Për shkak të gjatësisë saj,<br /> kjo fushë nuk mund të modifikohet ';
$strTheContent = 'Përmbajtja e file u shtua.';
$strTheContents = 'Përmbajtja e file zëvëndëson rreshtat e tabelës me të njëjtin kyç primar apo kyç të vetëm.';
$strTheTerminator = 'Karakteri përfundues i fushave.';
$strTotal = 'Gjithsej';
$strType = 'Tipi';

$strUncheckAll = 'Deseleksionoi të gjithë';
$strUnique = 'I vetëm';
$strUnselectAll = 'Deseleksiono gjithçka';
$strUpdatePrivMessage = 'Ke rifreskuar lejet për %s.';
$strUpdateProfile = 'Rifresko profilin:';
$strUpdateProfileMessage = 'Profili u rifreskua.';
$strUpdateQuery = 'Rifresko Query';
$strUsage = 'Përdorimi';
$strUseBackquotes = 'Përdor backquotes me emrat e tabelave dhe fushave';
$strUseTables = 'Përdor tabelat';
$strUser = 'Përdorues';
$strUserEmpty = 'Emri i përdoruesit është bosh!';
$strUserName = 'Emri i përdoruesit';
$strUsers = 'Përdorues';

$strValidateSQL = 'Vleftëso SQL';
$strValidatorError = 'Miratuesi SQL nuk arrin të niset. Ju lutem kontrolloni instalimin e ekstensioneve të duhura php ashtu si përshkruhet tek %sdokumentimi%s.';
$strValue = 'Vlera';
$strViewDump = 'Vizualizo dump (skema) e tabelës';
$strViewDumpDB = 'Vizualizo dump (skema) e databazë';

$strWebServerUploadDirectory = 'directory e upload të server-it web';
$strWebServerUploadDirectoryError = 'Directory që keni zgjedhur për upload nuk arrin të gjehet';
$strWelcome = 'Mirësevini tek %s';
$strWithChecked = 'N.q.s.të seleksionuar:';
$strWrongUser = 'Emri i përdoruesit apo password i gabuar. Ndalohet hyrja.';

$strYes = ' Po ';

$strZip = '"kompresuar me zip"';

// To translate
$strCompression = 'Compression'; //to translate
$strNumTables = 'Tables'; //to translate
$strTotalUC = 'Total'; //to translate
?>
