;;Potpourri of interesting functions.
;;Contact me, if you want them in future EMacro versions

(defmacro GNUEmacs (&rest x)
  (list 'if (string-match "GNU Emacs " (version)) (cons 'progn x)))
(defmacro XEmacs (&rest x)
  (list 'if (string-match "XEmacs " (version)) (cons 'progn x)))
(defmacro Xlaunch (&rest x)
  (list 'if (eq window-system 'x) (cons 'progn x)))
