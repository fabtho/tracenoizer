;;;; e-keys.el --- Keyboard routines for gnu and x emacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-06-12 12:00:30 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-keys.el,v 1.22 2003/05/24 17:37:01 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Defcustoms
;;	Elisp Key Syntax
;;	Key Macro Hints
;;	CUA (Windows-Style) Key Bindings
;;		Symbiotic Key Bindings
;;		Replacement Key Bindings
;;	Gnome/KDE Key Bindings
;;		Symbiotic Key Bindings
;;		Replacement Key Bindings
;;	Sun Keyboard
;;	Tab
;;	Mouse Bindings
;;	Mouse Function Menu
;;	Next & Previous Parens
;;	Assorted Global Key Bindings
;;	Text Selection
;;	Prevent Key Flubs
;;	TeraTerm Key Bindings
;;	-nw Terminal mode for Sparc keyboard
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2003 Bruce Ingalls
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file. Keyboard routines for Emacs & XEmacs on every OS.
;;These are mostly routines for defining Control- and Meta- (alt or esc) key
;;combinations and Function keys.
;;Keybinding FAQ: <url:ftp://ftp.cs.uta.fi/pub/ssjaaa//emacs-keys.html>

;;Gnome Keybinding Standard:
;;<url: http://developer.gnome.org/projects/gup/hig/1.0/userinput.html >

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls@users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;; Keywords:		keyboard key binding map

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)

;;__________________________________________________________________________
;;;; Defcustoms
(defgroup e-keys nil  "Settings from e-keys.el file."  :group 'emacro)

(defcustom e-keytheme 'native
  "Defines which keybinding standard to follow.
'native' is the default and original Emacs standard.
'cua' is the Common User Access standard with Microsoft Extensions.
'linux' is the emerging combined GNOME/KDE standard."
  :group 'e-keys
  :type '(choice (const native)
		 (const cua)
		 (const linux)))

