;;;; e-sql.el --- SQL database support for gnu and x emacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-02-16 10:15:18 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-sql.el,v 1.20 2003/05/24 17:37:02 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	SQL Mode
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file. SQL database support for every OS.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		program mode ide

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;;;		SQL Mode
;;See Also w32.el, Where sql-oracle-program Is Set !
;;sql		<url:http://www.geocities.com/TimesSquare/6120/emacs.html>
;;sql-mode (good!) <url:http://www.stanford.edu/~riepel/SQL-mode.html>
;;Note that sql-mode does not work under xemacs on ms windows, only.

;;Also: sqlplus-mode	<url:http://www.anc.ed.ac.uk/~stephen/emacs/ell.html>
(defvar cache-sql-mode)
(cache-locate-library
 use-cache 'cache-sql-mode "sql-mode"
 "For SQL support, get sql-mode.el from <url:http://www.stanford.edu/~riepel/SQL-mode.html>")
(defvar cache-sql)
(cache-locate-library
 use-cache 'cache-sql "sql"
 "For SQL support, get sql.el from <url:http://www.stanford.edu/~riepel/SQL-mode.html>")

(defvar use-sql-vendor)			;shut up compiler
(cond 
;;sql-mode.el:	recommended also <URL:http://geek.stanford.edu/>
 (cache-sql-mode
  (progn
    (autoload 'sql-mode "sql-mode" "sql major mode" t)
    (defvar sql-database)		;shut up compiler
    (defvar sql-user)			;shut up compiler

    (defconst sql-get-server-hist (make-list 2 sql-database))
    (defconst sql-get-vendor-hist (make-list 2 use-sql-vendor))
    (defconst sql-get-username-hist (make-list 2 sql-user))
    (add-to-list 'auto-mode-alist '("\\.sql$" . sql-mode))))

 (cache-sql
  (progn
    (autoload 'sql-mode "sql" "SQL mode." t) ;bundled w/ gnu & x emacs
    (when (or (string= use-sql-vendor "mysql")
	      (string= use-sql-vendor "oracle"))
      (defconst sql-electric-stuff "semicolon"))
    (when (or (string= use-sql-vendor "microsoft")
	      (string= use-sql-vendor "sybase"))
      (defconst sql-electric-stuff "go"))

;;MySQL setup:
;;(setq sql-mysql-options (quote ("-C" "-t" "-f" "-n")))

;;    (add-hook 'sql-mode-hook
;;	      (easy-menu-add-item sql-mode-map '("SQL") '("SQL" ["Connect" sql-mysql t]))
;;	      )

    (setq auto-mode-alist (append auto-mode-alist
				  (list '("\\.sql$" . sql-mode)))))))


;;Font lock for the latest sql keywords:
(eval-after-load "sql" 
  '(font-lock-add-keywords 
    'sql-mode
    '(("\\<\\(exception\\|notfound\\|pragma\\|cursor_already_open\\|dup_val_on_index\\|invalid_cursor\\|invalid_number\\|login_denied\\|no_data_found\\|not_logged_on\\|program_error\\|storage_error\\|timeout_on_resource\\|too_many_rows\\|transaction_backed_out\\|value_error\\|zero_divide\\|others\\)\\>"
       . font-lock-warning-face)
      ("\\<loop\\>" . font-lock-keyword-face)
      ("\\<\\(if\\|elsif\\|else\\|while\\|return\\)\\>" . 
       font-lock-function-name-face))))


;;(autoload 'sql-postgres "sql" "Interactive SQL mode." t)
;;(setq sql-postgres-program '("postgres.gugu.db.com" . 6000)) ;untested

;;Bugs: Oracle limits buffers pasted in to about 250 lines

;; ToDo: test this Customization for MySql
;; jeff_hamann(at)hamanndonald.com
;; (defcustom sql-mysql-program "mysql"
;;   "*Command to start mysql by TcX.

;; Starts `sql-interactive-mode' after doing some setup.

;; The program can also specify a TCP connection.  See `make-comint'."
;;   :type 'file
;;   :group 'SQL)

;; (defcustom sql-mysql-options nil
;;   "*List of additional options for `sql-mysql-program'.
;; The following list of options is reported to make things work
;; on Windows: \"-C\" \"-t\" \"-f\" \"-n\"."
;;   :type '(repeat string)
;;   :version "20.8"
;;   :group 'SQL)

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

(provide 'e-sql)
;;; e-sql.el ends here
