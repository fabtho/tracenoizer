<?php
/* $Id: brazilian_portuguese-iso-8859-1.inc.php,v 1.29 2002/11/28 09:15:19 rabus Exp $ */

/**
 * Translated by Renato Lins <thbest at information4u.com>
 */

$charset = 'iso-8859-1';
$text_dir = 'ltr';
$left_font_family = 'verdana, arial, helvetica, geneva, sans-serif';
$right_font_family = 'arial, helvetica, geneva, sans-serif';
$number_thousands_separator = ',';
$number_decimal_separator = '.';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB');

$day_of_week = array('Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab');
$month = array('Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez');
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%B %d, %Y at %I:%M %p';

$strAccessDenied = 'Acesso Negado';
$strAction = 'A��es';
$strAddDeleteColumn = 'Adiciona/Remove Colunas';
$strAddDeleteRow = 'Adiciona/Remove Condi��es de busca';
$strAddNewField = 'Adiciona novo campo';
$strAddPriv = 'Adiciona um novo Privil�gio';
$strAddPrivMessage = 'Privil�gio adicionado.';
$strAddSearchConditions = 'Condi��o de Pesquisa (Complemento da clausula "onde"):';
$strAddToIndex = 'Adicionar ao �ndice &nbsp;%s&nbsp;coluna(s)';
$strAddUser = 'Adicionar um novo usu�rio';
$strAddUserMessage = 'Usu�rio adcionado.';
$strAffectedRows = 'Registro afetados:';
$strAfter = 'Depois %s';
$strAfterInsertBack = 'Retornar';
$strAfterInsertNewInsert = 'Inserir um novo registro';
$strAll = 'Todos';
$strAlterOrderBy = 'Alterar tabela ordenada por';
$strAnalyzeTable = 'Analizar tabela';
$strAnd = 'E';
$strAnIndex = 'Um �ndice foi adicionado a %s';
$strAny = 'Qualquer';
$strAnyColumn = 'Qualquer coluna';
$strAnyDatabase = 'Qualquer banco de dados';
$strAnyHost = 'Qualquer servidor';
$strAnyTable = 'Qualquer tabela';
$strAnyUser = 'Qualquer usu�rio';
$strAPrimaryKey = 'Uma chave prim�ria foi adicionada a %s';
$strAscending = 'Ascendente';
$strAtBeginningOfTable = 'No come�o da tabela';
$strAtEndOfTable = 'Ao fim da tabela';
$strAttr = 'Atributos';

$strBack = 'Voltar';
$strBinary = ' Bin�rio ';
$strBinaryDoNotEdit = ' Bin�rio - n�o edite ';
$strBookmarkDeleted = 'O bookmark foi removido.';
$strBookmarkLabel = 'Nome';
$strBookmarkQuery = 'Procura de SQL salva';
$strBookmarkThis = 'Salvar essa procura de SQL';
$strBookmarkView = 'Apenas visualiza';
$strBrowse = 'Visualiza';
$strBzip = '"compactado com bzip"';

$strCantLoadMySQL = 'n�o foi poss�vel carregar extens�o do MySQL,<br />por favor cheque a configura��o do PHP.';
$strCantRenameIdxToPrimary = 'N�o foi poss�vel renomear o �ndice para "PRIMARY"!';
$strCardinality = 'Cardinalidade';
$strCarriage = 'Caracter de retorno: \\r';
$strChange = 'Muda';
$strChangePassword = 'Mude a senha';
$strCheckAll = 'Marcar All';
$strCheckDbPriv = 'Verifica Privil�gios do Banco de Dados';
$strCheckTable = 'Verifica tabela';
$strColumn = 'Coluna';
$strColumnNames = 'Nome da Colunas';
$strCompleteInserts = 'Inser��es Completas';
$strConfirm = 'Voc� tem certeza?';
$strCookiesRequired = 'Cookies devem estar ativados ap�s este ponto.';
$strCopyTable = 'Copiar tabela para (base<b>.</b>tabela):';
$strCopyTableOK = 'Tabela %s copiada para %s.';
$strCreate = 'Cria';
$strCreateIndex = 'Criar um �ndice em&nbsp;%s&nbsp;colunas';
$strCreateIndexTopic = 'Criar um novo �ndice';
$strCreateNewDatabase = 'Cria novo banco de dados';
$strCreateNewTable = 'Cria nova tabela no banco de dados %s';
$strCriteria = 'Crit�rio';

