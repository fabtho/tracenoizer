;;; e-browser.el --- Web browser support, both GNU and X Emacs on all platforms
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2003-07-06 11:43:54 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id: e-browser.el,v 1.20 2003/05/24 17:37:00 bingalls Exp $

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Web Browser
;;	W3 Web Browser
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
;;; Author:		Bruce Ingalls <bingalls@users.sourceforge.net>
;;<url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

;;; Change Log:		See ChangeLog history file
;;;; Keywords:		advanced power user enhanced miscellaneous applications

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
;;(defgroup e-browser nil "Settings from e-browser.el file." :group 'emacro)

(require 'which)
(require 'e-functions)

(cache-locate-library
 use-cache 'cache-dired "dired"
 "For printing support, get dired.el from full XEmacs sumo tarball")
(when cache-dired (require 'dired))

;;__________________________________________________________________________
;;;;		Web Browser
;;This chooses a web browser & writes it to preferences.el

;;These are your choices for a default browser invoked from emacs:
;;	grail		<url:http://grail.python.org/>
;;	lynx		<url:http://lynx.browser.org/>
;;	netscape	<url:http://www.netscape.com/>
;;	w3    <url:http://www.cs.indiana.edu/usr/local/www/elisp/w3/docs.html>
;;w3 is Emacs's built-in browser. May require optional package installation.

;;EMacro searches your path for browsers in the order below, but you can
;;always modify e-preferences.el

;;Check if browser is already defined in preferences.el
;;Otherwise, check for w32 os, which has a default browser
(when (eq use-browser 'nil)		;using value set in configure.el?
  (cond
   ((string-match "windows" (symbol-name system-type))
    (defconst use-browser 'default))	;w32 supports a default browser
   ((which "MozillaFirebird")	(defconst use-browser 'MozillaFirebird))
   ((which "galeon")	(defconst use-browser 'galeon))
   ((which "mozilla")	(defconst use-browser 'mozilla))
   ((which "netscape")	(defconst use-browser 'netscape))
   ((which "konqueror")	(defconst use-browser 'konqueror))
   ((which "dillo")	(defconst use-browser 'dillo)) ;cygnome

   ;;Name on MS Windows
   ;;((which "iexplore")	(defconst use-browser 'iexplorer))
   ;;Name on Solaris
   ((which "iexplorer")	(defconst use-browser 'iexplorer))
;;Deprecate this code!!!
   ((which "phoenix")	(defconst use-browser 'phoenix)) ;former firebird
   ((which "lynx")	(defconst use-browser 'lynx))
;;Uncomment, and below, when browse-url no longer hard-codes 'lynx'
;;   ((which "links")	(defconst use-browser 'links))
   ((which "grail")	(defconst use-browser 'grail))
   ((which "xmosaic")	(defconst use-browser 'xmosaic))
   ;;Nothing found? fall back on built-in browser, and hope it was installed ok
   (t
    (defconst use-browser 'w3)
    ;;Look like a big name browser, so servers will let you in:
    ;;        (w3-netscape-masquerade-mode)
    ;;        (w3-ie-masquerade-mode)
    ))
  ;;Append the results to preferences.el
  (append-to-file (format "(defconst use-browser '%s)\n" use-browser) 'nil
                  pref-file))

;;__________________________________________________________________________
;;;;		W3 Web Browser
(condition-case () (require 'w3-auto "w3-auto") (error nil))

(cache-locate-library
 use-cache 'cache-advice "advice"
 "For browser support, get advice.el from full tarball distribution where you got XEmacs")
(defvar cache-browse-url)
(cache-locate-library
 use-cache 'cache-browse-url "browse-url"
 "For browser support, get browse-url.el from full tarball distribution where you got XEmacs")
(cache-locate-library
 use-cache 'cache-w3 "w3"
 "For the emacs web browser, get w3 from <url:http://www.cs.indiana.edu/elisp/w3/docs.html>")

(autoload 'defadvice "advice" "advice" t)
;;(autoload 'after "" "" t)
(autoload 'overlays-at "overlay" "overlay" t)
(autoload 'overlay-get "overlay" "overlay" t)
(autoload 'move-overlay "overlay" "overlay" t)
(autoload 'make-overlay "overlay" "overlay" t)
(autoload 'overlay-put "overlay" "overlay" t)

(when (and cache-advice cache-browse-url)
  ;;See xemacs.el or gnu.el, where we enable Shift (middle) Mouse Button 2 to
  ;; launch <url:...>
  (require 'browse-url)
  (defvar use-modem)

  ;;From: offby1@blarg.net (Eric Hanchrow) Hitting 'b' in dired browses file
  (when cache-dired
    (define-key dired-mode-map [?b] 'browse-url-of-dired-file))

  (put 'browse-url 'mouse-face 'highlight) ; overlay category

  (defvar cache-overlay)
  (cache-locate-library
   use-cache 'cache-overlay "overlay"
   "To Shift Middle-mouse click email addresses, get overlay.el from the full XEmacs sumo tarball")

  (when (or (string-match "GNU" (emacs-version)) cache-overlay)
    (defadvice browse-url-url-at-point (after highlight activate)
      (if ad-return-value
          (let ((url-overlays (overlays-at (match-beginning 0))))
            (if url-overlays
                (while url-overlays
                  (if (eq (overlay-get (car url-overlays) 'category)
                          'browse-url)
                      (progn
                        (move-overlay (car url-overlays)
                                      (match-beginning 0)
                                      (match-end 0))
                        (setq url-overlays '()))
                    (setq url-overlays (cdr url-overlays))))
              (let ((url-overlay (make-overlay (match-beginning 0)
                                               (match-end 0))))
                (overlay-put url-overlay 'category 'browse-url)))))))

  (when cache-w3
    (autoload 'w3 "w3" "WWW Browser" t)
    (cond ((and use-net use-modem) (defconst w3-delay-image-loads t))
                                        
          (t                            ;else for high speed direct connection
	   (put 'url-be-asynchronous 'standard-value (list 't))
	   (put 'w3-do-incremental-display 'standard-value (list 't))
	   (put 'w3-user-colors-take-precedence 'standard-value (list 't))
          (global-set-key [iso-left-tab] 'widget-backward))))

;;TODO: Support browsers for newer releases of browse-url
  (cond
   ((eq window-system 'nil)		;Are we in text mode?
    (cond 
     ((string= use-browser 'lynx)	;lynx is chosen default?
	(defconst browse-url-browser-function 'browse-url-lynx-emacs))
;;     ((string= use-browser 'links)
;;	(defconst browse-url-browser-function 'browse-url-lynx-emacs))
	;else fall to w3
	(t (defconst browse-url-browser-function 'browse-url-w3))))

   ((string= use-browser 'dillo)	;cygnome browser
    (progn
      (defconst browse-url-browser-function 'browse-url-netscape)
      (defconst browse-url-netscape-program "dillo")))

   ((string= use-browser 'MozillaFirebird)
    (progn
      (defconst browse-url-browser-function 'browse-url-netscape)
      (defconst browse-url-netscape-program "MozillaFirebird")))

   ((string= use-browser 'galeon)
    (progn
;;XEmacs Way:
;;      (defconst browse-url-browser-function 'browse-url-galeon)
;;Emacs Way:
;;      (defconst browse-url-browser-function 'browse-url-gnome-moz)
;;Portable Way:
      (defconst browse-url-browser-function 'browse-url-netscape)
      (defconst browse-url-netscape-program "galeon")))

   ((string= use-browser 'grail)
    (defconst browse-url-browser-function 'browse-url-grail))

;;On MS Windows, it is called "iexplore", but we use
;; browse-url-windows-default-browser
;;     ((string= use-browser 'iexplore)
;;      (progn
;;        (defconst browse-url-browser-function 'browse-url-mosaic)
;;        (defconst browse-url-mosaic-program 'iexplore)))
;;On Solaris, it is called "iexplorer". Mac iexplorer has several names :(
   ((string= use-browser 'iexplorer)
    (progn
      (defconst browse-url-browser-function 'browse-url-mosaic)
      (defconst browse-url-mosaic-program "iexplorer")))

   ((string= use-browser 'konqueror)
    (progn
      (defconst browse-url-browser-function 'browse-url-netscape)
      (defconst browse-url-netscape-program "konqueror")))

   ((string= use-browser 'lynx)
    (defconst browse-url-browser-function 'browse-url-lynx-emacs))

   ((string= use-browser 'mozilla)
    (progn
      (defconst browse-url-browser-function 'browse-url-netscape)
      (defconst browse-url-netscape-program "mozilla")))

   ((string= use-browser 'netscape)
    (defconst browse-url-browser-function 'browse-url-netscape))
;;Deprecate this code!!!
   ((string= use-browser 'phoenix)	;the discontinued name for firebird
    (progn
      (defconst browse-url-browser-function 'browse-url-netscape)
      (defconst browse-url-netscape-program "phoenix")))

   ((string= use-browser 'w3)
    (defconst browse-url-browser-function 'browse-url-w3))

   ((string= use-browser 'xmosaic)
    (progn
      (defconst browse-url-browser-function 'browse-url-mosaic)
      (defconst browse-url-mosaic-program "xmosaic")))
   ))

;; any better way?
(setq format-alist
      '((image/jpeg    "JPEG image"
		       " JFIF"
		       image-decode-jpeg nil t image-mode)
	(image/gif     "GIF image"
		       "GIF8[79]"
		       image-decode-gif nil t image-mode)
	(image/png     "Portable Network Graphics"
		       "PNG"
		       image-decode-png nil t image-mode)
	(image/x-xpm   "XPM image"
		       "/\\* XPM \\*/"
		       image-decode-xpm nil t image-mode)
	(image/tiff    "TIFF image"
		       "II\\* "
		       image-decode-tiff nil t image-mode)
	(image/tiff    "TIFF image"
		       "MM \\*"
		       image-decode-tiff nil t image-mode)
	(text/enriched "Extended MIME text/enriched format."
		       "Content-[Tt]ype:[ 	]*text/enriched"
		       enriched-decode enriched-encode t enriched-mode)
	(text/richtext "Extended MIME obsolete text/richtext format."
		       "Content-[Tt]ype:[ 	]*text/richtext"
		       richtext-decode richtext-encode t enriched-mode)
	(plain         "ISO 8859-1 standard format, no text properties."
		       nil nil nil nil nil)))

;;This should fix up w3, where there are variations in font size
(defun fix-w3-fonts nil
  "Restore faces created by W3 so that they're all the same size.
This assumes that the standard faces 'default', 'italic', 'bold',
and 'bold-italic' are sensibly defined."
  (interactive)
  (mapatoms
   (lambda (x)
     (and (string-match "^w3-style-face" (symbol-name x))
          (facep x)
          (set-face-font x
                         (let ((font (face-font x)))
                           (and font
                                (face-font
                                 (if (string-match "-bold-" font)
                                     (if (string-match "-bold-[io]-" font)
                                         'bold-italic
                                       'bold)
                                   (if (string-match "-normal-[io]-" font)
                                       'italic
                                     'default))))))))))

;;If the above doesn't do it for you, uncomment below, edit your defaults.css
;;remove any "font-weight: bold" and "font-style: italic"
;;(defconst w3-user-fonts-take-precedence t)
;;(defconst w3-user-colors-take-precedence t)
;;(defconst w3-honor-stylesheets nil)

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

(provide 'e-browser)

;;; e-browser.el ends here
