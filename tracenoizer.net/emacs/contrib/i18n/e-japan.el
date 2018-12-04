;;; e-japan.el --- Japanese language support
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-02-16 10:26:56 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id$

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code

;;__________________________________________________________________________
;;;; Legal:
;;Copyright © 1998,2002 Yuji Minejima, Bruce Ingalls
;;See the file COPYING for license
;;This file is not (yet) part of Emacs nor XEmacs.

;;__________________________________________________________________________
;;; Commentary:
;;Support for Japanese language
;;I have included this in hopes that it will be useful.
;;Testing was limited, as the editor does not speak Japanese.
;;This file may require compiling Emacs with MULE support.

;;; Author:		Yuji Minejima <ggb01164(at)nifty.ne.jp>
;;; Editor:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url:http://www.sourceforge.net/projects/emacro>
;;<url:http://www.dotemacs.de/>
;;; Change Log:		See ChangeLog history file
;;; Keywords:		japanese

;;__________________________________________________________________________
;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

(require 'mule)

;;More to come in the future. See
;;<url:http://homepage1.nifty.com/bmonkey/emacs/>

(set-language-environment "Japanese")

(cond
;;FSF/Gnu Emacs, ms windows
  ((or (equal window-system 'w32)
      (string-match "Macintosh" (emacs-version)))
  (set-default-coding-systems 'shift-jis))

 (t (set-default-coding-systems 'euc-jp)))	;only on unix.

(defconst bbdb-north-american-phone-numbers-p nil)
(defconst bbdb-default-area-code nil)

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

(provide 'e-japan)

;;; e-japan.el ends here
