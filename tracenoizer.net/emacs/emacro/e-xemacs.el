;;; xemacs.el --- Routines for XEmacs but not Gnu Emacs for every OS
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-07-08 11:57:44 bingalls>
;;$Id: e-xemacs.el,v 1.22 2003/05/24 17:37:01 bingalls Exp $

;;__________________________________________________________________________
;;TABLE OF CONTENTS
;;	Legal
;;	Commentary (Description)
;;	Code
;;	Defcustoms
;;	v21.2 Requirements
;;	Display & Menu
;;		Customize A Popup Menu
;;		Customize The Menu
;;		Font Faces
;;		Mouse Click URLs
;;		Emacs Lisp Menu
;;		Function Menu
;;		Enable Xemacs Menu Items
;;	Keys
;;	Paren/Bracket/Brace Matching
;;	Address/Telephone Book
;;	Remote Editing & Ftp Interface
;;	Auto Minibuffer (Status Line) Sizing
;;	Gnu Server
;;	Internet Relay Chat
;;	Telnet
;;	Tile Child Subwindows/Minibuffers Vertically
;;	Tiny Tools
;;	Toggle Menubar Function
;;	Toggle Modeline Function
;;	Toggle Toolbar Function
;;	Misc
;;	query-selected-replace
;;	yank-line

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file.  XEmacs routines for every OS

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		xemacs

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;;; Defcustoms
(defgroup e-xemacs nil "Settings from e-xemacs.el file." :group 'emacro)

;;__________________________________________________________________________
;;;; v21.2 Requirements
;;These are provided automatically in older versions
(require 'view-less)
(require 'cus-edit)                     ;Editing under M-x customize
(require 'help-macro)
(autoload 'info "info" "info" t)
(autoload 'hyper-apropos "hyper-apropos" "hyper-apropos" t)

;;__________________________________________________________________________
;;;;	Display & Menu
(defvar cache-big-menubar)		;shut up compiler
(cache-locate-library
 use-cache 'cache-big-menubar "big-menubar"
 "For complete XEmacs menu support, get big-menubar.el from full tarball distribution where you got XEmacs")
(when cache-big-menubar (require 'big-menubar))	;should be near beginning

;;shut up compiler
(autoload 'recent-files-initialize "recent-files" "recent file menu." t)
(defvar cache-recent-files)		;shut up compiler
(cache-locate-library
 use-cache 'cache-recent-files "recent-files"
 "For last opened files in menu support, get recent-files.el from full tarball distribution where you got XEmacs")

(when cache-recent-files
  (require 'dired)			;load before recent-files
  (require 'recent-files)		;open latest files from menu
  (setq recent-files-menu-path '("File")) ;make submenu of File, to save space

  (set-default 'recent-files-add-menu-before "Open...")
  (recent-files-initialize))

(cache-locate-library
  use-cache 'cache-a2ps-print "a2ps-print"
  "For clean source code printouts, get a2ps-print.el from <url: http://sf.net/projects/emacro/ >")

(when cache-a2ps-print
  (autoload 'a2ps-region "a2ps-print" "a2ps-print" t)
  (autoload 'a2ps-buffer "a2ps-print" "a2ps-print" t)
  (define-key function-key-map [f22] [print])
  (global-set-key [print] 'a2ps-buffer) ;f22 is Print Screen
  (global-set-key [(shift print)] 'a2ps-region)	;print selected text
  (add-menu-button '("File") ["a2ps Print Buffer" a2ps-buffer "--"]))

;;Remote printing example to put into postload.el:
;;(setq a2ps-command "ssh")
;;(setq a2ps-switches '("myHost" "a2ps" "-P" "myPSprinter" "--line-numbers=1"))

;;__________________________________________________________________________
;;;;;;		Customize A Popup Menu

;;EXPECT THIS CODE TO CHANGE IN FUTURE RELEASES!!!

(defun popup-commands ()
  "Show a popup menu of commands. See also `choose-from-menu'."
  (interactive)
  (eval-expression
   (popup-menu
    (cons
     "%_Menubar Menu"
     '(("Utils")
       [(concat "EMacro v" emacro-version) emacro-help]
       ["Goto Line" (call-interactively 'goto-line)]
       ["Redo" redo]
       ["Refresh Cache"	emacro-refresh-cache]
       ["Refresh colors" font-lock-fontify-buffer]
       ["Search files" (call-interactively 'grep)]
       ["Word completion" dabbrev-expand])))))

(define-key global-map [(shift button3)] 'popup-commands)
;;Alt F1 is also available:
;;(define-key global-map [(meta button1)] 'popup-commands)

;;__________________________________________________________________________
;;;;;;		Customize The Menu
;;See ~lisp/edit-utils/big-menubar.el for more examples
(add-menu-button '("Options") ["Toggle Toolbar" toggle-toolbar])

;;Load any user defined toolbar
(if (and (featurep 'toolbar)
	 (fboundp 'console-on-window-system-p)
	 (console-on-window-system-p)
	 (file-exists-p "~/.xemacs/.toolbar"))
    (load-file (expand-file-name "~/.xemacs/.toolbar")))

;;Place version at help menu; launches html help
(add-menu-button '("Help") `[,(concat "EMacro v" emacro-version) emacro-help])

(defvar cache-redo)			;shut up compiler
(cache-locate-library
 use-cache 'cache-redo "redo"
 "For restoring undo support, get redo.el from sumo tarball distribution where you got XEmacs")

(when cache-redo
  (require 'redo)
  (add-menu-button '("Tools" "Utils")
                   ["Redo"	redo]))

(add-menu-button '("Tools" "Utils")
		 ["Refresh Cache"	emacro-refresh-cache])
(add-menu-button '("Tools" "Utils")
		 ["Refresh colors"	font-lock-fontify-buffer])
(add-menu-button '("Tools" "Utils")
		 ["Word completion"	dabbrev-expand])

;; Add 'dired' to the File menu
(add-menu-button '("File") ["Edit Directory" dired] "Insert File...")

;;The old way?
;;(add-submenu
;; '("Tools")		;change this line to 'nil' for top level menu
;; '("Utils" ["Redo"	redo	t] )
;; "----"					;menu seperator
;; )

;;__________________________________________________________________________
;;;;;;		Font Faces
;;See x_custom.el, where these should be set
;;Sample font families: Fixed; Lucida Sans Typewriter; Interface User

;;(custom-set-faces
;;'(default ((t (:family "Screen" :size "14pt" :background "grey90"))) t))

;;__________________________________________________________________________
;;;;;;		Mouse Click URLs
;;See inet.el, where we define browse-url-at-mouse() to launch <url:...>
(defvar cache-overlay)
(cache-locate-library
 use-cache 'cache-overlay "overlay"
 "To Shift Middle-mouse click email addresses, get overlay.el from the full XEmacs sumo tarball")
(when cache-overlay
  (require 'overlay)
  (define-key global-map [(shift button2)] 'browse-url-at-mouse))

;;__________________________________________________________________________
;;;;;;		Emacs Lisp Menu
;;Enable compile from menu. Assumes emacs is in the path.
;;Note that starting another copy of emacs is not efficient, but at least
;;the menu does something relevant.
(add-hook
 'emacs-lisp-mode-hook
 (function
  (lambda ()
    (set (make-local-variable 'compile-command)
         (format "xemacs -batch -f batch-byte-compile %s" buffer-file-name)))))

;;__________________________________________________________________________
;;;;;;		Function Menu
;;menu to jump to any function definition
(defvar cache-func-menu)		;shut up compiler
(cache-locate-library
 use-cache 'cache-func-menu "func-menu"
 "For menu to jump to functions, get func-menu from sumo tarball distribution where you got XEmacs")

(when cache-func-menu
  (require 'func-menu)

  (define-key global-map 'f8 'function-menu)
  (add-hook 'find-file-hooks 'fume-add-menubar-entry)

;;Define keys for these XEmacs only function menu functions
  (define-key global-map "\C-cl" 'fume-list-functions)
  (define-key global-map "\C-cg" 'fume-prompt-function-goto))

;;__________________________________________________________________________
;;;;;;		Enable Xemacs Menu Items
;;especially for win32 XEmacs. More mature XEmacs handle this already
(autoload 'xbm-button-create "xbm-button" "Required by file open dialog." t)
(autoload 'make-annotation "xpm-mode" "Required by file open dialog box." t)
(autoload 'xpm-mode "xpm-mode" "Required by file open dialog box." t)

(autoload 'shell "shell" "Start a command prompt in a buffer." t)
(autoload 'shell-mode "shell" "Start a command prompt in a buffer." t)
(autoload 'comint-xemacs "comint-mode" "Keep font in shell buffer." t)

;;This autoloads ediff-mode. Adds to tools menu: compare, merge, patch
(defvar cache-ediff-hook)		;shut up compiler
(cache-locate-library
 use-cache 'cache-ediff-hook "ediff-hook"
 "For comparing & merging files support, get ediff-hook from the full XEmacs distribution")

(when cache-ediff-hook
  (require 'ediff-hook)
  (add-hook 'ediff-cleanup-hook 'ediff-janitor)) ;add this to gnu.el?

;;(load-library "pretty-print")	;Not in core xemacs distribution!
(autoload 'pp-function "pp" nil t)
(autoload 'pp-variable "pp" nil t)
(autoload 'pp-plist     "pp" nil t)
(autoload 'macroexpand-sexp "pp" nil t)
(autoload 'macroexpand-all-sexp "pp" nil t)
(autoload 'prettyexpand-sexp "pp" nil t)
(autoload 'prettyexpand-all-sexp "pp" nil t)

(autoload 'grep "igrep" "Add igrep text search to tools menu." t)
(autoload 'igrep "igrep" "Add igrep text search to tools menu." t)
;;middle or double mouse button click of grep results jumps you into file

;;__________________________________________________________________________
;;;;	Keys
;;(load-library "keyswap")
;;Toggle ^? (del) key to delete next key
(set-default 'delete-key-deletes-forward 't)

;;Old XEmacs cua-mode locks up when text is selected.
;;Be sure to use a recent release

(defvar cache-cua-mode)		;shut up compiler
(cache-locate-library
 use-cache 'cache-cua-mode "cua-mode"
 "For CUA key support, get new xemacs cua-mode.el version from <url:ftp://ftp.xemacs.org/pub/xemacs/contrib/cua-mode.el>")

(if cache-cua-mode
    (progn
      (require 'cua-mode)
      (CUA-mode t))
  (progn				;continue cua code block
    (defvar cache-pc-select)		;shut up compiler
    (cache-locate-library
     use-cache 'cache-pc-select "pc-select"
     "For shift-arrow selection support, get pc-select.el from full tarball distribution where you got Emacs")

    (when cache-pc-select
      (require 'pc-select)		;requires xemacs > v20.5
;;shut up compiler:
      (autoload 'pc-select-mode "pc-select" "Shift-Arrow highlight" t)
      (pc-select-mode t))		;Shift-Arrow highlighting
))					;end of cua code block

;;__________________________________________________________________________
;;;;;;		Cycle Buffers
;;Code also works in Emacs, but tabbar.el does this
;;ToDo: C-F6/C-S-F6 is the w32 keybinding way
(defvar cache-iswitchb)			;shut up compiler
(cache-locate-library
 use-cache 'cache-iswitchb "iswitchb"
 "To cycle buffers with Control (Shift) TAB, get iswitchb.el from <url:http://www.cns.ed.ac.uk/people/stephen/emacs/>")
(autoload 'pc-bufsw::bind-keys "pc-bufsw" "pc-bufsw" t)

(when cache-iswitchb
  (autoload 'iswitchb-buffer "iswitchb" "iswitchb" t)
  (global-set-key [(control tab)] 'iswitchb-buffer))

;;__________________________________________________________________________
;;;;	Paren/Bracket/Brace Matching
(autoload 'paren-set-mode "paren" "show matching parenthesis" t) ;quiet compile
(defvar cache-mic-paren)		;shut up compiler
(cache-locate-library
 use-cache 'cache-mic-paren "mic-paren"
 "For matching parenthesis, braces, etc. support, get paren.el and mic-paren.el from sumo tarball distribution where you got XEmacs")

(defvar cache-paren)			;shut up compiler
(cache-locate-library
 use-cache 'cache-paren "paren"
 "For matching parenthesis, braces, etc. support, get paren.el and mic-paren.el from sumo tarball distribution where you got XEmacs")

(cond (cache-mic-paren
       (require 'mic-paren)
       (set-default 'paren-face 'bold)
       (set-default 'paren-sexp-mode 'nil)
       (paren-activate))
      (cache-paren
       (require 'paren)
       ;;other modes on solaris XEmacs 21.1 leave annoying highlight ghosts.
       (paren-set-mode 'blink-paren)))

;;__________________________________________________________________________
;;;;	Address/Telephone Book Function
;;Gnu Emacs version provides (goto-address)
(global-set-key [(meta f3)] 'address-book)
(defun address-book ()
  "Opens .addressbook (with goto address support on gnu Emacs)."
  (interactive)  (find-file "~/emacs/addressbook"))

;;__________________________________________________________________________
;;;;	Email To Address At Cursor
;; Based on a defun by Kevin Rodgers <kevinr(at)ihs.com>
(autoload 'thing-at-point "thingatpt" "mouse enable object" t)
(autoload 'mail-abbrev-init-keys "mail-abbrevs" "mail abbrev." t)
(autoload 'mail "sendmail" "Mail." t)

(defvar email-regexp)                   ;shutup bytecompiler
(eval-when-compile
  (defun mail-to-address-at-point ()
    "*Edit a new mail message to the address at point."
    (interactive)
    (let ((url-at-point (substring (thing-at-point 'url) 7)))
      (if (string-match email-regexp url-at-point)
	  (mail nil url-at-point)
	(message "Bad email address")))))

;;__________________________________________________________________________
;;;;	Remote Editing & FTP Interface
;;Open with	C-x C-f		/username@host:/home/username/file.txt
(defvar cache-efs-auto)			;shut up compiler
(cache-locate-library
 use-cache 'cache-efs-auto "efs-auto"
 "For remote file editing support, get efs.el from full tarball distribution where you got XEmacs")

(when cache-efs-auto
  (require 'efs-auto)                   ;efs-auto autoloads efs.
  (defconst efs-default-user use-login-name) ;set in configure.el
;;Non-nil fixes EFS remote ~ backup perms
  (set-default 'backup-by-copying 't)
;;Nil also fixes EFS *~ backup perms
  (set-default 'efs-make-backup-files 'nil))

;;Find out which part of this causes grief under Cygwin, before re-enabling:
;;Use ncftp for your ftp program (allows using a proxy)
;;  (when (which "ncftp")
;;Regex to match FTP prompt
;;     (set-default 'efs-ftp-prompt-regexp "^.*ncftp.*>.*")
;;     (set-default 'efs-ftp-program-args 'nil)
;;     (set-default 'efs-ftp-program-name (which-first "ncftp"))

;;Uncomment this, if you see "No such file or directory, nslookup"
;;(setq efs-generate-anonymous-password use-email-addr)
;;    )

;;__________________________________________________________________________
;;;;	Auto Minibuffer (Status Line) Sizing
;;resize-minibuffer-mode auto resizes the minibuffer to hold its contents
(autoload 'resize-minibuffer-mode "rsz-minibuf" nil t) ;shut up compiler

(condition-case err
    (progn
      (resize-minibuffer-mode)
      (defconst resize-minibuffer-window-exactly nil)
      )                                 ;else
  (error
   (progn
     (message "Cannot resize minibuffer %s." (cdr err))
     (message "For support to minimize the other buffer, get rsz-minibuf.el from full tarball distribution where you got XEmacs"))))

;;alternate, from
;; <url:ftp://ftp.splode.com/pub/users/friedman/emacs-lisp/rsz-mini.el>
;;(require 'rsz-minibuf)

;;__________________________________________________________________________
;;;;	Gnu Server
;;keeps emacs running for faster restarts.
(when (featurep 'which)
  (if (or (which "gnuserv") (which "gnuservw"))
      (progn
	(defvar gnuserv-done-function)	;shut up compiler
	(set-default 'gnuserv-done-function 'bury-buffer)
	(require 'gnuserv)
	(gnuserv-start))
    ;;else
    (message "Make a link from gnuserv in ~lib/xemacs[ver]/[architecture] to PATH")))

;;__________________________________________________________________________
;;;;	Internet Relay Chat
(defvar cache-zenirc)			;shut up compiler
(cache-locate-library
 use-cache 'cache-zenirc "zenirc"
 "For IRC chat support, get zenirc from <url:http://www.xemacs.org/Download/index.html>")

(when cache-zenirc
  (autoload 'zenirc "zenirc" "Internet relay chat." t)
  (defcustom zenirc-server-default "irc.debian.org" "Default chat server." 
    :group 'e-xemacs
    :type 'string))

;;__________________________________________________________________________
;;;;	Telnet
;;(defconst ftelnet-program "/bin/telnet.exe")	;for w32
(autoload 'ftelnet "ftelnet" "telnet" t) ;requires xemacs > v20.5

;;__________________________________________________________________________
;;;;;;		Tile Child Subwindows/Minibuffers Vertically
(autoload 'cl "cl-add-hook" "cl lisp." t)

(defun display-buffers (buffers &optional horizontally)
  "Display BUFFERS in current frame tiled vertically.
If HORIZONTALLY is non-nil (prefix arg), tile horizontally."
  (interactive
   (list (loop for buff = (read-buffer "Buffer to display: " nil t)
           while (not (equal buff ""))
           collect buff)
         current-prefix-arg))
  (delete-other-windows)
  (when buffers
    (let* ((max (if horizontally
                    (window-width)
                  (window-height)))
           (min (if horizontally
                    window-min-width
                  window-min-height))
           (size (/ max (length buffers))))
      (or (<= min size)
          (error "Too many buffers to display simultaneously"))
      (switch-to-buffer (first buffers))
      (loop for buffer in (rest buffers)
        do
        (select-window (split-window nil size horizontally))
        (switch-to-buffer buffer)))))

;;__________________________________________________________________________
;;;;	Tiny Tools
;;ToDo: remove this deprecated tiny code
 (defvar cache-tinyurl)			;shut up compiler
 (cache-locate-library
  use-cache 'cache-tinyurl "tinyurl"
  "For support to click & launch urls, get tiny-tools from <URL:http://www.sourceforge.net/projects/tiny-tools/>")
;; (autoload 'tinyurl-mode "tinyurl" "tinyurl" t)

(cache-locate-library
 use-cache 'cache-advice "advice"
 "For browser support, get advice.el from full tarball distribution where you got XEmacs")
(autoload 'ad-add-advice "advice" "advice" t)
(defvar use-modem)			;shut up compiler

(when (and cache-advice (not (string= window-system "gtk")))
  (autoload 'tinyurl-mode "tinyurl" "click urls to lauch browser" t)
  (when cache-tinyurl
    (add-hook 'tinyurl-:load-hook  'tinyurl-install-to-packages)
    (autoload 'tinyurl-mode-1 "tinyurl" "click urls to lauch browser" t)
    (tinyurl-mode)
    (cond
     ((and use-net (not use-modem))
      (defconst tinyurl-:plugged-function '(lambda () t))))))

;;__________________________________________________________________________
;;;;	Toggle Menubar Function
(defun toggle-menubar () "Hide/display text menu (usually at top)."
  (interactive)
  (set-specifier
   menubar-visible-p
   (not (specifier-instance menubar-visible-p))))

;;__________________________________________________________________________
;;;;	Toggle Modeline Function
(defun toggle-modeline () "Hide/display status bar (usually at bottom)."
  (interactive)
  (set-specifier
   has-modeline-p
   (not (specifier-instance has-modeline-p))))

;;__________________________________________________________________________
;;;;	Toggle Toolbar Function
(defun toggle-toolbar () "Hide/display icons (usually at top)."
  (interactive)
  (set-specifier
   default-toolbar-visible-p
   (not (specifier-instance default-toolbar-visible-p))))

;;__________________________________________________________________________
;;;;	Misc
;;(defconst url-be-asynchronous t)	;Prevent waiting on W3 browser
(autoload 'ksh-mode "ksh-mode" "ksh mode." t)
;;(require 'ksh-mode)

(defvar cache-filladapt)		;shut up compiler
(cache-locate-library
 use-cache 'cache-filladapt "filladapt"
 "For comment wrapping, get filladapt.el from full tarball distribution where you got XEmacs")
(autoload 'filladapt-mode "filladapt" "filladapt" t)

(when cache-filladapt
  (require 'filladapt)                  ;Smart line wrapping of comments?
  (filladapt-mode t))

;;__________________________________________________________________________
;;;;	query-selected-replace
;;From: scott.frazer(at)ericsson.com 
(defun query-selected-replace ()
  "query-replace, using the selected region, if active, as source to be replaced.
Otherwise, prompt the user, as usual"
  (interactive "*")
  (let (from-to-list from-string to-string)
    (if (region-active-p)
        (progn
          (setq from-string (buffer-substring (region-beginning) (region-end)))
          (zmacs-deactivate-region)
          (goto-char (region-beginning))
          (setq to-string (read-from-minibuffer
                           (format "Query replace %s with: " from-string)
                           nil nil nil 'query-replace-history))
          (progn
            (setq from-to-list (query-replace-read-args "Query replace" nil))
            (setq from-string (nth 0 from-to-list))
            (setq to-string   (nth 1 from-to-list))))
      (query-replace from-string to-string)))
  (global-set-key [(meta %)] 'query-selected-replace)) ;override original bind

;;__________________________________________________________________________
;;;;		yank-line
(defun yank-line () "copies current line. Should be merged with gnu emacs ver"
  (interactive)
  ;;This next line moves you to the beginning of line.
  (beginning-of-line)
  ;;Otherwise, this would just copy to end of line
  (call-interactively 'mark-end-of-line)
  (copy-primary-selection))

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

(provide 'e-xemacs)
;;; xemacs.el ends here
