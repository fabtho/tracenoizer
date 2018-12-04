<?php
/* $Id: brazilian_portuguese-utf-8.inc.php,v 1.29 2002/11/28 09:15:19 rabus Exp $ */

/**
 * Translated by Renato Lins <thbest at information4u.com>
 */

$charset = 'utf-8';
$allow_recoding = TRUE;
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
$strAction = 'Ações';
$strAddDeleteColumn = 'Adiciona/Remove Colunas';
$strAddDeleteRow = 'Adiciona/Remove Condições de busca';
$strAddNewField = 'Adiciona novo campo';
$strAddPriv = 'Adiciona um novo Privilégio';
$strAddPrivMessage = 'Privilégio adicionado.';
$strAddSearchConditions = 'Condição de Pesquisa (Complemento da clausula "onde"):';
$strAddToIndex = 'Adicionar ao índice &nbsp;%s&nbsp;coluna(s)';
$strAddUser = 'Adicionar um novo usuário';
$strAddUserMessage = 'Usuário adcionado.';
$strAffectedRows = 'Registro afetados:';
$strAfter = 'Depois %s';
$strAfterInsertBack = 'Retornar';
$strAfterInsertNewInsert = 'Inserir um novo registro';
$strAll = 'Todos';
$strAlterOrderBy = 'Alterar tabela ordenada por';
$strAnalyzeTable = 'Analizar tabela';
$strAnd = 'E';
$strAnIndex = 'Um índice foi adicionado a %s';
$strAny = 'Qualquer';
$strAnyColumn = 'Qualquer coluna';
$strAnyDatabase = 'Qualquer banco de dados';
$strAnyHost = 'Qualquer servidor';
$strAnyTable = 'Qualquer tabela';
$strAnyUser = 'Qualquer usuário';
$strAPrimaryKey = 'Uma chave primária foi adicionada a %s';
$strAscending = 'Ascendente';
$strAtBeginningOfTable = 'No começo da tabela';
$strAtEndOfTable = 'Ao fim da tabela';
$strAttr = 'Atributos';

$strBack = 'Voltar';
$strBinary = ' Binário ';
$strBinaryDoNotEdit = ' Binário - não edite ';
$strBookmarkDeleted = 'O bookmark foi removido.';
$strBookmarkLabel = 'Nome';
$strBookmarkQuery = 'Procura de SQL salva';
$strBookmarkThis = 'Salvar essa procura de SQL';
$strBookmarkView = 'Apenas visualiza';
$strBrowse = 'Visualiza';
$strBzip = '"compactado com bzip"';

$strCantLoadMySQL = 'não foi possível carregar extensão do MySQL,<br />por favor cheque a configuração do PHP.';
$strCantRenameIdxToPrimary = 'Não foi possível renomear o índice para "PRIMARY"!';
$strCardinality = 'Cardinalidade';
$strCarriage = 'Caracter de retorno: \\r';
$strChange = 'Muda';
$strChangePassword = 'Mude a senha';
$strCheckAll = 'Marcar All';
$strCheckDbPriv = 'Verifica Privilégios do Banco de Dados';
$strCheckTable = 'Verifica tabela';
$strColumn = 'Coluna';
$strColumnNames = 'Nome da Colunas';
$strCompleteInserts = 'Inserções Completas';
$strConfirm = 'Você tem certeza?';
$strCookiesRequired = 'Cookies devem estar ativados após este ponto.';
$strCopyTable = 'Copiar tabela para (base<b>.</b>tabela):';
$strCopyTableOK = 'Tabela %s copiada para %s.';
$strCreate = 'Cria';
$strCreateIndex = 'Criar um índice em&nbsp;%s&nbsp;colunas';
$strCreateIndexTopic = 'Criar um novo índice';
$strCreateNewDatabase = 'Cria novo banco de dados';
$strCreateNewTable = 'Cria nova tabela no banco de dados %s';
$strCriteria = 'Critério';

