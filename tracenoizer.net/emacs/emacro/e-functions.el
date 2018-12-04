
;;; e-functions.el --- Routines for both GNU and X Emacs on all platforms
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <03/07/08 12:53:52 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-functions.el,v 1.22 2003/05/24 17:37:00 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;		eol definition
;;	Functions
;;		add-to-info-path
;;		backward-tab-to-tab-stop
;;		bell
;;		beginning-of-next-line
;;		cache-locate-library
;;		choose-from-menu
;;		color-print
;;		cygwin-follow-symlink
;;		debug-on-error
;;		delete-buffer
;;		desktop-height-approx
;;		dirname
;;		dos-unix
;;		emacro-load
;;		emacro-help
;;		emacro-refresh-cache
;;		emacro-require
;;		emacro-stamp-append
;;		emacro-stamp-file
;;		goto-matching-paren
;;		insert-date
;;		just-one-line
;;		kill-junk-buffers
;;		moz-get-prefs
;;		my-add-hook
;;		my-gnus-summary-show-thread
;;		my-gnus-topic-show-topic
;;		prev-other-window
;;		query-replace-last-two-kills
;;		redo
;;		remove-empty-email-quotes
;;		replace-all-buffers
;;		replace-in-string
;;		reverse-windows
;;		shell plugin example
;;		sort-lines-ignore-case
;;		split-window-recent
;;		toggle-line-wrap
;;		touch-buffer
;;		unix-dos
;;		which-first
;;		write-file-no-select
;;		yank-and-indent

;;__________________________________________________________________________
;;; Legal:
;;Copyright ŽÂŽŽ© 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file.  Function definitions for every OS, for both Gnu &
;;X Emacs

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls(at)users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		miscellaneous functions


