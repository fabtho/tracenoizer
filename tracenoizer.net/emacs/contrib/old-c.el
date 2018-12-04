;;;; e-c.el --- C/C++ support for gnu and x emacs for every OS.
;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode
;;Time-stamp: <2002-07-29 18:58:54 bingalls>
;;;;Outline-Mode: C-c @ C-t to show as index. C-c @ C-a to show all.
;;$Id$

;;__________________________________________________________________________
;;;;	TABLE OF CONTENTS
;; 	Legal
;; 	Commentary
;; 	Code
;;	Misc Functions
;;	Outline-mode control variables

;;__________________________________________________________________________
;;; Legal:
;;Copyright © 1998,2002 Bruce Ingalls bingalls@sf.net
;;This file is not (yet) part of Emacs nor XEmacs. See file COPYING for license

;;__________________________________________________________________________
;;; Commentary:
;;Emacs editor startup file. C/C++ support for every OS.

;;__________________________________________________________________________
;;; Author:		Bruce Ingalls <bingalls@users.sourceforge.net>
;;<url:http://www.sourceforge.net/projects/emacro>
;;<url:http://www.dotemacs.de/>
;;; Change Log:		See ChangeLog history file
;;; Keywords:		program mode ide

;;__________________________________________________________________________
;;;; Code:
(autoload 'outline-minor-mode "outline" "automagic index to jump to" t)
;;(defgroup e-c nil "Settings from e-c.el file." :group 'emacro)
;;(require 'font-lock)

;;__________________________________________________________________________
;;;;		Misc Functions
;; Switches between source/header files
;(defun toggle-source-header()
;  "Switches to the source buffer if currently in the header buffer and vice versa."
;  (interactive)
;  (let ((buf (current-buffer))
;	(name (file-name-nondirectory (buffer-file-name)))
;	file
;	offs)
;    (setq offs (string-match c++-header-ext-regexp name))
;    (if offs
;	(let ((lst c++-source-extension-list)
;	      (ok nil)
;	      ext)
;	  (setq file (substring name 0 offs))
;	  (while (and lst (not ok))
;	    (setq ext (car lst))
;	    (if (file-exists-p (concat file "." ext))
;		  (setq ok t))
;	    (setq lst (cdr lst)))
;	  (if ok
;	      (find-file (concat file "." ext))))
;      (let ()
;	(setq offs (string-match c++-source-ext-regexp name))
;	(if offs
;	    (let ((lst c++-header-extension-list)
;		  (ok nil)
;		  ext)
;	      (setq file (substring name 0 offs))
;	      (while (and lst (not ok))
;		(setq ext (car lst))
;		(if (file-exists-p (concat file "." ext))
;		    (setq ok t))
;		(setq lst (cdr lst)))
;	      (if ok
;		  (find-file (concat file "." ext)))))))))


;(defun make-makefile()
;  "Creates the Makefile from the .pro project file"
;  (interactive)
;  (let ((project (project-main)))
;    (shell-command (concat "tmake -o Makefile "
;			   (file-name-nondirectory (buffer-file-name project))))))

;;; Finds all functions in a class in a given buffer
;;; Creates a list which looks like this.
;;; ((classname) func1 func2 ...)
;;; where func1 looks like
;;; (type1 type2 type3 reference name args)
;(defun find-class-functions ( buf )
;  (interactive)
;  (save-excursion
;    (set-buffer buf)
;    (beginning-of-buffer)
;    (if (search-forward-regexp (concat "^\\(template[ \t]*<[^>]+>[ \t]*\\)?class[ \t]+\\([a-zA-Z0-9_]+\\)[ \t\n]*"
;				       "\\([:][ \t\n]*\\(public\\|protected\\|private\\)?[ \t\n]*\\<[a-zA-Z0-9_]+\\>\\)?"
;				       "[ \t\n]*{") nil t)
;	(let (start
;	      stop
;	      (name (match-string-no-properties 2)))
;	  (setq start (match-end 0))
;	  (if ( search-forward "};" nil t)
;	      (let ((funclist '()))
;		(setq stop (match-beginning 0))
;		(save-restriction
;		  (narrow-to-region start stop)
;		  (beginning-of-buffer)
;		  (while (search-forward-regexp (concat
;						 "\\(\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \t]+\\)?"
;						 "\\(\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \t]+\\)?"
;						 "\\(\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \t]+\\)?"
;						 "\\([*&]?\\)[ \t]*"
;						 "\\([~]?[a-zA-Z][a-zA-Z0-9_]*\\)[ \t]*"
;						 "(\\([^\)]*\\))[ \t]*;")
;						nil t)
;		    (let (
;			  (type1 (match-string-no-properties 2))
;			  (type2 (match-string-no-properties 4))
;			  (type3 (match-string-no-properties 6))
;			  (ref (match-string-no-properties 7))
;			  (name (match-string-no-properties 8))
;			  (args (match-string-no-properties 9)))
;		      (setq funclist (cons (list type1 type2 type3 ref name args) funclist))
;		    ))
;		  (setq funclist (cons (list name) funclist ))
;		  funclist)))))))

;;; Removes virtual and static from a type
;(defun string-remove-type ( str reg )
;  (interactive)
;  (let (tmp)
;    (if (eq str nil)
;	(setq tmp "")
;      (if (string-match "\\(virtual\\|static\\)" str)
;	  (setq tmp "")
;	(if reg
;	    (setq tmp (concat str "[ \t]+"))
;	  (setq tmp (concat str " ")))))
;    tmp))

;;; Finds all functions in this buffers class and adds the one's missing from
;;; the source file.
;(defun expand-class-functions ( buf )
;  (interactive)
;  (if (string-match c++-header-ext-regexp (buffer-name buf))
;      (save-excursion
;	(set-buffer buf)
;	(let ((lst (find-class-functions buf))
;	      item
;	      classname)
;	  (toggle-source-header)
;	  (beginning-of-buffer)
;	  (setq classname (car (car lst)))
;	  (setq lst (cdr lst))
;	  (let (type1 type1_reg
;		      type2 type2_reg
;		      type3 type3_reg
;		      ref ref_reg
;		      name
;		      args args_reg)
;	    (setq lst (nreverse lst))
;	    (while lst
;	      (setq item (car lst))
;	      (setq type1 (car item))
;	      (setq item (cdr item))
;	      (setq type2 (car item))
;	      (setq item (cdr item))
;	      (setq type3 (car item))
;	      (setq item (cdr item))
;	      (setq ref (car item))
;	      (setq item (cdr item))
;	      (setq name (car item))
;	      (setq item (cdr item))
;	      (setq args (car item))
;	      (setq item (cdr item))
;	      (setq type1_reg (string-remove-type type1 t))
;	      (setq type2_reg (string-remove-type type2 t))
;	      (setq type3_reg (string-remove-type type3 t))
;	      (if (eq ref nil)
;		  (setq ref_reg "[ \t]*")
;		(setq ref_reg (concat "[" ref "]" "[ \t]*")))
;	      (setq args_reg (regexp-opt (list args)))
;	      (beginning-of-buffer)
;	      (if (search-forward-regexp (concat "^" type1_reg type2_reg type3_reg ref_reg
;						 classname "::" name "[ \t]*" "(\\([^)]+\\))" ) nil t)
;		  (let (args_org
;			args_new
;			(offs_org 0) (len_org 0)
;			(offs_new 0) (len_new 0)
;			type1 type2 type3 ref
;			(all t)
;			(args_reg "\\(\\([a-zA-Z]+\\)[ \t]+\\)?"
;				  "\\(\\([a-zA-Z]+\\)[ \t]+\\)?"
;				  "\\(\\([a-zA-Z]+\\)[ \t]+\\)?"
;				  "\\([&*]\\)?[ \t]*\\([a-zA-Z_][a-zA-Z_]*\\)?\\([ \t]*=[^,]+\\)?"))
;		    (setq args_new (match-string 1))
;		    (yes-or-no-p "match")
;		    (while (and (not offs_org) (not offs_new))
;		      (setq offs_org (string-match args_reg args offs_org))
;		      (setq type1 (substring args (match-beginning 2) (match-end 2)))
;		      (setq type2 (substring args (match-beginning 4) (match-end 4)))
;		      (setq type3 (substring args (match-beginning 6) (match-end 6)))
;		      (setq ref (substring args (match-beginning 7) (match-end 7)))
;;;		      (setq offs_new (string-match args_reg args_new offs_new))
;		      (yes-or-no-p (concat type1 ":" type2 ";" type3 ":" ref ))))
;		(save-excursion
;		    (end-of-buffer)
;		    (setq type1_reg (string-remove-type type1 nil))
;		    (setq type2_reg (string-remove-type type2 nil))
;		    (setq type3_reg (string-remove-type type3 nil))
;		    (if (eq ref nil)
;			(setq ref_reg "")
;		      (setq ref_reg (concat ref)))
;		    (if (not (bolp))
;			(insert-string "\n"))
;					;		(yes-or-no-p "h")
;		    (insert-string (concat "\n/*!\n  \n*/\n\n"
;					   type1_reg type2_reg type3_reg ref_reg
;					   classname "::" name "(" args ")"
;					   "\n{\n}\n"))))
;	      (setq lst (cdr lst))
;	      ))))))

;;; Will make sure that the #ifndef and #define that should be present in all c/c++ headers
;;; are corrected according their filename.
;(defun correct-c-header-define( buf )
;  (interactive "b")
;  (save-excursion
;    (set-buffer buf)
;    (if (string-match c++-header-ext-regexp (buffer-name))
;	(let ((bufname (buffer-name))
;	      defname
;	      defstring)
;	  (setq defname (concat (upcase (file-name-sans-extension bufname)) "_"
;				(upcase (file-name-extension bufname))))
;	  (setq defstring (concat
;			   "#ifndef " defname "\n"
;			   "#define " defname "\n"))
;	  (beginning-of-buffer)
;	  (if (search-forward-regexp (concat "^#ifndef[ \t]+\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \t]*[\n]"
;					     "#define[ \t]+\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \t]*[\n]")
;				     nil t)
;	      (replace-match defstring t t ))))))

;;; Will align c/c++ variable declarations in the selected region
;;; Example:
;;; int a;
;;; const QString b;
;;; static unsigned int c;
;;;
;;; will become:
;;; int                 a;
;;; const QString       b;
;;; static unsigned int c;
;(defun align-vars(beg end)
;  "Aligns c/c++ variable declaration names on the same column, with beginning and end taken from selected region."
;  (interactive "r")
;  (save-excursion
;    (let (bol eol expr-end
;	  (max-col 0) col
;	  poslist curpos)
;      (goto-char end)
;      (if (not (bolp))
;	  (setq end (line-end-position)))
;      (goto-char beg)
;      (while (and (> end (point)) (not (eobp)))
;	(setq bol (line-beginning-position))
;	(setq eol (line-end-position))
;	(beginning-of-line)
;	(setq expr-end (point))
;	(if (search-forward-regexp "^[^/][^/]\\([a-zA-Z][a-zA-Z]*\\)[ \t]+[^;]" eol t)
;	    (let ()
;	      (setq expr-end (match-end 1))
;	      (while (search-forward-regexp "\\([a-zA-Z][a-zA-Z]*\\)[ \t]+[^;]" eol t)
;		(setq expr-end (match-end 1)))
;	      (goto-char expr-end)
;	      (setq col (current-column))
;	      (if (search-forward-regexp (concat "\\(\\*\\|&[ \t]*\\)?"
;						 "\\([a-zA-Z\\_][a-zA-Z0-9\\_]*\\)\\([\[][0-9]+[\]]\\)?"
;						 "\\([ \t]*,[ \t]*\\([a-zA-Z\\_][a-zA-Z0-9\\_]*\\)\\([\[][0-9]+[\]]\\)?\\)*"
;						 "[ \t]*;$") eol t)
;		  (let ((name-col-end 0))
;		    (if (eq (match-beginning 2) (match-beginning 0))
;			(setq name-col-end 1))
;		    (setq poslist (cons (list expr-end col (match-beginning 0) name-col-end) poslist))
;		    (if (> col max-col)
;			(setq max-col col))
;		    (beginning-of-next-line))
;		(beginning-of-next-line)))
;	  (beginning-of-next-line)))
;      (setq curpos poslist)
;      (while curpos
;	(let* ((pos (car curpos))
;	       (col (car (cdr pos)))
;	       (col-end (car (cdr (cdr pos))))
;	       (col-end-name (car (cdr (cdr (cdr pos)))))
;	       (abs-pos (car pos)))
;	  (goto-char abs-pos)
;	  (delete-region abs-pos col-end)
;	  (insert-string (make-string (+ (+ (- max-col col) 1) col-end-name) 32)))
;	(setq curpos (cdr curpos))))))

;;;ToDo: add cache-locate-library call here
;;;(require 'align)

;;;;; Aligns all variable declarations in this buffer
;;;(defun align-vars-buffer()
;;;  "Aligns c/c++ variable declaration names on the same column in this buffer."
;;;  (interactive)
;;;  (save-excursion
;;;    (let (beg end)
;;;      (beginning-of-buffer)
;;;      (setq beg (point))
;;;      (end-of-buffer)
;;;      (setq end (point))
;;;      (align-vars beg end))))

;(defun project-add-include-classes (classnames classinclude)
;  "Adds an object-include connection to the projects list"
;  (let ()
;    (setq project-include-classes (cons (list classnames classinclude) project-include-classes))))

;(defun project-add-include-list (classes)
;  "Adds a list of object-include to the projects list"
;  (let ((inc-classes classes)
;	(class))
;    (while inc-classes
;      (setq class (car inc-classes))
;      (project-add-include-classes (car class) (car (cdr class)))
;      (setq inc-classes (cdr inc-classes)))))

;;; Load default classes
;(if (file-exists-p "~/.emacs-d-classes")
;    (load-file "~/.emacs-d-classes"))

;;; Load local classes
;(if (file-exists-p ".emacs-classes")
;    (load-file ".emacs-classes"))

;;; Returns the end of the include area, finds the end of the top comment and adds a newline if no includes
;;; are present.
;(defun end-of-include-place()
;  "Finds the end of the includes, or the end of the top comments if no includes are present."
;  (let ((pos))
;    (save-excursion
;      (beginning-of-buffer)
;      (let ((count 0))
;	(while (search-forward-regexp "^#include[ \t]+[\"<][a-zA-Z0-9\.\-\_]+[\">][ \t]*\n" nil t)
;	  (setq count (1+ count)))
;	(if (< count 1)
;	    (let ()
;	      (if (string-match c++-header-ext-regexp (buffer-name))
;		  (let (name)
;		    (setq name (concat "#ifndef[ \t]+"
;				       "[^ ^\t^\n]*"
;				       "[ \t]*\n"
;				       "#define[ \t]+"
;				       "[^ ^\t^\n]*"
;				       "[ \t]*\n"))
;		    (search-forward-regexp name nil t))
;		(let ()
;		  (beginning-of-buffer)
;		  (search-forward-regexp "\\(\\(\\(//[^\n]*\n\\)\\|\\(/\\*[^\\*]*\\*/[^\n]*\n\\)\\)*\\)[ \t]*\n")
;		  (goto-char (match-end 1))))
;	      (insert-string "\n"))))
;      (setq pos (point)))
;    pos))

;;; Checks for known classes and adds includes on the top if none are present
;(defun insert-include()
;  "Insert #include on the top of the file if certain class names are found in the file"
;  (interactive)
;  (if (string-equal mode-name "C++")
;      (let ((includes project-include-classes)
;	    (include)
;	    (include-classes)
;	    (include-class)
;	    (include-file)
;	    (class-exists nil))
;	(while includes
;	  (setq include (car includes))
;	  (setq include-classes (car include))
;	  (setq include-file (car (cdr include)))
;	  (setq class-exists nil)
;	  (while (and (not class-exists) include-classes)
;	    (setq include-class (car include-classes))
;	    (save-excursion
;	      (beginning-of-buffer)
;	      (if (search-forward-regexp (concat "\\<" include-class "\\>") nil t)
;		  (setq class-exists t)))
;	    (setq include-classes (cdr include-classes)))
;	  (if class-exists
;	      (let ((already-present nil))
;		(save-excursion
;		  (beginning-of-buffer)
;		  (if (search-forward-regexp (concat "^#include[ \t]+"
;						     include-file
;						     "[ \t]*\n") nil t )
;		      (setq already-present t)))
;		(if (not already-present)
;		    (save-excursion
;		      (goto-char (end-of-include-place))
;		      (insert-string (concat "#include " include-file "\n"))))))
;	  (setq includes (cdr includes))))))

;(defun project-looking-at-include()
;  (save-excursion
;    (let ((ok nil))
;      (beginning-of-line)
;      (if (looking-at project-c++-include-regexp)
;	  (setq ok t))
;      ok)))

;(defun project-looking-at-forward-class-decl()
;  (save-excursion
;    (let ((ok nil))
;      (beginning-of-line)
;      (if (looking-at project-c++-class-decl-regexp)
;	  (setq ok t))
;      ok)))

;(defun project-find-include( class )
;  (let ((classes project-include-classes)
;	class-include
;	class-list
;	class-name
;	include
;	(done nil))
;    (while (and classes (not done))
;      (setq class-include (car classes))
;      (setq class-list (car class-include))
;      (message (cadr class-list))
;      (while (and class-list (not done))
;	(setq class-name (car class-list))
;	(if (string-equal class-name class)
;	    (setq done t
;		  include (cadr class-include)))
;	(setq class-list (cdr class-list)))
;      (setq classes (cdr classes)))
;    include))

;;; Fix here
;(defun project-try-open-include( include )
;  (let (dir
;	filename
;	include-name
;	class-name)
;    (if (string-match "\"\\([^\"]*\\)\"" include)
;	(let ()
;	  (setq include-name (substring include (match-beginning 1) (match-end 1)))
;	  (setq class-name (project-try-open-local-include include-name))
;	  )
;      (if (string-match "<\\([^>]*\\)>" include)
;	  (let ()
;	    (setq include-name (substring include (match-beginning 1) (match-end 1)))
;	    (setq class-name (project-try-open-global-include include-name))
;	    )
;	))
;    class-name))

;(defun project-try-open-local-include( include-name )
;  (let ((project (project-main))
;	proj-dir
;	inc-file
;	classes
;	class)
;    (setq proj-dir (file-name-directory (buffer-file-name project)))
;    (setq inc-file (concat proj-dir include-name))
;    (setq classes (check-file inc-file))
;    (if classes
;	(setq class (car classes)))
;    class))

;(defun project-parse-tmake-line( var buf )
;  (save-excursion
;    (let (elements)
;      (set-buffer buf)
;      (beginning-of-buffer)
;      (while (re-search-forward (concat "\\(.+:\\)?"
;					var
;					"[ \t]+[+*/-]?=\\([ \t]*[A-Za-z0-9/.]+\\)*") nil t)
;	(setq elements (nconc elements (split-string (match-string-no-properties 2)))))
;      elements)))

;(defun project-find-include-paths( buf )
;  (let (paths
;	path
;	(real-paths nil)
;	proj-dir)
;    (setq proj-dir (file-name-directory (buffer-file-name buf)))
;    (setq paths (project-parse-tmake-line "TMAKE_INCDIR_QT" buf))
;    (while paths
;      (setq path (car paths))
;      (setq real-paths (nconc real-paths (list (concat proj-dir path))))
;      (setq paths (cdr paths)))
;    real-paths))

;(defun project-try-open-global-include( include-name )
;  (let ((project (project-main))
;	proj-dir
;	inc-file
;	classes
;	(class nil)
;	(paths project-include-paths)
;	path)
;    (setq proj-dir (file-name-directory (buffer-file-name project)))
;    (setq paths (nconc paths (project-find-include-paths project)))
;    (while (and paths (not class))
;      (setq path (car paths))
;      (setq path (substitute-in-file-name path))
;      (setq inc-file (concat path "/" include-name))
;      (if (file-exists-p inc-file)
;	  (let ()
;	    (setq classes (check-file inc-file))
;	    (if classes
;		(setq class (car classes)))))
;      (setq paths (cdr paths)))
;    class))

;(defun project-find-class-in-include( include )
;  (save-excursion
;    (let (class-name)
;      (setq class-name (project-find-class-in-classes include))
;      (if (not class-name)
;	  (setq class-name (project-try-open-include include)))
;      class-name)))

;(defun project-find-class-in-classes( include )
;  (let ((classes project-include-classes)
;	class-list
;	class-names
;	class-name
;	class-include
;	(done nil))
;    (while (and classes (not done))
;      (setq class-list (car classes))
;      (setq class-include (cadr class-list))
;      (if (string-equal class-include include)
;	  (setq class-names (car class-list)
;		done t))
;      (setq classes (cdr classes)))
;    (if done
;	(setq class-name (car class-names)))
;    class-name))

;(defun project-convert-include()
;  (save-excursion
;    (let (include
;	  class-name)
;      (beginning-of-line)
;      (if (looking-at project-c++-include-regexp)
;	  (save-restriction
;	    (narrow-to-region (match-beginning 0) (match-end 0))
;	    (setq include (match-string 1))
;	    (setq class-name (project-find-class-in-include include))
;	    (if class-name
;		(if (re-search-forward ".*\n")
;		    (replace-match (concat "class " class-name ";\n"))
;	      (message (concat "No class found for include " include)))))
;	(if (looking-at project-c++-class-decl-regexp)
;	    (save-restriction
;	      (narrow-to-region (match-beginning 0) (match-end 0))
;	      (setq class-name (match-string 1))
;	      (setq include (project-find-include class-name))
;	      (if include
;		  (replace-match (concat "#include " include "\n"))
;		(message (concat "Nothing known about " class-name))))
;	  (message "Not a forward class declaration or include file"))))))

;;;
;(defun project-insert-params( class header body )
;  "Insert params to a given class"
;  (save-excursion
;    (if (string-equal mode-name "C++")
;	(let ((includes project-include-params)
;	      (include)
;	      (include-classes)
;	      (include-class)
;	      (include-params-header)
;	      (include-params-body)
;	      (include-params)
;	      (done nil)
;	      (class-exists nil))
;	  (while (and includes (not done))
;	    (setq include (car includes))
;	    (setq include-classes (car include))
;	    (setq include-params-header (car (cdr include)))
;	    (setq include-params-body (car (cddr include)))
;	    (setq include-params (car (cdddr include)))
;	    (if (string-match include-classes class)
;		(save-excursion
;		  (set-buffer header)
;		  (save-excursion
;		    (beginning-of-buffer)
;		    (while (search-forward "$$$" nil t)
;		      (save-restriction
;			(narrow-to-region (match-beginning 0) (match-end 0))
;			(replace-match (concat " " include-params-header " ")))))
;		  (set-buffer body)
;		  (save-excursion
;		    (beginning-of-buffer)
;		    (while (search-forward "$$$" nil t)
;		      (save-restriction
;			(narrow-to-region (match-beginning 0) (match-end 0))
;			(replace-match (concat " " include-params-body " ")))))
;		  (save-excursion
;		    (beginning-of-buffer)
;		    (while (search-forward "===" nil t)
;		      (save-restriction
;			(narrow-to-region (match-beginning 0) (match-end 0))
;			(replace-match (concat " " include-params " ")))))
;		  (setq done t)
;		  ))
;	    (setq includes (cdr includes)))
;	  (if (not done)
;	      (save-excursion
;		(set-buffer header)
;		(save-excursion
;		  (beginning-of-buffer)
;		  (while (search-forward "$$$" nil t)
;		    (save-restriction
;		      (narrow-to-region (match-beginning 0) (match-end 0))
;		      (replace-match ""))))
;		(set-buffer body)
;		(save-excursion
;		  (beginning-of-buffer)
;		  (while (search-forward "$$$" nil t)
;		    (save-restriction
;		      (narrow-to-region (match-beginning 0) (match-end 0))
;		      (replace-match ""))))
;		(save-excursion
;		  (beginning-of-buffer)
;		  (while (search-forward "===" nil t)
;		    (save-restriction
;		      (narrow-to-region (match-beginning 0) (match-end 0))
;		      (replace-match ""))))))
;	  ))))

;;; List of classes known
;;; [REGEXP LOWCASE LOCAL RECURSIVE CHECKFILE]
;;; [REGEXP LOWCASE nil INCLUDEFILE]
;(defvar project-classes
;  '(
;    ("^eZ[a-zA-Z0-9_]+" (check-local-class ez-class-list))
;    ("^Q[a-zA-Z0-9_]+" (check-local-class qt-class-list))
;    ))

;;; (DIR RECURSIVE CHECK OLD)
;(defvar qt-class-list '("/usr/lib/qt/include" nil t qt-parsed-classes))

;(defvar ez-class-list '("." nil t qt-parsed-classes))

;(defvar project-known-classes nil)

;(defun check-for-class( word )
;  (interactive)
;  (let ((classes project-classes)
;	(known project-known-classes)
;	know
;	(ok nil)
;	reg
;	class)
;    (while (and known (not ok))
;      (setq know (car known))
;      (if (string-match (car know) word)
;	  (let ()
;	    (if (car (cdr know))
;		(message (concat "#include \"" (car (cdr (cdr know))) "\""))
;	      (message (concat "#include <" (car (cdr (cdr know))) ">")))
;	    (setq ok t )))
;      (setq known (cdr known)))
;    (if (not ok)
;	(while classes
;	  (setq class (car classes))
;	  (setq reg (car class))
;	  (if (string-match reg word)
;	      (let ((expr (car (cdr class)))
;		    retur
;		    file
;		    local
;		    (cls nil))
;		(setq retur (eval (append expr (list word))))
;		(message "Found these classes:")
;		(setq file (car retur))
;		(setq local (car (cdr retur)))
;		(setq retur (cdr (cdr retur)))
;		(while retur
;		  (message (car (car retur)))
;		  (setq cls (cons (car (car retur)) cls))
;		  (setq retur (cdr retur)))
;		(if cls
;		    (setq project-known-classes (cons (list (regexp-opt cls) local file) project-known-classes)))
;		))
;	  (setq classes (cdr classes))))))

;(defvar c++-source-extension-list '("c" "cc" "C" "cpp" "c++"))
;(defvar c++-header-extension-list '("h" "hh" "H" "hpp"))

;(defun check-local-class(class word)
;  (interactive)
;  (let ((dir (car class))
;	(recur (car (cdr class)))
;	(check (car (cdr (cdr class))))
;	(old (car (cdr (cdr class)))))
;    (if (file-exists-p dir)
;	(let (name
;	      loname
;	      hiname
;	      (exts c++-header-extension-list)
;	      ext
;	      (ok nil)
;	      include)
;	  (while (and exts (not ok))
;	    (setq ext (car exts))
;	    (setq name (concat word "." ext))
;	    (setq loname (concat (downcase word) "." ext))
;	    (setq hiname (concat (upcase word) "." ext))
;	    (cond
;	     ((file-exists-p (concat dir "/" name))
;	      (let ()
;		(setq ok t)
;		(setq include name)))
;	     ((file-exists-p (concat dir "/" loname))
;	      (let ()
;		(setq ok t)
;		(setq include loname)))
;	     ((file-exists-p (concat dir "/" hiname))
;	      (let ()
;		(setq ok t)
;		(setq include hiname))))
;	    (setq exts (cdr exts)))
;	  (if ok
;	      (let ((buf (find-buffer-visiting (concat dir "/" include)))
;		    classes)
;		(message include)
;		(if buf
;		    (save-excursion
;		      (set-buffer buf)
;		      (beginning-of-buffer)
;		      (setq classes (find-classes-in-buffer))
;		      (setq classes (cons (or (string-equal dir "") (string-equal dir ".") (string-equal dir nil)) classes))
;		      (setq classes (cons include classes))
;		      classes)
;		  (save-excursion
;		    (setq buf (find-file (concat dir "/" include)))
;		    (set-buffer buf)
;		    (setq classes (find-classes-in-buffer))
;		    (setq classes (cons (or (string-equal dir "") (string-equal dir ".") (string-equal dir nil)) classes))
;		    (setq classes (cons include classes))
;		    (kill-buffer buf)
;;		    (message (car (car classes)))
;		    classes
;		    ))))
;	  ))))

;(defvar buffer-include-list nil)


;(defvar c++-class-decl-regexp (concat 
;			       "^"
;			       ;; May have a template<>(1)
;			       "\\(template[ \t\n]*<[^>]*>\\)?"
;			       ;; class declaration and name(3)
;			       "[ \t\n]*class\\([ \t\n]+\\([a-zA-Z_][a-zA-Z0-9_]*\\)\\)+"
;			       ;; Ends in <>(4) if template
;			       "\\(<[^>]*>\\)?"
;			       ;; :
;			       "\\([ \t\n]*:[ \t\n]*"
;			       ;; public|protected|private(6)
;			       "\\(public\\|protected\\|private\\)?"
;			       ;; inherit name(7)
;			       "[ \t\n]*\\([a-zA-Z_][a-zA-Z0-9_]*\\)"
;			       ;; template(8)
;			       "\\(<[^>]*>\\)?\\)?"
;			       "[ \t]*\\(//[^\n]*\n\\)?[ \t\n]*"
;			       ;; { or ; (10)
;			       "[{]"
;			       ))

;(defvar c++-protect-clause-regexp (concat
;				   "^"
;				   ;; public|protected|private(2) signals|slots(4)
;				   "\\(\\(public\\|protected\\|private\\)"
;				   "\\([ \t]*\\(signals\\|slots\\)\\)?"
;				   "\\|"
;				   ;; or signals|slots(5)
;				   "\\(signals\\|slots\\)\\)"
;				   ;; :
;				   ":"))

;(defvar c++-class-func-regexp (concat
;			       "^[ \t]*"
;			       "\\(template[ \t\n]*<[^>]*>\\)?"
;			       ""
;			       ))

;(defun find-classes-in-buffer()
;  (interactive)
;  (let ((classes '())
;	pos end
;	(mpos (make-marker))
;	(mend (make-marker)))
;    (save-excursion
;      (beginning-of-buffer)
;      (while (search-forward-regexp
;	      c++-class-decl-regexp
;	      nil t)
;	(setq pos (match-beginning 0))
;	(setq end (match-end 0))
;	(set-marker mpos pos)
;	(set-marker mend end)
;	(message (match-string-no-properties 10))
;	(setq classes (cons (list (match-string-no-properties 3) mpos mend) classes))
;	))
;     classes))


;(defun find-includes()
;  (interactive)
;  (let ((lst '()))
;    (save-excursion
;      (beginning-of-buffer)
;      (while (search-forward-regexp (concat "^#include[ \t]+\\("
;					    "\\(<[a-zA-Z0-9._\-]+>\\)\\|"
;					    "\\(\"[a-zA-Z0-9._\-]+\"\\)"
;					    "\\)")
;				    nil t)
;	(let ((res (match-string-no-properties 1))
;	      (pos (match-beginning 0))
;	      (end (match-end 0))
;	      (mpos (make-marker))
;	      (mend (make-marker)))
;	  (set-marker mpos pos)
;	  (set-marker mend end)
;	  (setq lst (cons (list res mpos mend) lst)))))
;    lst))

;(defun include-exists( include )
;  (interactive)
;  (let ((incs buffer-include-list)
;	inc
;	(ok nil))
;    (while (and incs (not ok))
;      (setq inc (car incs))
;      (if (string-equal (car inc) include)
;	  (setq ok t))
;      (setq incs (cdr incs)))
;    ok))

;;;These need rewriting into portable key syntax
;;;(global-set-key [M-f11] '(lambda()
;;;			   (interactive)
;;;			   (let (buf)
;;;			     (setq buf (generate-new-buffer "*classes*"))
;;;			     (set-buffer buf)
;;;			     (insert-string (concat ";; -*- Mode: Emacs-Lisp -*-\n"
;;;						    ";; -*- lisp -*-\n"
;;;						    ";; Project classes\n"
;;;						    "\n"
;;;						    ";; Automaticly insert these include files when found in c++ file\n"))
;;;			     (insert-string (scan-directory-string "./" t "project-local-classes"))
;;;			     (write-file "./.emacs-classes")
;;;			     (kill-buffer buf))))

;;;(global-set-key [A-f11] '(lambda()
;;;			   (interactive)
;;;			   (message (check-for-class "QListView"))))

;;;(global-set-key [A-f11] '(lambda()
;;;			   (interactive)
;;;			   (message (find-classes-in-buffer))))

;;;(global-set-key [f11] '(lambda ()
;;;			 (interactive)
;;;			 (make-variable-buffer-local 'buffer-include-list)
;;;			 (setq buffer-include-list (find-includes))))


;(defun check-for-file( dir file rec)
;  (interactive)
;  (if (file-exists-p (concat dir file))))
      


;;; Checks for known classes and removes any unnecessary includes
;(defun remove-include()
;  "Removes #include on the top of the file if certain class names are not found in the file"
;  (interactive)
;  (if (string-equal mode-name "C++")
;      (let ((includes project-include-classes)
;	    (include)
;	    (include-classes)
;	    (include-class)
;	    (include-file))
;	(while includes
;	  (setq include (car includes))
;	  (setq include-classes (car include))
;	  (setq include-file (car (cdr include)))
;	  (save-excursion
;	    (beginning-of-buffer)
;	    (if (search-forward-regexp (concat "^#include[ \t]+"
;					       include-file
;					       "[ \t]*\n") nil t )
;		(let ((start)
;		      (end)
;		      (class-exists nil))
;		  (setq start (match-beginning 0))
;		  (setq end (match-end 0))
;		  (setq class-exists nil)
;		  (while (and (not class-exists) include-classes)
;		    (setq include-class (car include-classes))
;		    (save-excursion
;		      (beginning-of-buffer)
;		      (while (search-forward-regexp (concat "\\<\\(" include-class "\\)\\>") nil t)
;			(if (string-equal (match-string 1) include-class)
;			    (let ()
;			      (setq class-exists t)))))
;		    (setq include-classes (cdr include-classes)))
;		  (if (not class-exists)
;		      (save-restriction
;			(delete-region start end)))))
;	    (setq includes (cdr includes)))))))

;;; Make sure the include files are updated when saving
;(add-hook 'write-file-hooks (lambda()
;			      (interactive)
;			      (if c++-auto-include-add
;				  (insert-include))))
;(add-hook 'write-file-hooks (lambda()
;			      (interactive)
;			      (if c++-auto-include-remove
;				  (remove-include))))


;;; Count words in buffer
;(defun count-words-buffer ()
;  "Count the number of words in current the buffer
;print a message in the minibuffer with the result."
;  (interactive)
;  (save-excursion
;    (let ((count 0))
;      (goto-char (point-min))
;      (while (< (point) (point-max))
;	(forward-word 1)
;	(setq count (1+ count)))
;      (message "buffer contains %d words." count))))

;;; Returns a buffer with the main project
;;; Will try to load it from disk if not found in buffer list
;(defun project-main ()
;  "Finds the current project."
;  (let (buffer)
;    (let ((buffers (buffer-list))
;	  file)
;      (while buffers
;	(setq file (buffer-file-name (car buffers)))
;	(if file
;	    (if (string-match project-regexp file)
;		(setq buffer(car buffers))))
;	(setq buffers (cdr buffers))))
;    (if buffer
;	()
;      (let ((files (directory-files (expand-file-name ".") nil project-regexp t))
;	    file
;	    dir
;	    (count 0))
;	(setq dir files)
;	(while files
;	  (setq count (1+ count))
;	  (setq files (cdr files)))
;	(if (> count 0 )
;	    (if (<= count 1)
;		(if project-ask-load
;		    (if (y-or-n-p (concat "Really load \"" (car dir) "\" from disk?"))
;			(setq buffer (find-file (car dir))))
;		  (setq buffer (find-file (car dir))))
;	      (let ()
;		(message "%d files found." count)
;		(if (y-or-n-p (concat "Really load \"" (car dir) "\" from disk?"))
;		    (setq buffer (find-file (car dir)))))))))
;    buffer))

;;; Returns a buffer with the main project
;(defun project-main-in-buffers ()
;  "Finds the current project."
;  (let (buffer)
;    (let ((buffers (buffer-list))
;	  file)
;      (while buffers
;	(setq file (buffer-file-name (car buffers)))
;	(if file
;	    (if (string-match project-regexp file)
;		(setq buffer(car buffers))))
;	(setq buffers (cdr buffers))))
;    buffer))


;(defun project-file-list ( buffer tag )
;  (if (stringp tag)
;      (let ((lst nil))
;	(save-excursion
;	  (set-buffer buffer)
;	  (beginning-of-buffer)
;	  (if (search-forward-regexp (concat "^"
;					     tag
;					     "\\([ \t]*\=\\)[ \t]*\\(\\\\[ \t]*[\n]\\)?"
;					     "\\(\\([ \t]*[a-zA-Z\.\-/]+\\([ \t]*\\\\[ \t]*[\n]\\)?\\)*\\)")
;				     nil t)
;	      (save-restriction
;		(beginning-of-buffer)
;		(narrow-to-region (match-beginning 3) (match-end 3))
;		(while (search-forward-regexp (concat "[ \t]*\\([a-zA-Z\.\-/]+\\)"
;						      "\\([ \t]*\\\\[ \t]*[\n]\\)?")
;					      nil t)
;		  (setq lst (cons (match-string-no-properties 1) lst))))))
;	(nreverse lst))
;    (error "Must supply a tag string" )))

;(defun project-files ( project )
;  (list (project-file-list project "SOURCES")
;	(project-file-list project "HEADERS")))


;(defun project-load-check ()
;  (if (string-match project-regexp (buffer-name (current-buffer)))
;      (project-update-menu)))

;(add-hook 'find-file-hooks 'project-load-check)

;(defun project-update-menu ()
;  "Updates the project files menu with the files in the project"
;  (interactive)
;  (let* ((project (project-main))
;	 (lst (project-files project))
;	 (slst (car lst))
;	 (hlst (car (cdr lst)))
;	 bufdir)
;    (setq bufdir (file-name-directory (buffer-file-name project)))
;    (easy-menu-change '("files")
;		      "Project Files"
;		      (list (cons "Sources"
;				  (mapcar '(lambda (entry)
;					     (vector entry (list 'find-file (concat bufdir "/" entry)) t))
;					  (car (project-files (project-main)))))
;			    (cons "Headers"
;				  (mapcar '(lambda (entry)
;					     (vector entry (list 'find-file entry) t))
;					  (car (cdr (project-files (project-main)))))))
;		      "open-file")))

;;; Loads all header and source files found in the project file.
;(defun project-load-files ()
;  "Loads all the project files."
;  (interactive)
;  (let ((project (project-main))
;	lst slst hlst)
;    (if project
;	(save-excursion
;	  (setq lst (project-files project))
;	  (setq slst (car lst))
;	  (setq hlst (car (cdr lst)))
;	  (while slst
;	    (find-file-noselect (car slst))
;	    (setq slst (cdr slst)))
;	  (while hlst
;	    (find-file-noselect (car hlst))
;	    (setq hlst (cdr hlst))))
;      (message "Couldn't find any projects \(In right directory ?\)."))))

;(defun project-execute ()
;  "Executes the exe file in the current project."
;  (interactive)
;  (let (name)
;    (save-excursion
;      (set-buffer (project-main))
;      (beginning-of-buffer)
;      (save-excursion
;	(if (search-forward-regexp "^TARGET[ \t]*\=[ \t]*\\([a-zA-Z\.\-_]+[ \t]*\\)[\n]" nil t)
;	    (save-restriction
;	      (beginning-of-buffer)
;	      (shell-command (concat "./" (match-string 1) " &") (get-buffer "*compilation*")))
;	  (message "No target found"))))))

;(defun project-debug ()
;  "Debugs the exe file in the current project."
;  (interactive)
;  (let (name)
;    (save-excursion
;      (set-buffer (project-main))
;      (beginning-of-buffer)
;      (save-excursion
;	(if (search-forward-regexp "^TARGET[ \t]*\=[ \t]*\\([a-zA-Z\.\-_]+[ \t]*\\)[\n]" nil t)
;	    (save-restriction
;	      (beginning-of-buffer)
;	      (shell-command (concat project-debugger " " (match-string 1) " &") (get-buffer "*compilation*"))))))))

;; Compiles the current program with options
;(defun project-compile(opts)
;  "Compile current project with options"
;  (interactive "MEnter compile options: ")
;  (save-excursion
;    (let ((project (project-main)))
;      (if project
;	  (let ((object-dir (project-object-dir project)))
;	    (set-buffer project)
;	    (if (not (string-match object-dir ""))
;		(if (not (file-exists-p object-dir))
;		    (make-directory object-dir))))))
;    (compile (concat "make " opts))))

;;; Inserts a file into the project
;(defun project-insert-file (project file keyword)
;  "Insert a FILE into the current PROJECT buffer after the given KEYWORD."
;  (save-excursion
;    (set-buffer project)
;    (if (not (search-forward (file-relative-name file) nil t))
;	(save-excursion
;	  (beginning-of-buffer)
;	  (if (search-forward-regexp (concat "^"
;					     keyword
;					     "\\([ \t]*\=\\)[ \t]*\\(\\\\[ \t]*[\n]\\)?"
;					     "\\([ \t]*[a-zA-Z\.\-/]+\\([ \t]*\\\\[ \t]*[\n]\\)?\\)*")
;				     nil t)
;	      (save-restriction
;		(insert-string " \\\n")
;		(indent-relative)
;		(insert-string (file-relative-name file))))))))

;;; Removes a file from the project
;(defun project-remove-file (project file keyword)
;  "Removes a FILE from the current PROJECT buffer after the give KEYWORD."
;  (save-excursion
;    (set-buffer project)
;    (beginning-of-buffer)
;    (if (search-forward-regexp (concat "^"
;				       keyword
;				       "\\([ \t]*\=\\)\\(\\(\\([ \t]*\\\\[ \t]*[\n]\\)?"
;				       "\\([ \t]*[a-zA-Z\.\-/]+\\)\\)*\\)")
;			       nil t)
;	(save-restriction
;	  (narrow-to-region (match-beginning 2) (match-end 2))
;	  (beginning-of-buffer)
;	  (if (search-forward-regexp (concat "\\([ \t]*\\\\[ \t]*[\n]\\)?"
;					     "\\([ \t]*"
;					     file
;					     "\\)")
;				     nil t)
;	      (replace-match "")
;	    (message "Couldn't find file in project")))
;      (message (concat "Couldn't find keyword: " keyword " in project.")))))

;(defun project-replace-class-name (buffer classname oldname)
;  "Replaces every occurence of project-normal-name-match,project-downcase-name-match and project-upcase-name-match with CLASSNAME,
;in normal, downcase and upcase letters, in BUFFER."
;  (save-excursion
;    (set-buffer buffer)
;    (beginning-of-buffer)
;    (save-excursion
;      (while (search-forward project-normal-name-match nil t)
;	(save-restriction
;	  (narrow-to-region (match-beginning 0) (match-end 0))
;	  (replace-match classname))))
;    (save-excursion
;      (while (search-forward project-downcase-name-match nil t)
;	(save-restriction
;	  (narrow-to-region (match-beginning 0) (match-end 0))
;	  (replace-match (downcase classname)))))
;    (save-excursion
;      (while (search-forward project-upcase-name-match nil t)
;	(save-restriction
;	  (narrow-to-region (match-beginning 0) (match-end 0))
;	  (replace-match (upcase classname)))))
;    (save-excursion
;      (while (search-forward project-deriveclass-match nil t)
;	(save-restriction
;	  (narrow-to-region (match-beginning 0) (match-end 0))
;	  (replace-match oldname))))
;    (save-excursion
;      (while (search-forward "\<real-name\>" nil t)
;	(save-restriction
;	  (narrow-to-region (match-beginning 0) (match-end 0))
;	  (replace-match user-full-name))))
;    (save-excursion
;      (while (search-forward "\<login-name\>" nil t)
;	(save-restriction
;	  (narrow-to-region (match-beginning 0) (match-end 0))
;	  (replace-match user-login-name))))
;    (save-excursion
;      (while (search-forward "\<mail-name\>" nil t)
;	(save-restriction
;	  (narrow-to-region (match-beginning 0) (match-end 0))
;	  (replace-match project-mail-account))))))

;;; Returns the project type, currently Qt or c++.
;(defun project-type (project)
;  "Returns type of project in use."
;  (let (name)
;    (save-excursion
;      (set-buffer project)
;      (beginning-of-buffer)
;      (save-excursion
;	(if (search-forward-regexp "^CONFIG[ \t]*\=[ \t]*\\(\\([a-zA-Z\.\-_]+[ \t]*\\)*\\)[\n]" nil t)
;	    (save-restriction
;	      (beginning-of-buffer)
;	      (narrow-to-region (match-beginning 1) (match-end 1))
;	      (if (search-forward "qt" nil t)
;		  (setq name "Qt")
;		(setq name "c++")))
;	  (setq name "c++"))))
;    name))


;;; Returns a list of options
;(defun project-config (project)
;  "Returns project configuration."
;  (interactive)
;  (let (name)
;    (save-excursion
;      (set-buffer project)
;      (beginning-of-buffer)
;      (save-excursion
;	(if (search-forward-regexp "^CONFIG[ \t]*\=[ \t]*\\(\\([a-zA-Z\.\-_]+[ \t]*\\)*\\)[\n]" nil t)
;	    (save-restriction
;	      (beginning-of-buffer)
;	      (narrow-to-region (match-beginning 1) (match-end 1))
;	      (while (search-forward-regexp "[a-zA-Z\.\-_]+" nil t)
;		(let ()
;		  (setq name (cons (match-string 0) name))))))
;	(defvar project-config-opts name)))
;    name))

;;; Returns project object dir.
;(defun project-object-dir (project)
;  "Returns project object directory if exists."
;  (interactive)
;  (let (name)
;    (save-excursion
;      (set-buffer project)
;      (beginning-of-buffer)
;      (save-excursion
;	(if (search-forward-regexp "^OBJECTS_DIR[ \t]*\=[ \t]*\\([a-zA-Z\.\-_]+[ \t]*\\)[\n]" nil t)
;	    (setq name (match-string 1))
;	  (setq name ""))))
;    name))


;;; Aks for project name and creates a new project
;(defun project-new ()
;  "Creates a new project if the no project exists"
;  (interactive)
;  (let ((project (project-main)))
;    (if project
;	(message "Project already exists.")
;      (let (newproject
;	    projectfile
;	    projectbuf)
;	(setq newproject (read-from-minibuffer (concat "Enter name of new project : ")))
;	(setq projectfile (concat (downcase newproject)
;				  ".pro"))
;	(setq projectbuf (find-file projectfile))
;	(project-replace-class-name projectbuf newproject "")
;	(setq mainbuf (find-file-noselect "main.cpp"))
;	(project-replace-class-name mainbuf "main" "")
;	(save-buffer)
;;; Use revive instead
;	(save-current-configuration)
;	(shell-command (concat "tmake -o Makefile " projectfile))
;	(project-update-menu)))))

;;; Returns the name of the project
;(defun project-name (project)
;  "Returns the name of the project."
;  (let (name)
;    (save-excursion
;      (set-buffer project)
;      (beginning-of-buffer)
;      (if (search-forward-regexp "^PROJECT[ \t]*\=[ \t]*\\([a-zA-Z\.\-]+\\)[ \t]*[\n]" nil t)
;	  (setq name (match-string 1))
;	(setq name "Noname")))
;    name))

;;; Adds a class to the current project, creates the header and/or source file if non existing.
;(defun class-add ()
;  "Add a class to the current project."
;  (interactive)
;  (let ((project (project-main)))
;    (if project
;	(let (newclass
;	      oldclass
;	      oldname
;	      headerfile
;	      sourcefile
;	      headerbuf
;	      sourcebuf
;	      proj_dir
;	      real_headerfile
;	      real_sourcefile
;	      dest_dir)
;	  (setq proj_dir (file-name-directory (buffer-file-name project)))
;	  (setq cur_dir (file-name-directory (buffer-file-name (current-buffer))))
;	  (setq newclass (read-from-minibuffer (concat "Enter class name to add to "
;						       (project-type project)
;						       " project \""
;						       (project-name project)
;						       "\": ")))
;	  (setq oldname (read-from-minibuffer "Enter class to derive from(Enter for none): "))
;	  (setq dest_dir (file-relative-name  proj_dir))
;	  (if (string-equal dest_dir "./")
;	      (setq dest_dir ""))
;	  (setq dest_dir (read-from-minibuffer "Enter relative destination directory (Enter for current): " dest_dir))
;	  (if (string-equal dest_dir "")
;	      ()
;	    (setq dest_dir (file-name-as-directory dest_dir)))
;	  (make-directory dest_dir t)
;	  (if (eq oldname nil)
;	      (setq oldname ""))
;	  (if (not (string-equal oldname ""))
;	      (setq oldclass (concat " : public " oldname))
;	    (setq oldclass ""))
;	  (setq headerfile (concat dest_dir (downcase newclass)
;				"." c++-default-header-ext))
;	  (setq sourcefile (concat dest_dir (downcase newclass)
;				"." c++-default-source-ext))
;	  (setq headerbuf (find-file-noselect headerfile))
;	  (setq sourcebuf (find-file-noselect sourcefile))
;	  (setq real_headerfile (file-relative-name (buffer-file-name headerbuf) proj_dir))
;	  (setq real_sourcefile (file-relative-name (buffer-file-name sourcebuf) proj_dir))
;	  (project-replace-class-name headerbuf newclass oldclass)
;	  (if (not (string-equal oldname ""))
;	      (setq oldclass (concat "\n    : " oldname "(===)" ))
;	    (setq oldclass ""))
;	  (project-replace-class-name sourcebuf newclass oldclass)
;	  (project-insert-params oldname headerbuf sourcebuf)
;	  (project-insert-file project real_headerfile "HEADERS")
;	  (project-insert-file project real_sourcefile "SOURCES")
;	  (set-buffer project)
;	  (shell-command (concat "tmake -o Makefile "
;				 (file-name-nondirectory (buffer-file-name project))))
;	  (project-update-menu)
;	  (switch-to-buffer sourcebuf)
;	  (switch-to-buffer headerbuf))
;      (message "Couldn't find any projects \(In right directory ?\).")
;      )))

;;; Removes a file from the current project, and deletes them if is set.
;;; TODO: Request source directory for files as in class-add
;(defun class-remove ()
;  "Removes a class from the current project."
;  (interactive)
;  (let ((project (project-main)))
;    (if project
;	(let (newclass
;	      headerfile
;	      sourcefile
;	      headerbuf
;	      sourcebuf)
;	  (setq newclass (read-from-minibuffer (concat "Enter class name to remove from "
;						       (project-type project)
;						       " project \""
;						       (project-name project)
;						       "\": ")))
;	  (setq headerfile (concat (downcase newclass)
;				   "." c++-default-header-ext))
;	  (setq sourcefile (concat (downcase newclass)
;				   "." c++-default-source-ext))
;	  (let ((projectdir (file-name-directory (buffer-file-name project)))
;		(headerbuffer (get-buffer headerfile))
;		(sourcebuffer (get-buffer sourcefile))
;		realheaderfile realsourcefile;;Absolute file names
;		relheaderfile relsourcefile);;Relative files names
;	    (setq realheaderfile (buffer-file-name headerbuffer))
;	    (setq realsourcefile (buffer-file-name sourcebuffer))
;	    (setq relheaderfile (file-relative-name realheaderfile projectdir))
;	    (setq relsourcefile (file-relative-name realsourcefile projectdir))
;	    (if project-delete-redundant
;		(let ()
;		  (if headerbuffer
;		      (let ()
;			(set-buffer headerbuffer)
;			(save-buffer)
;			(kill-this-buffer)))
;		  (if (file-exists-p realheaderfile)
;		      (if project-delete-confirm
;			  (if (y-or-n-p (concat "Delete file " relheaderfile " "))
;			      (delete-file realheaderfile))
;			(delete-file realheaderfile)))

;		  (if sourcebuffer
;		      (let ()
;			(set-buffer sourcebuffer)
;			(save-buffer)
;			(kill-this-buffer)))
;		  (if (file-exists-p realsourcefile)
;		      (if project-delete-confirm
;			  (if (y-or-n-p (concat "Delete file " relsourcefile " "))
;			      (delete-file realsourcefile))
;			(delete-file realsourcefile)))
;		  (if (file-exists-p (concat (file-name-directory realsourcefile) "moc_" sourcefile))
;		      (delete-file (concat (file-name-directory realsourcefile) "moc_" sourcefile)))))
;	    (project-remove-file project relheaderfile "HEADERS")
;	    (project-remove-file project relsourcefile "SOURCES")
;	    (set-buffer project)
;	    (save-buffer)
;	    (shell-command (concat "tmake -o Makefile "
;				   (buffer-file-name project)))
;	    (project-update-menu)))
;      (message "Couldn't find any projects \(In right directory ?\).")
;      )))


;(defconst project-c++-func-regexp (concat
;			 "^"		; beginning of line is required
;			 "\\(template[ \t]*<[^>]+>[ \t]*\\)?" ; there may be a "template <...>"
;			 "\\([a-zA-Z0-9_:]+[ \t]+\\)?" ; type specs; there can be no
;			 "\\([a-zA-Z0-9_:]+[ \t]+\\)?" ; more than 3 tokens, right?

;			 "\\("		; last type spec including */&
;			 "[a-zA-Z0-9_:]+"
;			 "\\([ \t]*[*&]+[ \t]*\\|[ \t]+\\)" ; either pointer/ref sign or whitespace
;			 "\\)?"		; if there is a last type spec
;			 "\\("		; name; take that into the imenu entry
;			 "[a-zA-Z0-9_:~]+" ; member function, ctor or dtor...
;					; (may not contain * because then
;				; "a::operator char*" would become "char*"!)
;			 "\\|"
;			 "\\([a-zA-Z0-9_:~]*::\\)?operator"
;			 "[^a-zA-Z1-9_][^(]*" ; ...or operator
;			 " \\)"
;			 "[ \t]*([^)]*)[ \t\n]*[^ ;]" ; require something other than a ; after
;			 ))

;(defun c-project-menu (modestr)
;  (let ((m
;	 '(
;	   ("Options"
;	    ["Automatic Insert Include"
;	     (setq c++-auto-include-add (not c++-auto-include-add)) 
;	     :style toggle
;	     :selected c++-auto-include-add]
;	    ["Automatic Remove Include"
;	     (setq c++-auto-include-remove (not c++-auto-include-remove)) 
;	     :style toggle
;	     :selected c++-auto-include-remove]
;	    ["Ask Before Loading Project"
;	     (setq project-ask-load (not project-ask-load)) 
;	     :style toggle
;	     :selected project-ask-load]
;	    ["Use Project Auto Insertion"
;	     (setq project-use-auto-insert (not project-use-auto-insert)) 
;	     :style toggle
;	     :selected project-use-auto-insert]
;	    "---"
;	    ["Delete Removed Classes"
;	     (setq project-delete-redundant (not project-delete-redundant)) 
;	     :style toggle
;	     :selected project-delete-redundant]
;	    ["Confirm Deletion of Removed Classes"
;	     (setq project-delete-confirm (not project-delete-confirm)) 
;	     :style toggle
;	     :active project-delete-redundant
;	     :selected project-delete-confirm]
;	    "---"
;	    ["Home Hyper Jump"
;	     (setq key-home-jump (not key-home-jump))
;	     :style toggle
;	     :selected key-home-jump])
;	   ("Session"
;	    ["Save"
;	     (save-current-configuration)]
;	    ["Restore"
;	     (resume-try)]
;	    ["Wipe"
;	     (wipe-try)])
;	   "---"
;	   ["New Project"      project-new (not (project-main-in-buffers))]
;	   ["Load Project"     (set-buffer (project-main)) (not (project-main-in-buffers))]
;	   ["Close Project"     (kill-buffer (project-main-in-buffers)) (project-main-in-buffers)]
;	   ["Create Makefile"   (make-makefile) (project-main-in-buffers)]
;	   ["Load All Sources"  project-load-files (project-main-in-buffers)]
;	   "---"
;	   ["Add Class"         class-add (project-main-in-buffers)]
;	   ["Remove Class"      class-remove (project-main-in-buffers)]
;	   )))
;    (cons modestr m)))


;(defun project-test ()
;  (interactive)
;  (if (search-forward-regexp project-c++-func-regexp nil t )
;      (message (match-string 0))))


;;; Reads in an abbrev file if it exists
;;; C-x a i g to create an abbrev
;(if (file-exists-p abbrev-file-name)
;    (read-abbrev-file))

;(defun project-tag-file()
;  (let ((tag "TAGS")
;	(project (project-main))
;	prodir
;	tagfile)
;    (setq prodir (file-name-directory (buffer-file-name project)))
;    (setq tagfile (concat prodir tag))
;    tagfile))

;(defun project-load-tags()
;;  (interactive)
;  (let ((tagfile (project-tag-file)))
;    (if (file-exists-p tagfile)
;	(visit-tags-table tagfile))))

;(defvar project-tag-list)

;(defvar project-qt-tag-dir '("$QTDIR/src/dialogs/*.h" "$QTDIR/src/kernel/*.h"
;			     "$QTDIR/src/tools/*.h" "$QTDIR/src/widgets/*.h"))

;(defvar project-standard-tag-dir '("/usr/include/*.h" "/usr/include/bits/*.h"
;				   "/usr/include/g++-2/*" "/usr/include/sys/*.h"))

;(defun project-expand-tag-list (lst)
;  (interactive)
;  (let (dirs item items)
;    (setq items lst)
;    (while items
;      (setq item (car items))
;      (if dirs
;	  (setq dirs (concat dirs " " item))
;	(setq dirs item))
;      (setq items (cdr items)))
;    dirs))

;(defun project-config-has ( var )
;  (interactive)
;  (let ((items (project-config (project-main)))
;	item
;	(found nil))
;    (while items
;      (setq item (car items))
;      (if (string-equal item var)
;	  (setq found t))
;      (setq items (cdr items)))
;    found))

;(defun project-generate-tags()
;  (interactive)
;  (let (files
;	(lst nil))
;    (if (project-config-has "qt")
;	(setq lst (nconc lst project-qt-tag-dir)))
;    (setq lst (nconc lst project-standard-tag-dir))
;    (setq files (project-expand-tag-list lst))
;    (shell-command (concat "etags " files))
;    ))
  

;(defun project-expand-symbol( arg )
;  (interactive "P")
;  (if (not (file-exists-p (project-tag-file)))
;      (project-generate-tags))
;;       (project-load-tags)
;  (complete-symbol arg))

;(defun project-hide-entry ()
;  (interactive)
;  (if (outline-on-heading-p)
;      (let ()
;	(show-entry)
;	(forward-char))
;    (hide-entry)))

;;;---------------------------------------------------------------------
;;; C++ mode modifications


;;; Add project menu to the mode first started in emacs
;(easy-menu-define project-menu lisp-interaction-mode-map "C++ Project Commands"
;		  (c-project-menu "Project"))
;(easy-menu-add (c-project-menu "Project"))


;;; Define a new regexp for font-lock-mode
;;; DONT'T MESS WITH IT
;(defconst c++-new-font-lock-keywords
;  '(
;    ("\\<[0-9]+\\.[0-9]+\\>" (0 font-lock-floatnumber-face))
;    ("^#[ 	]*error[ 	]+\\(.+\\)"
;     (1 font-lock-warning-face prepend))
;    ("^#[ 	]*\\(import\\|include\\)[ 	]*\\(<[^>\"\n]*>?\\)"
;     (2 font-lock-string-face))
;    ("^#[ 	]*define[ 	]+\\(\\sw+\\)("
;     (1 font-lock-function-name-face))
;    ("^#[ 	]*\\(elif\\|if\\)\\>"
;     ("\\<\\(defined\\)\\>[ 	]*(?\\(\\sw+\\)?" nil nil
;      (1 font-lock-builtin-face)
;      (2 font-lock-variable-name-face nil t)))
;    ("^#[ 	]*\\(\\sw+\\)\\>[ 	!]*\\(\\sw+\\)?"
;     (1 font-lock-builtin-face)
;     (2 font-lock-variable-name-face nil t))
;    ("\\<\\(public\\|private\\|protected\\)\\>[ \t]+\\(\\<\\(signals\\|slots\\)\\>\\)[ \t]*:"
;     (1 font-lock-type-face)
;     (2 font-lock-type-face)
;     )
;    ("\\<\\(class\\|public\\|private\\|protected\\|typename\\|signals\\|slots\\)\\>[ 	]*\\(\\(\\sw+\\)\\>\\([ 	]*<\\([^>\n]+\\)[ 	*&]*>\\)?\\([ 	]*::[ 	*~]*\\(\\sw+\\)\\)*\\)?"
;     (1 font-lock-type-face)
;     (3
;      (if
;	  (match-beginning 6)
;	  font-lock-type-face font-lock-function-name-face)
;      nil t)
;     (5 font-lock-function-name-face nil t)
;     (7 font-lock-function-name-face nil t))
;    ("^\\(\\sw+\\)\\>\\([ 	]*<\\([^>\n]+\\)[ 	*&]*>\\)?\\([ 	]*::[ 	*~]*\\(\\sw+\\)\\)*[ 	]*("
;     (1
;      (if
;	  (or
;	   (match-beginning 2)
;	   (match-beginning 4))
;	  font-lock-type-face font-lock-function-name-face))
;     (3 font-lock-function-name-face nil t)
;     (5 font-lock-function-name-face nil t))
;    ("\\<\\(auto\\|bool\\|c\\(har\\|o\\(mplex\\|nst\\)\\)\\|double\\|e\\(num\\|x\\(p\\(licit\\|ort\\)\\|tern\\)\\)\\|f\\(loat\\|riend\\)\\|in\\(line\\|t\\)\\|long\\|mutable\\|namespace\\|register\\|s\\(hort\\|igned\\|t\\(atic\\|ruct\\)\\)\\|t\\(emplate\\|ypedef\\)\\|u\\(n\\(ion\\|signed\\)\\|sing\\)\\|v\\(irtual\\|o\\(id\\|latile\\)\\)\\|JBF[a-zA-Z0-9]+\\|eZ[a-zA-Z0-9]+\\|Q[A-Z][a-zA-Z]*\\|Q[a-z][A-Z][a-zA-Z]*\\|uint\\|ulong\\|string\\)\\>"
;     (0 font-lock-type-face))
;    ("\\<\\(operator\\)\\>[ 	]*\\(!=\\|%=\\|&[&=]\\|()\\|\\*=\\|\\+[+=]\\|-\\(>\\*\\|[=>-]\\)\\|/=\\|<\\(<=\\|[<=]\\)\\|==\\|>\\(>=\\|[=>]\\)\\|\\[\\]\\|\\^=\\||[=|]\\|[!%&*+,/<=>|~^-]\\)?"
;     (1 font-lock-keyword-face)
;     (2 font-lock-builtin-face nil t))
;    ("\\<\\(case\\|goto\\)\\>[ 	]*\\(-?\\sw+\\)?"
;     (1 font-lock-keyword-face)
;     (2 font-lock-constant-face nil t))
;    (":"
;     ("^[ 	]*\\(\\sw+\\)[ 	]*:\\($\\|[^:]\\)"
;      (beginning-of-line)
;      (end-of-line)
;      (1 font-lock-constant-face)))
;    ("\\<\\(asm\\|break\\|c\\(atch\\|on\\(st_cast\\|tinue\\)\\)\\|d\\(elete\\|o\\|ynamic_cast\\)\\|else\\|for\\|if\\|new\\|re\\(interpret_cast\\|turn\\)\\|s\\(izeof\\|tatic_cast\\|witch\\)\\|t\\(h\\(is\\|row\\)\\|ry\\)\\|while\\)\\>"
;     (0 font-lock-keyword-face))
;    ("\\<\\(false\\|true\\)\\>"
;     (0 font-lock-constant-face))
;    ("\\<\\(auto\\|bool\\|c\\(har\\|o\\(mplex\\|nst\\)\\)\\|double\\|e\\(num\\|x\\(p\\(licit\\|ort\\)\\|tern\\)\\)\\|f\\(loat\\|riend\\)\\|in\\(line\\|t\\)\\|long\\|mutable\\|namespace\\|register\\|s\\(hort\\|igned\\|t\\(atic\\|ruct\\)\\)\\|t\\(emplate\\|ypedef\\)\\|u\\(n\\(ion\\|signed\\)\\|sing\\)\\|v\\(irtual\\|o\\(id\\|latile\\)\\)\\|JBF[a-zA-Z0-9]*\\|eZ[a-zA-Z0-9]*\\|Q[a-zA-Z]*\\|uint\\|ulong\\|string\\)\\>\\([ 	]*<\\([^>\n]+\\)[ 	*&]*>\\)?\\([ 	]*::[ 	*~]*\\(\\sw+\\)\\)*\\([ 	*&]+\\(\\sw+\\)\\>\\([ 	]*<\\([^>\n]+\\)[ 	*&]*>\\)?\\([ 	]*::[ 	*~]*\\(\\sw+\\)\\)*\\)*"
;     (font-lock-match-c++-style-declaration-item-and-skip-to-next
;      (goto-char
;       (or
;	(match-beginning 20)
;	(match-end 1)))
;      (goto-char
;       (match-end 1))
;      (1
;       (cond
;	((or
;	  (match-beginning 2)
;	  (match-beginning 4))
;	 font-lock-type-face)
;	((match-beginning 6)
;	 font-lock-function-name-face)
;	(t font-lock-variable-name-face)))
;      (3 font-lock-function-name-face nil t)
;      (5
;       (if
;	   (match-beginning 6)
;	   font-lock-function-name-face font-lock-variable-name-face)
;       nil t)))
;    ("\\(}\\)[ 	*]*\\sw"
;     (font-lock-match-c++-style-declaration-item-and-skip-to-next
;      (goto-char
;       (match-end 1))
;      nil
;      (1
;       (if
;	   (match-beginning 6)
;	   font-lock-function-name-face font-lock-variable-name-face))))
;    ("^\\(\\(\\sw+\\)\\>\\([ 	]*<\\([^>\n]+\\)[ 	*&]*>\\)?\\([ 	]*::[ 	*~]*\\(\\sw+\\)\\)*[ 	*&]*\\)+"
;     (font-lock-match-c++-style-declaration-item-and-skip-to-next
;      (goto-char
;       (match-beginning 1))
;      (goto-char
;       (match-end 1))
;      (1
;       (cond
;       ((or
;	 (match-beginning 2)
;	 (match-beginning 4))
;	font-lock-type-face)
;       ((match-beginning 6)
;	font-lock-function-name-face)
;       (t font-lock-variable-name-face)))
;      (3 font-lock-function-name-face nil t)
;      (5
;       (if
;       (match-beginning 6)
;       font-lock-function-name-face font-lock-variable-name-face)
;       nil t)))
;    ("[{}()<>=;:+\\*\\/\\[]\\|\\]\\|\\-" (0 font-lock-keys-face))
;    ("\\<[0-9]+\\>" (0 font-lock-number-face))
;    ("\\<0x[0-9a-fA-F]+\\>" (0 font-lock-hexnumber-face))
;    ("\\<\\(Q_\\(EXPORT\\|OBJECT\\|PROPERTY\\)\\|S\\(IGNAL\\|LOT\\)\\|connect\\|disconnect\\|emit\\)\\>"
;     (0 font-lock-qt-face))
;    ))

;;; Auto-insert text when making new *.cpp, *.cc, *.h files.
;(add-hook 'find-file-hooks 'auto-insert)



;;; If you create a file called Test.hpp, this function will replace:
;;;
;;;   @@@ with TEST
;;;   ||| with Test
;;;   !!! with test
;;;
;;; The first one is useful for #ifdefs, the second one for the header
;;; description, for example.

;(defun auto-update-header-file ()
;  (if project-use-auto-insert
;      (let ()
;	(save-excursion
;	  (while (search-forward project-upcase-name-match nil t)
;	    (save-restriction
;	      (narrow-to-region (match-beginning 0) (match-end 0))
;	      (replace-match
;	       (upcase
;		(file-name-sans-extension
;		 (file-name-nondirectory buffer-file-name)))))))
;	(save-excursion
;	  (while (search-forward project-normal-name-match nil t)
;	    (save-restriction
;	      (narrow-to-region (match-beginning 0) (match-end 0))
;	      (replace-match
;	       (file-name-sans-extension
;		(file-name-nondirectory buffer-file-name))))))
;	(save-excursion
;	  (while (search-forward project-downcase-name-match nil t)
;	    (save-restriction
;	      (narrow-to-region (match-beginning 0) (match-end 0))
;	      (replace-match
;	       (downcase
;		(file-name-sans-extension
;		 (file-name-nondirectory buffer-file-name)))))))
;	(save-excursion
;	  (while (search-forward "\<real-name\>" nil t)
;	    (save-restriction
;	      (narrow-to-region (match-beginning 0) (match-end 0))
;	      (replace-match user-full-name))))
;	(save-excursion
;	  (while (search-forward "\<login-name\>" nil t)
;	    (save-restriction
;	      (narrow-to-region (match-beginning 0) (match-end 0))
;	      (replace-match user-login-name))))
;	(save-excursion
;	  (while (search-forward "\<mail-name\>" nil t)
;	    (save-restriction
;	      (narrow-to-region (match-beginning 0) (match-end 0))
;	      (replace-match project-mail-account)))))))

;;; If you create a file called Test.pro, this function will replace:
;;;
;;;   @@@ with test
;;;   ||| with Test
;;;   !!! with test
;;;
;;; It will also create a directory for objects if a OBJECTS_DIR is present

;(defun auto-update-project-file ()
;  (if project-use-auto-insert
;      (let ()
;	(save-excursion
;	  (while (search-forward project-upcase-name-match nil t)
;	    (save-restriction
;	      (narrow-to-region (match-beginning 0) (match-end 0))
;	      (replace-match
;	       (upcase
;		(file-name-sans-extension
;		 (file-name-nondirectory buffer-file-name)))))))
;	(save-excursion
;	  (while (search-forward project-normal-name-match nil t)
;	  (save-restriction
;	    (narrow-to-region (match-beginning 0) (match-end 0))
;	    (replace-match
;	     (file-name-sans-extension
;	      (file-name-nondirectory buffer-file-name))))))
;	(save-excursion
;	  (while (search-forward project-downcase-name-match nil t)
;	  (save-restriction
;	    (narrow-to-region (match-beginning 0) (match-end 0))
;	    (replace-match
;	     (downcase
;	      (file-name-sans-extension
;	       (file-name-nondirectory buffer-file-name)))))))
;	(save-excursion
;	  (while (search-forward "\<real-name\>" nil t)
;	  (save-restriction
;	    (narrow-to-region (match-beginning 0) (match-end 0))
;	    (replace-match user-full-name))))
;	(save-excursion
;	  (while (search-forward "\<login-name\>" nil t)
;	  (save-restriction
;	    (narrow-to-region (match-beginning 0) (match-end 0))
;	    (replace-match user-login-name))))
;	(save-excursion
;	  (while (search-forward "\<mail-name\>" nil t)
;	  (save-restriction
;	    (narrow-to-region (match-beginning 0) (match-end 0))
;	    (replace-match project-mail-account))))
;	(save-excursion
;	  (while (search-forward "OBJECTS_DIR" nil t)
;	  (save-excursion
;	    (search-forward "=" nil t)
;	    (save-restriction
;	      (if (search-forward-regexp "[ \t]*\\([a-zA-Z]+\\)[ \t]*$" nil t)
;		  (if (not (file-exists-p (match-string 1 )))
;		      (make-directory (match-string 1))))))))
;	(save-excursion
;	  (while (search-forward "MOC_DIR" nil t)
;	  (save-excursion
;	    (search-forward "=" nil t)
;	    (save-restriction
;	      (if (search-forward-regexp "[ \t]*\\([a-zA-Z]+\\)[ \t]*$" nil t)
;		  (if (not (file-exists-p (match-string 1 )))
;		      (make-directory (match-string 1))))))))
;	(save-buffer)
;	(shell-command (concat "tmake -o Makefile " (file-relative-name (buffer-file-name buffer-file-name) (pwd)))))))

;;; Scans a .hpp .h or .hh file when saved for the keyword Q_OBJECT
;;; if found then checks if the moc file exists for the the .cpp file
;;; if not runs tmake on the project file
;(defun c++-moc-file ()
;  "Runs tmake on the project if signals/slots has been added to the c++ header."
;  (interactive)
;  (if (string-match c++-header-ext-regexp (buffer-name))
;      (save-excursion
;	(beginning-of-buffer)
;	(let ((filedir (file-relative-name (file-name-directory (buffer-file-name))))
;	      (filenonext (file-name-sans-extension (file-relative-name (file-name-directory (buffer-file-name))))))
;	  (if (search-forward-regexp "\\<Q_OBJECT\\>" nil t)
;	      (progn
;		(set-buffer (project-main))
;		(save-buffer)
;		(if (not (file-exists-p (concat filedir	"moc_" filenonext "." c++-default-source-ext)))
;		    (shell-command (concat "tmake -o " filedir "Makefile " (file-name-nondirectory (buffer-file-name (project-main)))) )))
;	    (save-restriction
;	      (setq filename (concat filedir "moc_" filenonext "." c++-default-source-ext))
;	      (if (file-exists-p filename)
;		  (progn
;		    (set-buffer (project-main))
;		    (save-buffer)
;		    (shell-command (concat "tmake -o " filedir "Makefile " (file-name-nondirectory (buffer-file-name (project-main)))))
;		    (delete-file filename))))))))
;  nil)

;(add-hook 'after-save-hook 'c++-moc-file)

;;; Inserts a Q_OBJECT in a c++ header file if slots of signals are used
;(defun buffer-insert-qobject()
;  (interactive)
;  (save-excursion
;    (beginning-of-buffer)
;    (if (search-forward-regexp (regexp-opt '("slots" "signals") t) nil t)
;	(let ()
;	  (beginning-of-buffer)
;	  (if (search-forward-regexp (concat "^\\(template[ \t]*<[^>]+>[ \t]*\\)?class[ \t]+\\([a-zA-Z0-9_]+\\)[ \t\n]*"
;					     "\\([:][ \t\n]*\\(public\\|protected\\|private\\)?[ \t\n]*\\<[a-zA-Z0-9_]+\\>\\)?"
;					     "[ \t\n]*{")
;				     nil t)
;	      (if (not (looking-at "[ \t\n]*\\(Q_OBJECT\\)"))
;		  (insert-string "\n\tQ_OBJECT"))
;	    (ding))))))

;;(add-hook 'write-file-hooks '(lambda ()
;;			       (interactive)
;;			       (if (string-match c++-header-ext-regexp (buffer-name))
;;				   (buffer-insert-qobject))))

;;; Adds index to the menu for lisp and c/c++ modes.
;(defun project-add-index ()
;  (if (or (string-match mode-name "Emacs-Lisp")
;	  (string-match mode-name "C++")
;	  (string-match mode-name "C"))
;      (imenu-add-menubar-index)))


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

(provide 'e-c)
;;; e-c.el ends here
