(load-file (concat (expand-file-name "~") "/emacs/e-path.el"))
(require 'tramp)
(setq tramp-debug-buffer t)

;(setq tramp-default-method "pscp")
;(setq tramp-default-method "plink")
;(setq tramp-default-method "sshx")
;(setq tramp-default-method "ssh1")

(setq debug-on-error 't)
(setq debug-on-quit 't)

;(setq tramp-ls-command "\\ls")

;(setq debug-on-signal 't)
;(setq debug-ignored-errors 't)
;(setq debug-on-next-call 't)