$strData = 'Dados';
$strDatabase = 'Banco de Dados ';
$strDatabaseHasBeenDropped = 'Base de Dados %s foi eliminada.';
$strDatabases = 'Banco de Dados';
$strDatabasesStats = 'Estatisticas da base';
$strDatabaseWildcard = 'Banco de Dados (caractéres-coringa permitidos):';
$strDataOnly = 'Dados apenas';
$strDefault = 'Padrão';
$strDelete = 'Remove';
$strDeleted = 'Registro eliminado';
$strDeletedRows = 'Registro deletados:';
$strDeleteFailed = 'Não foi possível apagar!';
$strDeleteUserMessage = 'Você deletou o usuário %s.';
$strDescending = 'Descendente';
$strDisplay = 'Tela';
$strDisplayOrder = 'Ordenado por:';
$strDoAQuery = 'Faça uma "procura por exemplo" (coringa: "%")';
$strDocu = 'Documentação';
$strDoYouReally = 'Confirma : ';
$strDrop = 'Elimina';
$strDropDB = 'Elimina o banco de dados %s';
$strDropTable = 'Remove Tabela';
$strDumpingData = 'Extraindo dados da tabela';
$strDynamic = 'dinâmico';

$strEdit = 'Edita';
$strEditPrivileges = 'Edita Privilégios';
$strEffective = 'Efetivo';
$strEmpty = 'Limpa';
$strEmptyResultSet = 'MySQL retornou um conjunto vazio (ex. zero registros).';
$strEnd = 'Fim';
$strEnglishPrivileges = ' Nota: nomes de privilégios do MySQL são expressos em inglês ';
$strError = 'Erro';
$strExtendedInserts = 'Inserções extendidas';
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
$strFunction = 'Funçoes';

$strGenTime = 'Tempo de Generação';
$strGo = 'Executa';
$strGrants = 'Conceder';
$strGzip = '"compactado com gzip"';

$strHasBeenAltered = 'foi alterado.';
$strHasBeenCreated = 'foi criado.';
$strHome = 'Principal';
$strHomepageOfficial = 'Página Oficial do phpMyAdmin';
$strHomepageSourceforge = 'Nova Página do phpMyAdmin';
$strHost = 'Servidor';
$strHostEmpty = 'O nome do servidor está vazio!';

$strIdxFulltext = 'Fulltext';
$strIfYouWish = 'Para carregar apenas algumas colunas da tabela, faça uma lista separada por vírgula.';
$strIgnore = 'Ignorar';
$strIndex = 'Índice';
$strIndexes = 'Índices';
$strIndexHasBeenDropped = 'Índice %s foi deletado';
$strIndexName = 'Nome do índice&nbsp;:';
$strIndexType = 'Tipo de índice&nbsp;:';
$strInsert = 'Insere';
$strInsertAsNewRow = 'Insere uma nova coluna';
$strInsertedRows = 'Linhas Inseridas:';
$strInsertNewRow = 'Insere novo registro';
$strInsertTextfiles = 'Insere arquivo texto na tabela';
$strInstructions = 'Instruções';
$strInUse = 'em uso';
$strInvalidName = '"%s" é uma palavra reservada, você não pode usá-la como um nome de base de dados/tabela/campo.';

$strKeepPass = 'Não mudar a senha';
$strKeyname = 'Nome chave';
$strKill = 'Matar';

$strLength = 'Tamanho';
$strLengthSet = 'Tamanho/Definir*';
$strLimitNumRows = 'registros por página';
$strLineFeed = 'Caracter de Alimentação de Linha: \\n';
$strLines = 'Linhas';
$strLinesTerminatedBy = 'Linhas terminadas por';
$strLocationTextfile = 'Localização do arquivo texto';
$strLogin = 'Autenticação';
$strLogout = 'Sair';
$strLogPassword = 'Senha:';
$strLogUsername = 'Usuário:';

