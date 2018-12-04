;;; e-common.el --- Enhancements for both GNU and X Emacs on all platforms
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-04-28 14:42:23 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-common.el,v 1.22 2003/05/24 17:37:00 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Applications
;;		Calendar
;;		Dictionary
;;		Power Macros
;;		Spell Checker
;;		Tiny Tools
;;	Beginner's Settings
;;	Devices
;;		Alternate Character Set
;;		Mouse Set Up
;;		Printer Set Up
;;	Display Setup
;;		Cycle Buffers
;;		Horizontal Scroll Bar
;;		Menu
;;	File Handling
;;		Backups in ~/.backups Directory
;;		Compressed Files
;;			Bzip Compressed Files
;;		Locate Library
;;	Modes
;;		Completions
;;		Info Mode Font Locking/Syntax Coloring
;;		Info Path Appending
;;		Shell
;;		Word Completion / Dabbrev
;;		Word Wrap / Auto-Fill
;;	Misc
;;		Tiny Replace
;;		Force Single Space After Each Period
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;;; Commentary:
;;Emacs editor startup file.  Power User routines for every OS, for both Gnu &
;;X Emacs

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;;; Keywords:		advanced power user enhanced miscellaneous applications

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;;; Defcustoms
(defgroup e-common nil "Settings from e-common.el file." :group 'emacro)

(defcustom calendar-startup t "Display diary when starting EMacro."
  :group 'e-common
  :type 'boolean)

(defcustom scalable-fonts-allowed t "Nil, t, or Regex list of allowed fonts."
  :group 'e-common
  :type 'boolean)

(defcustom font-menu-ignore-scaled-fonts nil "Mostly for XEmacs?"
  :group 'e-common
  :type 'boolean)

;;__________________________________________________________________________
(require 'which)
(cache-locate-library
 use-cache 'cache-dired "dired"
 "For file directory support, get dired.el from full XEmacs sumo tarball")
(when cache-dired (require 'dired))

(require 'cus-edit)

;;__________________________________________________________________________
;;;;	Applications
;;__________________________________________________________________________
;;;;;;		Calendar
(set-default 'mark-holidays-in-calendar 't)

;;(add-hook diary-display-hook 'fancy-diary-display)
;;ToDo: fancy-diary-display with one-frame causes errors on Emacs v21.2.1

(set-default 'calendar-setup 'one-frame)
(set-default 'today-visible-calendar-hook 'calendar-mark-today)
(autoload 'calendar "calendar" "Display 3-month calendar." t)

;;(setq calendar-latitude 40.7)		;New York City
;;(setq calendar-longitude -73.9)	;New York City, EDT


(cache-locate-library
 use-cache 'cache-appt "appt"
 "For appointment support, get appt.el from full sumo XEmacs tarball")

(when cache-appt
  (require 'appt)
  (appt-check)
  (add-hook 'diary-hook 'appt-make-list))

;;Check your diary when starting Emacs
(when (and calendar-startup (file-exists-p diary-file))
  (let ((inhibit-redisplay t))
    (save-window-excursion
      (calendar)
      (mark-diary-entries)
      (diary))))

;;See i18n for European calendar style

;;__________________________________________________________________________
;;;;;;		Dictionary
(cache-locate-library
 use-cache 'cache-dictionary "dictionary"
 "For dictionary support, get dictionary.el from <url:http://me.in-berlin.de/~myrkr/dictionary/> or <url:http://www.dict.org>")

(when cache-dictionary
  (defcustom dictionary-server "localhost" "URI of online dictionary."
    :group 'e-common
    :type 'string)
  (global-set-key [(alt m)] 'dictionary-match-words)
  )

;;__________________________________________________________________________
;;;;;;		Power Macros
;;Improved library to record keystrokes, et. al.
;;To configure, 'M-x customize-group RET power-macros'
;;<url:http://www.imada.sdu.dk/~blackie/emacs/>
(autoload 'power-macros-mode "power-macros-mode" "power macros" t)

;;Jaari Alto's macro tool assigns F9 & C-F9 :
(autoload 'tinymacro-end-kbd-macro-and-assign  "tinymacro" t t)

;;__________________________________________________________________________
;;;;;;		Spell Checker
;;Find ispell in PATH. Note that version 3.x is more recent than v4!
(cond ((which "ispell")
       (progn
	 (defcustom ispell-el "ispell" "Program name of spell checker."
	   :group 'e-common
	   :type 'string)))
      ((which "ispell4")
       (defcustom ispell-el "ispell4" "Program name of spell checker."
	 :group 'e-common
	 :type 'string))
      (t (message "For spell-check support, get ispell. See emacs.html for sources")))

;;__________________________________________________________________________
;;;;;;		Tiny Tools
;;Enhancements to programming, search/replace, email and much more
(cache-locate-library
 use-cache 'cache-tiny-setup "tiny-setup"
 "For overall enhancement, get tiny-tools from <url: http://tiny-tools.sourceforge.net>")
(when cache-tiny-setup (require 'tiny-setup))

;;__________________________________________________________________________
;;;;	Beginner's Settings
;;These variables may make emacs easier to pick up.
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(setq enable-recursive-minibuffers t)
(put 'eval-expression 'disabled nil)

(put 'query-replace-highlight 'standard-value (list 't))
(put 'search-highlight 'standard-value (list 't))

;;enable converting selected text to lower case by default
(put 'downcase-region 'disabled nil)
;;enable converting selected text to upper case by default
(put 'upcase-region 'disabled nil)

;;__________________________________________________________________________
;;;;	Devices

;;__________________________________________________________________________
;;;;;;		Mouse Set Up
;;(setq mouse-yank-at-point 't)	;Paste at text point NOT at mouse cursor

;; Scroll Bar gets dragged by mouse butn 1
(global-set-key [vertical-scroll-bar down-mouse-1] 'scroll-bar-drag)

;; Rebind mouse-2 events to mouse-1 in various places:
;; Completion list
(add-hook 'completion-list-mode-hook
          '(lambda() (define-key completion-list-mode-map [down-mouse-1]
                       'mouse-choose-completion)))
;; TexInfo
(add-hook 'Info-mode-hook
          '(lambda() (define-key Info-mode-map [down-mouse-1]
                       'Info-mouse-follow-nearest-node)))
;; Buffer Menu
(add-hook 'buffer-menu-mode-hook
          '(lambda() (define-key Buffer-menu-mode-map [down-mouse-1]
                       'Buffer-menu-mouse-select)))

;;(global-unset-key [mouse-2])	;disable intellimouse wheel

;;__________________________________________________________________________
;;;;;;		Printer Set Up
(cache-locate-library
 use-cache 'cache-lpr "lpr"
 "For printing support, get lpr.el from full XEmacs sumo tarball")
(when cache-lpr
  (autoload 'lpr-buffer "lpr" "lpr print." t)
  (autoload 'lpr-region "lpr" "lpr print." t))

;;XEmacs can't handle this:
;;(cache-locate-library
;; use-cache 'cache-tinylpr "tinylpr"
;; "For printers menu, get tinylpr from <url: http://tiny-tools.sourceforge.net/ >")
;;(when cache-tinylpr (require 'tinylpr))

;;__________________________________________________________________________
;;;;	File Handling
;;(setq auto-save-directory (expand-file-name "~/.autosave/"))
;;(require 'auto-save)

;;__________________________________________________________________________
;;;;;;		Backups in ~/.backups Directory
(defvar cache-ebackup)		;shut up compiler
(cache-locate-library
 use-cache 'cache-ebackup "ebackup"
 "To put all your *~ backups into ~/.backup, get ebackup.el from <url:http://relativity.yi.org/el/>")

;;Need to find out why this code does not work with gnuserv on w32
;;v1.3.1 hangs on some w32 systems
(when (and cache-ebackup
	   (not (or (string-match "windows" (symbol-name system-type))
		    (which "gnuclientw"))))
  (require 'ebackup)
  (defcustom make-backup-files t "Store backups in '~/.backup'."
    :group 'e-common
    :type 'boolean))

;;__________________________________________________________________________
;;;;;;		Compressed Files
;;XEmacs says that jka-compr is obsolete. However it is portable with Gnu
(defvar cache-jka-compr)		;shut up compiler
(cache-locate-library
 use-cache 'cache-jka-compr "jka-compr"
 "For compressed file support, get jka-compr.el from the full tarball distribution where you got emacs")

(condition-case err		;Handle any exceptions
    (autoload 'toggle-auto-compression "jka-compr" "auto decompress files" t)
  (error
    (autoload 'auto-compression-mode "jka-compr" "auto decompress files" t)))

(when cache-jka-compr
  ;;This doesn't autoload nicely, but it sometimes shuts up bytecompiler
  (require 'jka-compr)                  ;read compressed files
  (condition-case err		;Handle any exceptions
      (toggle-auto-compression t)
    (error
     (auto-compression-mode t))))          ;automatically decompress files
(autoload 'archive-mode "arc-mode" "Major mode for editing archives." t)
(autoload 'tar-mode "tar-mode" "Major mode for editing Tape ARchives." t)

(when (which "unzip")
  (put 'archive-zip-use-pkzip 'standard-value (list 'nil)))

;;Discard stderr compression output. Always nil for w32.
(put 'jka-compr-use-shell 'standard-value (list 'nil))

;;__________________________________________________________________________
;;;;;;;;		Bzip2 Compressed Files
(defvar Info-suffix-list)
(defun setup-bzip2 () "Read bzip2 compressed info files."
  (progn
    (nconc Info-suffix-list '((".info.bz2" . "bzip2 -dc %s")))
    (nconc Info-suffix-list '((".bz2" . "bzip2 -dc %s")))))
(add-hook 'Info-mode-hook 'setup-bzip2)

;;__________________________________________________________________________
;;;;;;;;		Locate Library
;;Gives Emacs tab-completion for load-library() as in XEmacs
(autoload 'ilocate-library "ilocate-library" "Tab complete `load-library'." t)
(autoload 'ilocate-load-library "ilocate-library"
  "Tab complete `load-library'." t)

;;__________________________________________________________________________
;;;;	Display Setup
;;Filename alone fits into icon. 'Emacs - %f' shows full path.
(put 'icon-title-format 'standard-value (list "Emacs - %b"))

(defconst system-name (system-name))
;;Host:/path/[filename | nonfile-mode] in title bar. Mode=*shell*,*grep*,etc.
(put 'frame-title-format 'standard-value
     (list '(" " system-name ":" default-directory " %12b")))

(column-number-mode t)			;column number in modeline (status)
(line-number-mode t)			;line number in modeline (status bar)
(autoload 'display-time "time" "clock in status bar" t) ;shut up compiler

(defvar cache-time)			;shut up compiler
(cache-locate-library
 use-cache 'cache-time "time"
 "For clock display support, get time.el from the full tarball distribution where you got emacs")

(when cache-time
  (require 'time)
  (display-time))			;clock (sometimes in status bar)

;;See i18n for European/Military style time

(defvar use-left)			;shut up compiler
(defvar use-top)			;shut up compiler
(defvar use-height)			;shut up compiler
;;Position emacs, unless this is an ascii terminal
(when window-system
  ;;If this does not set emacs height, then try it twice:
  (set-frame-height (selected-frame) use-height))

;;Prevent passwords in M-x shell from being seen.
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;;Default display of status bar.
;;May be overridden by jde-mode-line-format and other modes.
(put
 'default-mode-line-format 'standard-value
 (list
  '("-"
    (line-number-mode "L%l--")
    (column-number-mode "C%c--")
    mode-line-mule-info mode-line-modified
    mode-line-frame-identification mode-line-buffer-identification
    "   " global-mode-string "   %[(" mode-name mode-line-process
    minor-mode-alist "%n" ")%]--"
    (which-func-mode ("" which-func-format "--"))
    "-%-")))

;;__________________________________________________________________________
;;;;;;		Horizontal Scroll Bar
;;ToDo: turn this into a cache-locate-library & defcustom option
;;These routines prevent line wrap-around (marked by continuation glyphs/chars)
;;(load-library "scroll-mode")
;;(setq-default auto-show-mode t)
;;(toggle-horizontal-scroll-bar t)	;;Might not yet be available.

;;__________________________________________________________________________
;;;;;;		Menu
(if (string-match "XEmacs" emacs-version)
    (progn
      (setq file-menu '("File"))
      (setq help-menu '("Help"))
      (setq tools-menu '("Tools")))
  (progn				;else Emacs
    (setq file-menu '("files"))
    (setq help-menu '("help"))
    (setq tools-menu '("tools"))))

;;Note that ps2pdf might not be installed
(defun save-current-buffer-as-pdf ()
  "Export pretty-printed file to PDF format."
  (interactive)
  (ps-print-buffer-with-faces (concat (buffer-file-name) ".ps"))
  (shell-command (concat "ps2pdf " (buffer-file-name) ".ps"))
  (delete-file (concat (buffer-file-name) ".ps"))
  (message "Done"))

(defvar cache-htmlize)			;shut up compiler
(cache-locate-library
 use-cache 'cache-htmlize "htmlize"
 "To export as HTML, get htmlize.el from <url:http://fly.srk.fer.hr/~hniksic/emacs/htmlize.el>")

(when cache-htmlize (require 'htmlize))

(easy-menu-change file-menu
		  "Export As"
		  (list
		   ["PDF" save-current-buffer-as-pdf
		    (if (which "ps2pdf") t nil)] ;enable only if in PATH
		   ["HTML" htmlize-buffer
		    (if cache-htmlize t nil)]
		   ))

(easy-menu-change tools-menu
		  "Utils"
		  (list
		   ["Redo" redo t]
		   ["Refresh colors" font-lock-fontify-buffer t]
		   ["View Mail" vm t]
		   ))

(easy-menu-change tools-menu
		  "Macros"
		  (list
		   ["Start Macro Recording" start-kbd-macro t]
		   ["Stop Macro Recording" end-kbd-macro t]
		   ["Execute Last Macro" call-last-kbd-macro t]
		   ["Name Last Macro" name-last-kbd-macro t]
		   ["Assign Key to Named Macro" global-set-key t]
		   ))

;;__________________________________________________________________________
;;;;	Modes

;;__________________________________________________________________________
;;;;;;		Completions
(cache-locate-library
 use-cache 'cache-icomplete "icomplete"
 "For improved tab completion, get icomplete.el from EMacro Libs <url: http://emacro.sf.net/ >")

(when cache-icomplete
  (require 'icomplete)
  (icomplete-mode))

;;Klaus Berndl	<klaus.berndl(at)sdm.de>
;;We want to complete and expand as much as possible in all buffers.
;;Order of try-functions is significant! Includes the whole dabbrev-stuff.
(defvar cache-hippie-exp)		;shut up compiler
(cache-locate-library
 use-cache 'cache-hippie-exp "hippie-exp"
 "For word completion support, get hippie-exp.el from full XEmacs sumo tarball")
(autoload 'hippie-expand "hippie-exp" "hippie-exp" t)

(when cache-hippie-exp
  (require 'hippie-exp)
  (setq hippie-expand-try-functions-list
        '(
          ;;try-complete-tempo-tag	;not active for me
          try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-file-name-partially
          try-complete-file-name
          ;;        try-expand-list
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol
          try-expand-whole-kill))
  ;; the expand-function. Called with a positive prefix <P> it jumps direct
  ;; to the <P>-th try-function.
  (defun my-hippie-expand (arg)
    (interactive "P")
;;hippie-expand doesn't have customization-feature (like dabbrev-expand) to
;;search case-sensitive for completions. So set 'case-fold-search' temp to nil
    (hippie-expand arg))
  ;;C-/ is taken, so this is S-C-/
  (global-set-key [(control \?)] (quote my-hippie-expand)))

;;__________________________________________________________________________
;;;;;;		Info Mode Font Locking/Syntax Coloring
(defvar info-font-lock-keywords
  (list
   '("^\\* [^:]+:+" . font-lock-function-name-face)
   '("\\*[Nn]ote\\b[^:]+:+" . font-lock-reference-face)
   '("  \\(Next\\|Prev\\|Up\\):" . font-lock-reference-face))
  "Additional expressions to highlight in Info mode.")

(add-hook 'Info-mode-hook
          (lambda ()
            (make-local-variable 'font-lock-defaults)
            (defconst font-lock-defaults '(info-font-lock-keywords nil t))))

;;__________________________________________________________________________
;;;;;;		Info Path Appending
;;(setq Info-directory-list
;;      (append '("/usr/local/lib/info")
;;	      (or (and (boundp 'Info-directory-list)
;;		       Info-directory-list)
;;		  (and (boundp 'Info-default-directory-list)
;;		       Info-default-directory-list)
;;		  (list Info-directory))))

;;Alternate:
;;(setq Info-default-directory-list
;;      (cons "c:/cvs/doc/cvsclient.texi" Info-default-directory-list))

;;__________________________________________________________________________
;;;;;;		Shell
;;Use .emacs_shellname for the shells rc file
;;For XEmacs, this requires ansi-color v3.3 or higher.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" "ansi-color" t)
(defvar cache-ansi-color)		;shut up compiler
(cache-locate-library
 use-cache 'cache-ansi-color "ansi-color"
 "For color in your M-x shell, get ansi-color from <url:http://www.gnu.org/>")

(when cache-ansi-color
  (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on))

;;__________________________________________________________________________
;;;;;;		Word Completion / Dabbrev
;;causes M-/ to fill in the rest of a word
;;optional package for XEmacs in sumo tarball
(autoload 'dabbrev-expand "dabbrev" "M-/ fills in the rest of a word" t)
(autoload 'dabbrev-completion "dabbrev" "M-/ fills in the rest of a word" t)

;;Grab word completion vocabulary from all active sessions.
(put 'dabbrev-always-check-other-buffers 'standard-value (list 't))
;;Regular expression to capture word completions.
(put 'dabbrev-abbrev-char-regexp 'standard-value (list "\\sw\\|\\s_"))

(autoload 'quietly-read-abbrev-file "abbrev" "word completion" t)
(autoload 'abbrev-mode "abbrev" "word completion" t)

;;From emacs faq. See it, to learn more.
(condition-case () (quietly-read-abbrev-file) (file-error nil))
(add-hook 'text-mode-hook (function (lambda () (setq abbrev-mode t))))

;;abbrev
(autoload 'read-abbrev-file "abbrev" "word completion" t)
;;(defconst abbrev-file-name "~/.abbrev_defs")	;default from write-abbrev-file
(if (file-exists-p abbrev-file-name)
    (read-abbrev-file))

;;__________________________________________________________________________
;;;;	Word Wrap / Auto-Fill
;;Set the column to break words at
(set-default 'fill-column '79)

;;__________________________________________________________________________
;;;;	Misc
;;Prevent Emacs (not a XEmacs problem) from appending, when moving down at EOF
(put 'next-line-add-newlines 'standard-value (list 'nil))

(cache-locate-library
 use-cache 'cache-speedbar "speedbar"
 "For fast file menu support, get speedbar from <URL:http://www.ultranet.com/~zappo/speedbar.shtml>")

(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)

(fset 'yes-or-no-p 'y-or-n-p)		;replace y-e-s by y
(defalias 'yes-or-no-p 'y-or-n-p)

;;(setq tex-dvi-view-command "xdvi")

(setq-default scalable-fonts-allowed 't)
;;__________________________________________________________________________
;;;;;;		Force Single Space After Each Period
(put 'sentence-end 'standard-value
     (list "[.?!][]\"')}]*\\($\\|[ \t]\\)[ \t\n]*"))
(put 'sentence-end-double-space 'standard-value (list 'nil))

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

(provide 'e-common)

;;; e-common.el ends here
