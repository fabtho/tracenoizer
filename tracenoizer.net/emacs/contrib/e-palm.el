;;;; e-palm.el --- Routines for synching emacs with palm pilots
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-02-16 10:28:49 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;; Version: 2.0.4

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;;	Legal
;; 	Commentary
;; 	Code
;;		411-2-CSV
;;		Pilot-Mark
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2002 Bruce Ingalls
;;See file COPYING for license. This file is not (yet) part of Emacs nor XEmacs

;;__________________________________________________________________________
;;;; Commentary:
;;These functions to link Emacs to a palm pilot is based entirely on Jack
;;Repenning's work.  I have not tested it on multiple Emacs & platforms

;;__________________________________________________________________________
;;; Author:		Jack Repenning <jackr(at)informix.com>
;;; Editor:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url:http://www.sourceforge.net/projects/emacro>
;;<url:http://www.dotemacs.de/>
;;; Change Log:		See ChangeLog history file
;;; Keywords:		3com palm pilot pda hand held

;;__________________________________________________________________________
;;;; Bug:	It looks that save-buffer-kill-buffer() needs rewriting
;;		It might not be portable between gnu & x emacs.

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;;;		411-2-CSV
(defun 411-2-csv (save)
  "Convert 411.txt to 411.csv, suitable for import to PalmPilot.
Argument SAVE cleans out 411.txt."
  (interactive "P")

;;You may wish to change "All Users" to your user ID.
;;Perhaps we can interactively prompt for this, or use $USER in the future?
  (let ((desktop "c:/WINNT/Profiles/All Users/Desktop"))

    (find-file-other-frame (concat desktop "/411.csv"))
    (widen)
    (kill-region (point-min) (point-max))

    (save-window-excursion
      (find-file (concat desktop "/My Briefcase/411.txt"))
      (widen)
      (if (not save)
	  (and (kill-region (point-min) (point-max))
	       (save-buffer))
	(copy-region-as-kill (point-min) (point-max))))

    (yank)
    (goto-char (point-min))
    ;; This is the default column order.
    ;; Unfortunately, "default" doesn't mean much - this is what you
    ;; get when you install the desktop, but any changes made
    ;; subsequently become the new default, and there's no "revert" or
    ;; "reset to defaults".
    ;;
    ;; "Last,First,Title,Company,Work,Home,Fax,Other,E-Mail,"
    ;; "Address,City,State,Zip,Country,"
    ;; "Custom 1,Printer,B'day,Custom 4,"
    ;; "Note,Private,Category\n"
    ;; I use Custom 1 ==
    ;;       Custom 2 == Printer
    ;;	     Custom 3 == B'day
    ;;	     Custom 4 == Source (411)
    ;;
    ;; This is the order 411 produces them in:
    (insert (concat "First,Last,Email,City,Address,Title,Work,Post-SSP,Other,Extn,Source,Category\n"))

    (save-restriction
      (while (/= (point) (point-max))

	;; Mark names: zero or more "first" names, one last name
	(save-restriction

	  (narrow-to-region (point) (+ (point) 28))
	  (save-excursion		; comma after names
	    (if (looking-at "\\(.*[^ ]\\) +")
		(replace-match "\\1,")))
	  (save-excursion		;comma before last name
	    (if (looking-at "\\(.*[^ ]\\) +")
		(replace-match "\\1,")))
	  (goto-char (point-max))
	  )

	;; mark remaining fields: column-delimited, possibly
	;; blank-padded, possible empty (all blank), widths
	;; preordained.
	(let ((len-list '(9		; length of email (+ space)
			  4		; length of "city" (MP, PORT, ...)
			  5		; "address" (building + space)
			  5		; "title" (department + space)
			  16		; work phone number
			  5		; post-ssp extension
			  4		; SSP
			  5		; extension
			  ))
	      len)
	  (while (setq len (car-safe len-list))
	    (setq len-list (cdr-safe len-list))

	    (save-restriction
	      (narrow-to-region (point)
				(min (+ len (point))
				     (save-excursion
				       (end-of-line 1)
				       (point))))
	      (if (looking-at "^ *\\([^ ]*\\) *")
		  (replace-match "\\1,"))))
	  (insert "411,Business"))

	(beginning-of-line 2))

      (goto-char (point-min))
      ))

  (save-excursion
    (while (re-search-forward
	    "\\(.*\\),\\(.*\\),\\(.*\\),\\(.*\\),.*,\\(.*\\),\\(.*\\),.*,\\(.*\\),.*,\\(.*\\),\\(.*\\)" nil t)
      (replace-match (concat "\\2,\\1,\\5,\"Informix Software, Inc.\",\\6,,,\\7,\\3,"
			     ",\\4,,,,,,,\\8,,,\\9"))))
  (save-excursion
    (set-buffer "411.csv")
    (if (file-exists-p "411.csv~")
	(delete-file "411.csv~"))
    (save-buffer-kill-buffer t))
  (set-buffer "411.txt")
  (if (file-exists-p "411.txt~")
      (delete-file "411.txt~"))
  (save-buffer-kill-buffer t)		;won't bytecompile on xemacs
  (delete-frame))

;;__________________________________________________________________________
;;;;		PILOT-MARK
;;htmlize: use &amp;#???;
(defvar pilot-mark "§" "*String to mark paragraphs for AportisDocs.")

(defun pilot-mark (arg)
  "Mark this spot (with ARG, this line) for AportisDoc bookmark."
  (interactive "*P")
  (unless arg
    (beginning-of-line 1))
  (insert pilot-mark " ")
  (save-restriction
    (save-excursion
      (goto-char (point-max))
      (skip-chars-backward (concat pilot-mark "<>\n"))
      (unless (looking-at (concat "\n<" pilot-mark ">\n"))
	(goto-char (point-max))
	(insert "\n<" pilot-mark ">\n")))))

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

(provide 'e-palm)
;;; e-palm.el ends here