$strModifications = 'Modificações foram salvas';
$strModify = 'Modificar';
$strModifyIndexTopic = 'Modificar um índice';
$strMoveTable = 'Mover tabela para (base de dados<b>.</b>tabela):';
$strMoveTableOK = 'Tabela %s foi movida para %s.';
$strMySQLReloaded = 'MySQL reiniciado.';
$strMySQLSaid = 'Mensagens do MySQL : ';
$strMySQLServerProcess = 'MySQL %pma_s1% funcionando em %pma_s2% como %pma_s3%';
$strMySQLShowProcess = 'Mostra os Processos';
$strMySQLShowStatus = 'Mostra informação de runtime do MySQL';
$strMySQLShowVars = 'Mostra variáveis de sistema do MySQL';

$strName = 'Nome';
$strNext = 'Próximo';
$strNo = 'Não';
$strNoDatabases = 'Sem bases';
$strNoDropDatabases = 'O comando "DROP DATABASE" está desabilitado.';
$strNoFrames = 'phpMyAdmin é mais amigável com um navegador <b>capaz de exibir frames</b>.';
$strNoIndex = 'Nenhum índice definido!';
$strNoIndexPartsDefined = 'Nenhuma parte de índice definida!';
$strNoModification = 'Sem Mudança';
$strNone = 'Nenhum';
$strNoPassword = 'Sem Senha';
$strNoPrivileges = 'Sem Privilégios';
$strNoQuery = 'Nenhuma procura SQL!';
$strNoRights = 'Você não tem direitos suficientes para estar aqui agora!';
$strNoTablesFound = 'Nenhuma tabela encontrada no banco de dados';
$strNotNumber = 'Isto não é um número!';
$strNotValidNumber = ' não é um número de registro valido!';
$strNoUsersFound = 'Nenhum usuário(s) encontrado.';
$strNull = 'Nulo';

$strOftenQuotation = 'Em geral aspas. OPCIONAL significa que apenas campos de caracteres são delimitados por caracteres "delimitadores"';
$strOptimizeTable = 'Optimizar tabela';
$strOptionalControls = 'Opcional. Controla como ler e escrever caracteres especiais.';
$strOptionally = 'OPCIONAL';
$strOr = 'Ou';
$strOverhead = 'Sobre Carga';

$strPartialText = 'Textos parciais';
$strPassword = 'Senha';
$strPasswordEmpty = 'A senhas está vazia!';
$strPasswordNotSame = 'As senhas não são a mesma!';
$strPHPVersion = 'Versão do PHP';
$strPmaDocumentation = 'Documentação do phpMyAdmin ';
$strPmaUriError = 'A diretiva <tt>$cfg[\'PmaAbsoluteUri\']</tt> Deve ser setada';
$strPos1 = 'Início';
$strPrevious = 'Anterior';
$strPrimary = 'Primária';
$strPrimaryKey = 'Chave Primária';
$strPrimaryKeyHasBeenDropped = 'A chave primária foi deletada';
$strPrimaryKeyName = 'O nome da chave primária deve ser... "PRIMARY"!';
$strPrimaryKeyWarning = '("PRIMARY" <b>precisa</b> ser o nome de e <b>apenas da</b> chave primária!)';
$strPrintView = 'Visualização para Impressão';
$strPrivileges = 'Privilégios';
$strProperties = 'Propriedades';

$strQBE = 'Procura por Exemplo';
$strQueryOnDb = 'Procura SQL na base de dados <b>%s</b>:';

