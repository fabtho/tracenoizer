;;Put your .emacs customization code here, which needs to load *AFTER* EMacro
;;$Id$
;;Remove this broken ediff code
;;(setq ediff-wide-display-p t)

;;Turn off XEmacs toolbar
;;(when (string-match "XEmacs" (emacs-version))
;;  (set-specifier default-toolbar-visible-p 'nil))

;;(setq-default indent-tabs-mode nil)     ;use spaces (not tabs) for indenting

;;(if (which "jikes")
;;    (progn
;;     (setq use-jde-compiler "jikes")
;;     (setq jde-interactive-compile-args  "+E +P -deprecation -depend")
;;     ))
;;See cache-java-open under "Java Accessories" in programmer/e-java.el
;(defconst source-path '("/usr/java/src" "/home/java/src/"))

;;(autoload 'jde-set-variables "jde" "jde" t)
;;(jde-set-variables
;; '(jde-jdk-registry '(("1.3.1_01" . "/usr/java/jdk1.3.1_01/"))))

(when cache-tiny-path (tinypath-cache-problem-report))
(add-to-list 'load-path "/usr/share/xemacs/site-lisp/w3m")

(provide 'e-postload)