$strData = 'Dados';
$strDatabase = 'Banco de Dados ';
$strDatabaseHasBeenDropped = 'Base de Dados %s foi eliminada.';
$strDatabases = 'Banco de Dados';
$strDatabasesStats = 'Estatisticas da base';
$strDatabaseWildcard = 'Banco de Dados (caract�res-coringa permitidos):';
$strDataOnly = 'Dados apenas';
$strDefault = 'Padr�o';
$strDelete = 'Remove';
$strDeleted = 'Registro eliminado';
$strDeletedRows = 'Registro deletados:';
$strDeleteFailed = 'N�o foi poss�vel apagar!';
$strDeleteUserMessage = 'Voc� deletou o usu�rio %s.';
$strDescending = 'Descendente';
$strDisplay = 'Tela';
$strDisplayOrder = 'Ordenado por:';
$strDoAQuery = 'Fa�a uma "procura por exemplo" (coringa: "%")';
$strDocu = 'Documenta��o';
$strDoYouReally = 'Confirma : ';
$strDrop = 'Elimina';
$strDropDB = 'Elimina o banco de dados %s';
$strDropTable = 'Remove Tabela';
$strDumpingData = 'Extraindo dados da tabela';
$strDynamic = 'din�mico';

$strEdit = 'Edita';
$strEditPrivileges = 'Edita Privil�gios';
$strEffective = 'Efetivo';
$strEmpty = 'Limpa';
$strEmptyResultSet = 'MySQL retornou um conjunto vazio (ex. zero registros).';
$strEnd = 'Fim';
$strEnglishPrivileges = ' Nota: nomes de privil�gios do MySQL s�o expressos em ingl�s ';
$strError = 'Erro';
$strExtendedInserts = 'Inser��es extendidas';
$strExtra = 'Extra';

$strField = 'Campo';
$strFieldHasBeenDropped = 'Campo %s foi deletado';
$strFields = 'Campos';
$strFieldsEmpty = ' O campo count esta vazio! ';
$strFieldsEnclosedBy = 'Campos delimitados por';
$strFieldsEscapedBy = 'Campo contornado por';
$strFieldsTerminatedBy = 'Campos terminados por';
$strFixed = 'fixo';
$strFlushTable = 'Limpar a tabela ("LIMPAR")';
$strFormat = 'Formato';
$strFormEmpty = 'Faltando valores do form !';
$strFullText = 'Textos completos';
$strFunction = 'Fun�oes';

$strGenTime = 'Tempo de Genera��o';
$strGo = 'Executa';
$strGrants = 'Conceder';
$strGzip = '"compactado com gzip"';

$strHasBeenAltered = 'foi alterado.';
$strHasBeenCreated = 'foi criado.';
$strHome = 'Principal';
$strHomepageOfficial = 'P�gina Oficial do phpMyAdmin';
$strHomepageSourceforge = 'Nova P�gina do phpMyAdmin';
$strHost = 'Servidor';
$strHostEmpty = 'O nome do servidor est� vazio!';

$strIdxFulltext = 'Fulltext';
$strIfYouWish = 'Para carregar apenas algumas colunas da tabela, fa�a uma lista separada por v�rgula.';
$strIgnore = 'Ignorar';
$strIndex = '�ndice';
$strIndexes = '�ndices';
$strIndexHasBeenDropped = '�ndice %s foi deletado';
$strIndexName = 'Nome do �ndice&nbsp;:';
$strIndexType = 'Tipo de �ndice&nbsp;:';
$strInsert = 'Insere';
$strInsertAsNewRow = 'Insere uma nova coluna';
$strInsertedRows = 'Linhas Inseridas:';
$strInsertNewRow = 'Insere novo registro';
$strInsertTextfiles = 'Insere arquivo texto na tabela';
$strInstructions = 'Instru��es';
$strInUse = 'em uso';
$strInvalidName = '"%s" � uma palavra reservada, voc� n�o pode us�-la como um nome de base de dados/tabela/campo.';

$strKeepPass = 'N�o mudar a senha';
$strKeyname = 'Nome chave';
$strKill = 'Matar';

$strLength = 'Tamanho';
$strLengthSet = 'Tamanho/Definir*';
$strLimitNumRows = 'registros por p�gina';
$strLineFeed = 'Caracter de Alimenta��o de Linha: \\n';
$strLines = 'Linhas';
$strLinesTerminatedBy = 'Linhas terminadas por';
$strLocationTextfile = 'Localiza��o do arquivo texto';
$strLogin = 'Autentica��o';
$strLogout = 'Sair';
$strLogPassword = 'Senha:';
$strLogUsername = 'Usu�rio:';

