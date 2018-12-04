;;;; e-programmer.el --- Programming routines for gnu and x emacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-04-28 14:27:18 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-programmer.el,v 1.21 2003/05/24 17:37:02 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Syntax Coloring
;;	File Extension Determines Edit Mode
;;	Modes
;;		Code Indentation/Formatting Styles
;;			Indent Style
;;		Awk Mode
;;		Basic Mode
;;		CamelCase Mode
;;		Emacs Lisp
;;		Ini / Conf mode
;;		Live Mode: tail -f
;;		MMM Multiple Mode: ASP, Embperl, Javascript, Mason, PHP
;;		OCaml Tuareg Mode
;;	Ediff: Hilight File Differences
;;	Mode Compile
;;	Save All Scripts As Executable
;;	Time Stamp At Top
;;	Version Control
;;	Misc
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file.  Programmer routines for every OS.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		program mode ide

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-programmer nil "Settings from e-programmer.el file."
  :group 'emacro)
;;(require 'custom)

;;(setq compilation-ask-about-save t)	;Prompt to save files before compiling

;;__________________________________________________________________________
;;;;	Syntax Coloring
;;See also gnu.el's "Colors"
(autoload 'turn-on-font-lock "font-lock" "font-lock" t)
(add-hook 'find-file-hooks 'turn-on-font-lock)

;;(setq font-lock-maximum-decoration t)	;seems to be default, now

(defconst font-lock-support-mode '((t . lazy-lock-mode)))

(cache-locate-library
 use-cache 'cache-lazy-lock "lazy-lock"
 "For large [log] file font-lock coloring, get lazy-lock.el from full tarball distribution where you got XEmacs")

;;This may be needed for huge files, such as live-mode log files.
(when cache-lazy-lock
  (autoload 'turn-on-lazy-lock "lazy-lock" "Force enable Lazy Lock mode.")
  (add-hook 'font-lock-mode-hook 'turn-on-lazy-lock)

;;ToDo: remove this?
;;   (setq lazy-lock-defer-contextually nil) ;Nil makes font lock smoother
;;   (setq lazy-lock-defer-time 5)	;5 is recommended for smooth font lock
;;   (setq lazy-lock-defer-on-the-fly t)  ;Non-nil makes font lock smoother
;;   (setq lazy-lock-defer-on-scrolling 'eventually)
;;'eventually' makes font lock smoother

  ;;To fontify when dragging the scroll-bar in Emacs
  (autoload 'lazy-lock-post-command-fontify-windows "lazy-lock")

  ;; Or to fontify when the Debugger pops up a source code window:
  (autoload 'lazy-lock-fontify-walk-windows "lazy-lock"))

;;__________________________________________________________________________
;;;;	File Extension Determines Edit Mode
;;You can also set an edit mode by putting -*-foo-mode-*- in a comment at top
;;Ex:	#-*- Shell-Script -*- will invoke that mode, if sh-mode.el is loaded.

(autoload 'sh-mode "sh-script" "shell script mode" t)
(autoload 'shell-script-mode "sh-script" "shell script mode" t)
(autoload 'awk-mode "awk-mode" "awk-mode" t)

(autoload 'cperl-mode "cperl-mode" "cperl-mode" t)	;shut up compiler
(defun e-perl-mode () "Loads e-perl.el and cperl-mode."
  (require 'e-perl)
  (cperl-mode))

;;sh-mode in emacs handles all /bin/*sh variants nicely.
;;ksh-mode in xemacs is probably better than sh-mode, but not needed in emacs
;;Invoke a script mode, when a shebang (e.g. #!/bin/sh) is at top
(add-to-list
 'interpreter-mode-alist
 '(
   ("ash"	. sh-mode)	;replace default sh-mode with nicer ksh-mode
   ("bash"	. sh-mode)
   ("csh"	. sh-mode)
   ("dtksh"	. sh-mode)
   ("ksh"	. sh-mode)
   ("pdksh"	. sh-mode)
;;trap perl to force lazy load of EMacro perl mode wrapper
   ("perl"	. e-perl-mode)
   ("perl5"	. e-perl-mode)
   ("python"	. python-mode)	;XEmacs supports python, Emacs does not :(
   ("ruby"	. ruby-mode)
   ("sh"	. sh-mode)
   ("tcsh"	. sh-mode)
   ("zsh"	. sh-mode)
   ))

(cond
 ('cache-psgml
  (setq auto-mode-alist (append '(("\\.x[ms]l$" . xml-mode))auto-mode-alist)))
 ;;Else psgml not in load-path- fall back to sgml.el
 (t
  (setq auto-mode-alist
        (append '(("\\.x[ms]l$" . sgml-mode))auto-mode-alist))))

(cache-locate-library
 use-cache 'cache-auctex  "tex-site"
 "For La/TeX doc support, get auctex from full tarball distribution where you got XEmacs")
;;tex-buf requires comint, which is not in xemacs base distribution

(when cache-auctex
  (require 'tex-site)                   ;This is a small file of autoloads

;;Run TeX against a file:
;;(add-to-list 'TeX-command-list '("make dvi" "make %d" TeX-run-LaTeX nil t))

;;   (add-hook 'LaTeX-mode-hook
;; 	    (lambda ()
;; 	      (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)))

  (setq auto-mode-alist (append '(("\\.\\(cls\\|dtx\\|sty\\|tex\\)$" .
                                   tex-mode)) auto-mode-alist))
  (setq auto-mode-alist (append '(("\\.texi$" . texinfo-mode))
                                auto-mode-alist)))

(autoload 'crontab-edit "crontab" "Edit crontab files." t)
(autoload 'php-mode "php-mode" "php-mode." t)
;;DEPRECATE: fixed in php-mode.el v1.0.1:
(autoload 'speedbar-add-supported-extension "speedbar" "speedbar." t)

;;DEPRECATE: c-mode & cc-mode are obsolete
(cache-locate-library
 use-cache 'cache-cc-mode "cc-mode"
 "Time to upgrade XEmacs/Emacs with full tarball distribution for C-like language support")
(when cache-cc-mode (require 'cc-mode))

(defun e-c-mode () "Loads e-c.el and c-mode."
  (require 'e-c)
  (c-mode))

(defun e-c++-mode () "Loads e-c.el and c++-mode."
  (require 'e-c)
  (c++-mode))

;;See also e-java.el, e-perl.el & e-xml.el for more auto-mode-alist
(setq auto-mode-alist
      (append
       '(
	 ("\\.htaccess$"       		. apache-mode)
	 ("\\(\\access\\|httpd\\|srm\\).conf$" . apache-mode)
	 ("\\.[ejw]ar$"			. archive-mode)
	 ("\\.asm$"			. asm-mode)
;;Force the lazy load of EMacro's c-mode wrapper:
	 ("\\.c$"			. e-c-mode)
	 ("\\.\\(C\\|cc\\h?h\\)$"	. e-c++-mode)
	 ("\\.[ch]\\(pp\\|xx\\)$"	. e-c++-mode)
	 ("\\.idl$" 		. e-c++-mode)
	 ("\\.c$"			. e-c-mode)
	 ("root$"			. crontab-edit)
;;/usr/spool/cron/crontabs/root/root is typical, but might be relative path
	 ("crontab"			. crontab-edit)
	 ("\\.\\dp[rk]$"       		. delphi-mode) ;.pas is pascal
	 ("\\.d\\(cl\\|ec\\|td\\)$"	. dtd-mode)
	 ("\\.\\(ele\\|ent\\|mod\\)$"	. dtd-mode)
	 ("\\.e$"			. eiffel-mode)
	 ("\\.emacs$"			. emacs-lisp-mode)
	 ("\\.gri$"			. gri-mode)
	 ("\\.js$"			. java-mode) ;java/ecma script
	 ("\\.m4$"			. m4-mode)
	 ("[mM]ak$"			. makefile-mode)
;;I use .tmpl for html templates
;;	 ("\\.tmpl$"			. makefile-mode)
;; .m is also used for objc-mode
;;	 ("\\.m$	"      		. matlab-mode)
	 ("\\.[im]2$"			. modula-2-mode)
	 ("\\.[im][3g]$"       		. modula-3-mode)
	 ("\\.[nt]r$"			. nroff-mode)
	 ("\\.cgi$"			. e-perl-mode)
	 ("\\.p[lm]$"			. e-perl-mode)
	 ("\\.php[34]?$"		. php-mode)
	 ("\\.c?ps$"			. postscript-mode)
	 ("\\.pro$"			. prolog-mode)
	 ("\\.py$"			. python-mode)
	 ("\\.rb$"			. ruby-mode)
	 ("\\.\\(sawfishrc\\|jl\\)$"	. sawfish-mode)
;;See dtd-mode above for handling xml.dtd files.
;;	 ("\\.dtd$"			. sgml-mode)
	 ("\\.[ckz]?sh$"       		. sh-mode)
	 ("profile$"			. sh-mode)
	 ("configure$"			. sh-mode)
	 ("\\.wm\\(rc\\)?$"		. winmgr-mode)
	 ("\\.tcl$"			. tcl-mode)
	 ("\\.[Dd][Oo][Cc]$"		. text-mode)
	 ("^mutt-"			. text-mode)	;mail reader
	 ("\\.d?v$"			. verilog-mode)
	 ("\\..wrl$"			. vrml-mode)
	 ("\\.xpm$"			. xpm-mode)
	 )
      auto-mode-alist))

(autoload 'add-change-log-entry "add-log" "change-log major mode" t)
(autoload 'change-log-mode "add-log" "change-log major mode" t)
(autoload 'nroff-mode "nroff-mode" "nroff-mode" t)
(autoload 'python-mode "python-mode" "python-mode" t) ;requires extra comint
(autoload 'sawfish-mode "sawfish" "sawfish-mode" t)

;;These have not been tested, including the above file extension associations
(autoload 'ada-mode "ada-mode")         ;<url:http://www.ada-france.org/ada-mode/>

(cache-locate-library
 use-cache 'cache-antlr-mode  "antlr-mode"
 "For antlr support, Get antlr-mode from <url:http://antlr-mode.sf.net/>")
(autoload 'antlr-mode "antlr-mode" nil t)

(cache-locate-library
 use-cache 'cache-apache-mode  "apache-mode"
 "To edit apache config files, Get apache-mode from <url:http://www.keelhaul.demon.co.uk/linux/>")
(autoload 'apache-mode "apache-mode" "Edit apache config files mode" t)
(autoload 'asm-mode "asm-mode")

;;ToDo: CSharp-mode is being deprecated in favor of http://CSDE.sf.net/

;;Since csharp-mode is part of cc-mode, we cannot use cache-locate-library()
;;Instead, assume cc-mode is loaded, and check for csharp-mode() function:

;;(defvar compilation-error-regexp-alist)	;shut up compiler
;; (if (fboundp 'csharp-mode)
;;     (progn
;;       (setq auto-mode-alist
;; 	    (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
;;       (setq compilation-error-regexp-alist
;; 	    (append '(
;;Sample C# Compiler error:
;;t.cs(6,18): error SC1006: Name of constructor must match name of class

;; 		      ("\\(\\([a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)[,]\\([0-9]+\\)): \\(error\\|warning\\) CS[0-9]+:" 1 3 4))
;; 		    compilation-error-regexp-alist))
;;       )					;else
;;   (when (not (boundp 'csharp-exists-p)) (append-to-file
;;    (concat "(defconst csharp-exists-p t)	;For C# support, Get csharp-mode from <url:http://www.cybercom.net/~zbrad/DotNet/Emacs/>" eol)
;;     'nil use-cache)))

(cache-locate-library
 use-cache 'cache-delphi-mode  "delphi-mode"
 "For delphi support, Get delphi-mode from <url:http://www.infomatch.com/~blaak/code/delphi.el>")
(autoload 'delphi-mode "delphi")
(autoload 'eiffel-mode "eiffel-mode")

(cache-locate-library
 use-cache 'cache-gri-mode  "gri-mode"
 "For gri postscript graphics, Get gri-mode from, <url:http://people.debian.org/~psg/elisp/>")
(autoload 'gri-mode "gri-mode" "Enter Gri-mode." t)

;;Switch commenting of clashing Objective C ".m" extension
;;Get matlab from <url:ftp://ftp.mathworks.com/pub/contrib/emacs_add_ons/matlab.el>
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)
(autoload 'm4-mode "m4-mode")
(autoload 'modula-2-mode "modula-2-mode")

(cache-locate-library
 use-cache 'cache-modula-3-mode  "modula-3-mode"
 "For modula3 support, modula3 from <url:http://m3.polymtl.ca/m3/pkg/pm3/language/modula3/m3tools/gnuemacs/src/.ghindex.html>")
(autoload 'modula-3-mode "modula-3-mode")
(autoload 'pascal-mode "pascal-mode")
(autoload 'postscript-mode "postscript-mode")
(autoload 'prolog-mode "prolog-mode")	;requires extra comint
(autoload 'tcl-mode "tcl-mode")
(autoload 'verilog-mode "verilog-mode")
(autoload 'vrml-mode "vrml-mode")
(autoload 'winmgr-mode "winmgr-mode" "Edit window manager config files mode")
(autoload 'xpm-mode "xpm-mode")

;;Not actually used, but does write reminder to cache file:
(cache-locate-library
 use-cache 'cache-ruby-mode  "ruby-mode"
 "For ruby support, move ruby-mode.el into emacs loadpath. See also <url:http://www.ruby-lang.org/>")
(autoload 'ruby-mode "ruby-mode" "Edit in ruby language" t)

(add-hook 'winmgr-mode-hook
	  '(lambda ()
	     (font-lock-mode t)
	     (setq font-lock-keywords winmgr-font-lock-keywords)
             (font-lock-fontify-buffer)))

;;__________________________________________________________________________
;;;;	MODES
(autoload 'regexp-opt "regexp-opt" "regexp opt." t)
(autoload 'makefile-mode "make-mode" "makefile mode." t)
(autoload 'imenu-add-menubar-index "imenu" "function menu" t)

(defvar makefile-find-file-autopickup-p)
;;(put 'makefile-find-file-autopickup-p 'standard-value (list 'nil))
(set-default 'makefile-find-file-autopickup-p 'nil)

;;(setq compile-command "make")	;;Comment this out for MS Windows
;;(setq compile-command '("nmake -f .mak " . 10))	;Visual C++ compiling

;;ToDo: remove this deprecated tiny code:
(cache-locate-library
 use-cache 'cache-tinyprocmail "tinyprocmail"
  "For procmail mail filter support, get tiny-tools from <URL:http://www.sourceforge.net/projects/tiny-tools/> Requires advice.el")

(when cache-tinyprocmail
  (pushnew (dirname (locate-library "tinyprocmail")) load-path :test 'string=)
  (autoload 'aput "assoc" "assoc" t)	;shut up compiler
  (aput 'auto-mode-alist
	"\\.rc$"
	'turn-on-tinyprocmail-mode)
  (aput 'auto-mode-alist
	"procmailrc$"
	'turn-on-tinyprocmail-mode))

;; (autoload 'turn-on-tinyprocmail-mode  "tinyprocmail" "" t)
;; (autoload 'turn-off-tinyprocmail-mode "tinyprocmail" "" t)
;; (autoload 'tinyprocmail-mode          "tinyprocmail" "" t)

(cache-locate-library
 use-cache 'cache-xrdb-mode "xrdb-mode"
  "For X Window config file support, get xrdb-mode from <URL:http://www.python.org/emacs/>")

(when cache-xrdb-mode
  (autoload 'xrdb-mode "xrdb-mode" "Mode for editing X resource files" t)
  (setq auto-mode-alist
	(append '(
		  ("\\.ad$"					   . xrdb-mode)
		  ("\\.X\\(defaults\\|environment\\|resources\\)$" . xrdb-mode)
		  )auto-mode-alist)))

;;__________________________________________________________________________
;;;;;;		Code Indentation/Formatting Styles
;;This mentions C mode, but impacts C++, Java, etc, which are built on top
;;Read cc-mode.el for other canned styles. See also
;; http://www.python.org/emacs/cc-mode/cc-mode-html/Sample-.emacs-File.html

;;(setq tab-stop-list '(2 4 6 8))

;;(defun stroustrup-common-hook () 	(c-set-style "stroustrup")
;;	(c-basic-offset . use-indent))
                                        ;(add-hook 'c-mode-common-hook 'stroustrup-common-hook)

;;If you don't like the canned styles, below are some customizations. You
;;can tweak them, by going to the line in question, and invoking
;;	M-x c-set-offset
;;or, usually, more simply,
;;	C-c C-o
;;Type TAB to check indentation of this line.
;;Type C-x ESC ESC then M-n and/or M-p until you find the right
;; c-set-offset statement you just produced with C-c C-o.
;; Insert that c-set-offset statement into your C mode hook.
;;
;;Also useful is
;;	M-x describe-key-briefly
;;You can check what is indenting your "//" C++ style comments, for example,
;;with the equivalent command shortcut
;;	C-h c /

;;__________________________________________________________________________
;;;;;;;;		Indent Style
;;Set defaults for where tabs & braces go, etc.
;;Ex: I like my opening brace on a new line (see S. McConnell's Code Complete)
;;You can access this style with "M-x c-set-style" or cperl-set-style, etc

(autoload 'c-add-style "cc-styles" "cc-styles" t) ;shut up compiler
;;'(defconst outdent (* -1 use-indent))

(defvar c-basic-offset)                 ;shut up compiler
;;setq must be used, in spite of possible compile warning
(defvar use-indent)			;shut up compiler
;;(setq c-basic-offset use-indent)
;;(put 'c-basic-offset 'standard-value (list use-indent))
(set-default 'c-basic-offset use-indent)

(cache-locate-library use-cache 'cache-cc-mode "cc-mode"
                      "For HTML support, get cc-mode.el from full tarball distribution where you got XEmacs")

(when cache-cc-mode (require 'cc-mode) ;;bad xemacs compile on w32.

  ;;setq must be used, in spite of possible compile warning
  (setq c-basic-offset use-indent)

  (c-add-style "local"
               '(
                 ;;'		     (c-basic-offset . 3)
                 (c-comment-only-line-offset . 0)
                 ;;'		     (c-hanging-braces-alist . ((substatement-open before after)))

                 (c-offsets-alist . ((topmost-intro        . 0)
                                     (topmost-intro-cont   . 0)
                                     (substatement         . +)
                                     (substatement-open    . 0)
                                     (statement-case-open  . +)
                                     (statement-cont       . +)
                                     (access-label         . -)
                                     (inclass              . +)
                                     (inline-open          . 0))))))

;;__________________________________________________________________________
;;;;;;		Awk Mode
(eval-after-load "awk-mode"
  '(setcar (nthcdr 1 awk-font-lock-keywords)
           (concat "\\<\\(BEGIN\\|END\\|break\\|continue\\|delete"
                   "\\|exit\\|for\\|getline\\|if\\|else\\|next\\|printf?"
                   "\\|return\\|while\\)\\>")))

;;__________________________________________________________________________
;;;;;;		Basic Mode
(cache-locate-library
 use-cache 'cache-visual-basic-mode "visual-basic-mode"
 "For visual basic support, get visual-basic-mode from <url:http://www.gest.unipd.it/~saint/hth.html>")

(if cache-visual-basic-mode
    (setq auto-mode-alist
	  (append '(("\\.\\(asp\\|bas\\|cls\\|frm\\)$" . visual-basic-mode)
		    )auto-mode-alist))
  (setq auto-mode-alist			;else fall back to basic-mode
	(append '(("\\.\\(asp\\|bas\\|cls\\|frm\\)$" . basic-mode)
		  )auto-mode-alist)))

;;__________________________________________________________________________
;;;;;;		CamelCase Mode
(cache-locate-library
 use-cache 'cache-camelCase-mode "camelCase-mode"
 "For visual basic support, get camelCase-mode from <url:http://www.ai.mit.edu/people/caroma/tools/>")

(when cache-camelCase-mode
  (autoload 'camelCase-mode "camelCase-mode" nil t)
;;   (add-hook 'java-mode-hook '(lambda () (camelCase-mode 1)))
  (add-hook 'find-file-hooks '(lambda () (camelCase-mode 1)))
  (add-hook 'post-command-hook '(lambda () (camelCase-mode 1)))
  )

;;__________________________________________________________________________
;;;;;;		Emacs Lisp
;;Enable compile from menu. Assumes emacs is in the path.
;;Note that starting another copy of emacs is not efficient, but at least
;;the menu does something relevant.
(add-hook
 'emacs-lisp-mode-hook
 (function
  (lambda ()
    (imenu-add-menubar-index)
    (set (make-local-variable 'compile-command)
         (format "emacs -batch -f batch-byte-compile %s" buffer-file-name)))))

;;__________________________________________________________________________
;;;;;;		Ini / Conf mode
;;Currently only supports Emacs, but XEmacs support may be planned
(when (string-match "GNU" (emacs-version))
(cache-locate-library
 use-cache 'cache-any-ini-mode "any-ini-mode"
 "For ini & conf file support, get any-ini-mode from <url:http://www.emacswiki.org/elisp/any-ini-mode.el>")

(when cache-any-ini-mode
  (add-to-list 'auto-mode-alist '(".*\\.ini$" . any-ini-mode))
  (add-to-list 'auto-mode-alist '(".*\\.conf$" . any-ini-mode))))

;;__________________________________________________________________________
;;;;;;		Live Mode: tail -f
;;Good for view httpd logs, as info gets appended
;;Be sure to use lazy-lock, as logs are usually large
;;I have noticed that live-mode seems to turn itself off, when reloading.
(cache-locate-library
 use-cache 'cache-live-mode "live-mode"
 "For log file support, get live-mode from <url:http://www.zanshin.com/~bobg/>")

(when cache-live-mode
  (autoload 'live-mode "live-mode" "live-mode tails logs" t)
  (setq auto-mode-alist (append '(("\\.log$" . live-mode))
                                auto-mode-alist)))

;;__________________________________________________________________________
;;;;;;		MMM Multiple Mode: ASP, Embperl, Javascript, Mason, PHP
;;Support mixed modes, typically code embedded in html
;;ToDo: Needs testing!
(defvar cache-mmm-mode)			;shut up compiler

(cache-locate-library
 use-cache 'cache-mmm-mode "mmm-mode"
 "For HTML support, get mmm.el from <url:http://mmm-mode.sourceforge.net/>")

(when cache-mmm-mode
  (defvar mmm-global-mode)		;shut up compiler
  (defvar mmm-submode-decoration-level)	;shut up compiler

  (require 'mmm-sample)			;includes mmm-auto & mmm-vars

  (setq mmm-global-mode t)
  (setq mmm-submode-decoration-level 100)

  (defvar e-xml-auto-fill)
  (add-hook 'mmm-mode-hook
	    (function
	     (lambda ()
;;This seems to make imenu TOO frequent.
;;	       (imenu-add-menubar-index)
	       (if e-xml-auto-fill (auto-fill-mode 1)
		 (auto-fill-mode -1))	;else disable word-wrap
	       )))

  (autoload 'mmm-add-classes "mmm-sample" "Multiple Major Mode." t)
  (mmm-add-classes
   '((embedded-php
      :submode php
      :face mmm-declaration-submode-face
      :front "<\\?\\(php\\)?"
      :back "\\?>")))

  (add-to-list 'mmm-mode-ext-classes-alist
	       '(nil "\\.\\(mason\\|.m[dc]\\)\\'" mason))

(defvar cache-rpm-spec-mode)		;shut up compiler
(cache-locate-library
 use-cache 'cache-rpm-spec-mode "rpm-spec-mode"
 "For HTML support, get rpm-spec-mode.el from <url:http://www.xemacs.org/~stigb/>")
(when cache-rpm-spec-mode
  (require 'mmm-rpm)
  (add-to-list 'mmm-mode-ext-classes-alist
	       '(rpm-spec-mode "\\.spec\\'" rpm-sh))))

;;__________________________________________________________________________
;;;;;;	OCaml Tuareg Mode
;;Skip the directions in the elisp- just move the files into the packages dir
(defvar cache-custom-tuareg)		;shut up compiler
(defvar cache-append-tuareg)		;shut up compiler
(cache-locate-library
 use-cache 'cache-custom-tuareg "custom-tuareg"
 "For OCaml programming support, get tuareg-mode from <url: http://www.ocaml.org >")
(cache-locate-library
 use-cache 'cache-append-tuareg "append-tuareg"
 "For OCaml programming support, get tuareg-mode from <url: http://www.ocaml.org >")
(when (and (and cache-append-tuareg cache-custom-tuareg)
	   (not (featurep 'e-tuareg)))	;simulate a require()
  (load-library "custom-tuareg")
  (load-library "append-tuareg")
  (provide 'e-tuareg))

;;__________________________________________________________________________
;;;;	Ediff: Hilight File Differences
                                        ;(require 'ediff)
(autoload 'ediff "ediff" "ediff compare files." t)
(defvar ediff-ignore-similar-regions)	;Toggle verbosity of file diffs
(defvar ediff-use-last-dir)		;Toggle remember path to diff-ed files
;;(put 'ediff-ignore-similar-regions 'standard-value (list 't))
;;(put 'ediff-use-last-dir 'standard-value (list 't))
(set-default 'ediff-ignore-similar-regions 't)
(set-default 'ediff-use-last-dir 't)

;;__________________________________________________________________________
;;;;	Mode Compile
;;Adds smarts to compile.el
;;<url: ftp://archive.cis.ohio-state.edu:pub/gnu/emacs/elisp-archive/misc/mode-compile.el.Z >

(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

;;__________________________________________________________________________
;;;;	Save All Scripts As Executable
;;!!!To Do: does this solve lockups on w32?

 (when (and (not (eq 'w32 system-type))
	    (fboundp 'executable-make-buffer-file-executable-if-script-p))
    (add-hook 'after-save-hook
              'executable-make-buffer-file-executable-if-script-p))

;;__________________________________________________________________________
;;;;	Time Stamp At Top
;; If you put a time stamp template anywhere in the first 8 lines of a file,
;; it can be updated every time you save the file.  See the top of
;; time-stamp.el for a sample.  The template looks like one of the following:
;;     Time-stamp: <>
;;     Time-stamp: " "
;; The time stamp is written between the brackets or quotes, resulting in
;;     Time-stamp: <93/06/18 10:26:51 gildea>
;; Here is an example which puts the file name and time stamp in the binary:
;; static char *time_stamp = "sdmain.c Time-stamp: <>";

(cache-locate-library
 use-cache 'cache-time-stamp "time-stamp"
 "To update time info at top of files (programming), get time-stamp.el from full tarball distribution where you got XEmacs")

(when cache-time-stamp
  (require 'time-stamp)
  (global-set-key [(control f3)] 'insert-date)
  (add-hook 'write-file-hooks 'time-stamp)

  ;;Activates automatic time stamping:
  (if (not (memq 'time-stamp write-file-hooks))
      (setq write-file-hooks
            (cons 'time-stamp write-file-hooks))))

;;__________________________________________________________________________
;;;;	Version Control
;;Assumes that ring.el, part of xemacs sumo tarball is installed.
(cache-locate-library
 use-cache 'cache-vc "vc"
 "For version control support, get vc.el from full tarball distribution where you got XEmacs")
;;generic Version tool menu cvs,sccs,
(when (and cache-vc (string-match "XEmacs" (emacs-version))) (require 'vc))

(cache-locate-library
 use-cache 'cache-pcl-cvs-defs "pcl-cvs-defs"
 "For cvs version control support, get pcl-cvs.el from full tarball distribution where you got XEmacs")
(when cache-pcl-cvs-defs
  (require 'pcl-cvs-defs))              ;Just menu:faster than all pcl-cvs

;;For extra cvs functionality. Do we need all these autoloads?
(autoload 'def-edebug-spec "edebug" "used by cvs" t)
(autoload 'debug-on-entry "debug" "used by cvs" t)	;works on xemacs
;(autoload 'debug-on-entry "edebug" "used by cvs" t)	;emacs only?

(autoload 'cvs-mode "pcl-cvs" "CVS version control" t)
(autoload 'cvs-examine "pcl-cvs" "CVS version control" t)
(autoload 'cvs-examine-other-window "pcl-cvs" "CVS version control" t)
(autoload 'cvs-update "pcl-cvs" "CVS version control" t)
(autoload 'cvs-update-other-window "pcl-cvs" "CVS version control" t)
(autoload 'cvs-checkout "pcl-cvs" "CVS version control" t)
(autoload 'cvs-checkout-other-window "pcl-cvs" "CVS version control" t)
(autoload 'cvs-status "pcl-cvs" "CVS version control" t)
(autoload 'cvs-status-other-window "pcl-cvs" "CVS version control" t)
(autoload 'cvs-help "pcl-cvs" "CVS version control" t)
(autoload 'cvs-change-cvsroot "pcl-cvs" "CVS version control" t)

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

(provide 'e-programmer)
;;; e-programmer.el ends here
