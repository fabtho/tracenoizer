;;; e-net.el --- Internet apps for both GNU and X Emacs on all platforms
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-04-17 11:29:47 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-net.el,v 1.22 2003/05/24 17:37:01 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Internetworking
;;	Big Brother Database
;;	Email Batching, For Offline Work
;;	Email Receiving
;;		Email Receiving With POP3 & Rmail
;;		Import Linux Mozilla Mailbox
;;		Email Receiving With POP3 & Vm
;;		Reading Mail
;;		Email Receiving With Vm: View Mail
;;	Email Sending
;;	News Reader/GNUS
;;	SSH
;;	Telnet
;;	Tiny Mail
;;	TRAMP
;;	Web Browser
;;	W3 Web Browser
;;	Watson Web Search
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;;; Commentary:
;;Emacs editor startup file.  Internet routines for every OS, for both Gnu &
;;X Emacs

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;;; Keywords:		advanced power user enhanced miscellaneous applications

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;;; Defcustoms
(defgroup e-net nil "Settings from e-net.el file." :group 'emacro)
(defcustom vm-pop-expunge-after-retrieving nil
  "t if vmail has read email, and you wish to delete it from the server.
Note that this always leaves a copy of email on the client."
  :group 'e-net
  :type 'boolean)

;;__________________________________________________________________________
(require 'which)
(require 'e-functions)

(cache-locate-library
 use-cache 'cache-dired "dired"
 "For printing support, get dired.el from full XEmacs sumo tarball")
(when cache-dired (require 'dired))

;;__________________________________________________________________________
;;;;	Internetworking

(autoload 'slashdot "slashdot" "web news for nerds" t)
(when (string-match "XEmacs" (emacs-version))
  (defvar cache-overlay)		;shut up compiler
  (cache-locate-library
   use-cache 'cache-overlay "overlay"
   "To Shift Middle-mouse click email addresses, get overlay.el from the full XEmacs sumo tarball")
  (when cache-overlay (require 'overlay)))

;;__________________________________________________________________________
;;;;		Big Brother Database
;;bundled in newer emacs
;;Builds an email addr book by capturing traffic Doesn't work on some Emacs
;;Try hitting ":" in a bbdb supported mode (gnus, vm), and it should add an
;;address to the database.
(defvar cache-bbdb)
(cache-locate-library
 use-cache 'cache-bbdb "bbdb"
 "To capture email addresses into database, get bbdb from <url:http://pweb.netcom.com/~simmonmt/bbdb/>")

(when cache-bbdb
  ;;   (require 'bbdb)
  ;;   (require 'bbdb-hooks)

  ;;   (bbdb-initialize)	;should do all autoloads, but not insinuations
;;(put 'gnus-optional-headers 'standard-value (list 'bbdb/gnus-lines-and-from))
  (set-default 'gnus-optional-headers 'bbdb/gnus-lines-and-from)

  (autoload 'bbdb/gnus-lines-and-from "bbdb-gnus")
  (autoload 'bbdb         "bbdb-com" "Insidious Big Brother Database" t)
  (autoload 'bbdb-name    "bbdb-com" "Insidious Big Brother Database" t)
  (autoload 'bbdb-company "bbdb-com" "Insidious Big Brother Database" t)
  (autoload 'bbdb-net     "bbdb-com" "Insidious Big Brother Database" t)
  (autoload 'bbdb-notes   "bbdb-com" "Insidious Big Brother Database" t)
  (autoload 'bbdb-insinuate-vm       "bbdb-vm"    "Hook BBDB into VM")
  (autoload 'bbdb-insinuate-rmail    "bbdb-rmail" "Hook BBDB into RMAIL")
  (autoload 'bbdb-insinuate-gnus     "bbdb-gnus"  "Hook BBDB into GNUS")
  (autoload 'bbdb-insinuate-sendmail "bbdb"      "Hook BBDB into sendmail")

  (set-default 'rmail-mode-hook 'bbdb-insinuate-rmail)
  (set-default 'gnus-startup-hook 'bbdb-insinuate-gnus)
  (set-default 'mail-setup-hook 'bbdb-insinuate-sendmail)
  (set-default 'bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook)
  (set-default 'bbdb-send-mail-style 'message)
  (set-default 'bbdb-ignore-some-messages-alist
	       '(("From" . "id\\|username\\|mailer.daemon")
		 ("Sender" . "localhost.com\\|id")))

  ;;(global-set-key [(control f5)]	'bbdb-create)
  ;;(global-set-key [(meta f5)]	'bbdb)
  ;;(setq bbdb-use-pop-up nil)	;;gnus
  ;;(setq bbdb/mail-auto-create-p nil)

;;Number of lines in popup
  (set-default 'bbdb-pop-up-target-lines '7)

  ;;See i18n for eastern hemisphere phone numbers

  ;;prevent recurring prompts to add a name:
  ;;   (setq bbdb-quiet-about-name-mismatches t
  ;;	 bbdb-always-add-addresses 'frob)

  ;;This should grab reply-to addr instead of from addr:
  (set-default 'sc-attrib-selection-list
	       '(("sc-from-address"
		  (("*" . (bbdb/sc-consult-attr
			 (sc-mail-field "sc-from-address"))))))))

;;__________________________________________________________________________
;;;;		Email Batching, For Offline Work
;;(setq send-mail-function 'feedmail-send-it)
;;(autoload 'feedmail-send-it "feedmail")
;;(autoload 'feedmail-run-the-queue "feedmail")
;;(setq feedmail-buffer-eating-function 'feedmail-buffer-to-smtpmail)
;;(setq feedmail-enable-queue t)		;optional
;;(setq feedmail-queue-chatty nil)		;optional

;;__________________________________________________________________________
;;;;		Email Receiving

;;__________________________________________________________________________
;;;;;;		Email Receiving With POP3 & Rmail
;;(setenv "MAILHOST" use-pop3)
(defvar rmail-pop-password-required)
(defvar rmail-primary-inbox-list)
(set-default 'rmail-primary-inbox-list '(concat "po:" use-login-name))
(set-default 'rmail-pop-password-required 't)

;;__________________________________________________________________________
;;;;;;		Import Linux Mozilla Mailbox

;;UNCOMMENT & USE AT YOUR OWN RISK!

;;Code might be useful, to read user.prefs, to set defaults in e-config.el

;;This code works. You would have to uncomment "use-moz-maildir" in the next
;;section. However, there are conditions (such as INBOX.CRASH) where emacs
;;appears to move messages from Mozilla's Inbox to its own file, even when
;;vm-pop-expunge-after-retrieving is nil

;;Elisp code to search the w32 registry to find the mail folder is welcome!
;;otoh, we could assume a modern w32, with a profile folder...
;;(when (not (boundp 'use-moz-maildir))
;;  (if (not (file-exists-p "~/.mozilla"))
;;      (append-to-file
;;       "(setq use-moz-maildir 'nil)\t;~/.mozilla does not exist\n"
;;		      'nil pref-file)
;;    (progn				;else find Mozilla mail dir
;;There are 3 dirs in the Moz default dir: . .. and some name with a letter
;;     (setq use-moz-maildir
;;	   (car (directory-files "~/.mozilla/default/" t "[a-z]")))
;;EMacro only looks at the Inbox folder:
;;     (setq use-moz-maildir
;;	   (car (directory-files
;;		 (format "%s/Mail/%s/" use-moz-maildir use-pop3)
;;		 t "Inbox")))
;;     (append-to-file
;;      (concat (concat "(setq use-moz-maildir \"" use-moz-maildir) "\")\n")
;;      'nil pref-file))))

;;__________________________________________________________________________
;;;;;;		Email Receiving With POP3 & Vm
(defvar use-pop3)			;shut up compiler
(when (boundp 'use-pop3)
  (set-default 'vm-spool-files
	       (list
		 (concat (concat use-pop3 ":") use-login-name)
		 "~/INBOX"
;;See Get Linux Mozilla Mailbox section above:
;;		 use-moz-maildir
		 "~/INBOX.CRASH"
		 )))

;;Search /etc/services for "pop". Here are some typical port values:
;;	(concat (concat use-pop3 ":109:") use-login-name)
;;	(format "%s:110:pass:POP %s:*" use-pop3 use-login-name)


;;__________________________________________________________________________
;;;;;;		Reading Mail
;; (other backends can be substituted for nnml)
;;(setq gnus-secondary-select-methods '((nnml "")))
;;(setq nnmail-spool-file "po:POP user name")
;;(setq nnmail-pop-password-required t)

;;__________________________________________________________________________
;;;;;;		Email Receiving With Vm: View Mail
(defvar cache-vm)
(cache-locate-library use-cache 'cache-vm "vm-version"
 "For better email support, get vm from <url: http://www.wonderworks.com/vm/download.html >")
(when cache-vm (load-library "vm"))

;;__________________________________________________________________________
;;;;		Email Sending
;;Note that IMAP does not send email...

(autoload 'smtpmail-via-smtp "smtpmail" "smtp mail." t)
(autoload 'user-mail-address "smtpmail" "smtp mail." t)
;;(require 'smtpmail)
(defvar use-smtp)			;shut up compiler
(when (boundp 'use-smtp)
  (set-default 'mail-host-address 'use-smtp)
  (set-default 'smtpmail-default-smtp-server 'use-smtp)
  (set-default 'smtpmail-smtp-server 'use-smtp))

(set-default 'query-user-mail-address 'nil)

;;(defconst message-default-headers "Reply-To: otherid@other.server.com\n")
;;(setq smtpmail-local-domain nil)
;;(setq send-mail-function 'smtpmail-send-it)
;;(defvar mail-default-reply-to)(setq mail-default-reply-to use-email-addr)

;;Toggle signature at email bottom
(set-default 'mail-signature 't)

;; For sending mail. Choose one of the following:
;;	message-send-mail-with-sendmail (default)
;;	message-send-mail-with-mh
;;	message-send-mail-with-qmail
;;	smtpmail-send-it
;;(setq message-send-mail-function 'smtpmail-send-it)

;; For sending mail.
;;(setq send-mail-function 'smtpmail-send-it)

;;(setq sendmail-program (which-first "sendmail"))
;;(setq sendmail-program "/usr/sbin/sendmail -i -t -froot@localhost.com")
;;(setq sendmail-program (format "/usr/lib/sendmail -i -t -f%s" use-email-addr))

;;(load-library "mutt")		;<url:http://www.mutt.org>

;;(setq smtpmail-code-conv-from nil)
;;(setq mail-self-blind t)

;;(require 'message)
;;(setq message-send-mail-function 'smtpmail-send-it)     ; for gnus/message

;;(setq smtpmail-smtp-service 25)
;;(setq smtpmail-debug-info t)

;;__________________________________________________________________________
;;;;		News Reader/GNUS
;;GNUS works with EMacro, but is outside its scope.
;;Visit <url: http://www.gnus.org/ > for proper support.
(autoload 'sort-subr "sort" "sort routines." t)
(autoload 'gnus "gnus" "gnus nntp usenet news reader." t)

;;(setq mail-use-rfc822 t) ;;uncomment for exact, but slow parsing

;;__________________________________________________________________________
;;;;		SSH
;;Regular expression to prevent display of password during SSH login.
;;Uncomment, if your older Emacs causes problems
;;(set-default 'comint-password-prompt-regexp
;;	     "^\\(\\([^@]+@[^']+'s \\|[Oo]ld \\|[Nn]ew \\)[Pp]assword\\|pass phrase\\):\\s *\\'")

;;Toggle bottom always displayed
;;(put 'comint-scroll-to-bottom-on-input 'standard-value (list 't))
(set-default 'comint-scroll-to-bottom-on-input 't)

;;Toggle shell display
;;(put 'comint-scroll-show-maximum-output 'standard-value (list 't))
(set-default 'comint-scroll-show-maximum-output 't)

;;Toggle shell display
;;(put 'comint-show-maximum-output 'standard-value (list 't))
(set-default 'comint-show-maximum-output 't)

;;__________________________________________________________________________
;;;;		Telnet
;;See also w32.el
(autoload 'telnet "telnet" "telnet." t)

;;;__________________________________________________________________________
;;;;;		Tiny Mail
(defvar cache-tinymail)
(defvar cache-tinyrmail)
(cache-locate-library use-cache 'cache-tinymail "tinymail"
 "For better email support, get tinymail from <url: http://tiny-tools.sourceforge.net/ >")
(when cache-tinymail
  (autoload 'turn-on-tinymail-mode "tinymail" "" t)
  (add-hook 'mail-setup-hook   'turn-on-tinymail-mode)
  (add-hook 'message-mode-hook 'turn-on-tinymail-mode))

(cache-locate-library use-cache 'cache-tinyrmail "tinyrmail"
 "For better email support, get tinyrmail from <url: http://tiny-tools.sourceforge.net/ >")
(when cache-tinyrmail
  (autoload 'tirm-rmail-summary-by-labels-and "tinyrmail" t t)
  (autoload 'tirm-install			"tinyrmail" t t)
  (add-hook 'rmail-mode-hook			'tirm-install))

;;__________________________________________________________________________
;;;;		TRAMP
;;Tramp lets you edit files remotely, using ssh, telnet, rcp.
;;See also efs or ange-ftp. Simply open files with
;;	C-x C-f
;;	/r:host:/path/file.name

;;ToDo: This could be fanicier, by probing for ssh, mimencode, etc in PATH
(defvar cache-tramp)
(cache-locate-library
 use-cache 'cache-tramp "tramp"
 "To edit remote files via ssh, get TRAMP from <url:http://tramp.sourceforge.net/>")

(when cache-tramp
  (require 'env)
  (require 'tramp)
;;   (defcustom tramp-debug-buffer nil "Toggle tramp debugging."
;;     :group 'e-net
;;     :type 'boolean)

;;ToDo: add the other possible Tramp methods:
(cond
 ((and (not use-net) (which "su"))	;No network? Try 'su'
  (set-default 'tramp-default-method "su"))
 ((which "plink")			;putty on w32
  (set-default 'tramp-default-method "plink"))
 ((which "ssh")
;;Inline ssh for remote editing. Similar to the less secure Ange-ftp/EFS
  (set-default 'tramp-default-method "ssh1"))))

;;Note: even if you have ssh v2, you might get annoying extra prompts, which
;;cause difficulty for TRAMP. Solve this with ssh v1.x

;;__________________________________________________________________________
;;;;		Watson Web Search
;;M-x watson searches the web for the word at the cursor
(cache-locate-library
 use-cache 'cache-watson "watson"
 "For web searching support, get watson from <URL:http://www.chez.com/emarsden/downloads/watson.el>")

(autoload 'edmacro-mode "edmacro" "edmacro mode." t)
(autoload 'watson "watson" "watson internet search engine." t)

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

(provide 'e-net)

;;; e-net.el ends here
