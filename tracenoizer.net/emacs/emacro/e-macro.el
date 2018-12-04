;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-07-09 12:20:40 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-macro.el,v 1.24 2003/05/24 17:37:01 bingalls Exp $

(defconst emacro-version "2.8.1")

;;__________________________________________________________________________
;;;;TABLE OF CONTENTS
;;	Legal
;;	Commentary (Description)
;;	History
;;	Archive Entry
;;	Code
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;;;	Commentary
;;Emacs editor startup file. This is the very first startup file
;;Don't edit this file. Edit the files in ~/emacs, which precompile for speed.
;;See "Code" below.

;;Limit your editing of this file, as it is due to change in the future.
;;Instead, put your customizations in ~emacs/postload.el or *_custom.el

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		user configure configuration setup

;;__________________________________________________________________________
;;;	History:	See emacs/ChangeLog

;;__________________________________________________________________________
;;;;	Archive Entry
;;See ftp://archive.cis.ohio-state.edu/pub/emacs-lisp/ARCHIVE-ENTRY

;; Emacs Lisp Archive Entry
;; Package: emacro
;; Keywords: configure, configuration, setup, install
;; Author: Bruce Ingalls <bingalls(at)users.sourceforge.net>
;; Maintainer:	Bruce Ingalls <bingalls(at)users.sourceforge.net>
;; Created: Jan 1998
;; Description: Easy, portable Emacs setup
;; URL: http://emacro.sourceforge.com/
;; Compatibility: Emacs20, XEmacs21

;;__________________________________________________________________________
;;;;	Code
(require 'cl)
(load-library "cl-macs")	;XEmacs v21.4 needs this
(require 'bytecomp)

;;__________________________________________________________________________
;;The following will improve your emacs file browsing experience:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;Kick off EMacro
;;Tell load-library where to search. Put new .el files in emacs/packages/
;;Note that loadpath is also used by *BatchCompile scripts
(require 'e-path)			;locations of *.el lisp libs
(require 'which)			;finds support programs

(defconst emacro-prefs-dir (concat emacro-top-dir "preferences/"))

;;Possible debug logging code:
;;(defadvice load (before debug-log activate)
;;  (message "Now loading: %s" (ad-get-arg 0)))

;;Version Stamp cache-locate-library files
(when
    (emacro-stamp-file (concat emacro-top-dir "preferences/e-cache.el"))
  (emacro-stamp-append (concat emacro-top-dir "preferences/e-cache.el")))
(when
    (emacro-stamp-file (concat emacro-top-dir "preferences/e-xcache.el"))
  (emacro-stamp-append (concat emacro-top-dir "preferences/e-xcache.el")))

;;__________________________________________________________________________
;;;;	Detect Load Paths
;;This tries to automatically find load paths under $HOME/emacs
;;This would not work in loadpath.el, when called from *BatchCompile scripts
(defvar cache-tiny-path)		;shut up compiler
(cache-locate-library
 use-cache 'cache-tiny-path "tiny-path"
 "For automatic load-path, get tiny-tools from <url: http://tiny-tools.sourceforge.net>")
(when (and cache-tiny-path (which "perl"))
  (require 'cl)
;; location of tinypath.el
  (pushnew
   (concat emacro-top-dir "packages/tiny-tools/lisp/tiny")
   load-path :test 'string=)
  (load "tinypath.el"))

;;__________________________________________________________________________
;;(when (not (featurep 'e-config)) (load (concat emacro-code-dir "e-config")))
(require 'e-config)

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

(provide 'e-macro)
;;; e-macro.el ends here
