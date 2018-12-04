;;;; e-perl.el --- Perl support for gnu and x emacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-04-18 11:18:42 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-perl.el,v 1.20 2003/05/24 17:37:02 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Perl Mode
;;	Make Perl Script Function
;;	Perl Doc
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file. Perl support for every OS.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		program mode ide

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-perl nil "Settings from e-perl.el file." :group 'emacro)

;;(require 'e-linux)
;;See also e-linux.el for these routines:
;;	Debug Perl To Here Function
(autoload 'gud "gud" "gud debug files." t)
(autoload 'perldb "gud" "debug perl files." t)


(defface cperl-space-face               ;from make-mode.el
  '((((class color))
     (:background "hotpink"))		; Yeah!
    ;; Everything else, just choose the most visible background
    ;; color.  We don't care about foreground, since it is only used
    ;; for whitespace.
    (((background light))
     (:background "black"))
    (((background dark))
     (:background "white")))
  "Face to use for highlighting leading Makefile spaces in Font-Lock mode."
  :group 'cperl-mode)

;;Whitespace display alternate, other than '_'.
(defvar cperl-invalid-face)
(set-default 'cperl-invalid-face 'cperl-space-face)

;;__________________________________________________________________________
;;;;		Perl Mode
;;cperl not available with older gnu emacs
(cache-locate-library use-cache 'cache-advice "advice"
                      "Get advice.el from full XEmacs sumo tarball")
(when cache-advice (autoload 'ad-add-advice "advice" "advice" t))

(defvar cperl-font-lock)
(set-default 'cperl-font-lock 't) ;Enable syntax coloring

;;ToDo: remove deprecated tiny code:
 (defvar cache-tinyperl)			;shut up compiler
 (cache-locate-library
  use-cache 'cache-tinyperl "tinyperl"
  "For extra Perl menu, get tiny-tools from <URL:http://www.sourceforge.net/projects/tiny-tools/> Requires advice.el")

(defvar cache-cperl-mode)		;shut up compiler
(cache-locate-library
 use-cache 'cache-cperl-mode "cperl-mode"
 "For extra Perl support, get cperl-mode from full XEmacs sumo tarball")

(defvar use-indent)			;shut up compiler
(when cache-cperl-mode
  (autoload 'cperl-mode "cperl-mode" "cperl major mode" t)
  (defconst cperl-indent-level use-indent)

;;Toggle brace style.
  (defvar cperl-extra-newline-before-brace)
  (set-default 'cperl-extra-newline-before-brace 't)

;;You may wish to remove -w and -T(aint) checking, i.e. just 'perl -c':
  (add-hook
   'cperl-mode-hook
   (function
    (lambda ()
      (when cache-imenu (imenu-add-menubar-index))
      (set (make-local-variable 'compile-command)
           (concat "perl -cwT " buffer-file-name))

       (when (and cache-tinyperl cache-advice)
         (require 'tinyperl))))))

;;__________________________________________________________________________
;;;;		Make Perl Script Function
(defun perl-make-script (arg)
  "Make the current buffer into a perl script.  With ARG, nukes first."
  (interactive "*P")
  (cond
   ((or arg (= (- (point-min) (point-max)) 0))
    (erase-buffer)
    (insert-file "~/emacs/template.pl")))
  (save-excursion
    (shell-command (concat "chmod +x " (buffer-file-name))))
  (if (search-forward "gud-perldb-history: " nil t)
      (insert (concat "(\"perl "
		      (file-name-nondirectory (buffer-file-name))
		      "\")")))
  (save-buffer)
  (shell-command (concat "chmod a+x " (buffer-file-name)))
  (find-alternate-file (buffer-file-name)) ; set mode, fontification, etc.
  (beginning-of-buffer)
  (search-forward "usage=\"Usage: $0 \[-$flags\]" nil t))

;;__________________________________________________________________________
;;;;	Perl Doc
(defvar cache-perldoc)			;shut up compiler
(cache-locate-library
 use-cache 'cache-perldoc "perldoc"
 "For help on Perl keywords, get perldoc from <URL:http://GNUSoftware.com/Emacs/Lisp/perldoc.el>")

;;ToDo: Make this an autoload, for efficiency.
(when cache-perldoc (require 'perldoc))

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

(provide 'e-perl)
;;; e-perl.el ends here