;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
(require 'cl)                           ;used by trailing whitespace code

;;__________________________________________________________________________
;;;;;;		eol definition
;;Set End Of Line char
(cond ((or (string-match "Macintosh" (emacs-version))
           (string-match "windows" (symbol-name system-type)))
       (defconst eol "\r"))             ;CRLF for Mac & W32
      (t (defconst eol "\n")))          ;else \n for Linux compatibles

;;__________________________________________________________________________
;;;;	Functions
;;Miscellaneous defuns. These usually need to be loaded first.
;;These functions will be moved or removed, to reduce bloat, as they become
;; available elsewhere.

;;__________________________________________________________________________
;;;;;;		add-to-info-path
(defun add-to-info-path (path)
  "Portablility layer to append to info-list. Path is a full directory."

(if (string-match "GNU" (emacs-version)) ;Emacs syntax:
    (add-to-list 'Info-default-directory-list path)
  ((add-to-list 'Info-directory-list path)))) ;else XEmacs v21+ syntax:
		
;;__________________________________________________________________________
;;;;;;		backward-tab-to-tab-stop
;;From lawrence mitchell <wence(at)gmx.li>
(defun backward-tab-to-tab-stop ()
  "Go to the previous tab-stop.
Reverses `tab-to-tab-stop', but stops before column zero."
  (interactive)
  (and abbrev-mode (= (char-syntax (preceding-char)) ?w)
       (expand-abbrev))
  (let ((tabs (reverse tab-stop-list)))
    (while (and tabs (<= (current-column) (car tabs)))
      (setq tabs (cdr tabs)))
    (if tabs
        (let ((opoint (point)))
          (skip-chars-backward " \t")
          (delete-region (point) opoint)
          (indent-to (car tabs)))
      (insert ?\ ))))

;;__________________________________________________________________________
;;;;;;		basename
(defun basename (file) (interactive) (file-name-nondirectory file))

;;__________________________________________________________________________
;;;;;;		bell
(defun bell () (interactive) (ding))

;;__________________________________________________________________________
;;;;;;		beginning-of-next-line
;; Jump to beginning of the next line if possible.
(defun beginning-of-next-line()
  "Moves cursor to the beginning of the next line, or nowhere if at end of the buffer"
  (interactive)
  (end-of-line)
  (if (not (eobp))
      (forward-char 1)))

;;__________________________________________________________________________
;;;;;;		cache-locate-library
(defun cache-locate-library (cache var lib msg)
  "Speeds up locate-library()
   First check cache for var, to confirm that lib is in load-path.
   If var is not in cache, run locate-library and save results to cache, and
   print msg. msg typically tells user where to get lib"
  (when (not (boundp var))
    (if (locate-library lib)
        (progn
          (append-to-file
           (concat (concat
                    (concat "(defconst ") (symbol-name var) " t)") eol)
           'nil cache)
          (set var 't))
      ;;else
      (progn
        (append-to-file
         (concat
          (concat
           (concat
            (concat "(defconst ") (symbol-name var) " nil)	;") msg) eol)
         'nil cache)
        (set var 'nil)))))

;;__________________________________________________________________________
;;;;;;		choose-from-menu
;;From Sandip Chitale <sandipchitale(at)attbi.com>

;;EXPECT THIS CODE TO CHANGE IN FUTURE RELEASES!!!

(defun choose-from-menu (menu-title menu-items)
  "Choose from a list of choices from a popup menu.
See `popup-commands' which calls this"
  (let ((item)
 (item-list))
    (while menu-items
      (setq item (car menu-items))
      (if (consp item)
   (setq item-list (cons (cons (car item) (cdr item) ) item-list))
 (setq item-list (cons (cons item item) item-list)))
      (setq menu-items (cdr menu-items))
      )
    (x-popup-menu t (list menu-title (cons menu-title (nreverse item-list))))))

;;__________________________________________________________________________
;;;;;;		color-print
(autoload 'ps-print-buffer-with-faces "ps-print" "ps-print" t)
(defun color-print ()
  (interactive)
  (set-face-background 'default "white")
                                        ; (setq-default ps-print-color-p t)
  (defconst ps-print-color-p t)
  (ps-print-buffer-with-faces)
  (set-face-background 'default "grey80"))

;;__________________________________________________________________________
;;;;;;		cygwin-follow-symlink
(defun follow-cygwin-symlink ()
  (save-excursion
    (goto-char (point-min))
    (if (re-search-forward "\\=!<symlink>\\(.*\\)\000" nil t)
	(find-alternate-file (match-string 1)))))

;;__________________________________________________________________________
;;;;;;		debug-on-error
(defun debug-on-error ()
  "Toggle variable 'debug-on-error'."
  (interactive)
  (setq debug-on-error (not debug-on-error))
  (message "debug-on-error=%s" debug-on-error))
(global-set-key [(super c) d] 'debug-on-error)

;;__________________________________________________________________________
;;;;;;		delete-buffer
(defun delete-buffer()
  "Tries `delete-frame', then `delete-window', then `kill-buffer'."
  (interactive)
  (condition-case err		;Handle any exceptions
      (delete-frame)
    (error
     (condition-case err
	 (delete-window)
       (error
	(condition-case err
	    (kill-buffer nil)
	  (error (message "No buffers, frames, nor windows to close"))))))))

;;__________________________________________________________________________
;;;;;;		desktop-height-approx
;;This function assumes that if a desktop taskbar is running, that it is
;; visible, and either at the default bottom, or at top.
(require 'which)			;get from <url: http://emacro.sf.net/ >

(defun desktop-height-approx () (interactive)
  "Returns the number of chars of approximate GUI desktop height.
Returns a value 1 or 6, if on X Window, with no `ps` command.
Returns 24 for a tty or console, regardless of actual LINES.
Tested for Emacs & XEmacs on w32 and X Window."

  (when (not (fboundp 'frame-char-height))
      (defun frame-char-height (&optional frame)
	"From w3/css.el, for the benefit of XEmacs users. Built into Emacs."
	(font-height (face-font 'default frame))))

  (cond
   ((eq window-system 'x)

;;Some systems have taskbars/panels, which we must decrease height for
;;shell-command-to-string() requires emacs > 20.1?
;;This probe slows performance by ~1 second.
;;EMacro caches results after first time.

    (if (which "ps")
	   (let ((use-ps (shell-command-to-string "ps -u $USER")))
	     (cond

;;ToDo: Send me the exe names for CDE, OSX, and other taskbars!
	      ((string-match "gnome-panel" use-ps)
	       (/ (- (x-display-pixel-height) 125) (frame-char-height)))

	      ((string-match "kdeinit\\|startkde" use-ps)
	       (/ (- (x-display-pixel-height) 125) (frame-char-height)))
	    
	      ((string-match "englightenment\\|fvwm95\\|afterstep" use-ps)
	       (/ (- (x-display-pixel-height) 156) (frame-char-height)))

	      (t	 ;Else no known panel. Subtract space for title bar(?)
	       (/ (- (x-display-pixel-height) 60) (frame-char-height)))))
	 6))				;Else return 6 for X window with no ps

    (window-system			;all other GUIs
     (/(-(x-display-pixel-height)70)(frame-char-height)))
    (t 24)))		;Else return 24 for tty, regardless of actual size

;;__________________________________________________________________________
;;;;;;		dirname
(defun dirname (file) (interactive) (or (file-name-directory file) ""))

;;__________________________________________________________________________
;;;;;;		dos-unix
(defun dos-unix () "Convert dos crlf to unix \n." (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;;__________________________________________________________________________
;;;;;;		emacro-load
(defun emacro-load (arg)
  "Checks for tiny-load, else uses load-library.
Should happen before (require 'tinyload) at end of e-config."
  (if cache-tinyload			;if tiny-load in load-path
      (setq tinyload-:load-list
	    (append tinyload-:load-list (list arg)))
    (load-library arg)))		;else regular load

;;__________________________________________________________________________
;;;;;;		emacro-help
;;Shut up compiler on non Mac OS systems:
(when (not (fboundp 'do-applescript)) (defun do-applescript (arg)))
(autoload 'browse-url "browse-url" "browse-url" t) ;shut up compiler
(defvar use-modem)			;shut up compiler
(defvar emacro-version)			;shut up compiler

(defun emacro-help () "Pop up HTML help file in browser." (interactive)
  (if
   (string-match "Macintosh" (emacs-version))
    (progn                              ;Detects MacOS Emacs, not MacOS XEmacs
      (require 'mac)
      (do-applescript "mac-ns-help"))	;Internet Explorer not supported on Mac

;;Else for all but Classic Mac OS (v8-9):
	(browse-url (format "file://%s/doc/index.html" emacro-top-dir))))

;;__________________________________________________________________________
;;;;;;		emacro-refresh-cache
;;Not as thorough as the shell scripts, but catches the important/typcal cases

(defun emacro-refresh-cache() "Deletes cache files in ~/emacs/preferences."
  (interactive)
  (condition-case err
      (delete-file (concat emacro-prefs-dir "e-cache.el"))
    (error nil))
  (condition-case err
      (delete-file (concat emacro-prefs-dir "e-xcache.el"))
  (error nil)))

;;__________________________________________________________________________
;;;;;;		emacro-require
(defun emacro-require (arg)
  "Checks for tiny-load, else uses require.
Should happen before (require 'tinyload) at end of e-config."
  (if cache-tinyload			;if tiny-load in load-path
      (setq tinyload-:load-list
	    (append tinyload-:load-list (list (format "%s" arg))))
    (require arg)))			;else regular load

;;__________________________________________________________________________
;;;;;;		emacro-stamp-append
(defun emacro-stamp-append (filename) "Write notice & version at top of file."
  (append-to-file
";;To enable Elisp Libs listed as 'nil' (not found), download them into the
;;load-path, such as ~/emacs/packages/ then delete this file to rebuild it.\n"
  'nil
  filename))

;;__________________________________________________________________________
;;;;;;		emacro-stamp-file
(defun emacro-stamp-file (filename) "Write notice & version at top of file."
  (if (not (file-readable-p filename))
      (progn
	(append-to-file
	 (concat
	  (concat ";;This file generated by EMacro v" emacro-version)
	  "\n;;If you edit this file, be sure to back up.\n")
	 'nil
	 filename)
	't)
    'nil))

;;__________________________________________________________________________
;;;;;;		goto-match-paren
;;vi-style: Cause the [C-] % key to jump to matching brace
;;See the C-% binding in keys.el

(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;;__________________________________________________________________________
;;;;;;		insert-date
(defun insert-date ()  "Insert date at point."  (interactive)
  (insert (format-time-string "%a %b %e, %Y %l:%M %p")))

;;__________________________________________________________________________
;;;;;;		just-one-line
(defun just-one-line (begin end)
  "Replace multiple blank lines with one in region BEGIN and END.
Recommend: run 'cw/trailing-whitespace' first."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region begin end)
      (goto-char (point-min))
      (while (re-search-forward "\n\\(\n\\)+" nil t)
	(replace-match "\n\n")))))

;;__________________________________________________________________________
;;;;;;		kill-junk-buffers
;;Remove unused buffers by Juergen Nickelsen <jnickelsen(at)acm.org>
(defvar junk-buffer-regexps
  '("^\\*cvs-"
    "^\\*cvs\\*$"
    "^\\*Completions\\*$"
    "^\\*Help\\*$"
    "^\\*compilation\\*"
    "^\\*grep\\*"
    "^\\*gdb-"
    "^\\*vc\\*"
    "^\\*Shell "
    "^\\*Buffer List\\*")
  "List of regexps for names of buffers considered junk.
Buffers with names matching any of these regexps will be deleted without
question by 'kill-junk-buffers'.")

(defun ni-filter (predicate list)
  "Apply PREDICATE to all members of LIST and return a list of those members
for which PREDICATE returns non-nil."
  (let ((result-list ()))
    (while list
      (if (apply predicate (list (car list)))
	  (setq result-list (cons (car list) result-list)))
      (setq list (cdr list)))
    result-list))

(defun kill-junk-buffers ()
  "Kill all buffers matching one of 'junk-buffer-regexps'."
  (interactive)
  (let* ((junk-buffer-regexp
	  (apply #'concat
		 (cons (concat "\\(" (car junk-buffer-regexps) "\\)")
		       (mapcar #'(lambda (regexp)
				   (concat "\\|\\(" regexp "\\)"))
			       (cdr junk-buffer-regexps))))))
    (mapcar #'kill-buffer
	    (ni-filter #'(lambda (buffer)
			   (string-match junk-buffer-regexp
					 (buffer-name buffer)))
		       (buffer-list)))))

;;__________________________________________________________________________
;;;;;;		moz-get-prefs
(defun moz-get-prefs (key)
  "Returns value in prefs.js corresponding to key. key is line in prefs.js
file, up to desired value (which is followed by closing double quote).
Returns nil, if no key or value not found. Requires the variable
moz-prefs-filename, which is set in e-config.el."

  (with-temp-buffer
    (condition-case err
	(insert-file-contents-literally moz-prefs-filename)
      (error 'nil))
    (if (re-search-forward key nil t)
	(setq server (match-string 1))
      'nil)))

;;__________________________________________________________________________
;;;;;;		my-add-hook
(defun my-add-hook (hook function &optional append)
  "Add to the value of HOOK the function FUNCTION unless already present.
\(It becomes the first hook on the list unless optional APPEND is non-nil, in
which case it becomes the last).  HOOK should be a symbol, and FUNCTION may be
any valid function.  HOOK's value should be a list of functions, not a single
function.  If HOOK is void, it is first set to nil."
  (or (boundp hook) (set hook nil))
  (or (if (consp function)
	  ;; Clever way to tell whether a given lambda-expression
	  ;; is equal to anything in the hook.
	  (let ((tail (assoc (cdr function) (symbol-value hook))))
	    (equal function tail))
	(memq function (symbol-value hook)))
      (set hook
	   (if append
	       (nconc (symbol-value hook) (list function))
	     (cons function (symbol-value hook))))))
(if (not (fboundp 'add-hook)) (fset 'add-hook 'my-add-hook))

;;__________________________________________________________________________
;;;;;;		 my-gnus-summary-show-thread
;;require is needed. autoload isn't good enough.
(autoload 'gnus-summary-show-thread "gnus-sum" "Usenet news." t)
(if (condition-case nil
	(require 'gnus-sum)
      (error nil))
    (progn
      ;;shut up compiler:
      (defvar gnus-summary-mode-map)
      (defvar my-gnus-summary-show-thread)
      (defun my-gnus-summary-show-thread ()
	"Show thread without changing cursor positon."
	(interactive)
	(gnus-summary-show-thread)
	(beginning-of-line)
	(forward-char 1))
      (define-key gnus-summary-mode-map [(right)]
	'my-gnus-summary-show-thread)
      (define-key gnus-summary-mode-map [(left)]
	'gnus-summary-hide-thread)
      (defconst gnus-thread-hide-subtree t)
      )
  ;;else
  (message
   "For usenet NNTP news support, get gnus from the full XEmacs distribution or <url:http://www.gnus.org/>"))

;;__________________________________________________________________________
;;;;;;		 my-gnus-topic-show-topic
(autoload 'gnus-group-topic-p "gnus-topic" "Usenet news." t)
(autoload 'gnus-topic-show-topic "gnus-topic" "Usenet news." t)
(autoload 'gnus-topic-read-group "gnus-topic" "Usenet news." t)
(if (condition-case nil
        (require 'gnus-topic)
      (error nil))
    (progn
      ;;shut up compiler:
      (defvar gnus-group-topic-p)
      (defvar gnus-topic-show-topic)
      (defvar gnus-topic-read-group)
      (defun my-gnus-topic-show-topic () "Show the hidden topic."
	(interactive)
	(if (gnus-group-topic-p)
	    (gnus-topic-show-topic)
	  (gnus-topic-read-group)))

      (add-hook
       'gnus-started-hook
       '(lambda ()
	  (define-key gnus-topic-mode-map [(right)] 'my-gnus-topic-show-topic)
	  (define-key gnus-topic-mode-map [(left)]  'gnus-topic-hide-topic)
	  ))
      )
  ;;else
  (message
   "For usenet NNTP news support, get gnus from the full emacs distribution or <url:http://www.gnus.org/>"))

;;__________________________________________________________________________
;;;;;;		prev-other-window
(defun prev-other-window () "Switch to last child frame."
  (interactive)
  (other-window -1))
;;(global-set-key [(control iso-left-tab)] 'prev-other-window)
;;see also completions in poweruser.el for tab keybinding

;;__________________________________________________________________________
;;;;;;		query-replace-last-two-kills
;;From: sandipchitale(at)yahoo.com (Sandip Chitale)
(defun query-replace-last-two-kills (&optional arg)
  "Query replace 1st item on the kill ring with 0th item.
With prefix arg Query replace 0th item on the kill ring with 1st item."
  (interactive "P")
  (if (> (length kill-ring) 1)
      (progn
;;ToDo: emacs autoloads from simple.el. Where does xemacs?
	(deactivate-mark)
	(beginning-of-buffer)       
	(query-replace (nth (if arg 0 1) kill-ring)
		       (nth (if arg 1 0) kill-ring)))))

;;__________________________________________________________________________
;;;;;;		redo
(when (not (fboundp 'redo))		;XEmacs already has undo
  (defun redo() "Reverses the effect of `undo'."
    (interactive)
;;break up an undo. Deal with the case of cursor at end of file
    (condition-case err
	(progn
	  (forward-char)
	  (backward-char))
      (error
       (backward-char)
       (forward-char)))
    (undo)))

;;__________________________________________________________________________
;;;;;;		remove-empty-email-quotes
(defun remove-empty-email-quotes () "Trim blank '>' lines in replies to email."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^[ \t]*>[ \t>]*$" nil t)
      (replace-match ""))))

;;__________________________________________________________________________
;;;;;;		replace-all-buffers
(defun replace-all-buffers (from-str to-str)
  "Replaces from-str with to-str in all buffers"
  (interactive (progn (setq from-str (read-from-minibuffer "Replace string: "))
		      (setq to-str (read-from-minibuffer
                                    (format "Replace %s with: " from-str)))
		      (list from-str to-str)))

  (let ((buffs (buffer-list))
	(current-buffer (current-buffer)))
    (while (car buffs)
      (switch-to-buffer (buffer-name (car buffs)))
      (let ((pos (point)))
	(goto-char 0)
	(query-replace from-str to-str)
	(goto-char pos))
      (setq buffs (cdr buffs)))
    (switch-to-buffer current-buffer)))

;;__________________________________________________________________________
;;;;;;		replace-in-string
;;Modified from XEmacs: lisp/prim/subr.el string() changed to char-to-string()

(defun replace-in-string (str regexp newtext &optional literal)
  "Replaces all matches in STR for REGEXP with NEWTEXT string,
 and returns the new string.
Optional LITERAL non-nil means do a literal replacement.
Otherwise treat \\ in NEWTEXT string as special:
  \\& means substitute original matched text,
  \\N means substitute match for \(...\) number N,
  \\\\ means insert one \\."
;;;  (check-argument-type 'stringp str)
;;;  (check-argument-type 'stringp newtext)
  (let ((rtn-str "")
        (start 0)
        (special)
        match prev-start)
    (while (setq match (string-match regexp str start))
      (setq prev-start start
            start (match-end 0)
            rtn-str
            (concat
             rtn-str
             (substring str prev-start match)
             (cond (literal newtext)
                   (t (mapconcat
                       (lambda (c)
                         (if special
                             (progn
                               (setq special nil)
                               (cond ((eq c ?\\) "\\")
                                     ((eq c ?&)
                                      (substring str
                                                 (match-beginning 0)
                                                 (match-end 0)))
                                     ((and (>= c ?0) (<= c ?9))
                                      (if (> c (+ ?0 (length
                                                      (match-data))))
                                          ;; Invalid match num
                                          (error "Invalid match num: %c" c)
                                        (setq c (- c ?0))
                                        (substring str
                                                   (match-beginning c)
                                                   (match-end c))))
                                     (t (char-to-string c))))
                           (if (eq c ?\\) (progn (setq special t) nil)
                             (char-to-string c))))
                       newtext ""))))))
    (concat rtn-str (substring str start))))

;;__________________________________________________________________________
;;;;;;		reverse-windows
(defun reverse-windows ()
  "Switch the current window and the next window."
  (interactive)
  (if (> (count-windows) 1)
      (let ((first-buffer (window-buffer (selected-window)))
            (second-buffer (window-buffer (next-window (selected-window)))))
        (set-window-buffer (selected-window) second-buffer)
        (set-window-buffer (next-window (selected-window)) first-buffer))))

;;__________________________________________________________________________
;;;;;;		shell plugin example
;; (defun run ()
;;   "Example asynchronous process / shell program called from Emacs."
;;   (interactive)
;;   (load-library "shell")
;;   (if (bufferp "*run*") (erase-buffer "*run*"))
;;   (start-process-shell-command "ls" "*run*" "ls" "-ACF")
;;   (switch-to-buffer-other-window "*run*")
;;   (shell-mode))

;;__________________________________________________________________________
;;;;;;		sort-lines-ignore-case
;;sort -f by girod(at)shire.ntc.nokia.com
(defun sort-lines-ignore-case(reverse beg end)
  (interactive "P\nr")
  (let ((sort-fold-case t))
    (sort-lines reverse beg end)))

;;__________________________________________________________________________
;;;;;;		split-window-recent
(defun split-window-recent ()
  "Split the current window, and show the next most recently used
buffer in the newly created window."
  (interactive)
  (split-window)
  (let ((nextbuf (caddr (buffer-list))))
    (when nextbuf
      (set-window-buffer (next-window (selected-window))
                         nextbuf))))

;;__________________________________________________________________________
;;;;;;		toggle-line-wrap
(defun toggle-line-wrap ()
  "Toggle the line-wrap (line-truncate) function.
Covers (and equates) both horizontal and vertical splits."
  (interactive)
  (setq truncate-lines (setq truncate-partial-width-windows (not
							     truncate-lines)))
  (recenter (- (count-lines (window-start) (point))
	       (if (bolp) 0 1)))
  )

;;__________________________________________________________________________
;;;;;;		touch-buffer
(defun touch-buffer ()
  "Touch, to be saved, and force recompile."
  (interactive)
  (set-buffer-modified-p t))
(global-set-key [(control x) t] 'touch-buffer)

;;__________________________________________________________________________
;;;;;;		unix-dos
(defun unix-dos () "Convert unix \n to dos crlf." (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;;__________________________________________________________________________
;;;;;;		which-first
(defun which-first (path) "Return the first dir an executable is found in PATH."
  (car (which path)))

;;__________________________________________________________________________
;;;;;;		write-file-no-select
(defun write-file-no-select ()
  "'write-file' without changing to new filename.
Useful for making a copy of working file in development."
  (interactive)
  (let ((old-filename (buffer-file-name)))
    (call-interactively 'write-file)
    (write-file old-filename)))
(global-set-key [(control x) w] 'write-file-no-select)

;;__________________________________________________________________________
;;;;;;		yank-and-indent
(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))	;(call-interactively #'indent-region))

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

(provide 'e-functions)

;;; e-functions.el ends here
