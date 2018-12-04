;;;; e-w32.el --- MS Windows routines common to X and Gnu Emacs.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-02-16 10:45:15 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-w32.el,v 1.22 2003/05/24 17:37:01 bingalls Exp $

;;__________________________________________________________________________
;;;;    TABLE OF CONTENTS
;;      Legal
;;      Commentary
;;      Code
;;              Display And Menu
;;		Dired Association
;;              Printing Under Windows
;;			Ghostview Postscript
;;			Acrobat
;;		Cygwin Find
;;              Replace Windows Command.Com/Cmd.Exe For Invoking "M-X Shell"
;;                      Z Shell
;;                      Cygwin Bash
;;                      Mks Korn Shell
;;              Windows  Fixes
;;                      Windows Command Shell Fixes
;;                      Win 95/98 Command.Com Fix
;;                      Stop Command Shell Echoing
;;                      Fix "Specified Command Search Directory Bad"
;;		Programming
;;              	Set Oracle For SQL Mode
;;		I18N Internationalization
;;              Internetworking
;;                      Windows Ftp
;;                      TCP/IP Dialup
;;                      Telnet
;;                      Web Browsing
;;              Woman: With Out Man(ual) Pages
;;              Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;;; Commentary:
;;Emacs editor startup file.  MS Windows routines common to X & Gnu Emacs

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;;; Keywords:		microsoft windows w32 w2k win32

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-w32 nil "Settings from e-w32.el file." :group 'emacro)

(cache-locate-library
 use-cache 'cache-dired "dired"
 "For file directory support, get dired.el from full XEmacs sumo tarball")
