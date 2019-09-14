;; Add custom themes here. I would like to build a collection of
;; several to choose from. Maybe a fast theme switcher would be
;; fun/useful to implement someday

;; Original default zenburn
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

;; Not the biggest fan of this theme. It's a bit lighter than
;; sanityinc-tomorrow and a lot more purple. Keeping the code
;; in case I would like to use it again sometime.
;; (use-package apropospriate-theme
;;   :config
;;   (setq custom-safe-themes t)
;;   (load-theme 'apropospriate-dark t))

(provide 'base-theme)
