;;;; e-xml.el --- HTML/SGML/XML support for gnu and x emacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-06-28 23:06:29 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-xml.el,v 1.20 2003/05/24 17:37:02 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	SGML Parser
;;	DTD Mode
;;	HTML Mode
;;	SGML Colors
;;	XML Mode
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file. HTML/SGML/XML support for every OS.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		program mode ide

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-xml nil "Settings from e-xml.el file." :group 'emacro)
(require 'which)

;;Currently only applies to html modes
(defcustom e-xml-auto-fill t "Enable word wrap in xml and html source."
  :group 'e-xml
  :type 'boolean)

(cache-locate-library
 use-cache 'cache-psgml "psgml"
 "For xml & sgml support, get psgml at <url: http://psgml.sourceforge.net/ >")

;;xemacs v21.4 requires psgml v1.2.2 or higher
(when cache-psgml (require 'psgml))

;;If you do xml instead of sgml:
;;Need to get the sgml catalog for xml!!!
;;      (defconst sgml-validate-command "nsgmls -wxml %b")
;;      (defconst sgml-validate-command "nsgmls -wxml -c%s %s")

(cache-locate-library
 use-cache 'cache-xxml "xxml"
 "For extra xml support, get xxml.el from <url:http://www.iro.umontreal.ca/~pinard/fp-etc/dist/xxml/xxml.el>")

;;SEE ALSO HTML FALLBACK MODE, WHICH MAY CONFLICT
(autoload 'xxml-mode-routine "xxml")
(setq sgml-indent-data t)		;Indent psgml-mode
(setq sgml-set-face t)			;Colorizes psgml-mode

;;ToDo: delete this deprecated code:
;;(defcustom sgml-font-lock t "Enable syntax coloring."
;;  :group 'e-xml
;;  :type 'boolean)

;;xslide colors for a light background
(defvar xsl-font-lock-face-attributes
  (list
   '(xsl-xsl-main-face "Dark Goldenrod")
   '(xsl-xsl-alternate-face "DimGray")
   '(xsl-fo-main-face "PaleGreen")
   '(xsl-fo-alternate-face "YellowGreen")
   '(xsl-other-element-face "Coral"))
  "*List of XSL-specific font lock faces and their attributes")

;;__________________________________________________________________________
;;;;		SGML Parser
;;Parser used by psgml.el. See programmer/e-xml.el
(when (not (which "nsgmls"))
  (message "For XML parsing support, get sp / nsgmls from <url:http://www.jclark.com/sp/howtoget.htm>"))

;;__________________________________________________________________________
;;;;		DTD Mode
;;tdtd.el from <url:http://www.mulberrytech.com/tdtd/>
(autoload 'dtd-mode "tdtd" "Major mode for SGML and XML DTDs." t)
(autoload 'dtd-etags "tdtd"
  "Execute etags on FILESPEC and match on DTD-specific regular expressions."
  t)
(autoload 'dtd-grep "tdtd" "Grep for PATTERN in files matching FILESPEC." t)

(add-hook 'dtd-mode-hook 'turn-on-font-lock)
;;(setq dtd-xml-flag t)		;Don't insert "- -"
;;Use header of <?xml version="1.0" encoding='ISO-8859-1'?> to avoid "- -"

;;__________________________________________________________________________
;;;;		HTML Mode
;;I currently recommend html-helper-mode
;;I've had problems with html-helper-mode v3.0.3.3 on xemacs 21.1 and the
;;possibly required visual-basic-mode.el causes grief on gnu emacs v20.2

;;To Do? add psgml support for html files
;;(p)sgml-mode		<url:ftp://ftp.lysator.liu.se/pub/sgml/>

;;html-helper-mode (good)	<url:http://www.santafe.edu/~nelson/tools/>
;;html-mode (good)    <url:ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/modes/>
;;hm--html-mode			<url:http://www.xemacs.org/>
;;sgml-mode			<url:ftp://ftp.ifi.uio.no/pub/SGML/Emacs-LISP/>

(cache-locate-library
 use-cache 'cache-advice "advice"
 "For HTML support, get advice.el from full tarball distribution where you got XEmacs")
(cache-locate-library
 use-cache 'cache-html-helper-mode
 "html-helper-mode"
 "For recommended HTML support, get html-helper-mode from <URL:http://www.anc.ed.ac.uk/~stephen/emacs/ell.html> Requires advice.el")
(cache-locate-library
 use-cache 'cache-html-mode
 "html-mode"
 "For alternate HTML support, get html-mode.el from full tarball distribution where you got XEmacs")
(cache-locate-library
 use-cache 'cache-hm--html-mode
 "hm--html-mode"
 "For alternate HTML support, get hm--html-helper-mode.el from full tarball distribution where you got XEmacs")
(cache-locate-library
 use-cache 'cache-psgml
 "psgml"
 "For alternate HTML support, get psgml.el from full tarball distribution where you got XEmacs")
(cache-locate-library
 use-cache 'cache-sgml-mode
 "sgml-mode"
 "For alternate HTML support, get sgml-mode.el from full tarball distribution where you got XEmacs")

(autoload 'html-helper-add-type-to-alist "html-helper-mode"
  "HTML helper mode" t)                 ;May prevent some loading bugs

(defvar use-indent)			;shut up compiler

(when cache-advice
  (require 'advice)                     ;hm--html-mode.el, tiny*-mode.el
  (cond
   (cache-html-helper-mode
    (autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic" t)
    (require 'tempo)
    (autoload 'html-helper-mode "html-helper-mode" "HTML helper mode" t)
    (set-default 'html-helper-build-new-buffer 't)

    (add-hook
     'html-helper-mode-hook
     (function
      (lambda ()
	(defvar html-helper-basic-offset) ;shut up compiler
	(set-default 'html-helper-basic-offset 't)
        (if e-xml-auto-fill (auto-fill-mode 1)
	  (auto-fill-mode -1))		 ;else disable word-wrap
	)))

    (setq auto-mode-alist
          (append '(
                    ("\\..?html?$"	. html-helper-mode)
                    ("\\.tmpl$"	. html-helper-mode) ;html template
                    )auto-mode-alist)))

   (cache-html-mode
    (autoload 'html-mode "html-mode" "HTML major mode." t)
    (add-hook 'html-mode-hook
              (function
               (lambda ()
		 (if e-xml-auto-fill (auto-fill-mode 1)
		   (auto-fill-mode -1))	;else disable word-wrap
		 )))
    (setq auto-mode-alist
          (append '(
                    ("\\..?html?$"	. html-mode)
                    ("\\.tmpl$"	. html-mode) ;html template
                    )auto-mode-alist)))

   (cache-hm--html-mode
    (autoload 'hm--html-mode "hm--html-mode" "HTML hm mode" t)
    (add-hook 'hm-html-mode-hook
              (function
               (lambda ()
		 (if e-xml-auto-fill (auto-fill-mode 1)
		   (auto-fill-mode -1))	;else disable word-wrap
		 )))
    (setq auto-mode-alist
          (append '(
                    ("\\..?html?$"	. hm--html-mode)
                    ("\\.tmpl$"	. hm--html-mode) ;html template
                    )auto-mode-alist)))
   (cache-psgml
    (autoload 'xml-mode "psgml" "xml major mode" t)
;;fill-column & autofill set unconditionally below
    (setq auto-mode-alist
          (append '(
                    ("\\..?html?$"	. xml-mode)
                    ("\\.tmpl$"	. xml-mode) ;html template
                    )auto-mode-alist)))
   ;;else all modern emacs have sgml-mode
   (t
    (autoload 'sgml-mode "sgml-mode" "SGML major mode" t)

    ;;SEE ALSO DTD MODE, WHICH MAY CONFLICT WITH THIS HOOK
    (add-hook 'sgml-mode-hook
              (function
               (lambda ()
		 (if e-xml-auto-fill (auto-fill-mode 1)
		   (auto-fill-mode -1))	;else disable word-wrap
		 )))

    (setq auto-mode-alist
          (append '(
                    ("\\..?html?$"	. sgml-mode)
                    ("\\.tmpl$"	. sgml-mode) ;html template
                    )auto-mode-alist)))))

;;Toggle timestamp updating
(set-default 'html-helper-do-write-file-hooks 't)

;;Not nil gets template in new buffers
(set-default 'html-helper-build-new-buffer 't)

;;Toggle html templates
(set-default 'tempo-interactive 't)

;;Nil gets full HTML menu
(set-default 'html-helper-use-expert-menu 'nil)

;;XHTML DTD: attempt to support combined html & xml
;;(put 'html-helper-htmldtd-version 'standard-value
;;     (list "<?xml version=\"1.0\">\n<!DOCTYPE XHTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\">\n"))
(set-default
 'html-helper-htmldtd-version
 "<?xml version=\"1.0\">\n<!DOCTYPE XHTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\">\n")

;;Older, better tested HTML declaration:
;;  "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 4.0//EN\">\n"

;;(defvar html-helper-htmldtd-version
;;  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n")
;;DTD declaration at top of HTML files. Allows v4 compliance

;;__________________________________________________________________________
;;;;;;	wrap-url
;;Creates hrefs from urls:
(defun wrap-word (front middle rear)
  (re-search-backward "[\n\t ]" nil t)
  (looking-at "[\n\t ]?\\([^\n\t ]+\\)")
  (goto-char (match-end 1))
  (insert middle (match-string 1) rear)
  (goto-char (match-beginning 1))
  (insert front))

(defun wrap-url ()
  "Make the URL around the point into a link."
  (interactive)
  (wrap-word "<a href=\"" "\">" "</a>"))

;;__________________________________________________________________________
;;;;	SGML colors
;;See http://xtalk.price.ru/.emacs.html
;;From boris(at)xtalk.msk.su, tobotras(at)jet.msk.su
(make-face 'sgml-comment-face)
(make-face 'sgml-doctype-face)
(make-face 'sgml-end-tag-face)
(make-face 'sgml-entity-face)
(make-face 'sgml-ignored-face)
(make-face 'sgml-ms-end-face)
(make-face 'sgml-ms-start-face)
(make-face 'sgml-pi-face)
(make-face 'sgml-sgml-face)
(make-face 'sgml-short-ref-face)
(make-face 'sgml-start-tag-face)

(set-face-foreground 'sgml-comment-face "dark green")
(set-face-foreground 'sgml-doctype-face "maroon")
(set-face-foreground 'sgml-end-tag-face "blue2")
(set-face-foreground 'sgml-entity-face "red2")
(set-face-foreground 'sgml-ignored-face "maroon")
(set-face-background 'sgml-ignored-face "gray90")
(set-face-foreground 'sgml-ms-end-face "maroon")
(set-face-foreground 'sgml-ms-start-face "maroon")
(set-face-foreground 'sgml-pi-face "maroon")
(set-face-foreground 'sgml-sgml-face "maroon")
(set-face-foreground 'sgml-short-ref-face "goldenrod")
(set-face-foreground 'sgml-start-tag-face "blue2")

(set-default 'sgml-markup-faces
              '((comment . sgml-comment-face)
                (doctype . sgml-doctype-face)
                (end-tag . sgml-end-tag-face)
                (entity . sgml-entity-face)
                (ignored . sgml-ignored-face)
                (ms-end . sgml-ms-end-face)
                (ms-start . sgml-ms-start-face)
                (pi . sgml-pi-face)
                (sgml . sgml-sgml-face)
		(sgml-auto-activate-dtd t)
		(sgml-insert-end-tag-on-new-line t)
		(sgml-recompile-out-of-date-cdtd t)
                (short-ref . sgml-short-ref-face)
                (start-tag . sgml-start-tag-face)))

(set-default 'sgml-auto-insert-required-elements 't)
(set-default 'sgml-normalize-trims 't)
(set-default 'sgml-live-element-indicator 't)
(set-default 'sgml-balanced-tag-edit 't)
(set-default 'sgml-set-face 't)
(set-default 'sgml-warn-about-undefined-entities 'nil)

;;__________________________________________________________________________
;;;;	XML Mode

;;This will enable loading DTDs thru a URL, as in
;; <!DOCTYPE my_dtd SYSTEM "http://my.dtd.com/path/file.dtd">
;;Note that you may need w3 version 1.10 "4.0pre.46 1999/10/01" or higher
;;Slow modem users will have to parse from the menu for each remote dtd
(cache-locate-library
 use-cache 'cache-w3 "w3"
 "For the emacs web browser, get w3 from <url:http://www.cs.indiana.edu/elisp/w3/docs.html>")

(autoload 'url-type "url" "url" t)
(autoload 'url-generic-parse-url "url" "url" t)
(autoload 'url-retrieve "url" "url" t)
;;sgml-next-trouble-spot used to load from psgml
(autoload 'sgml-next-trouble-spot "psgml-edit" "psgml-edit" t)

(defvar use-net)			;shut up compiler
(defvar use-modem)			;shut up compiler

;;If we have a fast net connection, parse remote DTD URIs
(when (and (and (and cache-html-helper-mode cache-w3)
                (and use-net  (not use-modem))) cache-advice)
  (require 'url)
  (require 'w3)
  (defvar url-working-buffer)		;shut up compiler

  (defvar sgml-system-identifiers-are-preferred)
  (defvar sgml-indent-step)
  (defun sgml-resolve-url (url)
    "Insert the contents of URL into the current buffer."
    ;;Unfortunately, url-retrieve always returns nil and always inserts text in
    ;;url-working-buffer, so we can't detect whether it succeeded or failed.
    (if (url-type (url-generic-parse-url url))
        (let ((url-multiple-p nil))
          (save-excursion
            (url-retrieve url))
          (insert-buffer url-working-buffer))
      t))

  (set-default 'sgml-system-identifiers-are-preferred 't)
  (add-hook 'sgml-sysid-resolve-functions 'sgml-resolve-url))

(add-hook 'xml-mode-hook
          (function
           (lambda ()
	     (if e-xml-auto-fill (auto-fill-mode 1)
	       (auto-fill-mode -1))	;else disable word-wrap
             (message
              "Enable line wrap with M-x toggle-text-mode-auto-fill")
	     (set-default 'sgml-indent-step use-indent)
             ;;The following may not be required. Validate & font-lock xml
             ;;Note that Gnu MacOS Emacs should not barf on which()
             (when (which "nsgmls")
		   (sgml-next-trouble-spot))
	       (font-lock-fontify-buffer))))

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

(provide 'e-xml)
;;; e-xml.el ends here
