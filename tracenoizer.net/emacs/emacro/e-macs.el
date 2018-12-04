;;;; e-macs.el ---  Routines specific to Emacs but not XEmacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-07-08 11:57:54 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-macs.el,v 1.22 2003/05/24 17:37:01 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;;	Legal
;;	Commentary
;;	Code
;;	Defcustoms
;;	Display & Menu
;;		Colors
;;		Fonts
;;		Keys
;;		Menu Customization
;;		Minibuffer Scrolling
;;		Minibuffer (status area) Sizing
;;		Recent Files Menu
;;		Wheel Mouse
;;	Utilities
;;		Emacs Server
;;		File Handling
;;		split-path()
;;		Toggle Text Mode
;;		yank-line()
;;	Internet
;;		Email To Address At Cursor
;;		Remote Editing & Ftp Interface
;;		Web Browsing
;;	Applications
;;		Telephone/Address Book
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file.  Routines for every OS, but only Gnu Emacs.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls@users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		gnu

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;;; Defcustoms
(defgroup e-macs nil  "Settings from e-macs.el file."  :group 'emacro)

(defcustom e-right-popup 'gnome
  "Popup menu for right mouse (button 3) gnome/kde/w32 style.
Nil = native, the old X Window style to end a selection."
  :group 'e-macs
  :type '(choice (const nil)
		 (const cua)))

;;__________________________________________________________________________
;;;;    DISPLAY & MENU
;;(menu-bar-mode nil)                    ;turn off menu bar
;;(load-library "term/pc-win")

(cache-locate-library
 use-cache 'cache-a2ps-print "a2ps-print"
 "For clean source code printouts, get a2ps-print.el from <url: http://sf.net/projects/emacro/ >")