$strRecords = 'Registros';
$strReferentialIntegrity = 'Verificar integridade referencial:';
$strReloadFailed = 'Reinicialização do MySQL falhou.';
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
$strRevokeGrant = 'Revogar Privilégio de Conceder';
$strRevokeGrantMessage = 'Você revogou o privilégio de conceder para %s';
$strRevokeMessage = 'Você revogou os privilégios para %s';
$strRevokePriv = 'Revogar Privilégios';
$strRowLength = 'Tamanho da Coluna';
$strRows = 'Colunas';
$strRowsFrom = 'colunas começando de';
$strRowSize = ' Tamanho do registro ';
$strRowsModeHorizontal = 'horizontal';
$strRowsModeOptions = 'no modo %s e repetindo cabeçalhos após %s células';
$strRowsModeVertical = 'vertical';
$strRowsStatistic = 'Estatistícas da Coluna';
$strRunning = 'Rodando em %s';
$strRunQuery = 'Envia Query';
$strRunSQLQuery = 'Fazer procura(s) SQL no banco de dados %s';

$strSave = 'Salva';
$strSelect = 'Procura';
$strSelectADb = 'Por favor, selecione uma base de dados';
$strSelectAll = 'Selecionar Todos';
$strSelectFields = 'Selecione os campos (no mínimo 1)';
$strSelectNumRows = 'na procura';
$strSend = 'Envia';
$strServerChoice = 'Seleção da Base';
$strServerVersion = 'Versão do Servidor';
$strSetEnumVal = 'Se um tipo de campo é "enum" ou "set", por favor entre valores usando este formato: \'a\',\'b\',\'c\'...<br />Se você for colocar uma barra contrária ("\") ou aspas simples ("\'") entre os valores, coloque uma barra contrária antes (por exemplo \'\\\\xyz\' ou \'a\\\'b\').';
$strShow = 'Mostrar';
$strShowAll = 'Mostrar Todos';
$strShowCols = 'Mostrar Colunas';
$strShowingRecords = 'Mostrando registros ';
$strShowPHPInfo = 'Mostra informações do PHP';
$strShowTables = 'Mostrar Tabelas';
$strShowThisQuery = ' Mostra esta query novamente ';
$strSingly = '(singularmente)';
$strSize = 'Tamanho';
$strSort = 'Ordena';
$strSpaceUsage = 'Uso do espaço';
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
$strTableComments = 'Comentários da tabela';
$strTableEmpty = 'O Nome da Tabela está vazio!';
$strTableHasBeenDropped = 'Tabela %s foi deletada';
$strTableHasBeenEmptied = 'Tabela %s foi esvaziada';
$strTableHasBeenFlushed = 'Tabela %s foi limpa';
$strTableMaintenance = 'Tabela de Manutenção';
$strTables = '%s tabela(s)';
$strTableStructure = 'Estrutura da tabela';
$strTableType = 'Tipo da Tabela';
$strTextAreaLength = ' Por causa da sua largura,<br /> esse campo pode não ser editável ';
$strTheContent = 'O conteúdo do seu arquivo foi inserido';
$strTheContents = 'O conteúdo do arquivo substituiu o conteúdo da tabela que tinha a mesma chave primária ou única';
$strTheTerminator = 'Terminador de campos.';
$strTotal = 'total';
$strType = 'Tipo';

$strUncheckAll = 'Desmarca Todos';
$strUnique = 'Único';
$strUnselectAll = 'Desmarcar Todos';
$strUpdatePrivMessage = 'Você mudou os priviléios para %s.';
$strUpdateProfile = 'Atualizar configuração:';
$strUpdateProfileMessage = 'A configuração foi atualizada.';
$strUpdateQuery = 'Atualiza a Procura';
$strUsage = 'Uso';
$strUseBackquotes = 'Usa aspas simples nos nomes de tabelas e campos';
$strUser = 'Usuário';
$strUserEmpty = 'O nome do usuário está vazio!';
$strUserName = 'Nome do usuário';
$strUsers = 'Usuários';
$strUseTables = 'Usar Tabelas';

$strValue = 'Valor';
$strViewDump = 'Ver o esquema da tabela';
$strViewDumpDB = 'Ver o esquema do banco de dados';

$strWelcome = 'Bem vindo ao %s';
$strWithChecked = 'Com marcados:';
$strWrongUser = 'Usuário ou Senha errado. Acesso Negado.';

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
