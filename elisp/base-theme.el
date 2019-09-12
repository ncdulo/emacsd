;; (use-package zenburn-theme
;;   :defer t
;;   :init
;;   (load-theme 'zenburn t))

(use-package color-theme-sanityinc-tomorrow
  :config
  ;; We shouldn't need this, but using as a quick workaround
  ;; for emacs asking 'is this theme safe?' each start.
  (setq custom-safe-themes t)
  (load-theme 'sanityinc-tomorrow-eighties t))

(provide 'base-theme)
