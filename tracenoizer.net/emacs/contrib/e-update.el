;;;; e-update.el --- Define user variables.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2002-07-29 18:58:54 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id$

;;__________________________________________________________________________
;;;;    TABLE OF CONTENTS
;;      Legal
;;      Commentary
;;      Code
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2002 Bruce Ingalls bingalls@sf.net
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls@users.sourceforge.net>
;;<url:http://www.sourceforge.net/projects/emacro>
;;<url:http://www.dotemacs.de/>
;;; Change Log:		See ChangeLog history file
;;; Keywords:		user configure configuration setup

;;__________________________________________________________________________
;;;; Code:
;;ToDo: remove this deprecated line:
;;(defgroup e-update nil "Settings from e-update.el file." :group 'emacro)

(defvar splash-frame-static-body)	;shut up compiler
(defvar splash-frame-static-body)	;shut up compiler
(defvar use-update)			;shut up compiler

;;__________________________________________________________________________
;;;;;;		ver-lessp
(defun ver-lessp (left right)
  "Return t if 3 digit left version < right version."
;;Check the first digit
  (cond
   ((< (string-to-int (car (split-string left "\\.")))
       (string-to-int (car (split-string right))))
    't)
   ((> (string-to-int (car (split-string left "\\.")))
       (string-to-int (car (split-string right))))
    'nil)

;;Else the first digits are equal. Repeat for next digit:
   (t
    (cond
     ((< (string-to-int (cadr (split-string left "\\.")))
	 (string-to-int (cadr (split-string right "\\."))))
	't)
     ((> (string-to-int (cadr (split-string left "\\.")))
	 (string-to-int (cadr (split-string right "\\."))))
	'nil)

;;XEmacs puts its last digit as "(patch 6)"
     (t
      (< (string-to-int (caddr (split-string left "\\(\\.\\|patch \\)")))
	 (string-to-int (caddr (split-string right "\\(\\.\\|patch \\)")))))))))
;;__________________________________________________________________________
(when (not (boundp 'use-update))
  (if
;;If this fast network runs on w32, ask the user, if this is a laptop.
;;Having the network unplugged hasn't been a problem on Linux & compatibles
      (and  use-net
	    (and (not use-modem)
		 (string-match "windows" (symbol-name system-type))))

      (if (y-or-n-p
	   "Allow internet check for updates? (n if MS Windows laptop) ")
	  ;;Append the results to preferences.el
	  (progn
	    (setq use-update 't)
	    (append-to-file
"(setq use-update 't)\n;;EMacro collects no info over the net. Set use-update to nil to prevent version download\n"
'nil pref-file))
	;;else use-update is false
	(progn
	  (setq use-update 'nil)
	  (append-to-file
"(setq use-update 'nil)\n;;EMacro collects no info over the net. Set use-update to nil to prevent version download\n"
'nil pref-file)))

;;else default use-update to 't for non windows, or no/slow net users
    (progn
      (setq use-update 't)
      (append-to-file
"(setq use-update 't)\n;;EMacro collects no info over the net. Set use-update to nil to prevent version download\n"
'nil pref-file))))


(defcustom emacro-allow-check t
  "EMacro collects no individual info about its users. Set this to nil to
disable checks for updates, if you are privacy paranoid, or for unlikely
faster startup."
  :group 'e-update
  :type 'boolean)
;;__________________________________________________________________________
;;;;		Version Check
;;If you said you've a fast net, EMacro tries to check web for upgrades
;;EMacro checks known hardcoded X/Emacs versions. Results into splash screen

(defconst emacro-ver-uri "http://emacro.sf.net/emacro.ver")
(defconst emacro-is-old nil)

(defconst emacro-hosting-site "emacro.sourceforge.net")
(defconst emacro-latest-revision nil "latest emacro revision available")

(defun emacro-latest-revision ()
  "obtain revision number of the most recent emacro available
   result in emacro-latest-revision
   note: doesn't handle http redirection, emacro-hosting-site must be right"
  (interactive)
  (condition-case nil (progn
    (setq emacro-latest-revision nil)
;;    (condition-case nil (delete-process "emacro-foo") (t nil))
;;    (condition-case nil (kill-buffer " emacro-foo") (t nil))
;;Next 2 defuns require X/Emacs >= v20.x
    (open-network-stream "emacro-foo" " emacro-foo" emacro-hosting-site 80)
    (process-send-string " emacro-foo" (concat
        "GET /emacro.ver HTTP/1.0\r\nHost: " emacro-hosting-site "\r\n\r\n"))
    (while (or (eq (process-status "emacro-foo") 'run)
               (eq (process-status "emacro-foo") 'open)) (sit-for 0.1))
    (with-current-buffer " emacro-foo" (progn
      (goto-char (point-max))
      (search-backward-regexp "^\\([0-9]+\\.[0-9]+\\.[0-9]+\\)$")
      (setq emacro-latest-revision (match-string 0))))
;;    (condition-case nil (delete-process "emacro-foo") (t nil))
;;    (condition-case nil (kill-buffer " emacro-foo") (t nil))
    )
    (t nil))
  emacro-latest-revision)

;;ToDo: Deprecate following code in favor of portable elisp code above
;;Alternatives are
;; w3m -dump http://emacro.sf.net/emacro.ver
;; curl -L http://emacro.sf.net/emacro.ver
;; wget -qO - http://emacro.sf.net/emacro.ver

;; wget is the fastest (for me) for this sort of one-shot retrieval:
;; wget 0.00user 0.00system 0:00.17elapsed 0%CPU
;; w3m  0.07user 0.01system 0:00.27elapsed 29%CPU
;; lynx 0.08user 0.06system 0:00.94elapsed 14%CPU
;; curl 0.00user 0.01system 0:01.18elapsed 0%CPU

;; (when (and use-net (not use-modem))
;; ;;See also links & other possible browsers
;;   (cond
;;    ((which "lynx")
;;     (when
;; 	(ver-lessp
;; 	 emacro-version
;; ;;lynx -source works here the same as lynx -dump
;; 	 (shell-command-to-string (concat "lynx -dump " emacro-ver-uri)))
;;       (setq emacro-is-old t)))
;;    ((which "links")
;;     (when
;; 	(ver-lessp
;; 	 emacro-version
;; 	 (shell-command-to-string (concat "links -source " emacro-ver-uri)))
;;       (setq emacro-is-old t)))
;;    ))

(when (and
       (and (and use-net (not use-modem)) emacro-allow-check))
  (emacro-latest-revision)
  (when (ver-lessp emacro-version emacro-latest-revision)
    (setq emacro-is-old t)))

(defconst emacro-splash-text "\n")
(when (string-match "Gnu" (emacs-version))
  (when emacro-is-old
    (defconst emacro-splash-text
	  (concat "\tAn EMacro UPGRADE is available!\n\n" emacro-splash-text)))

;;UPDATE EMACS VERSION HERE!
  (when (ver-lessp emacs-version "21.2.8")

    (defconst emacro-splash-text
	  (concat "\tAn Emacs UPGRADE is available!\n\n" emacro-splash-text))))

(when (not (string= emacro-splash-text "\n"))
  (if (and (string= window-system "x") (string= system-type "gnu/linux"))
      (setq
       fancy-splash-text
       (append
	(list
	 (list
	  :face 'bold
	  emacro-splash-text))
	fancy-splash-text))
;;Else splash screens for systems not as X Window on Linux:
    (let ((buffer (generate-new-buffer "MESSAGE")))
      (add-text-properties 0 (length emacro-splash-text)
			   '(face bold) emacro-splash-text)
      (switch-to-buffer buffer)
      (insert "\n\n\n" emacro-splash-text)
      (set-buffer-modified-p nil)
      (sit-for 7)
      (kill-buffer buffer))))

(when (string-match "xemacs" (emacs-version))
;;Currently, 21.4.x are Gamma releases; the 21.x branch are stable.

;;UPDATE XEMACS VERSION HERE
  (when (ver-lessp emacs-version "21.1.14")

    (setq splash-frame-static-body
	  (append (list '(face bold "\tA XEmacs UPGRADE is available!\n"))
		  splash-frame-static-body)))
  (when emacro-is-old
    (setq splash-frame-static-body
	  (append (list '(face bold "\tAn EMacro UPGRADE is available!\n"))
		  splash-frame-static-body)))
  (xemacs-splash-buffer))		;Force splash screen to be displayed

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

(provide 'e-update)
;;; e-update.el ends here
