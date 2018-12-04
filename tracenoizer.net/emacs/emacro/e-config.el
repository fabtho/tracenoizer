;;;; e-config.el --- Define user variables.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;__________________________________________________________________________
;;;;    TABLE OF CONTENTS
;;      Legal
;;      Commentary
;;      Code
;;	Load Preferences
;;	Variables
;;		Set Your Startup Size And Position
;;		Color & Size
;;		Import Mozilla Prefs
;;		Internetworking
;;		Printer
;;		Programmer
;;		SQL Mode
;;	Load Affiliated Files
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Limit your editing of this file, as it is due to change in the future.
;;Instead, put your customizations in ~emacs/e-preload.el, e-postload.el,
;;e-custom.el (emacs), or e-xcustom.el (xemacs)

;;ToDo? Extract server names from Mozilla or Netscape's prefs.js

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		user configure configuration setup

;;__________________________________________________________________________
;;;; Code:
;;Some of this shuts up warnings from the elisp byte-compiler:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-config nil "Settings from e-config.el file." :group 'emacro)

;;If EMacro causes problems, try uncommenting the following 2 lines:
;;(set-default 'max-specpdl-size '8000)
;;(set-default 'max-lisp-eval-depth '22000)

;;Some user .emacs code works better, before loading the bulk of EMacro.
;;Simulate a require(), in case users wipe out the file.
(when (not (featurep 'e-preload))
  (load-library "e-preload")
  (provide 'e-preload))

(require 'which)                        ;works for classic Mac Emacs, as well
(autoload 'which "which" "find file in path" t)	;shut up bytecompiler

(require 'e-functions)
(autoload 'cache-locate-library "e-functions" "optimized locate-library" t)

(defconst use-browser 'nil)		;initialize for inet.el

;;__________________________________________________________________________
;;;;	Load Preferences
;;These files must be loaded before most of EMacro.
(defconst pref-file (concat emacro-top-dir "preferences/e-prefs.el"))
(if (file-exists-p pref-file)
    (load-library "e-prefs")
  (emacro-stamp-file pref-file))	;else create this file

;;__________________________________________________________________________
;;;;	Variables
;;Variables are simultaneously set & written to preferences.el.
;;Thus, EMacro works from the first startup.

;;Load user customizations
(cond
 ((string-match "GNU" (emacs-version)) ;FSF/Gnu Emacs, all platforms
  (when (file-readable-p (concat emacro-top-dir "preferences/e-custom.el"))
    (load-library "e-custom")))

 ((string-match "XEmacs" (emacs-version)) ;XEmacs, all platforms
  (when (file-readable-p (concat emacro-top-dir "preferences/e-xcustom.el"))
    (load-library "e-xcustom"))))

;;__________________________________________________________________________
;;;;;;		Set Your Startup Size And Position
;;Make sure that user can see the prompt at bottom, before continuing.
(defvar use-height)			;shut up compiler

(cond
 ((not (boundp 'use-height))
  (progn
    (setq use-height (desktop-height-approx))
    (append-to-file
     (format
      "(setq use-height 0) ;0 = auto max height. Try %s for fixed height\n"
      use-height) 'nil pref-file)))
 ((= use-height 0)
  (setq use-height (desktop-height-approx))))

;;__________________________________________________________________________
;;;;		Color & Size
;;This code will not tinyload very well :(
(cache-locate-library
 use-cache 'cache-color-theme "color-theme"
 "To start EMacro faster, get tiny tools from <url: http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme>")
(defvar default-frame-plist)		;shut up compiler

(when (and cache-color-theme (not (featurep 'color-theme)))
  (progn
    (require 'color-theme)		;setup color-theme for first time
    (autoload 'color-theme-standard "color-theme" "color-theme" t)
    (color-theme-standard)		;afterwards, use preferences.el
    (append-to-file
     "(require 'color-theme)\n(color-theme-standard)\n" 'nil pref-file)))

(if (string-match "XEmacs" (emacs-version)) ;Won't compile for xemacs < v21
    (progn
;;It seems necessary to subtract 4 lines for XEmacs.
;;Is this only for XWindow? Due to default font?
      (setq use-height (- use-height 4))
      (setq frame-initial-frame-plist `(height ,use-height)))
;;Else Emacs
  (progn
    (setq default-frame-plist `(height . ,use-height))))

;;__________________________________________________________________________
;;;;;;		Import Mozilla Prefs
;;This gets & saves the full path to prefs.js. Actual import of prefs is
;;in each call to moz-get-prefs(), below
(when (not (boundp 'moz-prefs-filename)) ;cache not inited yet

;;save into cache, that no Mozilla was found.
;;ToDo: code for Netscape, as well
  (if (not (file-exists-p "~/.mozilla"))
      (append-to-file
       "(setq moz-prefs-filename 'nil)\t;~/.mozilla does not exist\n"
       'nil pref-file)

    (progn				;else find Mozilla mail dir
;;There are 3 dirs in the Moz default dir: . .. and some name with a letter
      (setq moz-prefs-filename
	    (car (directory-files "~/.mozilla/default/" t "[a-z]")))
;;EMacro only looks at the Inbox folder:
      (setq moz-prefs-filename
	    (concat moz-prefs-filename "/prefs.js"))
      (append-to-file
       (concat (concat "(setq moz-prefs-filename \""
		       moz-prefs-filename) "\")\n") 'nil pref-file))))

;;__________________________________________________________________________
;;;;;;		Internetworking
(defvar use-net)			;shut up compiler
(when (not (boundp 'use-net))
  (progn
    (when window-system
      (cond
       ((fboundp 'get-dialog-box-response) ;XEmacs
	(get-dialog-box-response
	 't '("Please answer questions in minibuffer at bottom"
	      ("OK" . t))))
       ((fboundp 'x-popup-dialog)	;Else Emacs
	(x-popup-dialog
	 't '("Please answer questions in minibuffer at bottom"
	      ("OK" . t))))))
    (if (y-or-n-p
	 "Do you want Emacs to access the internet? (email, news) ")
	;;Append the results to preferences.el
	(progn
	  (setq use-net 't)
	  (append-to-file "(setq use-net 't)\n" 'nil pref-file))
;;else use-net is false
      (progn
	(setq use-net 'nil)
	(append-to-file "(setq use-net 'nil)\n" 'nil pref-file)))))

;;This optimizes your connection. Ex: tiny-url will cache urls, until
;;you redial your ISP, instead of forcing an immediate connection.
(defvar use-modem)			;shut up compiler
(when (and (not (boundp 'use-modem)) use-net)
  (if (y-or-n-p
       "Do you have fast access to the internet? (no if dialup modem) ")
      ;;Append the results to preferences.el
      (progn
	(setq use-modem 'nil)
	(append-to-file "(setq use-modem 'nil)\n" 'nil pref-file))
;;else
    (progn
      (setq use-modem 't)
      (append-to-file "(setq use-modem 't)\n" 'nil pref-file))))

;;use-login-name is needed, even if we don't connect to net
;;could be used for databases
(defvar use-login-name)			;shut up compiler
(when (not (boundp 'use-login-name))
  (cond
   ((getenv "USER")			;First try unix environment variables
    (append-to-file
     (format "(setq use-login-name \"%s\")\n"
             (setq use-login-name (getenv "USER")))
     'nil pref-file))

   ((getenv "LOGNAME")
    (append-to-file
     (format "(setq use-login-name \"%s\")\n"
             (setq use-login-name (getenv "LOGNAME")))
     'nil pref-file))

   ((getenv "USERNAME")                 ;Next try w32 environment variables:
    (append-to-file
     (format "(setq use-login-name \"%s\")\n"
             (setq use-login-name (getenv "USERNAME")))
     'nil pref-file))

   (t			      ;Could be mac, which doesn't set these variables:
    (append-to-file
     (format "(setq use-login-name \"%s\")\n"
             (setq use-login-name
                   (read-string
		    "What's your login name? [for net, sql] " "userID")))
     'nil pref-file))))

;;user-full-name also useful for hm-html-mode, without net connection
(when (or (not (boundp 'user-full-name)) (string= user-full-name ""))
  (append-to-file
   (format
    "(setq user-full-name  \"%s\")\n"
    (setq
     user-full-name
     (read-string
      "What's your full name? "
      (or
       (moz-get-prefs
	"user_pref(\"mail.identity.id1.fullName\", \"\\([^\"]+\\)")
       "Joe Novice"))))
   'nil pref-file))

;;Save user's return email address in preferences
(defvar gnus-nntp-server)               ;shut up compiler
(defvar use-smtp)			;shut up compiler
(defvar use-pop3)			;shut up compiler
(when use-net
  (when
      (or (or (or (or
		   (or (not(boundp 'user-mail-address))(not user-mail-address))
		   (not (boundp 'use-smtp)))
		  (not (boundp 'use-pop3)))
;;note that order of following is important, due to short-circuit evaluation:
	      (not (boundp 'gnus-nntp-server)))
	  (and (not gnus-nntp-server)
	       (string= (cadr gnus-select-method) "news")))
    (when (getenv "MAILHOST")
      (defconst use-domain
            (format "%s.%s" 
                    (car(cdr (split-string (getenv "MAILHOST") "[.]")))
                    (car(cdr(cdr (split-string (getenv "MAILHOST") "[.]")))))))

    (when (not (boundp 'use-domain))
      (defconst use-domain
	(read-string
	 "What's your network domain? "
	 (or
	  (moz-get-prefs
	   "user_pref(\"mail.smtpserver.smtp1.hostname\", \"[^\.]+\.\\([^\"]+\\)")
	  "localhost.com"))))))

(when (and
       (or (not(boundp 'user-mail-address))(not user-mail-address))
       use-net)
  (append-to-file
   (format
    "(setq user-mail-address \"%s\")\n"
    (setq user-mail-address
          (read-string
	   "What's your email address? "
	   (or
	    (moz-get-prefs
	     "user_pref(\"mail.identity.id1.useremail\", \"\\([^\"]+\\)")
	    (format "%s@%s" use-login-name use-domain)))))
   'nil pref-file))

;;address of your smtp email server to SEND mail:
(when (and (not (boundp 'use-smtp)) use-net)
  (append-to-file
   (format "(setq use-smtp \"%s\")\n"
           (setq
	    use-smtp
	    (read-string
	     "What's your smtp email sending server name? "
	     (or
	      (moz-get-prefs
	       "user_pref(\"mail.smtpserver.smtp1.hostname\", \"\\([^\"]+\\)")
	      (format "smtp.%s" use-domain)))))
   'nil pref-file))

;;address of your pop3 email server to GET mail:
(when (and (not (boundp 'use-pop3)) use-net)
  (append-to-file
   (format "(setq use-pop3 \"%s\")\n"
           (setq
	    use-pop3
	    (read-string
	     "What's your pop3 email receiving server name? "
	     (or
	      (moz-get-prefs
	       "user_pref(\"mail.server.server1.hostname\", \"\\([^\"]+\\)")
	      (format "pop3.%s" use-domain)))))
   'nil pref-file))

;;address of nntp usenet news reader
(when (and (not (boundp 'gnus-nntp-server)) use-net)
  (append-to-file
   (format "(setq gnus-nntp-server \"%s\")\n"
           (setq
	    gnus-nntp-server
	    (read-string
	     "What's your nntp usenet news server name? "
	     (or
;;ToDo: proper way to import Moz nntp hostname is complex: must search for
;;mail.server.server*.type = nntp
	      (moz-get-prefs
	       "user_pref(\"mail.server.server3.name\", \"\\([^\"]+\\)")
	      (format "news.%s" use-domain)))))
	   'nil pref-file))

;;fsf/gnu emacs is deprecating gnus-nntp-server.
;;Defaults: gnus-nntp-server = nil, gnus-select-method = "news"
(when (and (and (not gnus-nntp-server) use-net)
	   (string= (cadr gnus-select-method) "news"))
  (defvar e-gnus-select-method)		;shut up compiler
  (setq e-gnus-select-method
	(read-string
	 "What's your nntp usenet news server name? "
	 (or
;;ToDo: proper way to import Moz nntp hostname is complex: must search for
;;mail.server.server*.type = nntp
	  (moz-get-prefs
	   "user_pref(\"mail.server.server3.name\", \"\\([^\"]+\\)")
	  (format "news.%s" use-domain))))
  (setq gnus-select-method `(nntp ,e-gnus-select-method))
  (append-to-file
   (format "(setq gnus-select-method \'(nntp \"%s\"))\n" e-gnus-select-method)
   'nil pref-file))

(defvar nntp-authinfo-user)		;shut up compiler
(when (and (not (boundp 'nntp-authinfo-user)) use-net)
  (append-to-file
   (format "(setq nntp-authinfo-user \"%s\")\n"
           (setq nntp-authinfo-user
                 (read-string
                  "What's your nntp usenet news login id? "
		  (or
		   (moz-get-prefs
		    "user_pref(\"mail.server.server3.userName\", \"\\([^\"]+\\)")
		   (format "%s" use-login-name)))))
   'nil pref-file))

;;__________________________________________________________________________
;;;;;;		Printer
;;Common unix printer names:	"/dev/lp0"	"/dev/rp0"
;;typical dos printer names:	"prn"	"\\\\server\\mylaser"
;;'NET HELP' in ms windows will get you networking commands.
;;If you know your server name, 'NET VIEW SERVER' will list its printer(s).

;;(defconst printer-name "//print_server/hp")		;new emacs syntax
;;(defconst ps-printer-name "\\\\hpserver\\hp_ps")	;postscript

(defvar use-paper)
(when (not (boundp 'use-paper))
  (append-to-file
   (format "(defconst use-paper  \"%s\")\n"
	   (setq use-paper
		 (read-string
		  "Print letter or a4 (metric) paper size? " "letter")))
   'nil pref-file))

;;Regular Printer. Sometimes predefined as 'nil.
(when (or (not (boundp 'printer-name)) (eq printer-name 'nil))
  (if (string-match "windows" (symbol-name system-type)) ;for ms windows
      (append-to-file
       (format "(setq printer-name  \"%s\")\n"
	       (setq printer-name
		     (read-string
		      "What's your printer name? (see control panel) "
		      "//no-server/no-printer-port-name"))) 'nil pref-file)
  ;;else for mac, linux, all others 
    (append-to-file
     (format "(setq printer-name  \"%s\")\n"
             (setq printer-name
                   (read-string "What's your printer name? "
                                "/dev/lp0"))) 'nil pref-file)))

;;Postscript Printer: use regular printer name for default
(defvar ps-printer-name)			;shut up compiler
(when (not (boundp 'ps-printer-name))
  (append-to-file
   (format "(setq ps-printer-name  \"%s\")\n"
	   (setq ps-printer-name
		 (read-string "What's your postscript printer name? "
			      printer-name))) 'nil pref-file))

(autoload 'pp "pp" "Postscript Print" t) ;May ease some load bugs
(autoload 'pp-to-string "pp" "Postscript Printer settings" t)

(when (not (boundp 'lpr-command))	;note that undefined lpr-switches is ok
  (defconst lpr-list (split-string
                      (read-string
                       "What is your print command? "
                       (concat "lp -d " printer-name))))
  (setq lpr-command (car lpr-list))
  (append-to-file
   (format "(setq lpr-command \"%s\")\n" lpr-command) 'nil pref-file)

  (setq lpr-switches (cdr lpr-list))
  (defvar cache-pp)			;shut up compiler
  (cache-locate-library
   use-cache 'cache-pp "pp"
   "For postscript printer support, get pp.el from full tarball distribution where you got XEmacs")

  (when cache-pp
    ;;w32 xemacs 21.1.13 binary distrib has bad file "pp" (no .el) in lisp dir
    (condition-case err                 ;Handle any exceptions
	(require 'pp)
      (err (message err)(message "Fix 'pp.el' in your emacs lisp path")))
    (when (featurep 'pp)
      (append-to-file
       (format "(setq lpr-switches '%s)\n" (pp-to-string lpr-switches))
       'nil pref-file))))

;;__________________________________________________________________________
;;;;;;		Programmer
(defvar use-indent)			;shut up compiler
(when (not (boundp 'use-indent))	;number of spaces to indent
  (append-to-file
   (format "(setq use-indent %s)\n"
           (setq use-indent
                 (read-string
		  "How many spaces should tabs indent code? " "2")))
   'nil pref-file))

;;__________________________________________________________________________
;;;;;;		SQL Mode
;;Search PATH for first database found, and configure for it, if possible

;;See Also w32.el, Where sql-oracle-program Is Set !
;;sql		<url:http://www.geocities.com/TimesSquare/6120/emacs.html>
;;sql-mode (good!) <url:http://www.stanford.edu/~riepel/SQL-mode.html>

(when (not (boundp 'use-sql-vendor))
  (cond
   ((which "sqlplus")                   ;all OS except w32
    (defconst use-sql-vendor "oracle")
    (append-to-file "(defconst use-sql-vendor \"oracle\")\n" 'nil pref-file))

   ((which "plus80")                    ;w32
    (defconst use-sql-vendor "oracle")
    (append-to-file "(defconst use-sql-vendor \"oracle\")\n" 'nil pref-file))

   ((which "mysql")
    (defconst use-sql-vendor "mysql")
    (append-to-file "(defconst use-sql-vendor \"mysql\")\n" 'nil pref-file))

   ((which "psql")
    (defconst use-sql-vendor "postgres")
    (append-to-file "(defconst use-sql-vendor \"postgres\")\n" 'nil pref-file))

   ((which "solsql")
    (defconst use-sql-vendor "solid")
    (append-to-file "(defconst use-sql-vendor \"solid\")\n" 'nil pref-file))
    
   ((which "dbaccess")
    (defconst use-sql-vendor "informix")
    (append-to-file "(defconst use-sql-vendor \"informix\")\n" 'nil pref-file))

   ((which "sql")
    (defconst use-sql-vendor "ingres")
    (append-to-file "(defconst use-sql-vendor \"ingres\")\n" 'nil pref-file))

;;Search isql's PATH for words "microsoft" or "sybase"
   ((which "isql")
    (defvar sql-path)			;shut up compiler
    (setq sql-path (which-first "isql"))
    (cond
     ((string-match "sybase" sql-path)
      (defconst use-sql-vendor "sybase")
      (append-to-file "(defconst use-sql-vendor \"sybase\")\n" 'nil pref-file))
     ((string-match "microsoft" sql-path)
      (defconst use-sql-vendor "microsoft")
      (append-to-file "(defconst use-sql-vendor \"microsoft\")\n" 'nil
		      pref-file))
     ((or (string-match "borland" sql-path)
	  (string-match "interbase" sql-path))
      (defconst use-sql-vendor "interbase")
      (append-to-file "(defconst use-sql-vendor \"interbase\")\n" 'nil
		      pref-file))
;;If isql in PATH is unixODBC, write comment and skip prompt for database
     ((string-match "ODBC" (shell-command-to-string "isql --help"))
      (append-to-file ";;unixODBC found in PATH\n" 'nil pref-file))
     (t				;else prompt for vendor
      (append-to-file
       (format
	"(setq use-sql-vendor \"%s\")\n"
	(setq use-sql-vendor
	      (read-string
	       "What brand SQL do you use? [microsoft, sybase, interbase] "
	       "microsoft"))) 'nil pref-file))))

   (t
    (defconst use-sql 'nil)
    (append-to-file
     "(defconst use-sql-vendor \"none\")    ;no database found in PATH\n" 'nil
     pref-file)
    (message
     "configure.el: No supported database program found in PATH. SQL support disabled"))))
;;Does anyone read these messages? If so, turn this on:
;;(message (concat (concat "Supported sql brand is " use-sql-vendor) "\n"))

;;Set and save the SQL server info, if it doesn't exist & SQL is enabled
(defvar sql-user)			;shut up compiler
(defvar sql-password)			;shut up compiler
(when (and (boundp 'sql-vendor) (not (boundp 'sql-user)))
  (append-to-file
   (format "(setq sql-user \"%s\")\n"
           (setq sql-user
                 (read-string "What is your database login ID? "
			      (format "%s" use-login-name)))) 'nil pref-file)
  (when (not (string=
	      (setq sql-password
		    (read-string
   "You may insecurely save your database password: "
		     "[skip]")) "[skip]"))
    (append-to-file
     (concat (concat "(setq sql-password \"" sql-password) "\")\n")
     'nil pref-file)))

(when (and (boundp 'sql-vendor) (not (boundp 'sql-server)))
  (when (not (boundp 'use-domain))
    (when (getenv "MAILHOST")
      (setq use-domain
            (format "%s.%s" 
                    (car(cdr (split-string (getenv "MAILHOST") "[.]")))
                    (car(cdr(cdr (split-string (getenv "MAILHOST") "[.]")))))))

    (when (not (boundp 'use-domain))
      (setq use-domain
            (read-string "What's your network domain? " "localhost.com"))))

  (append-to-file
   (format "(setq sql-server \"%s\")\n"
           (setq sql-user
                 (read-string
                  "What is your database server host name? "
                  (format "sql.%s" use-domain)))) 'nil pref-file))

(when (and (boundp 'sql-vendor) (not (boundp 'sql-database)))
  (append-to-file
   (format "(setq sql-database \"%s\")\n"
           (setq sql-user
                 (read-string
                  "What is your database name on the server? " "master")))
   'nil pref-file))

;;__________________________________________________________________________
;;;;	Load Affiliated Files
(cache-locate-library
 use-cache 'cache-tinyload "tinyload"
 "To start EMacro faster, get tiny tools from <url: http://tinytools.sourceforge.net>")
(defvar tinyload-:load-list "")	;shut up compiler

(emacro-require 'e-keys)		;Key assignments
(emacro-require 'e-common)		;Remaining common Emacs & XEmacs code
(emacro-require 'e-programmer)		;General Programming
;;e-c & e-perl are autoloaded by programmer.el
(emacro-require 'e-java)
(when (boundp 'sql-vendor) (emacro-require 'e-sql))
(emacro-require 'e-xml)			;HTML, SGML, XML

(when use-net (emacro-require 'e-net))	;Internet routines
(emacro-require 'e-browser)		;Web and EMacro help viewer support

(cond
 ((string-match "windows" (symbol-name system-type))
  (emacro-require 'e-w32))
 ((or (string-match "Macintosh" (emacs-version))
      (string-match "macos" (emacs-version)))
  (emacro-require 'e-mac-os))
 (t (emacro-require 'e-linux)))		;Else only on unix

;;Load XEmacs or Gnu Emacs specific code
(cond
 ((string-match "GNU" (emacs-version)) ;FSF/Gnu Emacs, all platforms
  (emacro-require 'e-macs))

 ((string-match "XEmacs" (emacs-version)) ;XEmacs, all platforms
  (emacro-require 'e-xemacs)))

;;User code (that's yours!)
(when (not (featurep 'e-postload))
  (emacro-load "e-postload"))

;;This line must follow all the emacro-requires & emacro-loads, above.
(when cache-tinyload (require 'tinyload)) ;time delayed loading of list

;;__________________________________________________________________________
;;;;	Outline-mode control variables
;;4 ';'s at beginning of line makes an index entry
;;more ';'s nests the entry deeper

;; Local Variables:
;; mode: outline-minor
;; center-line-decoration-char: ?-
;; center-line-padding-length: 1
;; center-line-leader: ";;;; "
;; fill-column: 79
;; line-move-ignore-invisible: t
;; outline-regexp: ";;;;+"
;; page-delimiter: "^;;;;"
;; End:

(provide 'e-config)

;;; e-config.el ends here