(when cache-dired (require 'dired))

(autoload 'gud "gud" "gud debug files." t)
(autoload 'perldb "gud" "debug perl files." t)
(autoload 'comint-send-input "comint" "comint." t)

;;__________________________________________________________________________
;;;;    Display And Menu
;;(set-message-beep 'ok)                 ;"OK" windows system sound

;;Use the alt key as alt, not meta:
;;(setq win32-alt-is-meta nil)  ; Emacs 19 (XEmacs?)
;;(setq w32-alt-is-meta nil)    ; Emacs 20

;;__________________________________________________________________________
;;;;    Dired Association
;;This allows "X" in dired to open the file using the explorer settings.
;;From TBABIN(at)nortelnetworks.com
;;ToDo: adapt mswindows-shell-execute() for XEmacs or use tinyurl shell exec

(when (string-match "GNU" (emacs-version))
  (defun dired-custom-execute-file (&optional arg)
    (interactive "P")
    (mapcar #'(lambda (file)
		(w32-shell-execute "open" (convert-standard-filename file)))
	    (dired-get-marked-files nil arg)))

  (defun dired-custom-dired-mode-hook ()
    (define-key dired-mode-map "X" 'dired-custom-execute-file))
  (add-hook 'dired-mode-hook 'dired-custom-dired-mode-hook))

;;__________________________________________________________________________
;;;;    Printing Under Windows
;;See also printer section in poweruser.el, preferences.el and solutions.html
;;Example printer name:
;;(defconst printer-name "\\\\server-name\\printer-port-name")
(autoload 'ps-print-buffer "ps-print" "postscript print" t)
(autoload 'ps-print-region "ps-print" "postscript print" t)

(cache-locate-library
 use-cache 'cache-lpr "lpr"
 "For printing support, get lpr.el from full XEmacs sumo tarball")
(when cache-lpr (require 'lpr))

(set-default 'lpr-command "print")

;;(defconst ps-lpr-command "print")

;;If you grab <url:http://hem1.passagen.se/ptlerup> uncomment the following
;;printfile.exe seems to automagically determine if it's postscript
;;(defconst printer-name nil)
;;(defconst lpr-command "c:/progra~1/printfile/prfile32.exe")
;;(defconst lpr-switches '("/q"))

;;Alternate solution at <url: http://www.lerup.com/printfile/ >
;; (setq ps-lpr-command "d:/programmer/printfile/prfile.exe")
;; (setq ps-printer-name t)

;; (setq printer-name nil)
;; (setq lpr-command "d:/programmer/printfile/prfile.exe")

;;__________________________________________________________________________
;;;;;;    	Ghostview Postscript
;;This should allow non postscript printers to print
(defvar cache-ps-print)			;shut up compiler
(cache-locate-library
 use-cache 'cache-ps-print "ps-print"
 "For postscript printing support, Get ps-print from full XEmacs sumo tarball")
(when cache-ps-print (require 'ps-print))

(defvar use-paper)			;shut up compiler
(set-default 'ps-paper-type use-paper)
(set-default 'ps-print-color-p 'black-white)
(set-default 'ps-header-lines '1)
(set-default 'ps-print-header-frame 'nil)

;;Assume that w32 users with ghostview in path, use it to print.
;;ToDo: probably need to prompt users in future.
(when (which "ghostview")
  (defcustom ghostview-program (which-first "ghostview")
    "full path for PostScript print support."
    :group 'e-w32
    :type 'string)
  (set-default 'ps-printer-name 't)	;t if postscript
  (set-default 'ps-lpr-switches '(ghostview-program))
  (set-default 'ps-lpr-command "cmdproxy"))

;;"snapshot" is caught by the system by default, so register it as a hotkey.
;;w32-register-hot-key is a Gnu Emacs (only) builtin.
(when (string-match "GNU" (emacs-version)) (w32-register-hot-key [snapshot]))

(define-key global-map [snapshot] 'ps-print-buffer-with-faces)

;;__________________________________________________________________________
;;;;;;		Acrobat
;;Close acrobat viewer more easily, when creating PDF from TeX Emacs
(defun acrobat-close-all-docs ()
  "Close all open documents in Acrobat."
  (save-excursion
    (set-buffer (get-buffer-create " *ddeclient*"))
    (erase-buffer)
    (insert "[CloseAllDocs()]")
    (call-process-region (point-min) (point-max)
			 "ddeclient" t t nil "acroview" "control")
    (if (= 0 (string-to-int (buffer-string))) t nil)))

;; (when (fboundp 'TeX-run-LaTeX)
;;   (defun TeX-run-pdfLaTeX (name command file)
;;     "Create a process for NAME using COMMAND to format FILE with pdfLaTeX."
;;     (acrobat-close-all-docs)
;;     (TeX-run-LaTeX name command file))

;;   (add-to-list 'TeX-command-list
;; 	       (list "PDFLaTeX" "pdflatex \\nonstopmode\\input{%t}"
;; 		     'TeX-run-pdfLaTeX nil t)))

;;__________________________________________________________________________
;;;;;;          Cygwin Find
;;Enables recursive grep and prevents bytecompilation crash
;;I recommend you stay with Cygnus's default path!
;;Full path to Cygnus find.exe, not Microsoft find.exe

(set-default 'igrep-find-program "/bin/find")

;;__________________________________________________________________________
;;;;    Replace Windows Command.Com/Cmd.Exe For Invoking "M-X shell"
;;You need to get the executable for one of the shells and uncomment the
;;appropriate block

;;__________________________________________________________________________
;;;;;;          Z Shell         ftp://ftp.blarg.net/users/amol/zsh
;;consider creating ~/.zshenv startup with 'TERM=emacs exec zsh' (see zsh faq)
;;	Begin Shell Detection Block
(defvar explicit-shell-file-name)	;shut up compiler
(defvar explicit-sh-args)	;shut up compiler
(cond
 ((which "zsh")
  (defcustom use-sh "zsh" "Default shell."
    :group 'e-w32
    :type 'string))
 ((which "bash")
  (defcustom use-sh "bash" "Default shell."
    :group 'e-w32
    :type 'string))
 ((which "ksh")
  (defcustom use-sh "ksh" "Default shell."
    :group 'e-w32
    :type 'string))
 (t
  (defcustom use-sh 'nil "Default shell."
    :group 'e-w32
    :type 'string)))		;else nil for no shell in PATH

(when use-sh				;if a shell is found in PATH
  (cond
   ((string= use-sh "zsh")
    (set-default 'explicit-shell-file-name (which-first "zsh"))
    (put 'exec-path 'standard-value
	 (list (cons explicit-shell-file-name exec-path)))
    (set-default 'shell-file-name explicit-shell-file-name)
    (set-default 'sh-shell-file explicit-shell-file-name)
    (set-default 'win32-quote-process-args 't)
    (set-default 'zsh-dir explicit-shell-file-name)

    (setenv "ESHELL" explicit-shell-file-name)
    (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)
    (add-hook 'shell-mode-hook
	      '(lambda () (setq comint-completion-addsuffix t)) t))

;;__________________________________________________________________________
;;;;;;          Cygwin Bash             http://www.cygnus.com/
;;Else

   ((string= use-sh "bash")
    (set-default 'explicit-shell-file-name (which-first "bash"))
    (put 'exec-path 'standard-value
	 (list (cons explicit-shell-file-name exec-path)))
    (set-default 'explicit-sh-args '("-login" "-i"))
    (set-default 'shell-file-name explicit-shell-file-name)
    (set-default 'sh-shell-file explicit-shell-file-name)
    (set-default 'win32-quote-process-args 't)

    (setenv "ESHELL" shell-file-name)
    (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

    (setenv "SHELL" shell-file-name)

    ;;getenv() is not available in all emacs
    ;;  (setenv "PATH" (concat (concat shell-file-name ";") (getenv "PATH")))

    (add-hook 'shell-mode-hook
	      '(lambda () (setq comint-completion-addsuffix t)) t))

;;__________________________________________________________________________
;;;;;;          MKS Korn Shell          http://www.mks.com/
;;Else

   ((string= use-sh "ksh")
    (set-default 'explicit-shell-file-name (which-first "ksh"))
    (put 'exec-path 'standard-value
	 (list (cons explicit-shell-file-name exec-path)))
    (set-default 'explicit-sh-args '("-login" "-i"))
    (set-default 'shell-file-name explicit-shell-file-name)
    (set-default 'sh-shell-file explicit-shell-file-name)
    (set-default 'win32-quote-process-args 't)

    (setenv "ESHELL" (which-first "ksh"))
    (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)
    (add-hook 'shell-mode-hook
	      '(lambda () (setq comint-completion-addsuffix t)) t))))

;;	End Shell Detection Block

;;__________________________________________________________________________
;;;;    Windows  Fixes
;;add these if the programs mentioned are't working.
;;(setq grep-null-device null-device)                    ;igrep 2.82
;;(let ((emacs-minor-version 2)) (require 'lazy-lock))   ;20.3 lazy lock
;;(setq backup-by-copying t) ;stop single original overwriting backup

;;__________________________________________________________________________
;;;;            Windows Command Shell Fixes
;;This strips ^Ms in command shell mode:
;;(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;;__________________________________________________________________________
;;;;;;          Windows 95/98 Command.Com Fix
;;(setq process-coding-system-alist
;;      '(("cmdproxy" . (raw-text-dos . raw-text-dos))))

;;__________________________________________________________________________
;;;;;;          Stop Command Shell Echoing
;;FIRST, TRY:
;;(defun my-comint-init ()
;;  (setq comint-process-echoes t))
;;(add-hook 'comint-mode-hook 'my-comint-init)
;;THEN TRY:
;;(setq explicit-cmd.exe-args '("/q"))

;;__________________________________________________________________________
;;;;;;          Fix "Specified Command Search Directory Bad"
;;FIRST TRY:
;;(load-library "winnt")
;;THEN TRY:
;;windows 95/98
;;(setq explicit-command.com-args nil)
;;(setq explicit-COMMAND.COM-args nil)
;;windows nt
;;(setq explicit-cmd.exe-args nil)
;;(setq explicit-CMD.EXE-args nil)

;;__________________________________________________________________________
;;;;;;    Set Oracle For SQL Mode
;;See Also Sql-Mode In programmer.el !
;;sql.el:
(defconst sql-oracle-program "n")
(cond					;Oracle v8.x else v7.x
 ((which "PLUS80") (set-default 'sql-oracle-program (which-first "PLUS80")))
 ((which "PLUS33") (set-default 'sql-oracle-program (which-first "PLUS33"))))

;;sql-mode.el:  http://geek.stanford.edu
(when (not (string= sql-oracle-program "n"))
;;sqlplus-mode.el: http://www.anc.ed.ac.uk/~stephen/emacs/ell.html
  (defvar sql-process-name)
  (defvar sql-command)
  (defvar sqlplus-command)
  (set-default 'sql-process-name sql-oracle-program)
  (set-default 'sql-command sql-oracle-program)
  (set-default 'sqlplus-command sql-oracle-program)

;;  (defvar sql-user)			;shut up compiler
;;  (defvar sql-database)
  (defvar sqlplus-command-args)
;;Oracle login default. For less security, try 'name/password@sid'
  (set-default 'sqlplus-command-args (format "%s@%s" sql-user sql-database)))

;;Bugs: Oracle limits buffers pasted in to about 250 lines

;;__________________________________________________________________________
;;;;    I18N Internationalization
;;(setq w32-enable-unicode-output nil)

;;(setq w32-enable-italics t)
;;(create-fontset-from-fontset-spec
;;  "-*-Courier New-normal-r-*-*-*-120-*-*-c-*-fontset-courier,
;;   ascii:-*-Courier New-normal-r-*-*-*-120-*-*-c-*-iso8859-1,
;;   latin-iso8859-1:-*-Courier New-normal-r-*-*-*-120-*-*-c-*-iso8859-1,
;;   latin-iso8859-2:-*-Courier New-normal-r-*-*-*-120-*-*-c-*-iso8859-2,
;;   latin-iso8859-3:-*-Courier New-normal-r-*-*-*-120-*-*-c-*-iso8859-3,
;;   latin-iso8859-4:-*-Courier New-normal-r-*-*-*-120-*-*-c-*-iso8859-4,
;;   cyrillic-iso8859-5:-*-Courier New-normal-r-*-*-*-120-*-*-c-*-iso8859-5,
;;   greek-iso8859-7:-*-Courier New-normal-r-*-*-*-120-*-*-c-*-iso8859-7,
;;   latin-iso8859-9:-*-Courier New-normal-r-*-*-*-120-*-*-c-*-iso8859-9"
;; t)

;;(setq default-frame-alist
;;      '((font . "-*-Courier New-normal-r-*-*-*-120-*-*-c-*-fontset-courier")))

;;__________________________________________________________________________
;;;;    Internetworking
;;__________________________________________________________________________
;;;;;;          Windows FTP
;;allows editing remote files with syntax:
;;      C-x C-f         /username@host:/home/file.txt
;;(defconst ange-ftp-ftp-program-name "c:/winnt/system32/ftp.exe") ;path to ftp
;;(defconst ange-ftp-tmp-name-template              ;;where to cache ftp files
;;      (concat (expand-file-name (getenv "TEMP")) "/ange-ftp"))
;;(defconst ange-ftp-gateway-tmp-name-template
;;      (concat (expand-file-name (getenv "TEMP")) "/ange-ftp"))

;;__________________________________________________________________________
;;;;;;          TCP/IP Dialup
;;If emacs prompts you for a dial-up connection, get nttcp.exe & tcp.el:
;;http://www.cs.washington.edu/homes/voelker/ntemacs/contrib/nttcp.exe
;;http://www.cs.washington.edu/homes/voelker/ntemacs/contrib/tcp.el
;;then add:
;;(load-library "tcp")
;;(defconst tcp-program-name "nttcp")

;;__________________________________________________________________________
;;;;;;          Telnet
;;See also poweruser.el and xemacs.el
;;This works in XEmacs, if you type it in by hand, but doesn't autoload from
;; .emacs. Try ftelnet() from xemacs.el, instead.

;;You need a _Console_ telnet program, like utilities.zip from
;; <URL:http://hesweb1.med.virginia.edu/biostat/s/EmacsTeX/index.html>
;;telnet-mode for w32 also from
;; <URL:http://www.cs.washington.edu/homes/voelker/ntemacs/contrib/>
;;This seems to require telnet.el bundled with emacs
(autoload 'telnet "telnet" "telnet" t)
(autoload 'telnet-mode "telnet" "telnet" t)

;;(put 'telnet-program 'standard-value (list (which-first "telnet")))
(set-default 'telnet-program (which-first "telnet"))

;;__________________________________________________________________________
;;;;	Tiny Tools
;;Lets you click urls in text to lauch browser
(defvar cache-tinyurl)
(cache-locate-library
 use-cache 'cache-advice "advice"
 "get advice.el from full sumo tarball distribution where you got XEmacs")
(cache-locate-library
 use-cache 'cache-tinyurl "tinyurl"
 "get tiny-tools from <URL:http://poboxes.com/jari.aalto/emacs-tiny-tools.html>")
(defvar use-modem)			;shut up compiler
(when (and cache-advice cache-tinyurl)
  (if (which "shellex")
      (progn
	(add-hook 'tinyurl-:load-hook  'tinyurl-install-to-packages)
        (autoload 'tinyurl-mode "tinyurl" "click urls to lauch browser" t)
	(tinyurl-mode)
	(cond ((and (boundp use-modem) (not use-modem))

	       (defvar tinyurl-:plugged-function) ;shut up compiler
	       (set-default 'tinyurl-:plugged-function '(lambda () t))
	       ))
	))                        ;else no shellex.exe
  (message "Put shellex.exe into PATH, from <url: http://www.tertius.com/projects/library/ > for better browser launching"))

;;__________________________________________________________________________
;;;;	Woman: With Out Man(ual) Pages
;;Get woman.el from http://www.anc.ed.ac.uk/~stephen/emacs/ell.html
(autoload 'define-key-after "subr" "subr.el" t)
(defvar cache-woman)			;shut up compiler
(cache-locate-library
 use-cache 'cache-woman "woman"
 "For Manual pages, get woman from <url: http://centaur.maths.qmw.ac.uk/Emacs/ >")

(when cache-woman
  (autoload 'woman "woman" "Decode and browse a UN*X man page." t)
  (autoload 'woman-find-file "woman"  "Find, decode & browse a  man-page." t)
  ;;(global-set-key [f6] 'woman-find-file)
  (autoload 'woman-dired-find-file "woman"
    "In dired, run the WoMan man-page browser on this file." t)
  (add-hook 'dired-mode-hook
            (function
             (lambda ()
               (define-key dired-mode-map "W" 'woman-dired-find-file))))
  
  (let (help-menu manuals)
    (if (setq help-menu (lookup-key global-map [menu-bar help-menu]))
        (if (setq manuals (lookup-key help-menu [manuals]))
            (define-key-after
              manuals [woman] '("Read Man Page (WoMan)..." . woman) t)
          (define-key-after
            help-menu [woman] '("WoMan..." . woman) 'man))))

;;Use color instead of underscores
  (defvar woman-always-colour-faces)
  (set-default 'woman-always-colour-faces 't)
;;Fill up the full width of the frame
  (defvar woman-fill-frame)
  (set-default 'woman-fill-frame 't))

;;__________________________________________________________________________
;;;;	Misc
;;'M-x w32-faq' optional package for common help
;;(require 'w32-shellex	;;http://www.tertius.com/projects/library/index.html
;;(require 'w32-faq)	;<url:http://GNUSoftware.com/Emacs/Lisp/>

;;__________________________________________________________________________
;;;;    Outline-mode control variables
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
(provide 'e-w32)

;;; e-w32.el ends here
