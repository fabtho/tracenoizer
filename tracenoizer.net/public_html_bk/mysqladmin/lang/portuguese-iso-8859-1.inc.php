<?php
/* $Id: portuguese-iso-8859-1.inc.php,v 1.32 2002/11/28 09:15:38 rabus Exp $ */

/**
 * Portuguese language file by
 *   Lopo Pizarro <lopopizarro@users.sourceforge.net>
 *   Ant�nio Raposo <cfmsoft@users.sourceforge.net>
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
$datefmt = '%d-%B-%Y �s %H:%M';

$strAPrimaryKey = 'Uma chave prim�ria foi adicionada a %s';
$strAccessDenied = 'Acesso Negado';
$strAction = 'Ac��es';
$strAddDeleteColumn = 'Adicionar/Remover Campos';
$strAddDeleteRow = 'Adicionar/Remover Crit�rios';
$strAddNewField = 'Adiciona novo campo';
$strAddPriv = 'Acrescenta um novo Privil�gio';
$strAddPrivMessage = 'Acrescentou um novo privil�gio.';
$strAddSearchConditions = 'Condi��o de Pesquisa (Complemento da clausula "where"):';
$strAddToIndex = 'Adicionar ao �ndice &nbsp;%s&nbsp;coluna(s)';
$strAddUser = 'Acrescenta um utilizador';
$strAddUserMessage = 'Acrescentou um novo utilizador.';
$strAffectedRows = 'Linhas afectadas:';
$strAfter = 'Depois %s';
$strAfterInsertBack = 'Voltar atr�s';
$strAfterInsertNewInsert = 'Inserir novo registo';
$strAll = 'Todas';
$strAllTableSameWidth = 'mostrar todas as tabelas com a mesma altura?';
$strAlterOrderBy = 'Alterar a ordem da tabela por';
$strAnIndex = 'Um �ndice foi adicionado a %s';
$strAnalyzeTable = 'Analizar tabela';
$strAnd = 'E';
$strAny = 'Todos';
$strAnyColumn = 'Qualquer coluna';
$strAnyDatabase = 'Qualquer base de dados';
$strAnyHost = 'Qualquer m�quina';
$strAnyTable = 'Qualquer tabela';
$strAnyUser = 'Qualquer utilizador';
$strAscending = 'Ascendente';
$strAtBeginningOfTable = 'No In�cio da Tabela';
$strAtEndOfTable = 'No Fim da Tabela';
$strAttr = 'Atributos';

$strBack = 'Voltar';
$strBinary = ' Bin�rio ';
$strBinaryDoNotEdit = ' Bin�rio - n�o editar ';
$strBookmarkDeleted = 'Marcador apagado com sucesso.';
$strBookmarkLabel = 'Etiqueta';
$strBookmarkQuery = 'Comandos SQL marcados';
$strBookmarkThis = 'Marcar este comando SQL';
$strBookmarkView = 'Ver apenas';
$strBrowse = 'Visualiza';
$strBzip = '"Compress�o bzip"';

$strCantLoadMySQL = 'n�o foi poss�vel carregar a extens�o MySQL,<br />por favor verifique a configura��o do PHP.';
$strCantLoadRecodeIconv = 'N�o � poss�vel carregar <i>iconv</i> ou recodificar a extens�o necess�ria para a convers�o do Mapa de Caracteres, configure o php de modo a permitir utilizar estas extens�es ou desligue a convers�o do mapa de caracteres no phpmyadmin.';
$strCantRenameIdxToPrimary = 'Imposs�vel renomear �ndice para PRIMARY!';
$strCantUseRecodeIconv = 'N�o � poss�vel usar <i>iconv</i> nem <i>libiconv</i> nem a fun��o <i>recode_string</i> enquanto a extens�o reportar que est� ligada. Confira a configura��o do seu php.';
$strCardinality = 'Quantidade';
$strCarriage = 'Fim de linha: \\r';
$strChange = 'Muda';
$strChangeDisplay = 'Escolha campo para mostrar';
$strChangePassword = 'Alterar a senha';
$strCheckAll = 'Todos';
$strCheckDbPriv = 'Visualiza os Privil�gios da Base de Dados';
$strCheckTable = 'Verificar tabela';
$strChoosePage = 'Escolha uma P�gina para editar';
$strColComFeat = 'Mostrando coment�rios das Colunas';
$strColumn = 'Campo';
$strColumnNames = 'Nome dos Campos';
$strComments = 'Coment�rios';
$strCompleteInserts = 'Instruc��es de inser��o completas';
$strCompression = 'Compress�o';
$strConfigFileError = 'O phpMyAdmin n�o foi capaz de ler o ficheiro de configura��o!<br />Isto pode acontecer se o php encontrar um erro no <i>parsing</i>  ou se n�o conseguir encontrar o ficheiro.<br />Chame o ficheiro de configura��o directamente usando o <i>link</i> a baixo e leia a(s) mensagem(ns) de erro do php. Na maior parte dos casos, trata-se de uma falta de aspas ou de um ponto e v�rgula algures.<br />Se receber uma p�gina em branco, est� tudo correcto.';
$strConfigureTableCoord = 'Configure as cordenadas para a tabela %s';
$strConfirm = 'Confirma a sua op��o?';
$strCookiesRequired = 'O mecanismo de "Cookies" tem de estar ligado a partir deste ponto.';
$strCopyTable = 'Copia tabela para (base-de-dados<b>.</b>tabela):';
$strCopyTableOK = 'Tabela %s copiada para %s.';
$strCreate = 'Criar';
$strCreateIndex = 'Criar um �ndice com&nbsp;%s&nbsp;coluna(s)';
$strCreateIndexTopic = 'Criar um novo �ndice';
$strCreateNewDatabase = 'Criar nova base de dados';
$strCreateNewTable = 'Criar nova tabela na base de dados %s';
$strCreatePage = 'Criar uma P�gina nova';
$strCreatePdfFeat = 'Cria��o de PDFs';
$strCriteria = 'Crit�rios';

$strData = 'Dados';
$strDataOnly = 'Apenas dados';
$strDatabase = 'Base de Dados ';
$strDatabaseHasBeenDropped = 'A base de dados %s foi eliminada.';
$strDatabaseWildcard = 'Base de Dados (aceita caracteres universais):';
$strDatabases = 'Base de Dados';
$strDatabasesStats = 'Estat�sticas das bases de dados';
$strDefault = 'Defeito';
$strDelete = 'Apagar';
$strDeleteFailed = 'Erro ao apagar!';
$strDeleteUserMessage = 'Apagou o utilizador %s.';
$strDeleted = 'Registo eliminado';
$strDeletedRows = 'Linhas apagadas:';
$strDescending = 'Descendente';
$strDisabled = 'Desactidado';
$strDisplay = 'Mostra';
$strDisplayFeat = 'Mostrar Caracter�sticas';
$strDisplayOrder = 'Ordem de visualiza��o:';
$strDisplayPDF = 'Mostrar o esquema de PDF';
$strDoAQuery = 'Fa�a uma "pesquisa por formul�rio" (caractere universal: "%")';
$strDoYouReally = 'Confirma : ';
$strDocu = 'Documenta��o';
$strDrop = 'Elimina';
$strDropDB = 'Elimina a base de dados %s';
$strDropTable = 'Elimina tabela';
$strDumpXRows = 'Exporta %s registos come�ando em %s.';
$strDumpingData = 'Extraindo dados da tabela';
$strDynamic = 'din�mico';

$strEdit = 'Edita';
$strEditPDFPages = 'Editar p�ginas PDF';
$strEditPrivileges = 'Alterar Privilegios';
$strEffective = 'Em uso';
$strEmpty = 'Limpa';
$strEmptyResultSet = 'MySQL n�o retornou nenhum registo.';
$strEnabled = 'Activado';
$strEnd = 'Fim';
$strEnglishPrivileges = ' Nota: os nomes dos privil�gios do MySQL s�o em Ingl�s ';
$strError = 'Erro';
$strExport = 'Exportar';
$strExportToXML = 'Exportar para o formato XML';
$strExtendedInserts = 'Instruc��es de inser��o m�ltiplas';
$strExtra = 'Extra'; // written the same in portuguese

$strField = 'Campo';
$strFieldHasBeenDropped = 'O campo %s foi eliminado';
$strFields = 'Qtd Campos';
$strFieldsEmpty = ' N�mero de campos inv�lido! ';
$strFieldsEnclosedBy = 'Campos delimitados por';
$strFieldsEscapedBy = 'Campos precedidos por';
$strFieldsTerminatedBy = 'Campos terminados por';
$strFixed = 'fixo';
$strFlushTable = 'Fecha a tabela ("FLUSH")';
$strFormEmpty = 'N� de dados insuficiente!\nPreencha todas as op��es!';
$strFormat = 'Formato';
$strFullText = 'Texto inteiro';
$strFunction = 'Fun��es';

$strGenBy = 'Gerado por';
$strGenTime = 'Data de Cria��o';
$strGeneralRelationFeat = 'Caracter�sticas gerais de Rela��o';
$strGo = 'Executa';
$strGrants = 'Autoriza��es';
$strGzip = '"Compress�o gzip"';

$strHasBeenAltered = 'foi alterado(a).';
$strHasBeenCreated = 'foi criado(a).';
$strHaveToShow = 'Tem que escolher pelo menos uma coluna para mostrar';
$strHome = 'In�cio';
$strHomepageOfficial = 'P�gina Oficial do phpMyAdmin';
$strHomepageSourceforge = 'Sourceforge phpMyAdmin - P�gina de Download';
$strHost = 'M�quina';
$strHostEmpty = 'O nome da m�quina est� vazio!';

$strIdxFulltext = 'Texto Completo';
$strIfYouWish = 'Para carregar apenas algumas colunas da tabela, fa�a uma lista separada por virgula.';
$strIgnore = 'Ignora';
$strInUse = 'em uso';
$strIndex = '�ndice';
$strIndexHasBeenDropped = 'O �ndice %s foi eliminado';
$strIndexName = 'Nome do �ndice&nbsp;:';
$strIndexType = 'Tipo de �ndice&nbsp;:';
$strIndexes = '�ndices';
$strInsert = 'Insere';
$strInsertAsNewRow = 'Insere como novo registo';
$strInsertNewRow = 'Insere novo registo';
$strInsertTextfiles = 'Insere arquivo texto na tabela';
$strInsertedRows = 'Registos inseridos :';
$strInstructions = 'Instru��es';
$strInvalidName = '"%s" � uma palavra reservada, n�o pode usar como nome de base de dados/tabela/campo.';

$strKeepPass = 'Sem alterar senha';
$strKeyname = 'Nome do �ndice';
$strKill = 'Termina';

$strLength = 'Comprimento';
$strLengthSet = 'Tamanho/Valores*';
$strLimitNumRows = 'N�mero de registos por p�gina';
$strLineFeed = 'Mudan�a de linha: \\n';
$strLines = 'Linhas';
$strLinesTerminatedBy = 'Linhas terminadas por';
$strLinkNotFound = 'Link n�o encontrado';
$strLinksTo = 'Links para';
$strLocationTextfile = 'Localiza��o do arquivo de texto';
$strLogPassword = 'Senha&nbsp;:';
$strLogUsername = 'Utilizador&nbsp;:';
$strLogin = 'Entrada';
$strLogout = 'Sair';

$strMissingBracket = 'Falta de par�ntesis recto';
$strModifications = 'Modifica��es foram guardadas';
$strModify = 'Modifica';
$strModifyIndexTopic = 'Modificar um �ndice';
$strMoveTable = 'Move tabela para (base de dados<b>.</b>tabela):';
$strMoveTableOK = 'A tabela %s foi movida para %s.';
$strMySQLCharset = 'Mapa de Caracteres do mySQL';
$strMySQLReloaded = 'MySQL reiniciado.';
$strMySQLSaid = 'Mensagens do MySQL : ';
$strMySQLServerProcess = 'MySQL %pma_s1% a correr em %pma_s2% como %pma_s3%';
$strMySQLShowProcess = 'Mostra os Processos';
$strMySQLShowStatus = 'Mostra informa��o do estado do MySQL';
$strMySQLShowVars = 'Mostra as vari�veis de sistema do MySQL';

$strName = 'Nome';
$strNext = 'Pr�ximo';
$strNo = 'N�o';
$strNoDatabases = 'Sem bases de dados';
$strNoDescription = 'sem Descri��o';
$strNoDropDatabases = 'Os comandos "DROP DATABASE" est�o inibidos.';
$strNoFrames = 'O phpMyAdmin torna-se mais agrad�vel se usado num browser que suporte <b>frames</b>.';
$strNoIndex = 'Nenhum ind�ce definido!';
$strNoIndexPartsDefined = 'Nenhuma parte do �ndice definida!';
$strNoModification = 'Sem altera��es';
$strNoPassword = 'Sem Senha';
$strNoPhp = 'sem c�digo PHP';
$strNoPrivileges = 'Sem Privil�gios';
$strNoQuery = 'Nenhum comando SQL encontrado!';
$strNoRights = 'N�o tem permiss�es suficientes para aceder aqui, neste momento!';
$strNoTablesFound = 'Nenhuma tabela encontrada na base de dados';
$strNoUsersFound = 'Nenhum utilizador encontrado.';
$strNone = 'Nenhum';
$strNotNumber = 'Isto n�o � um n�mero!';
$strNotOK = 'n�o est� OK';
$strNotSet = 'A Tabela <b>%s</b> n�o foi encontrada ou n�o foi definida em %s';
$strNotValidNumber = ' n�o � um n�mero de registo v�lido!';
$strNull = 'Nulo';
$strNumSearchResultsInTable = '%s resultado(s) na tabela <i>%s</i>';
$strNumSearchResultsTotal = '<b>Total:</b> <i>%s</i> resultado(s)';

$strOK = 'OK';  //Same in portuguese
$strOftenQuotation = 'Normalmente aspas. OPTIONALLY significa que apenas os campos "char" e "varchar" s�o delimitados pelo caractere delimitador.';
$strOperations = 'Opera��es';
$strOptimizeTable = 'Optimizar tabela';
$strOptionalControls = 'Opcional. Comanda o modo de escrita e leitura dos caracteres especiais.';
$strOptionally = 'OPCIONAL';
$strOptions = 'Op��es';
$strOr = 'Ou';
$strOverhead = 'Suspenso';

$strPHPVersion = 'vers�o do PHP';
$strPageNumber = 'P�gina n�mero:';
$strPartialText = 'Texto parcial';
$strPassword = 'Senha';
$strPasswordEmpty = 'Indique a Senha!';
$strPasswordNotSame = 'As senhas s�o diferentes!\nLembre-se de confirmar a senha!';
$strPdfDbSchema = 'Esquema da base de dados "%s" - P�gina %s';
$strPdfInvalidPageNum = 'Numero da p�gina do PDF indefinido!';
$strPdfInvalidTblName = 'A tabela "%s" n�o existe!';
$strPdfNoTables = 'Sem tablelas';
$strPhp = 'Criar c�digo PHP';
$strPmaDocumentation = 'Documenta��o do phpMyAdmin';
$strPmaUriError = 'A directiva <tt>$cfg[\'PmaAbsoluteUri\']</tt> TEM que ser definida no ficheiro de configura��o!';
$strPos1 = 'Inicio';
$strPrevious = 'Anterior';
$strPrimary = 'Prim�ria';
$strPrimaryKey = 'Chave Prim�ria';
$strPrimaryKeyHasBeenDropped = 'A chave prim�ria foi eliminada';
$strPrimaryKeyName = 'O nome da chave prim�ria tem de ser... PRIMARY!';
$strPrimaryKeyWarning = '("PRIMARY" <b>tem</b> de ser o nome de e <b>apenas de</b> uma chave prim�ria!)';
$strPrintView = 'Vista de impress�o';
$strPrivileges = 'Privil�gios';
$strProperties = 'Propriedades';

$strQBE = 'Pesquisa por formul�rio';
$strQBEDel = 'Elim.';
$strQBEIns = 'Ins.';
$strQueryOnDb = 'Comando SQL na base de dados <b>%s</b>:';

$strReType = 'Confirma';
$strRecords = 'Registos';
$strReferentialIntegrity = 'Verificar Integridade referencial:';
$strRelationNotWorking = 'As Caracter�sticas adicionais para trabalhar com liga��es entre Tabelas foram desactivadas. Para saber porqu� carregue %saqui%s.';
$strRelationView = 'Vista de Rela��o';
$strReloadFailed = 'Reinicia��o do MySQL falhou.';
$strReloadMySQL = 'Reiniciar o MySQL';
$strRememberReload = 'Lembre-se de reiniciar o servidor.';
$strRenameTable = 'Renomeia a tabela para ';
$strRenameTableOK = 'Tabela %s renomeada para %s';
$strRepairTable = 'Reparar tabela';
$strReplace = 'Substituir';
$strReplaceTable = 'Substituir os dados da tabela pelos do arquivo';
$strReset = 'Limpa';
$strRevoke = 'Anula';
$strRevokeGrant = 'Anula Autoriza��o';
$strRevokeGrantMessage = 'Anulou a autoriza��o para %s';
$strRevokeMessage = 'Anulou os privil�gios para %s';
$strRevokePriv = 'Anula Privil�gios';
$strRowLength = 'Comprim. dos reg.';
$strRowSize = ' Tamanho dos reg.';
$strRows = 'Registos';
$strRowsFrom = 'registos come�ando em';
$strRowsModeHorizontal = 'horizontal';  // written the same in portuguese!
$strRowsModeOptions = 'em modo %s com cabe�alhos repetidos a cada %s c�lulas';
$strRowsModeVertical = 'vertical';  // written the same in portuguese!
$strRowsStatistic = 'Estat�sticas dos registos';
$strRunQuery = 'Executa Comando SQL';
$strRunSQLQuery = 'Executa comando(s) SQL na base de dados %s';
$strRunning = 'a correr em %s';

$strSQL = 'SQL';
$strSQLQuery = 'Comando SQL';
$strSQLResult = 'Resultado SQL';
$strSave = 'Guarda';
$strScaleFactorSmall = 'O factor escala � muito pequeno para encaixar o esquema numa p�gina';
$strSearch = 'Pesquisar';
$strSearchFormTitle = 'Pesquisar na Base de Dados';
$strSearchInTables = 'Dentro de Tabela(s):';
$strSearchNeedle = 'Palavra(s) ou valor(es) para pesquisar para (wildcard: "%"):';
$strSearchOption1 = 'pelo menos uma das palavras';
$strSearchOption2 = 'todas as palavras';
$strSearchOption3 = 'a frase exacta';
$strSearchOption4 = 'as regular expression';
$strSearchResultsFor = 'Procurar resultados para "<i>%s</i>" %s:';
$strSearchType = 'Procurar:';
$strSelect = 'Selecciona';
$strSelectADb = 'Por favor seleccione uma base de dados';
$strSelectAll = 'Selecciona Todas';
$strSelectFields = 'Seleccione os campos (no m�nimo 1)';
$strSelectNumRows = 'na pesquisa';
$strSelectTables = 'Seleccionar Tabelas';
$strSend = 'envia';
$strServerChoice = 'Escolha do Servidor';
$strServerVersion = 'Vers�o do servidor';
$strSetEnumVal = 'Se o tipo de campo � "enum" ou "set", por favor introduza os valores no seguinte formato: \'a\',\'b\',\'c\'...<br />Se precisar de colocar uma barra invertida ("\") ou um ap�strofe ("\'") entre esses valores, coloque uma barra invertida antes (por exemplo \'\\\\xyz\' ou \'a\\\'b\').';
$strShow = 'Mostra';
$strShowAll = 'Mostrar tudo';
$strShowColor = 'Mostrar c�r';
$strShowCols = 'Mostra Colunas';
$strShowGrid = 'Mostrar grelha';
$strShowPHPInfo = 'Mostra informa��o do PHP';
$strShowTableDimension = 'Mostrar dimens�o das tabelas';
$strShowTables = 'Mostra tabelas';
$strShowThisQuery = ' Mostrar de novo aqui este comando ';
$strShowingRecords = 'Mostrando registos ';
$strSingly = '(A refazer ap�s inserir/eliminar)';
$strSize = 'Tamanho';
$strSort = 'Ordena��o';
$strSpaceUsage = 'Espa�o ocupado';
$strSplitWordsWithSpace = 'As palavras s�o separadas pelo caracter espa�o (" ").';
$strStatement = 'Itens';
$strStrucCSV = 'Dados CSV';
$strStrucData = 'Estrutura e dados';
$strStrucDrop = 'Adiciona \'drop table\'';
$strStrucExcelCSV = 'dados CSV para Ms Excel';
$strStrucOnly = 'Somente estrutura';
$strStructPropose = 'Propor uma estrutura de tabela';
$strStructure = 'Estrutura';
$strSubmit = 'Submete';
$strSuccess = 'O seu comando SQL foi executado com sucesso';
$strSum = 'Soma';

$strTable = 'Tabela';
$strTableComments = 'Coment�rios da tabela';
$strTableEmpty = 'O nome da tabela est� vazio!';
$strTableHasBeenDropped = 'A tabela %s foi eliminada';
$strTableHasBeenEmptied = 'A tabela %s foi limpa';
$strTableHasBeenFlushed = 'A tabela %s foi fechada';
$strTableMaintenance = 'Manuten��o da tabela';
$strTableStructure = 'Estrutura da tabela';
$strTableType = 'Tipo de tabela';
$strTables = '%s tabela(s)';
$strTextAreaLength = ' Devido ao seu tamanho,<br /> este campo pode n�o ser edit�vel ';
$strTheContent = 'O conte�do do seu arquivo foi inserido';
$strTheContents = 'O conte�do do arquivo substituiu o conte�do da tabela que tinha a mesma chave prim�ria ou �nica';
$strTheTerminator = 'Terminador de campos.';
$strTotal = 'total';
$strType = 'Tipo';

$strUncheckAll = 'Nenhum';
$strUnique = '�nico';
$strUnselectAll = 'Limpa Todas as Selec��es';
$strUpdatePrivMessage = 'Actualizou os privil�gios de %s.';
$strUpdateProfile = 'Actualiza o prefil:';
$strUpdateProfileMessage = 'O prefil foi actualizado.';
$strUpdateQuery = 'Actualiza Comando SQL';
$strUsage = 'Utiliza��o';
$strUseBackquotes = 'Usar ap�strofes com os nomes das tabelas e campos';
$strUseTables = 'Usar Tabelas';
$strUser = 'Utilizador';
$strUserEmpty = 'O nome do utilizador est� vazio!';
$strUserName = 'Nome do Utilizador';
$strUsers = 'Utilizadores';

$strValue = 'Valor';
$strViewDump = 'Ver o esquema da tabela';
$strViewDumpDB = 'Ver o esquema da base de dados';

$strWelcome = 'Bemvindo ao %s';
$strWithChecked = 'Com os seleccionados:';
$strWrongUser = 'Utilizador ou Senha errada. Acesso Negado.';

$strYes = 'Sim';

$strZip = '"Compress�o zip"';

$strBeginCut = 'BEGIN CUT';  //to translate
$strBeginRaw = 'BEGIN RAW';  //to translate

$strCharsetOfFile = 'Character set of the file:'; //to translate

$strDataDict = 'Data Dictionary';  //to translate

$strEndCut = 'END CUT';  //to translate
$strEndRaw = 'END RAW';  //to translate
$strExplain = 'Explain SQL';  //to translate

$strImportDocSQL = 'Import docSQL Files';  //to translate
$strInsecureMySQL = 'Your configuration file contains settings (root with no password) that correspond to the default MySQL privileged account. Your MySQL server is running with this default, is open to intrusion, and you really should fix this security hole.';  //to translate

$strNoExplain = 'Skip Explain SQL';  //to translate
$strNoValidateSQL = 'Skip Validate SQL';  //to translate

$strPHP40203 = 'You are using PHP 4.2.3, which has a serious bug with multi-byte strings (mbstring). See PHP bug report 19404. This version of PHP is not recommended for use with phpMyAdmin.';  //to translate
$strPrint = 'Print';  //to translate
$strPutColNames = 'Put fields names at first row';  //to translate

$strSQLParserBugMessage = 'There is a chance that you may have found a bug in the SQL parser. Please examine your query closely, and check that the quotes are correct and not mis-matched. Other possible failure causes may be that you are uploading a file with binary outside of a quoted text area. You can also try your query on the MySQL command line interface. The MySQL server error output below, if there is any, may also help you in diagnosing the problem. If you still have problems or if the parser fails where the command line interface succeeds, please reduce your SQL query input to the single query that causes problems, and submit a bug report with the data chunk in the CUT section below:';  //to translate
$strSQLParserUserError = 'There seems to be an error in your SQL query. The MySQL server error output below, if there is any, may also help you in diagnosing the problem';  //to translate
$strSQPBugInvalidIdentifer = 'Invalid Identifer';  //to translate
$strSQPBugUnclosedQuote = 'Unclosed quote';  //to translate
$strSQPBugUnknownPunctuation = 'Unknown Punctuation String';  //to translate
$strServer = 'Server %s';  //to translate

$strValidateSQL = 'Validate SQL';  //to translate
$strValidatorError = 'The SQL validator could not be initialized. Please check if you have installed the necessary php extensions as described in the %sdocumentation%s.'; //to translate

$strWebServerUploadDirectory = 'web-server upload directory';  //to translate
$strWebServerUploadDirectoryError = 'The directory you set for upload work cannot be reached';  //to translate

$strNumTables = 'Tables'; //to translate
$strTotalUC = 'Total'; //to translate
?>