;;__________________________________________________________________________
;;;;	Elisp Key Syntax
;;both XEmacs and GNU/FSF Emacs
;;	(define-key global-map [(control right)] 'forward-word)
;;GNU/FSF Emacs only
;;	(define-key global-map [C-right] 'forward-word)
;;ver > 20, both
;;	(define-key global-map (kbd "C-<right>") 'forward-word)

;;NOTE: User keybindings should start with C-c
;;Any other keybinding risks breaking future Emacs compatibilty!

;;This should port to both Emacs and XEmacs:
;;(let ((keymap (make-sparse-keymap)))
;;  (define-key keymap "?\C-k" 'sl-kill-screen-line)
;;  ...
;;  (add-to-list 'minor-mode-map-alist keymap))

;;__________________________________________________________________________
;;;;	Key Macro Hints
;;View existing key commands	C-h b   or M-x help<ret> b
;;View recent keystrokes with	C-h l	or M-x view-lossage

;;__________________________________________________________________________
;;;;	CUA Key Bindings with MS Windows extensions
;;__________________________________________________________________________
;;;;;;			Symbiotic Key Bindings
;;symbiotic bindings don't conflict with existing Emacs bindings
;;See also CUA in e-xemacs.el, gnu.el & bugs in readme.txt

;;Moving cursor down at bottom scrolls only a single line, not half page
(setq scroll-step 1)
(setq scroll-conservatively 1)
;;Half-page scrolling is nice when viewing in the debugger

;;overrides beginning-of-line (home) to select entire active file
;;(global-set-key [(control a)] 'mark-whole-buffer)

;;C-s is reserved for search; use Alt-S to save:
(global-set-key [(meta s)]	'save-buffer)
(global-set-key [(meta o)]	'find-file)
(global-set-key [(control o)]	'find-file)

;;Try swapping backspace & delete, which affects help key. See e-xemacs.el
;;(load-library "keyswap")
;;(setq delete-key-deletes-forward t)	;another possible fix
;;(define-key function-key-map [delete] "\C-d") ;yet another way
;;(global-set-key [delete] 'delete-char)
;;(global-set-key [kp-delete] 'delete-char)

(global-set-key (quote [home]) 'beginning-of-line)
(global-set-key (quote [end]) 'end-of-line)
(global-set-key [(control escape)] 'list-buffers)

;;Rebind C-z MS windows style, to undo.
;;If you uncomment this, you will lose the standard tiny-tools keybindings
;;Note that C-y (redo) is native Emacs Yank (paste)
(global-set-key [(control z)] 'undo)

;;__________________________________________________________________________
;;;;;;			Replacement Key Bindings
;;These are keybindings which conflict with native Emacs bindings

(when (eq e-keytheme 'cua)
;;FILE
;;Any way to create a new, blank buffer? (C-n)

  (global-set-key [(control s)] 'save-buffer)
  (global-set-key [(control p)] 'print-buffer)

;;EDIT
  (global-set-key [(control a)] 'mark-whole-buffer)
  (global-set-key [(control f)] 'isearch-forward)
  (define-key isearch-mode-map [(control f)] 'isearch-repeat-forward)

;;  (global-set-key [(control h)] 'query-replace)  ;conflicts with help
;;Control G as goto useful enough to conflict?

  (global-set-key [(control v)] 'yank)
;;Any way to build an Emacs macro for redo?
  (when (fboundp 'redo)
    (global-set-key [(control y)] 'redo)) ;exists for XEmacs, only
  )

;;__________________________________________________________________________
;;;;	Gnome/KDE Key Bindings
;;__________________________________________________________________________
;;;;;;			Symbiotic Key Bindings
(global-set-key [(meta q)] 'quoted-insert)	;provide C-q
(global-set-key [(meta control q)] 'quoted-insert) ;provide C-q

;;(global-set-key [(control i)] 'facemenu-set-italic)	;interferes with TAB

;;__________________________________________________________________________
;;;;;;			Replacement Key Bindings
(when (eq e-keytheme 'linux)
;;FILE
  (cond					;email current buffer
   ((fboundp 'metamail-buffer)
    (global-set-key [(control e)] 'metamail-buffer))
   ((fboundp 'w3-mail-current-document)
    (global-set-key [(control e)] 'w3-mail-current-document)))

  (global-set-key [(control p)] 'print-buffer)
 
;;Failed attempt to clear the menu:
;;  (global-unset-key [(control s)])
  (global-set-key [(control s)] 'save-buffer)

;;This one is a little too dangerous. Uncomment, if you disagree.
;;Clashes with quoted-insert(), which allows e.g. tabs instead of indenting
;;If you do uncomment this, M-q & M-C-q (see above) still do quoted-insert()
;;  (global-set-key [(control q)] 'save-buffers-kill-emacs)
  (global-set-key [(control w)] 'kill-buffer)

;;EDIT
;;C-u duplicates selection, without affecting clipboard. Can this be done in
;;Emacs?
;;C-i inverts selection: all selected items become unselected, and vice versa

  (global-set-key [(control a)] 'mark-whole-buffer)
  (global-set-key [(control f)] 'isearch-forward)
  (define-key isearch-mode-map [(control f)] 'isearch-repeat-forward)

;;Control G as 'find next match' useful enough to conflict?
;;(global-set-key [(control h)] 'query-replace)  ;conflicts with help

  (global-set-key [(control v)] 'yank)

;;Any way to build an Emacs macro for redo?
;;This replaces zap-to-char()
  (when (fboundp 'redo)
    (global-set-key [(meta z)] 'redo)) ;exists for XEmacs, only

;;VIEW
;;Conflicts with Reverse Search
;;  (global-set-key [(control r)] 'recenter) ;"refresh view"

;;RELOAD/REFRESH
;;(global-set-key [(control d)] 'bookmark-set) ;conflicts with delete-forward
;;(global-set-key [(control b)] 'edit-bookmarks)

;;FORMAT
  (global-set-key [(control b)] 'bold-region)
;;  (global-set-key [(control u)] 'facemenu-set-underline)
;;We need an alternative to universal-argument() to allow the previous line

;;WINDOW MANAGER STANDARDS
  (global-set-key [(meta \ )] 'tmm-menubar) ;M-space is symbiotic?
  )

;;__________________________________________________________________________
;;;;;;			Sun Keyboard
;;Sun keyboards have Alt keys in addition to Meta, so we can do microsoft
;;style keybindings. Technically, this is not cua, for purists...
;;Note that some keybindings might be used as XEmacs menu accelerators
(when
    (string-match "sun" (emacs-version))
  (global-set-key [(alt c)] 'copy-primary-selection)
  (global-set-key [(alt s)] 'save-buffer)
  (global-set-key [(alt v)] 'yank-clipboard-selection)
  (global-set-key [(alt x)] 'kill-primary-selection)
  (global-set-key [(alt y)] 'redo)
  (global-set-key [(alt z)] 'undo)
  )

;;__________________________________________________________________________
;;;;	Tab
;;Tab moves to the next code indentation
;;Shift Tab moves to the next tab stop (usually a multiple of 8 spaces)
(global-set-key [(iso-left-tab)] 'tab-to-tab-stop)

;;Here's how to get tab to do a real tab, instead of indenting.
;;Best solution. Seperates tab key from C-i on ttys:
;;(define-key text-mode-map (kbd "TAB") 'self-insert-command)

;;Another solution
;;Change text-mode-hook to whatever mode, e.g. html-mode-hook.
;;(add-hook 'text-mode-hook
;;	  (lambda ()
;;	    (local-set-key [tab]
;;			   (lambda ()
;;			     (interactive)
;;			     (insert "\t")))))

;;You can also skip the hook and just do for everywhere
;;(global-set-key [tab] (lambda () (interactive) (insert "\t")))

;;Only works if some text is currently highlighted.
;;(global-set-key [(control meta y)] 'yank-and-indent)

;;__________________________________________________________________________
;;;;	Mouse Bindings
;;From: Andreas Kuhn <andreas.kuhn@brokat.com> This should allow left mouse
;; select/copy and middle mouse paste on W32, just like on Linux:
;;(defun mouse-track-drag-copy-to-kill (event count)
;;  "Copy the dragged region to the kill ring"
;;  (let ((region (default-mouse-track-return-dragged-selection event)))
;;    (when region
;;      (copy-region-as-kill (car region)
;;                           (cdr region)))
;;    nil))
;;(add-hook 'mouse-track-drag-up-hook 'mouse-track-drag-copy-to-kill)

;;On x emacs, you can select a box of text with M- or Shift-M- button 1
;;(Alt Left Mouse button dragging). Note that your window manager might
;;intercept the mouse and prevent emacs.

;;For gnu emacs, get rect-mouse.el from
;;<url:ftp://ls6-ftp.cs.uni-dortmund.de/pub/src/emacs/>
;;There's also rect-mark.el for gnu emacs; I had problems on old v20.2

(autoload 'delete-rectangle "rect" "cut a box of text with mouse" t)
(autoload 'delete-extract-rectangle "rect" "cut a box of text with mouse" t)
(autoload 'extract-rectangle "rect" "select a box of text with mouse" t)
(autoload 'kill-rectangle "rect" "cut a box of text with mouse" t)
(autoload 'yank-rectangle "rect" "paste a box of text with mouse" t)
(autoload 'insert-rectangle "rect" "paste a box of text with mouse" t)
(autoload 'open-rectangle "rect" "clear a box of text with mouse" t)
(autoload 'string-rectangle "rect" "paste a box of text with mouse" t)
(autoload 'clear-rectangle "rect" "clear a box of text with mouse" t)

;;XEmacs predefines meta left mouse button to visually select a box
;;Select text as box with mouse.
(if (string-match "XEmacs" (emacs-version))
   (progn
    (define-key global-map [(control shift button1)] 'mouse-track-do-rectangle)
    (define-key global-map [(control shift button2)] 'yank-rectangle)  ;paste
    (define-key global-map [(control shift button3)] 'kill-rectangle)) ;cut
;;else Emacs
   (progn
    (require 'rect)
;;Nothing to select a rectangle in Emacs :(
    (define-key global-map [(C-S-down-mouse-2)] 'yank-rectangle)   ;paste
    (define-key global-map [(C-S-down-mouse-3)] 'kill-rectangle))) ;cut

;;This is probably predefined for Gnu Emacs:
;;(define-key global-map [(meta shift button3)] 'imenu)	;major mode menu

;;XEmacs Mouse Wheel. See also mwheel.el
(define-key global-map [(button4)] 'scroll-down)
(define-key global-map [(button5)] 'scroll-up)

;;__________________________________________________________________________
;;;;	Mouse Function Menu
;;Jump to function from menu. Must be at least Emacs v20.3
(cache-locate-library
 use-cache 'cache-imenu "imenu"
 "For function menu support, get imenu.el from full XEmacs sumo tarball")
(when cache-imenu
  (require 'imenu)
;;Make imenu a mouse menu popup:
  (if (string-match "XEmacs" (emacs-version))
      (define-key global-map [(shift button3)] 'imenu)
    (define-key global-map [S-down-mouse-3] 'imenu)))

;;__________________________________________________________________________
;;;;	Next & Previous Parens
(global-set-key [(meta p)] (lambda ()
			     (interactive)
			     (re-search-backward "(\\|)" nil t)))
(global-set-key [(meta n)] (lambda ()
			     (interactive)
			     (re-search-forward "(\\|)" nil t)))

;;__________________________________________________________________________
;;;;	Assorted Global Key Bindings
;;Gnome standard
(global-set-key [(meta f4)]	'save-buffers-kill-emacs)
(global-set-key [(control f11)]
 '(progn (menu-bar-mode 0) (tool-bar-mode 0)))

;;Largely CUA with MS Extension standard
(global-set-key [f1]		'help)  ;like windows (cua?)
(global-set-key [(shift f1)]	'manual-entry)   ;like windows

;;f2 is rename (file?) in Gnome standard
;;(global-set-key [f2]		'save-buffer)
(global-set-key [f3]		'isearch-forward) ;like windows

(global-set-key [f4]		'kill-buffer)
(global-set-key [(control f4)]	'delete-buffer)

(global-set-key [f5]		'query-replace)
;;Can we local-set-key this, as most prog modes derive from cc-mode?
;;(global-set-key [f5]		'compile)

;;(global-set-key [f6]		'next-error)
;;(global-set-key [(shift f6)]	'first-error)
(global-set-key [f7]		'ispell-buffer)

;;Conflicts with Gnome standard to move window
(global-set-key [(meta f7)]	'ispell-buffer)

;;(global-set-key [f8]		'split-window-vertically)
;;(global-set-key [(shift f8)]	'delete-other-windows)
;;(global-set-key [f9]		'new-frame)
;;(global-set-key [(shift f9)]	'delete-frame)

;;F10 is menu for Gnu Emacs & windows
;;'quote' is optional syntax
;;(global-set-key (quote [f11])	'undo)
;;(global-set-key [(shift f12)]	'delete-window)

(global-set-key (quote [f12])	'save-buffer)
(global-set-key [(control f12)]	'find-file)

(global-set-key (quote [f14])	'undo)  ;undo key on sun keyboard
(global-set-key [(shift f14)]	'redo)

(global-set-key [(shift f16)]	'yank-line) ;copy key on sun keyboard

;;vi-style: hit % over paren to show matched paren
;;(global-set-key [(control %)] 'match-paren)
;;(global-set-key "%" 'goto-match-paren)
(global-set-key [(control %)] 'goto-match-paren)

(global-set-key [(meta g)] 'goto-line)	;override set-face
;;(global-set-key [(control /]) 'undo)
;;(global-set-key [(control _)] 'undo)

;;See e-functions.el for details
(global-set-key [(control :)] 'query-replace-last-two-kills)

;;__________________________________________________________________________
;;;;	Text Selection
(defconst query-replace-highlight t)	;highlight during query
(defconst search-highlight t)		;highlight incremental search

;;This may allow middle mouse pasting while doing a search. Needs testing.
;;(define-key isearch-mode-map (quote [mouse-2]) 'isearch-yank-kill)
;;(define-key isearch-mode-map (quote [down-mouse-2]) nil)

;;__________________________________________________________________________
;;;;	Prevent Key Flubs
;;(bad things that happen you slip onto the next key)
;;Make it easier to back out of hitting Esc key twice on older emacs
(put 'eval-expression 'disabled nil)

;;__________________________________________________________________________
;;;;	Teraterm Key Bindings
;;Uncomment this, for emacs inside w32 Teraterm ssh or telnet client from
;;<url: http://www.zip.com.au/~roca/download.html >. Recommended: _Setup
;;_Keyboard to transmit DEL by Backspace key & turn on Meta to enable Alt key.

;;This partially works, to detect we are inside a term:
;;(when (string= window-system nil)
;; (define-key function-key-map (kbd "ESC [ 6 ~") 'scroll-up)
;; (define-key function-key-map "\e[3~" 'scroll-down)
;; (define-key function-key-map "\e[5~" 'end-of-line)
;; (define-key function-key-map "\e[2~" 'beginning-of-line)
;; (define-key function-key-map "\e[1~" 'overwrite-mode))

;;__________________________________________________________________________
;;;;	-nw Terminal mode for Sparc keyboard
;;Here is a start at supporting emacs -nw for a sparc keyboard
;;Discover keys with 'C-h l'; discover keyboard type with (shell "kbd -t")
;;(define-key function-key-map (kbd "ESC [ C") [C-right])
;;(define-key function-key-map (kbd "ESC [ C") (kbd "C-<right>"))
;;(define-key function-key-map "\e[C" [(control right)])

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

(provide 'e-keys)
;;; e-keys.el ends here