$strModifications = 'Modifica��es foram salvas';
$strModify = 'Modificar';
$strModifyIndexTopic = 'Modificar um �ndice';
$strMoveTable = 'Mover tabela para (base de dados<b>.</b>tabela):';
$strMoveTableOK = 'Tabela %s foi movida para %s.';
$strMySQLReloaded = 'MySQL reiniciado.';
$strMySQLSaid = 'Mensagens do MySQL : ';
$strMySQLServerProcess = 'MySQL %pma_s1% funcionando em %pma_s2% como %pma_s3%';
$strMySQLShowProcess = 'Mostra os Processos';
$strMySQLShowStatus = 'Mostra informa��o de runtime do MySQL';
$strMySQLShowVars = 'Mostra vari�veis de sistema do MySQL';

$strName = 'Nome';
$strNext = 'Pr�ximo';
$strNo = 'N�o';
$strNoDatabases = 'Sem bases';
$strNoDropDatabases = 'O comando "DROP DATABASE" est� desabilitado.';
$strNoFrames = 'phpMyAdmin � mais amig�vel com um navegador <b>capaz de exibir frames</b>.';
$strNoIndex = 'Nenhum �ndice definido!';
$strNoIndexPartsDefined = 'Nenhuma parte de �ndice definida!';
$strNoModification = 'Sem Mudan�a';
$strNone = 'Nenhum';
$strNoPassword = 'Sem Senha';
$strNoPrivileges = 'Sem Privil�gios';
$strNoQuery = 'Nenhuma procura SQL!';
$strNoRights = 'Voc� n�o tem direitos suficientes para estar aqui agora!';
$strNoTablesFound = 'Nenhuma tabela encontrada no banco de dados';
$strNotNumber = 'Isto n�o � um n�mero!';
$strNotValidNumber = ' n�o � um n�mero de registro valido!';
$strNoUsersFound = 'Nenhum usu�rio(s) encontrado.';
$strNull = 'Nulo';

$strOftenQuotation = 'Em geral aspas. OPCIONAL significa que apenas campos de caracteres s�o delimitados por caracteres "delimitadores"';
$strOptimizeTable = 'Optimizar tabela';
$strOptionalControls = 'Opcional. Controla como ler e escrever caracteres especiais.';
$strOptionally = 'OPCIONAL';
$strOr = 'Ou';
$strOverhead = 'Sobre Carga';

$strPartialText = 'Textos parciais';
$strPassword = 'Senha';
$strPasswordEmpty = 'A senhas est� vazia!';
$strPasswordNotSame = 'As senhas n�o s�o a mesma!';
$strPHPVersion = 'Vers�o do PHP';
$strPmaDocumentation = 'Documenta��o do phpMyAdmin ';
$strPmaUriError = 'A diretiva <tt>$cfg[\'PmaAbsoluteUri\']</tt> Deve ser setada';
$strPos1 = 'In�cio';
$strPrevious = 'Anterior';
$strPrimary = 'Prim�ria';
$strPrimaryKey = 'Chave Prim�ria';
$strPrimaryKeyHasBeenDropped = 'A chave prim�ria foi deletada';
$strPrimaryKeyName = 'O nome da chave prim�ria deve ser... "PRIMARY"!';
$strPrimaryKeyWarning = '("PRIMARY" <b>precisa</b> ser o nome de e <b>apenas da</b> chave prim�ria!)';
$strPrintView = 'Visualiza��o para Impress�o';
$strPrivileges = 'Privil�gios';
$strProperties = 'Propriedades';

$strQBE = 'Procura por Exemplo';
$strQueryOnDb = 'Procura SQL na base de dados <b>%s</b>:';

$strRecords = 'Registros';
$strReferentialIntegrity = 'Verificar integridade referencial:';
$strReloadFailed = 'Reinicializa��o do MySQL falhou.';
$strReloadMySQL = 'Reinicializa o MySQL';
$strRememberReload = 'Lembre-se recarregar o servidor.';
$strRenameTable = 'Renomeia a tabela para ';
$strRenameTableOK = 'Tabela %s renomeada para %s';
$strRepairTable = 'Reparar tabela';
$strReplace = 'Substituir';
$strReplaceTable = 'Substituir os dados da tabela pelos do arquivo';
$strReset = 'Resetar';
$strReType = 'Re-digite';
$strRevoke = 'Revogar';
$strRevokeGrant = 'Revogar Privil�gio de Conceder';
$strRevokeGrantMessage = 'Voc� revogou o privil�gio de conceder para %s';
$strRevokeMessage = 'Voc� revogou os privil�gios para %s';
$strRevokePriv = 'Revogar Privil�gios';
$strRowLength = 'Tamanho da Coluna';
$strRows = 'Colunas';
$strRowsFrom = 'colunas come�ando de';
$strRowSize = ' Tamanho do registro ';
$strRowsModeHorizontal = 'horizontal';
$strRowsModeOptions = 'no modo %s e repetindo cabe�alhos ap�s %s c�lulas';
$strRowsModeVertical = 'vertical';
$strRowsStatistic = 'Estatist�cas da Coluna';
$strRunning = 'Rodando em %s';
$strRunQuery = 'Envia Query';
$strRunSQLQuery = 'Fazer procura(s) SQL no banco de dados %s';

