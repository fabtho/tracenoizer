;;;; e-path.el --- Define user variables.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-07-06 12:56:56 bingalls>
;;$Id$

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;See file COPYING for license. This file is not (yet) part of Emacs nor XEmacs

;;__________________________________________________________________________
;;; Commentary:
;;This file tells emacs, and the *BatchCompile scripts where to find elisp
;;library macro files
;;Users may need to edit this file. It is shipped with suggested possible
;;paths; it is OK if they do not exist.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url:http://emacro.sourceforge.net/>
;;<url:http://www.dotemacs.de/>
;;; Change Log:		See ChangeLog history file
;;; Keywords:		user load-path configuration setup environment

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-path nil "Settings from e-path.el file." :group 'emacro)

;;__________________________________________________________________________
;;;;	Custom Variables
;;Tell load-library & require where to search
;;ToDo: consolidate this with .emacs:
(when (not (boundp 'emacro-top-dir))
;;  (setq emacro-top-dir (concat (expand-file-name "~") "/emacs/")))
	   (defcustom emacro-top-dir (concat (expand-file-name "~") "/emacs/")
	     "Absolute path where all EMacro files are."
	     :group 'emacs
	     :type 'string))

(defcustom emacro-code-dir (concat emacro-top-dir "emacro/")
  "Relative path where main e-*.el elisp files are."
  :group 'e-path
  :type 'string)

(defcustom emacro-pkg-dir (concat emacro-top-dir "packages/") 
  "Relative path where external add-on *.el elisp files are."
  :group 'e-path
  :type 'string)

;;	End of Custom Variables
;;__________________________________________________________________________

(add-to-list 'load-path emacro-code-dir)
(require 'e-functions)

;;(require 'loaddefs)		;defines custom-file
(defvar use-cache 'nil)
(cond
 ((string-match "GNU" (emacs-version))
  (setq use-cache (concat emacro-top-dir "preferences/e-cache.el"))
  (setq custom-file (concat emacro-top-dir "preferences/e-custom.el"))

  (add-to-list 'load-path (concat emacro-pkg-dir "w3/lisp"))
  (add-to-list 'load-path (concat emacro-pkg-dir "w3/contrib"))
  )
 ((string-match "XEmacs" (emacs-version))
  (setq use-cache (concat emacro-top-dir "preferences/e-xcache.el"))
  (setq custom-file (concat emacro-top-dir "preferences/e-xcustom.el"))

  (add-to-list 'load-path "/usr/share/xemacs/site-lisp")
  ))

(when (file-exists-p use-cache) (load-library use-cache))

;;__________________________________________________________________________
;;Put your new .el files in emacs/packages/
;;__________________________________________________________________________
;;;;	Load Paths
;;Tell load-library to search your emacs directory. Add personal .el paths here
;;Included are sample locations to install packages. Note that these are
;;prepended, and could mask *.el files from your distribution.

;;This might be added twice, to accomodate e-[x]compile scripts & regular use:
(add-to-list 'load-path emacro-top-dir)

;;Add the emacro directories:
(add-to-list 'load-path (concat emacro-top-dir "preferences"))
(add-to-list 'load-path (concat emacro-top-dir "programmer"))
(add-to-list 'load-path (concat emacro-top-dir "i18n"))

;;postpend EMacro Libs
(setq load-path (append load-path (list "/usr/share/elisp")))

(add-to-list 'load-path emacro-pkg-dir)

;;Many of these are available in EMacro Libs
;;(add-to-list 'load-path (concat emacro-pkg-dir "bbdb/lisp"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "eieio"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "elib"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "html"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "jde/lisp"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "mmm-mode"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "psgml"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "semantic"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "speedbar"))
(add-to-list 'load-path (concat emacro-pkg-dir "tiny-tools/lisp/tiny"))
(add-to-list 'load-path (concat emacro-pkg-dir "tiny-tools/lisp/other"))
;;The following line will be deprecated in the future:
;;(add-to-list 'load-path (concat emacro-pkg-dir "tiny-tools/lisp"))

(add-to-list 'load-path (concat emacro-pkg-dir "tramp/lisp"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "vm"))
(add-to-list 'load-path (concat emacro-pkg-dir "w3m"))

;;(add-to-list 'load-path (concat emacro-pkg-dir "esheet"))
;;(add-to-list 'load-path (concat emacro-pkg-dir "xae/lisp"))


;;Find & remove duplicate libs with 'M-x list-load-path-shadows'
;;An alternate solution follows, which you likely won't use.
;;Postpend to load-path, so the jde bundled with xemacs will first get used:
;;(setq load-path (append load-path (list (concat emacro-pkg-dir "jde/lisp"))))

(defcustom e-path nil
  "Custom path to add to load-path."
    :group 'e-path
    :set (lambda (sym val)
	   (dolist (dir load-path)
	     (add-to-list 'val dir))
	   (set-default sym (reverse val)))
    :type '(repeat directory))

(append load-path e-path)

(provide 'e-path)

;;; e-path.el ends here
