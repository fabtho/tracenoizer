;;;; e-c.el --- C/C++ support for gnu and x emacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-04-18 11:16:11 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-c.el,v 1.20 2003/05/24 17:37:01 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	C/GTK/Gnome Syntax
;;	QT/KDE Syntax
;;	Doxygen Doc Comments
;;	Load Header Files
;;	Tags: Find C Declarations & Refs Fast
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file. C/C++ support for every OS.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		program mode ide

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-c nil "Settings from e-c.el file." :group 'emacro)
(require 'font-lock)

;;__________________________________________________________________________
;;;;			C/GTK/Gnome Syntax
;;Syntax color for GLIB datatypes
;;DEPRECATE: e-c-font-lock-keywords-3 is from obsolete c-mode
(if cache-cc-mode
    (require 'cc-mode)
;;It appears that c-C-extra-toplevel-kwds doesn't allow regexes.
;;Unsure how to translate former regexes FILE\\sw+_t and [A-Z]\\sw*[a-z]\\sw*
    (defvar c-C-extra-toplevel-kwds
	  (concat c-C-extra-toplevel-kwds
"\\|gboolean\\|gfloat\\|gdouble\\|gpointer\\|gconstpointer\\|gchar\\|gshort\\|glong\\|gint\\|gint8\\|gint16\\|gint32\\|gint64\\|guchar\\|gushort\\|gulong\\|guint\\|guint8\\|guint16\\|guint32\\|guint64"))
;;Else obsolete mode:
  (defvar c-font-lock-keywords-3
    (append
     '("FILE" "\\sw+_t"
       "gboolean" "gfloat" "gdouble"	; aliases for int, float, double
       "gpointer" "gconstpointer"	; aliases for void *, const void *
       "gu?\\(char\\|short\\|long\\)"	; aliases for various integer types
       "gu?int\\(8\\|16\\|32\\|64\\)?"	; aliases for uint8_t and friends
       "[A-Z]\\sw*[a-z]\\sw*"	   ; mark capitalized mixed-case words as types
       c-font-lock-keywords-3))))

;;__________________________________________________________________________
;;;;			QT/KDE Syntax
;;DEPRECATE: e-c-font-lock-keywords-3 is from obsolete c-mode
(cache-locate-library
 use-cache 'cache-cc-mode "cc-mode"
 "To load C header files, get cc-mode.el from the full sumo XEmacs tarball")

(if cache-cc-mode
;;It appears that c-C-extra-toplevel-kwds doesn't allow regexes.
;;Unsure how to translate former regexes FILE\\sw+_t and [A-Z]\\sw*[a-z]\\sw*
    (defvar c-C++-extra-toplevel-kwds
	  (concat c-C++-extra-toplevel-kwds "\\|signals\\|slots"))
;;Else obsolete mode:
  (defvar c-font-lock-keywords-3
    (append '("signals" "\\(public\\|protected\\|private\\) slots")
	    c-font-lock-keywords-3)))

;;__________________________________________________________________________
;;;;		C/C++  Hooks
(defvar tags-table-list)
(setq tags-table-list (append '(".") (list emacro-top-dir)))
;;Location for C/C++ program variables

;;This section is a compile warning fix, only for win32 XEmacs 21.1. See below
;;This is a fix for problems between delbackspace & cc-mode
;;(setcar (assoc "cc-mode" after-load-alist) "cc-langs")

(defvar c-font-lock)
(defvar c++-font-lock)
(setq c-font-lock t)			;Enable C syntax coloring
(setq c++-font-lock t)			;Enable C++ syntax coloring

(autoload 'imenu-add-menubar-index "imenu" "gnu emacs function menu" t)

(defvar c-site-default-style)
(setq c-site-default-style "local")	;Set new C editing defaults
(setq c-file-style "local")		;Set new C editing defaults

;;This is set in programmer.el
;;(defconst c-basic-offset use-indent)

(add-hook
 'c-mode-hook
 (function
  (lambda ()
    (local-set-key "\C-c:" 'uncomment-region)
    (local-set-key "\C-c;" 'comment-region)
    (imenu-add-menubar-index))))

(add-hook
 'c++-mode-hook
 (function
  (lambda ()
    (local-set-key "\C-c:" 'uncomment-region)
    (local-set-key "\C-c;" 'comment-region)
    (imenu-add-menubar-index))))

;;__________________________________________________________________________
;;;;		Doxygen Doc Comments
;;ToDo: test this
;;(defun my-doxymacs-font-lock-hook ()
;;   (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;       (doxymacs-font-lock)))
;; (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;;__________________________________________________________________________
;;;;		Load Header Files
(defvar cache-ffap)			;shut up compiler
(cache-locate-library
 use-cache 'cache-ffap "ffap"
 "To load C header files, get ffap.el from full sumo tarball distribution where you got XEmacs")
(when cache-ffap
  (require 'ffap)

  (add-to-list 'ffap-c-path "/usr/include")
  (add-to-list 'ffap-c-path "/usr/local/include")

  ;;3 ways of grabbing the INCLUDE path, roughly in order of best to worst:
  ;;Be sure to test that INCLUDE environment variable is set!
  ;;(setq ffap-c-path (append (parse-colon-path (getenv "INCLUDE"))
  ;;                          ffap-c-path))

  ;;(require 'cl)
  ;;(dolist (x (split-string (getenv "INCLUDE") ":"))
  ;;  (add-to-list 'ffap-c-path x))

  ;;(mapcar
  ;;  (lambda (x)
  ;;    (add-to-list 'ffap-c-path x))
  ;;  (parse-colon-path (getenv "INCLUDE")))

  )                                     ;end when ffap


;;__________________________________________________________________________
;;;;;;		Tags: Find C Declarations & References Fast
;;note: this section need to be before the C language preference so that
;;my-C-find-tag-default can piggy-back off of etags' find-tag-default
;; tweak tags library so that syntax is chosen from first file in tags file
;;(require 'etags)


;; (autoload 'etags "etags" "find variable declarations." t)


;;This section has byte-compile problems on v20.2
;;(autoload 'find-tag-default "etags" "find variable declarations." t)

;;(defun my-C-find-tag-default ()
;;  "If on a #include line, use the included file as the tag."
;;  (or (save-excursion
;;        (beginning-of-line)
;;        (if (looking-at
;;             "^[ \\t]*#[ \\t]*include[ \\t]*[<\"]\\([^>\"]+\\)[>\"]")
;;            (match-string 1)))
;;      (find-tag-default)))

;;(defvar tags-table-format-hooks)

;;(defconst librarys-recognize-table 
;;      (car tags-table-format-hooks))
;;(setcar tags-table-format-hooks
;;        '(lambda ()     "DOCUMENT ME!"
;;           (if (funcall librarys-recognize-table)
;;               (set-syntax-table
;;                (save-excursion
;;                  (goto-char (point-min))
;;                  (search-forward "\f\n")
;;                  (set-buffer (find-file-noselect (file-of-tag)))
;;                  (syntax-table)))
;;             nil)))

(defun re-search-forward-sensitive (REGEXP &optional BOUND NOERROR COUNT)
  "Wrap 're-search-forward'.
A local bind of 'case-fold-search' to nil now forces a case-sensitive search.
Argument REGEXP is a regular expression.
Optional argument BOUND DOCUMENT ME!
Optional argument NOERROR DOCUMENT ME!
Optional argument COUNT DOCUMENT ME!"
  (let ((case-fold-search nil))
    (re-search-forward REGEXP BOUND NOERROR COUNT)))

(defvar tags-loop-scan)
(defvar tags-loop-operate)
(defun my-tags-search (arg regexp &optional file-list-form)
  "Prefix ARG will force case-sensitivity.
Search through all files listed in tags table for match for REGEXP.
Stops when a match is found.  To continue searching for next match, use command
        \\[tags-loop-continue].
See documentation of variable 'tags-file-name'.
Optional argument FILE-LIST-FORM DOCUMENT ME!"
  (interactive "P\nsTags search (regexp): ")
  (let ((search-function (if arg 're-search-forward-sensitive
                           're-search-forward)))
    (if (and (equal regexp "")
             (eq (car tags-loop-scan) search-function)
             (null tags-loop-operate))
        ;; Continue last tags-search as if by M-,.
        (tags-loop-continue nil)
      (setq tags-loop-scan
            (list search-function (list 'quote regexp) nil t)
            tags-loop-operate nil)
      (tags-loop-continue (or file-list-form t)))))

(global-set-key "\C-x," 'my-tags-search)

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

(provide 'e-c)
;;; e-c.el ends here
