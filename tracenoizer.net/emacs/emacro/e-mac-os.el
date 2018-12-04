;;;; e-mac-os.el --- Routines for Emacs on classic Mac OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-02-16 10:45:15 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-mac-os.el,v 1.22 2003/05/24 17:37:01 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;;	Legal
;; 	Commentary
;; 	Code
;;		Mac Extended Fonts
;;		Key Mapping
;;		Applescript Launch Help
;;		Misc
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;;; Commentary:
;;Emacs editor startup file.  Mac Gnu Emacs routines
;;If you installed Emacs in ":diskname:emacs-20.4", it will
;;look for the .emacs file as ":diskname:emacs-20.4:mac:.emacs".

;;THIS FILE IS BEING DEPRECATED, AND MAY BE REMOVED FROM FUTURE RELEASES!!!

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		apple mac os macintosh

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(defgroup e-mac-os nil "Settings from e-mac-os.el file." :group 'emacro)
(require 'dired)

;;__________________________________________________________________________
;;;;	Mac Extended Fonts
(make-coding-system
 'mac-roman 4 ?M "Mac Roman Encoding"
 '(decode-mac-roman . encode-mac-roman)
;;Ascii: unknown function
;; '((safe-charsets (ascii mac-roman-lower mac-roman-upper))
;;   (valid codes (0 . 255)))
 )

;;__________________________________________________________________________
;;;;	Key Mapping
;;There are many collisions with Mac keys & Emacs standards :(

;;Toggle whether Command key acts like Esc key.
(put 'mac-command-key-is-meta 'standard-value (list 't))

(global-set-key [(control l)]	'forward-page) ;page down key
;;(global-set-key [(control k)]	'backward-page)	;override cut to end of line
;;(global-set-key [(control d)]	'end-of-line)	;end key overrides delete-char
(global-set-key [(control p)]	'help)	;f1 key override up line
;;(global-set-key [(control e)]	'help)	;help key override end of line

;;__________________________________________________________________________
;;		Applescript Launch Help
;;This enables the next line to launch ~/doc/index.html, using NetScape.
;;Internet Explorer needs to be worked on.
;;(do-applescript mac-ns-help)

(defun unix-pathlist-to-applescript (pathlist)
  "Convert unix path as list into applescript format.\
Assumes Startup Disk, and aliases are not allowed"
  (if (null (cdr pathlist)) nil
    ;;Get all but the top directory, which is called "startup disk"
    ;;but not "Macintosh HD".
    ;;This assumes that you run on the startup disk.
    (concat
     (concat (concat " of folder \"" (car pathlist)) "\"")
     (unix-pathlist-to-applescript (cdr pathlist)))))

(defun unix-pathname-to-applescript (path)
  "Convert absolute path of '/path/file' to\
 '\"file\" of folder \"path\" of startup disk"
  (let ((pathlist (reverse (split-string path "/"))))
    (concat (unix-pathlist-to-applescript pathlist) " of startup disk")))

(defcustom mac-ns-help
  (concat
   (concat
    "tell application \"Finder\"\r activate\r select file \"index.html\" of folder \"doc\" of folder \"emacs\""
    (unix-pathname-to-applescript (dirname emacro-top-dir)))
   "\r open selection\rend tell\rtell application \"Netscape Communicator?\"\r activate\r select window 1\rend tell\r")
  "Called as (do-applescript \"mac-ns-help\") in function.el's emacro-help().
   Applescript invoking Netscape and help HTML from help menu."
  :group 'e-mac-os
  :type 'string)

;;Here is an OS X OsaScript from Ian Boardman iandeb@attbi.com
;;http://iandeb.home.attbi.com/

;; #!/usr/local/bin/bash
;; # launches OmniWeb on argument URL

;; case "$1" in
;; *:*) ;;
;; *) set "http://$1"
;; esac

;; /usr/bin/osascript <<EOF
;; tell application "OmniWeb"
;;   activate
;;   GetURL "$1"
;; end tell
;; EOF

;;__________________________________________________________________________
;;;;	Misc
;; Here is where I keep my Emacs Lisp info files
(setq
 Info-default-directory-list
 '("~emacs/../elisp-manual-20-2.5/" "~emacs/info"))

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

(provide 'e-mac-os)
;;; e-mac-os.el ends here
