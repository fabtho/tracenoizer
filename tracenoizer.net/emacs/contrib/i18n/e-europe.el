;;; e-europe.el --- Enhancements for both GNU and X Emacs on all platforms
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-04-28 14:37:24 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: europe.el,v 1.1 2000/08/24 21:37:38 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Applications
;;		Babel Translation
;;		BBDB
;;		Calendar
;;		Dictionary
;;			Spell Check On-the-fly
;;	I18N/Internationalization
;;		European
;;		Unibyte Support
;;		Windows Fonts
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2002 Bruce Ingalls
;;See the file COPYING for license
;;This file is not (yet) part of GNU or X Emacs.

;;__________________________________________________________________________
;;;; Commentary:
;;Emacs editor startup file.  Power User routines for every OS, for both Gnu &
;;X Emacs

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url:ftp://ftp.cppsig.org/pub/tools/emacs/>	<url:http://www.ikoch.de/>
;;; Change Log:		See ChangeLog history file
;;;; Keywords:		advanced power user enhanced miscellaneous applications

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;;;	Applications
;;__________________________________________________________________________
;;;;;;		Babel Translation
;;Use babel fish web site to translate languages
;;This only works with Gnu Emacs
(defvar cache-babel)			;shut up compiler
(cache-locate-library
 use-cache 'cache-babel "babel"
 "For language translation support, get babel.el from <URL:http://www.chez.com/emarsden/downloads/babel.el>")

