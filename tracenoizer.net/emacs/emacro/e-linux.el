;;;; e-linux.el --- Routines for unix like systems only.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-06-09 13:15:20 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-linux.el,v 1.22 2003/05/24 17:37:01 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;;	Legal
;; 	Commentary
;; 	Code
;;	Programmer
;;		Debug Perl To Here Function
;;		Insert Braces Function
;;		perl-man-func()

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;This code should also work for Mac OS X, and W32 Unix shells, such as Cygwin
;;So far, the only nonportable code deals with man pages.
;;In fact, Debug Perl() and Insert Braces() also works on W32.
;;Users may duplicate this code themselves, or upgrade to Linux, or let me
;;know how I can avoid maintaining duplicate code.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;; Keywords:		program mode ide
 
;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(autoload 'manual-entry "man" "manual pages" t)

(setq-default x-select-enable-clipboard 't) ;System clipboard, not Emacs ring

;;__________________________________________________________________________
;;;;;;		Debug Perl To Here Function
;;e-linux.el is loaded at beginning of e-perl.el
;;These are otherwise autoloaded in mac.el. Here, prevents compile warnings
(autoload 'gud "gud" "gud debug files." t)
(autoload 'perldb "gud" "debug perl files." t)

;;If you get "** the function comint-send-input is not known to be defined."
;;during runtime (as opposed to bytecompiling this file)
;;then you should upgrade comint.el, available in gnu emacs >= v20.2
;;gnu emacs defines comint-send-input in comint.el
;;x emacs defines it in ilisp/comint-v18.el, xemacs-base/comint.el
(autoload 'comint-send-input "comint" "comint." t)

(defun pdb-down-to-here (command-line)
  "Launch perl debugger, proceeding down to current line.
Argument COMMAND-LINE NEED TO DOCUMENT COMMAND-LINE."
  (interactive
   (list (read-from-minibuffer "Run perldb (like this): "
			       (if (and (require 'gud)
					(consp gud-perldb-history))
				   (car gud-perldb-history)
				 "perl ")
			       nil nil
			       '(gud-perldb-history . 1))))

  (make-local-variable 'gud-perldb-history)
  (let ((buf (current-buffer))
	(line (+ (if (bolp) 1 0)
		 (count-lines (point-min) (point)))))
    (save-some-buffers t)
    (perldb command-line)		; changes current buf
    (while (save-excursion
	     (goto-char (point-max))
	     (beginning-of-line)
	     (not (looking-at " *DB<1>")))
      (sit-for 1)
      (accept-process-output)
      (if (save-excursion
	    (goto-char (point-max))
	    (beginning-of-line 0)
	    (looking-at "Debugger exited abnormally.*"))
	  (progn
	    (pop-to-buffer buf)
	    (error (buffer-substring (match-beginning 0) (match-end 0))))))
    (goto-char (point-max))		; ... but doesn't do this, oddly
    (insert "c " (number-to-string (+ line (if (bolp) 1 0))))
    (comint-send-input)))

;;__________________________________________________________________________
;;;;;;		Insert Braces Function
;;(autoload 'c-indent-exp "cc-cmds" "indent c" t)
(defvar cache-cc-cmds)			;shut up compiler

(cache-locate-library
 use-cache 'cache-cc-cmds "cc-cmds"
 "For extra C language support, get cc-cmds.el from full tarball distribution where you got XEmacs")

(when cache-cc-cmds
  (require 'cc-cmds)
  (defun insert-braces ()
    "Insert matched braces, leave point inside."
    (interactive "*")
    (let (blink-paren-function)         ;nil it temporarily
      (execute-kbd-macro
       (if (and (eq major-mode 'cc-c++-mode) (not (looking-at ";")))
           "{};" "{}")))
    (backward-sexp 1)
    (if (save-excursion
          (forward-char -1)
          (looking-at "\\$"))
        nil
      (reindent-then-newline-and-indent)
      (c-indent-exp)
      (forward-char 1)
      (newline-and-indent))))

;;__________________________________________________________________________
;;;;	perl-man-func()
	  (autoload 'Man-getpage-in-background "man" "man" t) ;shut up compiler
	  (defun perl-man-func (func)
	    "Look up FUNC in the perlfunc man page."
	    (interactive "sFunction: ")
	    (if (not (get-buffer "*Man perlfunc*"))
		(Man-getpage-in-background "perlfunc")
	      (pop-to-buffer (get-buffer "*Man perlfunc*"))
	      (goto-char (point-min))
	      (re-search-forward (concat "^       " func " "))))

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

(provide 'e-linux)
;;; e-linux.el ends here
