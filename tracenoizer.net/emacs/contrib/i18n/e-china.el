;;; e-china.el --- Chinese language support
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-02-16 10:25:36 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id$

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code

;;__________________________________________________________________________
;;;; Legal:
;;Copyright © 1998,2002 Stephen Tse, Bruce Ingalls
;;See the file COPYING for license
;;This file is not (yet) part of Emacs nor XEmacs.

;;__________________________________________________________________________
;;; Commentary:
;;Support for Chinese language
;;I have included this in hopes that it will be useful.
;;Testing was limited, as the editor does not speak Chinese.
;;This file may require compiling Emacs with MULE support.

;;; Author:		Stephen Tse <stephent(at)sfu.ca>
;;; Editor:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url:http://www.sourceforge.net/projects/emacro>
;;<url:http://www.dotemacs.de/>
;;; Change Log:		See ChangeLog history file
;;; Keywords:		chinese


;;__________________________________________________________________________
;;; Code:
(require 'mule)

(setup-chinese-big5-environment)
(set-keyboard-coding-system 'chinese-big5-dos) ; windows ¿é¤Jªk
(set-selection-coding-system 'chinese-big5-dos) ; Copy/Paste

;;The top 3 lines may be all that is needed?

(defconst bbdb-north-american-phone-numbers-p nil)
(defconst bbdb-default-area-code nil)

(setq default-input-method 'chinese-b5-tsangchi)

;;These byte-compile errors need fixing :^(
(unless (eq (console-type) 'tty)
  (set-face-font   'default
		   "-uw-ming-medium-r-normal-fantizi-16-160-75-75-c-160-big5-0"
		   'global
		   '(mule-fonts) 'prepend))

(defun chinese-decode-buffer ()
  "Decode chinese in buffer.It ignores 'buffer-read-only'."
  (interactive)
  (setq buffer-read-only nil)
  (decode-coding-region (point-min) (point-max) 'big5))

;;override upcase-initial	This syntax needs fixing to work with gnu emacs
(global-set-key [(meta c) d] 'chinese-decode-buffer)

;; keystroke dictionaries
;; http://www.sfu.ca/~stephent/emacs/clib

;;need definition of hot-file function :^(
(global-set-key [(alt c) ?1] (hot-file "~/code/chinese/associate"))
(global-set-key [(alt c) ?2] (hot-file "~/code/chinese/canton"))
(global-set-key [(alt c) ?3] (hot-file "~/code/chinese/ecdict"))
(global-set-key [(alt c) ?4] (hot-file "~/code/chinese/simple"))

;; chinese key dictionary
;; http://www.sfu.ca/~stephent/chinese/chinesekeys.tgz
;; This package is a database for dict server <http://www.dict.org>. It is
;; a dictionary of chinese characters that lists input key and association
;; information of each character. I wrote it to aid learning of chinese
;; typing.

;; -unix crlf conversion
(setq network-coding-system-alist '((2628 . big5-unix)))

;;These have byte-compile errors :^(
(defun cinfo-encode (char)
  (let ((big5-char (encode-coding-string char 'big5)))
    (format "%s-%s"
	    (char-to-int (aref big5-char 0))
	    (char-to-int (aref big5-char 1)))))

(defun cinfo-char-info (char)
  "Do dictionary search of chinese CHAR."
  (interactive)
  (list (if current-prefix-arg
	    (read-string "char: ")
	  (char-to-string (following-char))))
  (dictionary-search
   (cinfo-encode char)
   "chinesekeys"))
(global-set-key [(alt c) c] 'cinfo-char-info)

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

(provide 'e-china)

;;; e-china.el ends here