(autoload 'babel-mode "babel" "Babel translator." t)
(when cache-babel
  (progn
    (autoload 'babel "babel" "Babel translator." t)
    (autoload 'babel-region "babel" "Babel translator." t)
    (autoload 'babel-as-string "babel" "Babel translator." t)
    (autoload 'babel-buffer "babel" "Babel translator." t)
    (autoload 'babel-as-string "babel" "Babel translator." t)
    (defvar mark-active)                ;shut up bytecompiler

    (defun translate-with-babel (&optional arg)
      "Translates the word at point (if no region active) or whole region
	with babel. If ARG then the word at point (if no region active) or
	whole region is automatically replaced with the translation returned
	by babel. If ARG is nil then the translation-result is only displayed:
	If a region is active result is displayed in the standard babel-buffer
	otherwise result is displayed in the echo area."
      (interactive "P")
      (let* ((region-p (and mark-active (/= (mark) (point))))
             (babel-result
              (if region-p
                  (babel-as-string (buffer-substring-no-properties
                                    (mark) (point)))
                (babel-as-string (thing-at-point 'word))))
             ;; do additonal washing cause of some babel-backends return
             ;; space-stuff in front of the translation
             (index (string-match "[^ 	\n\f].*" babel-result)))
        (if index (setq babel-result (substring babel-result index)))
        (if (not arg)
            ;; no replacing only displaying the translation
            (if region-p
                (with-output-to-temp-buffer "*babel*"
                  (princ babel-result)
                  (save-excursion
                    (set-buffer "*babel*")
                    (babel-mode)))
              (message babel-result))
          ;; translation replaces the original text.
          (if region-p
              (kill-region (mark) (point))
            (autoload 'beginning-of-thing "thingatpt" "Thingatpt." t)
            (beginning-of-thing 'word)
            (kill-word 1))
          (insert babel-result))))

    (defadvice babel (after babel-advice activate)
      "Because the buffer \" *babelurl*\" is always modified we kill it after
     finishing babel so functions like save-some-buffers,
     save-buffers-kill-emacs ... don¥t annoying us with confirmation requests"
      (let ((buf-name " *babelurl*"))
        (if (member buf-name (mapcar (function buffer-name) (buffer-list)))
            (save-excursion
              (set-buffer buf-name)
              (set-buffer-modified-p nil)
              (kill-buffer buf-name)))))
    ))

;;__________________________________________________________________________
;;;;;;		BBDB
(progn
  (defconst bbdb-north-american-phone-numbers-p nil)
  (defconst bbdb-default-area-code nil)))

;;__________________________________________________________________________
;;;;;;		Calendar
;;See also e-common.el

;;European alendar style
(defconst european-calendar-style t)
(defconst calendar--week--start--day 1)	;;start on Monday, not Sunday

(defconst display-time-24hr-format t) ;European/military time

;;We should make these defcustom settings
;; (defvar calendar-german-day-name-array
;;   ["Sonntag" "Montag" "Dienstag" "Mittwoch" "Donnerstag" "Freitag" "Samstag"])
;; (setq calendar-day-name-array calendar-german-day-name-array)

;; (defvar calendar-german-month-name-array
;;   ["Januar" "Februar" "März" "April" "Mai"      "Juni"
;;    "Juli"    "August"   "September" "Oktober" "November" "Dezember"])
;; (setq calendar-month-name-array calendar-german-month-name-array)

;;__________________________________________________________________________
;;;;;;		Dictionary
;;<url:http://www.in-berlin.de/User/myrkr/dictionary.html>
;;<url:http://www.dict.org>
;;See also poweruser.el

;;Uncomment to make German your default ispell dictionary:
;(defconst ispell-dictionary 'deutsch8)

;;__________________________________________________________________________
;;;;;;;;		Spell Check On-the-fly
;;M-x flyspell-auto-correct-word: automatically correct word.
;;M-x flyspell-correct-word (or mouse-2): popup correct words.
;;(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checking" t)
;;(autoload 'global-flyspell-mode "flyspell" "On-the-fly spelling" t)
;;(global-flyspell-mode t)
(require 'flyspell)
(defun flyspell-danish ()
  (interactive)
  (flyspell-mode t)
  (ispell-change-dictionary "dansk")
  (flyspell-buffer))
(defun flyspell-english ()
  (interactive)
  (flyspell-mode t)
  (ispell-change-dictionary "english")
  (flyspell-buffer))

;;  (flyspell-buffer))
;;(autoload 'flyspell-danish)

;;__________________________________________________________________________
;;;;	I18N/Internationalization
;;See also x-compose.el, which is bundled with XEmac
;;Try putting the following line at the top of your docs:
;;-*- coding: iso-8859-1 -*-
;;Workaround for new, unsupported encodings:
;(define-coding-system-alias 'iso-8859-16 'iso-8859-1)
;;Russian Win-1251 codepage
;(prefer-coding-system 'cp1251)

;;__________________________________________________________________________
;;;;;;		European
(cond (use-europe
      (progn
       (standard-display-european 1)	;Alternate Character Set
;       (autoload '??? "latin-1" "Latin character set" t)
;       (require 'latin-1)
;(set-buffer-multibyte nil)		;disable wide chars (until v20.4)

       (autoload 'iso-accents-mode "iso-acc" "i18n chars" t)
;       (load-library "iso-acc")
       ;(iso-accents-mode t)            ;byte-compile warning
       (defconst iso-accents-mode t)

       (require 'iso-insert)	;this doesn't autoload nicely.

;;gnu only?
;	(set-language-environment 'latin-1)	;emacs ver >= 20.3
       (set-input-mode (car (current-input-mode))
		       (nth 1 (current-input-mode)) 0)
       (defconst sgml-mode-hook 
	 '(lambda () "Default extended chars for SGML mode"
;;Need to get syntax to change this to autoload
			       (require 'iso-sgml)))
       )))

;(modify-coding-system-alist 'file "" 'iso-8859-1)	;all files are encoded
;(modify-coding-system-alist 'file "mutt" 'iso-8859-1)

;;Map Shift-4 to $ on Finnish keyboard: Useful for perl's $variables
;(defun insert-dollar-sign () (interactive) (insert-char 36 1))

;;htmlize: no &123; code for "¤"
;(global-set-key "¤" 'insert-dollar-sign)		;change everywhere
;(define-key cperl-mode-map "¤" 'insert-dollar-sign)	;change only for perl

;;Map Shift-4 to $ on Finnish keyboard: (solution 2) Useful for perl
; -*- unibyte:t -*-	;place at top of file
;;htmlize: "ö" is &#246; or &ouml;
;(define-key key-translation-map (kbd "ö") "$")

;;__________________________________________________________________________
;;;;;;		Unibyte Support
;;(set-language-environment "Latin-1")
;;(set-terminal-coding-system 'iso-latin-1)
;;(set-terminal-coding-system 'iso-8859-1)
;;(setq unibyte-display-via-language-environment t)

;;__________________________________________________________________________
;;;;;;		Windows Fonts
;;BDF font locations for ps-bdf (printing) and w32bdf (display)
;; (setq bdf-directory-list
;;       '("c:/fonts/Asian" "c:/fonts/Chinese" "c:/fonts/Chinese-X"
;; 	"c:/fonts/Ethiopic" "c:/fonts/European" "c:/fonts/Japanese-X"
;; 	"c:/fonts/Japanese" "c:/fonts/Korean-X" "c:/fonts/Misc"))

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

(provide 'e-europe)

;;; e-europe.el ends here