$strSave = 'Salva';
$strSelect = 'Procura';
$strSelectADb = 'Por favor, selecione uma base de dados';
$strSelectAll = 'Selecionar Todos';
$strSelectFields = 'Selecione os campos (no m�nimo 1)';
$strSelectNumRows = 'na procura';
$strSend = 'Envia';
$strServerChoice = 'Sele��o da Base';
$strServerVersion = 'Vers�o do Servidor';
$strSetEnumVal = 'Se um tipo de campo � "enum" ou "set", por favor entre valores usando este formato: \'a\',\'b\',\'c\'...<br />Se voc� for colocar uma barra contr�ria ("\") ou aspas simples ("\'") entre os valores, coloque uma barra contr�ria antes (por exemplo \'\\\\xyz\' ou \'a\\\'b\').';
$strShow = 'Mostrar';
$strShowAll = 'Mostrar Todos';
$strShowCols = 'Mostrar Colunas';
$strShowingRecords = 'Mostrando registros ';
$strShowPHPInfo = 'Mostra informa��es do PHP';
$strShowTables = 'Mostrar Tabelas';
$strShowThisQuery = ' Mostra esta query novamente ';
$strSingly = '(singularmente)';
$strSize = 'Tamanho';
$strSort = 'Ordena';
$strSpaceUsage = 'Uso do espa�o';
$strSQLQuery = 'comando SQL';
$strStatement = 'Comandos';
$strStrucCSV = 'Dados CSV';
$strStrucData = 'Estrutura e dados';
$strStrucDrop = 'Adiciona \'Sobrescrever\'';
$strStrucExcelCSV = 'CSV para dados Ms Excel';
$strStrucOnly = 'Somente estrutura';
$strSubmit = 'Submete';
$strSuccess = 'Seu comando SQL foi executado com sucesso';
$strSum = 'Soma';

$strTable = 'Tabela';
$strTableComments = 'Coment�rios da tabela';
$strTableEmpty = 'O Nome da Tabela est� vazio!';
$strTableHasBeenDropped = 'Tabela %s foi deletada';
$strTableHasBeenEmptied = 'Tabela %s foi esvaziada';
$strTableHasBeenFlushed = 'Tabela %s foi limpa';
$strTableMaintenance = 'Tabela de Manuten��o';
$strTables = '%s tabela(s)';
$strTableStructure = 'Estrutura da tabela';
$strTableType = 'Tipo da Tabela';
$strTextAreaLength = ' Por causa da sua largura,<br /> esse campo pode n�o ser edit�vel ';
$strTheContent = 'O conte�do do seu arquivo foi inserido';
$strTheContents = 'O conte�do do arquivo substituiu o conte�do da tabela que tinha a mesma chave prim�ria ou �nica';
$strTheTerminator = 'Terminador de campos.';
$strTotal = 'total';
$strType = 'Tipo';

$strUncheckAll = 'Desmarca Todos';
$strUnique = '�nico';
$strUnselectAll = 'Desmarcar Todos';
$strUpdatePrivMessage = 'Voc� mudou os privil�ios para %s.';
$strUpdateProfile = 'Atualizar configura��o:';
$strUpdateProfileMessage = 'A configura��o foi atualizada.';
$strUpdateQuery = 'Atualiza a Procura';
$strUsage = 'Uso';
$strUseBackquotes = 'Usa aspas simples nos nomes de tabelas e campos';
$strUser = 'Usu�rio';
$strUserEmpty = 'O nome do usu�rio est� vazio!';
$strUserName = 'Nome do usu�rio';
$strUsers = 'Usu�rios';
$strUseTables = 'Usar Tabelas';

$strValue = 'Valor';
$strViewDump = 'Ver o esquema da tabela';
$strViewDumpDB = 'Ver o esquema do banco de dados';

$strWelcome = 'Bem vindo ao %s';
$strWithChecked = 'Com marcados:';
$strWrongUser = 'Usu�rio ou Senha errado. Acesso Negado.';

$strYes = 'Sim';

$strZip = '"compactado com zip"';
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

$strQBEDel = 'Del';  //to translate (used in tbl_qbe.php)
$strQBEIns = 'Ins';  //to translate (used in tbl_qbe.php)

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
