;;;; e-java.el --- Java support for gnu and x emacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-04-18 11:18:06 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-java.el,v 1.20 2003/05/24 17:37:02 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Java Hooks
;;	JDE Java Development Environment
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file. Java support for every OS.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		program mode ide

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-java nil "Settings from e-java.el file." :group 'emacro)
(require 'which)

;;__________________________________________________________________________
;;;;		Java Hooks
;;(setq tags-file-name "/edit/this/dir")	;find function declares & refs
(setq java-font-lock t)			;Enable Java syntax coloring

(autoload 'qflib-mode "qflib" "Minor mode utilities for editing Java code")

(cache-locate-library
 use-cache 'cache-jde "jde"
 "For a Java IDE, get JDE from <url:http://sunsite.auc.dk/jde/>")

(when cache-jde
  (add-hook 'jde-mode-hook
            '(lambda ()
               (local-set-key [?\C-c ?\C-c] 'jde-complete-at-point-menu)
	       (font-lock-fontify-buffer)
	       )))

(cache-locate-library
 use-cache 'cache-qflib "qflib"
 "For a Java menu, get qflib from <url:http://www.qfs.de/en/projects/elisp/index.html>")

(defvar use-indent)			;shut up compiler
;;Java-mode-hook also gets called by JDE, affecting both
(add-hook 'java-mode-hook
          '(lambda ()
	     (imenu-add-menubar-index)
             (setq c-file-style "local")
             (setq c-basic-offset use-indent)

             (when cache-qflib
               (defconst qflib-prefix-key "\C-x\C-j")
               (global-set-key "\C-x\C-j\C-m" 'qflib-find-stacktrace-error)
               ;;(setq qflib-source-directories 
               ;;      (list (expand-file-name "~/src/Java")))
               (qflib-mode))))

;;__________________________________________________________________________
;;;;		JDE: Java Development Environment
;;Get JDE from <URL:http://sunsite.auc.dk/jde/> See JDE section below
;;Support for gnu emacs appears to be less than for xemacs

(cache-locate-library
 use-cache 'cache-speedbar "speedbar"
 "For fast navigation menu, get speedbar.el from full XEmacs sumo tarball")

(cond
 ((and cache-jde cache-speedbar)
  (autoload 'jde-mode "jde" "Java Development Environment" t)
  (setq auto-mode-alist (append '(
                                  ("\\.java$" . jde-mode)
                                  ("\\.jsp$"  . jde-mode)
                                  ) auto-mode-alist))
  ;;(defconst jde-jdk-doc-url "/jdk1.2.2/readme.html")

  );;Else use plain java mode:
 (t (setq auto-mode-alist(append '(
				   ("\\.java$" . java-mode)
				   ("\\.jsp$"  . java-mode)
				   )auto-mode-alist))))

;;SET THIS IN e-preload.el!
;;source-path is similar in function to CLASSPATH
;;      (defconst source-path '("D:/java/source" "C:/jdk1.3/src"))

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

(provide 'e-java)
;;; e-java.el ends here
