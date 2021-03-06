<?php
/* $Id: french-iso-8859-1.inc.php,v 1.36 2002/11/28 09:15:28 rabus Exp $ */

$charset = 'iso-8859-1';
$text_dir = 'ltr';
$left_font_family = 'verdana, arial, helvetica, geneva, sans-serif';
$right_font_family = 'arial, helvetica, geneva, sans-serif';
$number_thousands_separator = ' ';
$number_decimal_separator = ',';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('Octets', 'Ko', 'Mo', 'Go');

$day_of_week = array('Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi');
$month = array('Janvier', 'F�vrier', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Ao�t', 'Septembre', 'Octobre', 'Novembre', 'D�cembre');
// Voir http://www.php.net/manual/en/function.strftime.php pour la variable
// ci-dessous
$datefmt = '%A %d %B %Y � %H:%M';

$strAPrimaryKey = 'Une cl� primaire a �t� ajout�e sur %s';
$strAccessDenied = 'Acc�s refus�';
$strAction = 'Action';
$strAddDeleteColumn = 'Ajouter/effacer x colonne(s)';
$strAddDeleteRow = 'Ajouter/effacer x ligne(s)';
$strAddNewField = 'Ajouter un champ';
$strAddPriv = 'Ajouter un privil�ge';
$strAddPrivMessage = 'Vous avez ajout� un privil�ge';
$strAddSearchConditions = 'Crit�res de recherche (pour l\'�nonc� "where"):';
$strAddToIndex = 'Ajouter � la clef&nbsp;%s&nbsp;colonne(s)';
$strAddUser = 'Ajouter un utilisateur';
$strAddUserMessage = 'Vous avez ajout� un utilisateur';
$strAffectedRows = 'Nombre d\'enregistrements affect�s :';
$strAfter = 'Apr�s %s';
$strAfterInsertBack = 'Retourner � la page pr�c�dente';
$strAfterInsertNewInsert = 'Ins�rer un nouvel enregistrement';
$strAll = 'Tout';
$strAllTableSameWidth = 'Afficher toutes les tables avec une largeur identique';
$strAlterOrderBy = '<b>Ordonner</b> la table par';
$strAnIndex = 'Un index a �t� ajout� sur %s';
$strAnalyzeTable = 'Analyser la table';
$strAnd = 'et';
$strAny = 'N\'importe quel';
$strAnyColumn = 'Toute colonne';
$strAnyDatabase = 'Toute base de donn�es';
$strAnyHost = 'Tout serveur';
$strAnyTable = 'Toute table';
$strAnyUser = 'Tout utilisateur';
$strAscending = 'Croissant';
$strAtBeginningOfTable = 'En d�but de Table';
$strAtEndOfTable = 'En fin de Table';
$strAttr = 'Attributs';

$strBack = 'Retour';
$strBeginCut = 'D�but de la section � couper';
$strBeginRaw = 'D�but des informations sur l\'anomalie';
$strBinary = 'Binaire';
$strBinaryDoNotEdit = 'Binaire - ne pas �diter';
$strBookmarkDeleted = 'Le bookmark a �t� effac�.';
$strBookmarkLabel = 'Intitul�';
$strBookmarkQuery = 'Requ�tes bookmark�es';
$strBookmarkThis = 'Bookmarker cette requ�te';
$strBookmarkView = 'Voir uniquement';
$strBrowse = 'Afficher';
$strBzip = '"bzipp�"';

$strCantLoadMySQL = 'ne peux charger l\'extension MySQL,<br />v�rifiez la configuration PHP';
$strCantLoadRecodeIconv = 'Erreur lors du chargement de l\'extension iconv ou recode, utilis�e pour convertir le jeu de caract�res; veuillez activer l\'une de ces extensions dans PHP, ou d�sactiver la conversion des jeux de caract�res dans phpMyAdmin';
$strCantRenameIdxToPrimary = 'La clef ne peut �tre renomm�e PRIMARY&nbsp;!';
$strCantUseRecodeIconv = 'Erreur lors de l\'utilisation de iconv, libiconv et recode_string, alors que ces extensions semblent charg�es. Veuillez v�rifier votre configuration de PHP.';
$strCardinality = 'Cardinalit�';
$strCarriage = 'Retour de chariot : \\r';
$strChange = 'Modifier';
$strChangeDisplay = 'Champ � afficher';
$strChangePassword = 'Modifier le mot de passe';
$strCharsetOfFile = 'Jeu de caract�res du fichier:';
$strCheckAll = 'Tout cocher';
$strCheckDbPriv = 'Afficher les privil�ges sur';
$strCheckTable = 'V�rifier la table';
$strChoosePage = 'Page � �diter';
$strColComFeat = 'Commentaires de colonnes';
$strColumn = 'Colonne';
$strColumnNames = 'Nom des colonnes';
$strComments = 'Commentaires';
$strCompleteInserts = 'Insertions compl�tes';
$strCompression = 'Compression';
$strConfigFileError = 'phpMyAdmin n\'a pu lire votre fichier de configuration!<br />Il est possible qu\'il contienne une erreur de syntaxe, ou que PHP soit incapable de le trouver<br />� l\'aide du lien suivant, vous pouvez v�rifier le message d\'erreur g�n�r� par PHP;<br />la plupart du temps, un apostrophe ou un point-virgule sont manquants.<br />Si vous recevez une page blanche, aucune erreur n\'a �t� d�tect�e.';
$strConfigureTableCoord = 'Les coordonn�es de la table %s n\'ont pas �t� configur�es';
$strConfirm = 'Veuillez confirmer';
$strCookiesRequired = 'Vous devez accepter les cookies pour poursuivre.';
$strCopyTable = '<b>Copier</b> la table vers (base<b>.</b>table)&nbsp;:';
$strCopyTableOK = 'La table %s a �t� copi�e vers %s.';
$strCreate = 'Cr�er';
$strCreateIndex = 'Cr�er une clef sur&nbsp;%s&nbsp;colonne(s)';
$strCreateIndexTopic = 'Cr�er un nouvelle clef';
$strCreateNewDatabase = 'Cr�er une base de donn�es';
$strCreateNewTable = 'Cr�er une nouvelle table sur la base %s';
$strCreatePage = 'Cr�er une page';
$strCreatePdfFeat = 'G�n�ration de sch�mas en PDF';
$strCriteria = 'Crit�re';

$strData = 'Donn�es';
$strDataDict = 'Dictionnaire de donn�es';
$strDataOnly = 'Donn�es seulement';
$strDatabase = 'Base de donn�es';
$strDatabaseHasBeenDropped = 'La base de donn�es %s a �t� effac�e.';
$strDatabaseWildcard = 'Base de donn�es (passepartout autoris�):';
$strDatabases = 'bases de donn�es';
$strDatabasesStats = 'Statistiques sur les bases de donn�es';
$strDefault = 'D�faut';
$strDelete = 'Effacer';
$strDeleteFailed = 'L\'effacement a �chou�';
$strDeleteUserMessage = 'Vous avez effac� l\'utilisateur %s.';
$strDeleted = 'L\'enregistrement a �t� effac�';
$strDeletedRows = 'Nombre d\'enregistrements effac�s :';
$strDescending = 'D�croissant';
$strDisabled = 'd�sactiv�';
$strDisplay = 'Montrer';
$strDisplayFeat = 'Affichage infobulle';
$strDisplayOrder = 'Ordre d\'affichage :';
$strDisplayPDF = 'Afficher le sch�ma en PDF';
$strDoAQuery = 'Recherche par valeur (passepartout: "%")';
$strDoYouReally = 'Voulez-vous vraiment effectuer ';
$strDocu = 'Documentation';
$strDrop = 'Supprimer';
$strDropDB = 'Supprimer la base %s';
$strDropTable = 'Supprimer la table';
$strDumpXRows = 'Exporte %s enregistrement(s) � partir du rang n� %s.';
$strDumpingData = 'Contenu de la table';
$strDynamic = 'dynamique';

$strEdit = 'Modifier';
$strEditPDFPages = 'Pr�parer le sch�ma en PDF';
$strEditPrivileges = 'Changer les privil�ges';
$strEffective = 'effectif';
$strEmpty = 'Vider';
$strEmptyResultSet = 'MySQL n\'a retourn� aucun enregistrement.';
$strEnabled = 'activ�';
$strEnd = 'Fin';
$strEndCut = 'Fin de la section � couper';
$strEndRaw = 'Fin des informations sur l\'anomalie';
$strEnglishPrivileges = ' Veuillez noter que les noms de privil�ges sont exprim�s en anglais';
$strError = 'Erreur';
$strExplain = 'Expliquer SQL';
$strExport = 'Exporter';
$strExportToXML = 'Exporter en format XML';
$strExtendedInserts = 'Insertions �tendues';
$strExtra = 'Extra';

$strField = 'Champ';
$strFieldHasBeenDropped = 'Le champ %s a �t� effac�';
$strFields = 'Champs';
$strFieldsEmpty = 'Il faut indiquer le nombre de champs';
$strFieldsEnclosedBy = 'Champs entour�s par';
$strFieldsEscapedBy = 'Caract�re sp�cial';
$strFieldsTerminatedBy = 'Champs termin�s par';
$strFixed = 'fixe';
$strFlushTable = 'Recharger la table ("FLUSH")';
$strFormEmpty = 'Formulaire incomplet !';
$strFormat = 'format';
$strFullText = 'Textes complets';
$strFunction = 'Fonction';

$strGenBy = 'G�n�r� par';
$strGenTime = 'G�n�r� le ';
$strGeneralRelationFeat = 'Fonctions relationnelles';
$strGo = 'Ex�cuter';
$strGrants = 'Autres privil�ges';
$strGzip = '"gzipp�"';

$strHasBeenAltered = 'a �t� modifi�(e).';
$strHasBeenCreated = 'a �t� cr��(e).';
$strHaveToShow = 'Vous devez choisir au moins une colonne � afficher';
$strHome = 'Accueil';
$strHomepageOfficial = 'Site officiel de phpMyAdmin';
$strHomepageSourceforge = 'Page de T�l�chargement phpMyAdmin sur Sourceforge';
$strHost = 'Serveur';
$strHostEmpty = 'Le nom de serveur est vide';

$strIdxFulltext = 'Texte entier';
$strIfYouWish = 'Si vous d�sirez ne charger que certaines colonnes, indiquez leurs noms, s�par�s par des virgules.';
$strIgnore = 'Ignorer';
$strImportDocSQL = 'Importer des fichiers docSQL';
$strInUse = 'utilis�';
$strIndex = 'Index';
$strIndexHasBeenDropped = 'L\'index %s a �t� effac�';
$strIndexName = 'Nom de la clef&nbsp;:';
$strIndexType = 'Type de clef&nbsp;:';
$strIndexes = 'Index';
$strInsecureMySQL = 'Votre fichier de configuration fait r�f�rence � l\'utilisateur root sans mot de passe, ce qui correspond � la valeur par d�faut de MySQL.  Votre serveur MySQL est donc ouvert aux intrusions, et vous devriez corriger ce probl�me de s�curit�.';
$strInsert = 'Ins�rer';
$strInsertAsNewRow = 'Ins�rer en tant que nouvel enregistrement';
$strInsertNewRow = 'Ins�rer un nouvel enregistrement';
$strInsertTextfiles = 'Ins�rer des donn�es provenant d\'un fichier texte dans la table';
$strInsertedRows = 'Nombre d\'enregistrements ins�r�s :';
$strInstructions = 'Instructions';
$strInvalidName = '"%s" est un mot r�serv�, il ne peut �tre utilis� comme nom de base/table/champ.';

$strKeepPass = 'Conserver le mot de passe';
$strKeyname = 'Nom de la cl�';
$strKill = 'Supprimer';

$strLength = 'Long.';
$strLengthSet = 'Taille/Valeurs*';
$strLimitNumRows = 'Nombre d\'enregistrements par page';
$strLineFeed = 'Saut de ligne : \\n';
$strLines = 'Lignes';
$strLinesTerminatedBy = 'Lignes termin�es par';
$strLinkNotFound = 'Lien absent';
$strLinksTo = 'Reli� �';
$strLocationTextfile = 'Emplacement du fichier texte';
$strLogPassword = 'Mot de passe&nbsp;:';
$strLogUsername = 'Nom d\'utilisateur&nbsp;:';
$strLogin = 'Connexion';
$strLogout = 'Quitter';

$strMissingBracket = 'Parenth�se manquante';
$strModifications = 'Les modifications ont �t� sauvegard�es.';
$strModify = 'Modifier';
$strModifyIndexTopic = 'Modifier une clef';
$strMoveTable = '<b>D�placer</b> la table vers (base<b>.</b>table)&nbsp;:';
$strMoveTableOK = 'La table %s a �t� d�plac�e vers %s.';
$strMySQLCharset = 'Jeu de caract�res pour MySQL';
$strMySQLReloaded = 'MySQL recharg�.';
$strMySQLSaid = 'MySQL a r�pondu:';
$strMySQLServerProcess = 'MySQL %pma_s1% sur le serveur %pma_s2% - utilisateur&nbsp;: %pma_s3%';
$strMySQLShowProcess = 'Afficher les processus';
$strMySQLShowStatus = 'Afficher l\'�tat du serveur MySQL';
$strMySQLShowVars = 'Afficher les variables du serveur MySQL';

$strName = 'Nom';
$strNext = 'Suivant';
$strNo = 'Non';
$strNoDatabases = 'Aucune base de donn�es';
$strNoDescription = 'pas de description';
$strNoDropDatabases = 'La commande "DROP DATABASE" est d�sactiv�e.';
$strNoExplain = 'Ne pas expliquer SQL';
$strNoFrames = 'L\'utilisation de phpMyAdmin est plus ais�e avec un navigateur <b>supportant les "frames"</b>.';
$strNoIndex = 'Aucune clef n\'est d�finie&nbsp;!';
$strNoIndexPartsDefined = 'Aucune colonne n\'a �t� d�finie pour cette clef&nbsp;!';
$strNoModification = 'Pas de modifications';
$strNoPassword = 'aucun mot de passe';
$strNoPhp = 'Sans source PHP';
$strNoPrivileges = 'aucun privil�ge';
$strNoQuery = 'Aucune requ�te SQL !';
$strNoRights = 'Vous n\'�tes pas autoris� � acc�der � cette page';
$strNoTablesFound = 'Aucune table n\'a �t� trouv�e dans cette base.';
$strNoUsersFound = 'Il n\'y a aucun utilisateur';
$strNoValidateSQL = 'Ne pas valider SQL';
$strNone = 'aucune';
$strNotNumber = 'Ce n\'est pas un nombre !';
$strNotOK = 'en erreur';
$strNotSet = 'La table <b>%s</b> est absente ou non d�finie dans %s';
$strNotValidNumber = ' n\'est pas un nombre valide !';
$strNull = 'Null';
$strNumSearchResultsInTable = '%s occurence(s) dans la table <i>%s</i>';
$strNumSearchResultsTotal = '<b>Total :</b> <i>%s</i> occurence(s)';
$strNumTables = 'Tables';

$strOK = 'OK';
$strOftenQuotation = 'Souvent des guillemets. OPTIONNEL signifie que seuls les champs de type char et varchar sont entour�s par ce caract�re.';
$strOperations = 'Op�rations';
$strOptimizeTable = 'Optimiser la table';
$strOptionalControls = 'Optionnel. Indique le caract�re qui permet d\'enlever l\'effet des caract�res sp�ciaux.';
$strOptionally = 'OPTIONNEL';
$strOptions = 'Options';
$strOr = 'Ou';
$strOverhead = 'Perte';

$strPHP40203 = 'Vous utilisez PHP 4.2.3, et cette version a un s�rieux probl�me avec les caract�res multi-octets (mbstring), tel que d�crit sur le rapport d\'anomalies 19404 chez PHP.  Il n\'est pas recommand� d\'utiliser cette version de PHP avec phpMyAdmin.';
$strPHPVersion = 'Version de PHP';
$strPageNumber = 'Page n�:';
$strPartialText = 'Textes r�duits';
$strPassword = 'Mot de passe';
$strPasswordEmpty = 'Le mot de passe est vide';
$strPasswordNotSame = 'Les mots de passe doivent �tre identiques';
$strPdfDbSchema = 'Schema de la base "%s" - Page %s';
$strPdfInvalidPageNum = 'Num�ro de page PDF non d�fini !';
$strPdfInvalidTblName = 'La table "%s" n\'existe pas !';
$strPdfNoTables = 'Pas de table !';
$strPhp = 'Cr�er source PHP';
$strPmaDocumentation = 'Documentation de phpMyAdmin';
$strPmaUriError = 'Le param�tre <tt>$cfg[\'PmaAbsoluteUri\']</tt> DOIT �tre renseign� dans votre fichier de configuration !';
$strPos1 = 'D�but';
$strPrevious = 'Pr�c�dent';
$strPrimary = 'Primaire';
$strPrimaryKey = 'Cl� primaire';
$strPrimaryKeyHasBeenDropped = 'La cl� primaire a �t� effac�e';
$strPrimaryKeyName = 'Le nom d\'une clef primaire doit �tre PRIMARY&nbsp;!';
$strPrimaryKeyWarning = '("PRIMARY" <b>doit et ne peut �tre</b> que le nom d\'une clef primaire&nbsp;!)';
$strPrint = 'Imprimer';
$strPrintView = 'Version imprimable';
$strPrivileges = 'Privil�ges';
$strProperties = 'Propri�t�s';
$strPutColNames = 'Afficher les noms de champ en premi�re ligne';

$strQBE = 'Requ�te';
$strQBEDel = 'Effacer';
$strQBEIns = 'Ajouter';
$strQueryOnDb = 'Requ�te SQL sur la base <b>%s</b>&nbsp;:';

$strReType = 'Entrer � nouveau';
$strRecords = 'Enregistrements';
$strReferentialIntegrity = 'V�rifier l\'int�grit� r�f�rentielle';
$strRelationNotWorking = 'Certaines fonctionnalit�s ayant trait aux tables reli�es sont d�sactiv�es. Pour une analyse du probl�me, cliquez %sici%s.';
$strRelationView = 'Gestion des relations';
$strReloadFailed = 'MySQL n\'a pu �tre recharg�.';
$strReloadMySQL = 'Recharger MySQL';
$strRememberReload = 'N\'oubliez pas de recharger MySQL';
$strRenameTable = '<b>Changer le nom</b> de la table pour';
$strRenameTableOK = 'La table %s se nomme maintenant %s';
$strRepairTable = 'R�parer la table';
$strReplace = 'Remplacer';
$strReplaceTable = 'Remplacer les donn�es de la table avec le fichier';
$strReset = 'R�initialiser les valeurs';
$strRevoke = 'R�voquer';
$strRevokeGrant = 'R�voquer "grant option"';
$strRevokeGrantMessage = 'Vous avez r�voqu� "grant option" pour %s';
$strRevokeMessage = 'Vous avez r�voqu� les privil�ges pour %s';
$strRevokePriv = 'R�voquer les privil�ges';
$strRowLength = 'Longueur enr.';
$strRowSize = ' Taille enr. ';
$strRows = 'Enregistrements';
$strRowsFrom = 'ligne(s) � partir de l\'enregistrement n�';
$strRowsModeHorizontal= 'horizontal';
$strRowsModeOptions= 'en mode %s et r�p�ter les en-t�tes � chaque groupe de %s';
$strRowsModeVertical= 'vertical';
$strRowsStatistic = 'Statistiques';
$strRunQuery = 'Ex�cuter la requ�te';
$strRunSQLQuery = 'Ex�cuter une ou des <b>requ�tes</b> sur la base %s';
$strRunning = 'sur le serveur %s';

$strSQL = 'SQL';
$strSQLParserBugMessage = 'Il semble que vous ayiez trouv� une anomalie dans l\'analyseur syntaxique SQL. Veuillez examiner votre requ�te attentivement, et v�rifier que vos apostrophes sont conformes. Il se pourrait aussi que vous ayiez charg� un fichier dont le contenu binaire n\'est pas entre apostrophes.  Si vous avez acc�s � MySQL via son interface de commande en mode ligne, vous pouvez y essayer votre requ�te. Le message d\'erreur pr�sent� plus bas pourrait vous indiquer la source du probl�me. En dernier recours, veuillez trouver la plus courte requ�te possible qui cause le probl�me, et soumettre un rapport d\'anomalie en incluant la section � couper:';
$strSQLParserUserError = 'Il semble qu\'il y ait une erreur dans votre requ�te SQL. Le message ci-bas peut vous aider � en trouver la cause.';
$strSQLQuery = 'requ�te SQL';
$strSQLResult = 'Resultat de la requ�te SQL';
$strSQPBugInvalidIdentifer = 'Identificateur invalide';
$strSQPBugUnclosedQuote = 'Apostrophe non ferm�';
$strSQPBugUnknownPunctuation = 'Ponctuation invalide';
$strSave = 'Sauvegarder';
$strScaleFactorSmall = 'Veuillez augmenter l\'�chelle car le sch�ma d�borde la page';
$strSearch = 'Rechercher';
$strSearchFormTitle = 'Effectuer une nouvelle recherche dans la base de donn�es';
$strSearchInTables = 'Dans la(les) table(s) :';
$strSearchNeedle = 'Mot(s) ou Valeur � rechercher (passe-partout: "%") :';
$strSearchOption1 = 'au moins un mot';
$strSearchOption2 = 'tous les mots';
$strSearchOption3 = 'phrase exacte';
$strSearchOption4 = 'expression r�guli�re';
$strSearchResultsFor = 'R�sultats de la recherche de "<i>%s</i>" %s :';
$strSearchType = 'Type de recherche :';
$strSelect = 'S�lectionner';
$strSelectADb = 'Choisissez une base de donn�es';
$strSelectAll = 'Tout s�lectionner';
$strSelectFields = 'Choisir les champs � afficher (au moins un)';
$strSelectNumRows = 'dans la requ�te';
$strSelectTables = 'Choisissez les tables';
$strSend = 'Transmettre';
$strServer = 'Serveur %s';
$strServerChoice = 'Choix du serveur';
$strServerVersion = 'Version du serveur';
$strSetEnumVal = 'Les diff�rentes valeurs des champs de type enum/set sont � sp�cifier sous la forme \'a\',\'b\',\'c\'...<br />Pour utiliser un caract�re "\\" ou "\'" dans l\'une de ces valeurs, faites le pr�c�der du caract�re d\'�chappement "\\" (par exemple \'\\\\xyz\' ou \'a\\\'b\').';
$strShow = 'Afficher';
$strShowAll = 'Tout afficher';
$strShowColor = 'Couleurs';
$strShowCols = 'Afficher les colonnes';
$strShowGrid = 'Grille';
$strShowPHPInfo = 'Afficher les informations relatives � PHP';
$strShowTableDimension = 'Dimension des tables';
$strShowTables = 'Afficher les tables';
$strShowThisQuery = 'R�afficher la requ�te apr�s ex�cution';
$strShowingRecords = 'Affichage des enregistrements';
$strSingly = '(� refaire apr�s insertions/destructions)';
$strSize = 'Taille';
$strSort = 'Tri';
$strSpaceUsage = 'Espace utilis�';
$strSplitWordsWithSpace = 'S�parer les mots par un espace (" ").';
$strStatement = 'Information';
$strStrucCSV = 'Donn�es CSV';
$strStrucData = 'Structure et donn�es';
$strStrucDrop = 'Ajouter des �nonc�s "drop table"';
$strStrucExcelCSV = 'Donn�es CSV pour Ms Excel';
$strStrucOnly = 'Structure seule';
$strStructPropose = 'Sugg�rer des optimisations quant � la structure de la table';
$strStructure = 'Structure';
$strSubmit = 'Ex�cuter';
$strSuccess = 'Votre requ�te SQL a �t� ex�cut�e avec succ�s';
$strSum = 'Somme';

$strTable = 'Table';
$strTableComments = 'Commentaires sur la table';
$strTableEmpty = 'Le nom de la table est vide';
$strTableHasBeenDropped = 'La table %s a �t� effac�e';
$strTableHasBeenEmptied = 'La table %s a �t� vid�e';
$strTableHasBeenFlushed = 'La table %s a �t� recharg�e';
$strTableMaintenance = 'Maintenance de la table';
$strTableStructure = 'Structure de la table';
$strTableType = 'Table en format';
$strTables = '%s table(s)';
$strTextAreaLength = 'Il est possible que ce champ<br />ne soit pas �ditable<br />en raison de sa longueur';
$strTheContent = 'Le contenu de votre fichier a �t� ins�r�.';
$strTheContents = 'Le contenu du fichier remplacera le contenu de la table pour les enregistrements ayant une valeur de cl� primaire ou unique identique.';
$strTheTerminator = 'Le caract�re qui s�pare chacun des champs.';
$strTotal = 'total';
$strTotalUC = 'Total';
$strType = 'Type';

$strUncheckAll = 'Tout d�cocher';
$strUnique = 'Unique';
$strUnselectAll = 'Tout d�selectionner';
$strUpdatePrivMessage = 'Vous avez modifi� les privil�ges pour %s.';
$strUpdateProfile = 'Modifier le profil :';
$strUpdateProfileMessage = 'Le profil a �t� modifi�.';
$strUpdateQuery = 'Mise-�-jour de la requ�te';
$strUsage = 'Espace';
$strUseBackquotes = 'Prot�ger les noms des tables et des champs par des&nbsp;"`"';
$strUseTables = 'Utiliser les tables';
$strUser = 'Utilisateur';
$strUserEmpty = 'Le nom d\'utilisateur est vide';
$strUserName = 'Nom d\'utilisateur';
$strUsers = 'Utilisateurs et privil�ges';

$strValidateSQL = 'Valider SQL';
$strValidatorError = 'Le validateur SQL n\'a pas pu �tre initialis�. V�rifiez que les extensions PHP n�cessaires ont bien �t� install�es (voir la %sdocumentation%s).';
$strValue = 'Valeur';
$strViewDump = '<b>Afficher le sch�ma</b> de la table';
$strViewDumpDB = 'Afficher le sch�ma de la base ';

$strWebServerUploadDirectory = 'r�pertoire de transfert du serveur Web';
$strWebServerUploadDirectoryError = 'Le r�pertoire de transfert est inaccessible';
$strWelcome = 'Bienvenue � %s ';
$strWithChecked = 'Pour la s�lection :';
$strWrongUser = 'Erreur d\'utilisateur/mot de passe. Acc�s refus�';

$strYes = 'Oui';

$strZip = '"zipp�"';

?>