(when cache-a2ps-print
  (autoload 'a2ps-region "a2ps-print" "a2ps-print" t)
  (autoload 'a2ps-buffer "a2ps-print" "a2ps-print" t)
  (define-key function-key-map [f22] [print])
  (global-set-key [print] 'a2ps-buffer)		;f22 is Print Screen
  (global-set-key [(shift print)] 'a2ps-region)	;print selected text
  (define-key-after menu-bar-file-menu [a2ps] 
    '("a2ps Print Buffer" . a2ps-buffer)
    'ps-print-buffer))

(cache-locate-library
 use-cache 'cache-mic-paren "mic-paren"
 "For Gnu Emacs parenthesis, brace, etc., matching, get mic-paren.el from <url:http://www.emacswiki.org/elisp/mic-paren.el>")

(cond (cache-mic-paren
       (require 'mic-paren)
       (set-default 'paren-face 'bold)
       (set-default 'paren-sexp-mode 't)
       (show-paren-mode 1))
      (t (progn
	   (require 'paren)
	   (show-paren-mode 1))))       ;highlight matching parenthesis

(when (not (eq system-type 'darwin))	;OS X console hates scrollbars
  (defcustom e-scrollbar-side 'right "Side where scrollbar appears."
    :group 'e-macs
    :type '(choice (const :tag "none (nil)")
		   (const left)
		   (const right))
    :set 'set-scroll-bar-mode-1)
  (setq scroll-bar-mode 'e-scrollbar-side))
;;(toggle-scroll-bar t)			;refresh scroll bar

(require 'msb)                          ;Mouse Select Buffer: popup menus
;;(menu-bar-mode (if window-system 1 -1))	;Disable menu-bar in console

;;__________________________________________________________________________
;;;;;;		Colors
;;See also Programmer.el
;;(set-background-color "grey90")
(global-font-lock-mode t)

;;__________________________________________________________________________
;;;;;;		Keys
;;(require 'pc-mode)			;similar code is in keys.el
(require 'pc-select)                    ;Shift-Arrow highlighting
(pc-selection-mode)

(defvar cache-cua)			;shut up compiler
(cache-locate-library
 use-cache 'cache-cua "cua"
 "For CUA key support, get cua.el from <url:http://www.cua.dk/cua.html>")

(when cache-cua
  (require 'cua)
  (CUA-mode t)
  ;;(CUA-keypad-mode 'prefix t)		;saves into numbered registers
  )

;;Next 2 lines may cause error:
;; "Symbol's value as variable is void: minibuffer-local-ns-map"
(require 'delsel)                       ;delete selected text when overtyped
(delete-selection-mode t)               ;Overwrites selected text

(require 'mouse-sel)

;;override one of the libraries above
(global-set-key [(meta backspace)]      'backward-kill-word)
(global-set-key [(control backspace)]   'undo)

;;__________________________________________________________________________
;;;;;;		Fonts
;;(set *default-font* "-adobe-courier-bold-*-*-*-20-*-*-*-*-*-*-*")
;;'xfontsel' in Linux lists fonts. Here's how to set a default for emacs:
;;(set-default-font "-*-Lucida Console-normal-r-*-*-11-82-*-*-c-*-*-#204-")
;;(set-default-font "-adobe-courier-*-*-*-14-*-*-*-*-*-*-*")

;;__________________________________________________________________________
;;;;;;		Customize A Popup Menu

;;EXPECT THIS CODE TO CHANGE IN FUTURE RELEASES!!!

(defun popup-commands ()
  "Show a popup menu of commands. See also `choose-from-menu'."
  (interactive)
  (eval-expression
   (car
    (read-from-string
     (choose-from-menu
      "Commands"
      (list
       (cons (concat "EMacro v" emacro-version) "(emacro-help)")
       (cons "Goto Line"	"(call-interactively 'goto-line)")
       (cons "Redo"		"(redo)")
       (cons "Refresh Cache"	"(emacro-refresh-cache)")
       (cons "Search files"	"(call-interactively 'grep)")
       ))))))

    (global-set-key [S-down-mouse-3] 'popup-commands)

;;Look & feel compatibility with gnome/kde/w32. How does OS/X do it?
(when (eq e-right-popup 'gnome)
  (defun right-popup ()
    "Show a popup menu of commands. See also `choose-from-menu'."
    (interactive)
    (eval-expression
     (car
      (read-from-string
       (choose-from-menu
	"Commands"
	(list
	 (cons (concat "EMacro v" emacro-version) "(emacro-help)")
	 (cons "Copy                C-insert" "(call-interactively 'copy-region-as-kill)")
	 (cons "Goto Line"		"(call-interactively 'goto-line)")
	 (cons "Paste/yank        S-insert"	"(yank)")
	 (cons "Redo"			"(redo)")
	 (cons "Refresh Cache"	"(emacro-refresh-cache)")
	 (cons "Search files"		"(call-interactively 'grep)")
	 (cons "Undo                 C-_"	"(undo)")
	 (cons "Word completion M-/"	"(call-interactively 'dabbrev-expand)")
	 ))))))

  (global-set-key [mouse-3] 'right-popup))

;;__________________________________________________________________________
;;;;;;		Customize The Menu
(defvar emacro-version)			;shut up compiler
(define-key global-map [menu-bar help-menu emacro-help]
  `(,(concat "EMacro v" emacro-version) . emacro-help))

;;(define-key global-map [menu-bar tools locate] '("Locate file" . locate))
;;turn off emacs toolbar, Emacs v21
;;(tool-bar-mode -1)

;;__________________________________________________________________________
;;;;;;		Recent Files Menu
(cache-locate-library
 use-cache 'cache-recentf "recentf"
 "To get recently opened files on menu, get recentf from <url:http://perso.wanadoo.fr/david.ponce/more-elisp.html>")

(when (string-match "Gnu" (emacs-version))
  (when (and cache-recentf window-system)
    (require 'recentf)
    (recentf-mode t)))

;;__________________________________________________________________________
;;;;;;		Minibuffer Scrolling
;;This causes XEmacs to lock up, ex: C-x k won't respond to kill buffer
;;(cache-locate-library use-cache 'cache-mscroll "mscroll"
;; "For a minibuffer that scrolls, get mscroll.el from <url:http://vegemite.chem.nott.ac.uk/~matt/emacs/>")

;;(cond
;; (cache-mscroll
;;  (require 'mscroll)
;;  (mscroll-activate)
;;  (add-to-list 'mscroll-ignored-messages "^Compiling .*\\.el")))

;;__________________________________________________________________________
;;;;;;		Minibuffer (status area) Sizing
;;resize-minibuffer-mode auto resizes the minibuffer to hold its contents
;;bundled with newer emacs?
;;(require 'rsz-mini)
;;(autoload 'resize-minibuffer-mode "rsz-minibuf" nil t)
;;(resize-minibuffer-mode)
;;(setq resize-minibuffer-window-exactly nil)

;;__________________________________________________________________________
;;;;;;		Wheel Mouse
(mouse-wheel-mode)

;;__________________________________________________________________________
;;;; UTILITIES

;;__________________________________________________________________________
;;;;;;		Emacs Server
;;Be sure to test changes on w98
(defvar server-process)                 ;shut up bytecompiler

(autoload 'gnuserv-running-p "gnuserv" "gnuserv." t) ;shut up compiler
(autoload 'gnuserv-start "gnuserv" "gnuserv." t) ;shut up compiler
(if (which "gnuclientw")		;w32 emacs client
  (progn
    (require 'gnuserv)
    (setq server-done-function 'bury-buffer gnuserv-frame (car (frame-list)))
    (gnuserv-start)
;;open buffer in existing frame instead of creating a new one...
    (setq gnuserv-frame (selected-frame)))

;;else use bundled emacs server
  (when
      (not (or (string-match "windows" (symbol-name system-type))
	       (string-match "macos" (symbol-name system-type))))
    (require 'server)
    (if (and server-process
	     (equal (process-status server-process) 'run))
	(progn
;;New 'window' when loading new files:
;;  (add-hook 'server-visit-hook #'(lambda() (setq server-window (new-frame))))
	  (global-set-key [(control xc)]	'delete-frame)
	  (global-set-key [(meta f4)]	'delete-frame))
      ;;else this is the only emacs instance:
      (server-start))))

;;__________________________________________________________________________
;;;;;;		File Handling
;;<url:ftp://ls6-ftp.cs.uni-dortmund.de/pub/src/emacs/>
;;This sometimes works in xemacs
(autoload 'locate "locate" "Quickly find unix files." t)
(autoload 'locate-with-filter "locate" "filter output of locate")

;;__________________________________________________________________________
;;;;;;		Toggle Text Mode
(toggle-text-mode-auto-fill);;hook for filling in text & la/tex mode

;;__________________________________________________________________________
;;;;;;		yank-line
(defun yank-line () "copies current line. Should be merged with XEmacs ver"
  (interactive)
  (push-mark (beginning-of-line))
  (end-of-line)
  (copy-region-as-kill (mark) (point)))

;;__________________________________________________________________________
;;;; INTERNET
;;__________________________________________________________________________
;;;;;;		Email To Address At Cursor
;; Based on a defun by Kevin Rodgers <kevinr@ihs.com>
;;(require 'thingatpt)
(autoload 'thing-at-point "thingatpt" "mouse enable object" t)

(defvar email-regexp)
(defun mail-to-address-at-point ()
  "*Edit a new mail message to the address at point."
  (interactive)
  (let ((url-at-point (substring (thing-at-point 'url) 7)))
    (if (string-match email-regexp url-at-point)
        (mail nil url-at-point)
      (message "Bad email address"))))

;;__________________________________________________________________________
;;;;;;		Remote Editing & FTP Interface
;;Open with     C-x C-f [ret] /username@host:/path/file.name
(autoload 'ange-ftp "ange-ftp" "ange-ftp edit remote files." t)
(defvar use-login-name)			;shut up compiler
(set-default 'ange-ftp-default-user use-login-name)
(setq default-directory (expand-file-name "./")) ;not needed, but may help

;;Non-nil fixes ~ backup permissions on remote files created by ange-ftp.
(set-default 'backup-by-copying 't)

;;Nil fixes ~ backup permissions on remote files created by ange-ftp.
(set-default 'ange-ftp-make-backup-files 'nil)

;;__________________________________________________________________________
;;;;;;		Web Browsing
;;w3 web browser from http://www.cs.indiana.edu/elisp/w3/docs.html
;;(load-library "w3-auto")

;;See inet.el, where we define browse-url-at-mouse() to launch <url:...>
(global-set-key [S-mouse-2] 'browse-url-at-mouse)

;;__________________________________________________________________________
;;;; APPLICATIONS

;;__________________________________________________________________________
;;;;;;		Telephone/Address Book Function
;;X Emacs version does not provide (goto-address)
(global-set-key [(meta f3)] 'address-book)
(defun address-book ()
  "Opens .addressbook with goto address support."
  (interactive)  (find-file "~/emacs/addressbook") (goto-address))

;;__________________________________________________________________________
;;		Tab Bars
;;Should be loaded last
(cache-locate-library
 use-cache 'cache-tabbar "tabbar"
 "For file tabs at top, get tabbar.el from <url:http://www.dponce.com/downloads/>")

(cond (cache-tabbar
       (require 'tabbar)
       (global-set-key [(control shift tab)] 'tabbar-backward)
       (global-set-key [(control tab)]       'tabbar-forward)
       (tabbar-mode)))

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

(provide 'e-macs)

;;; e-macs.el ends here

