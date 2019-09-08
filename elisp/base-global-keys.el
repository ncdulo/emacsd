;; Add your keys here, as such

;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])

(global-set-key (kbd "C-c q") 'auto-fill-mode)
(global-set-key (kbd "<RET>") 'newline-and-indent)

;; ibuffer related
(global-set-key (kbd "C-x C-b") 'ibuffer)
(define-key ibuffer-mode-map (kbd "<up>") 'kuanyui/ibuffer-previous-line)
(define-key ibuffer-mode-map (kbd "C-p") 'kuanyui/ibuffer-previous-line)
(define-key ibuffer-mode-map (kbd "<down>") 'kuanyui/ibuffer-next-line)
(define-key ibuffer-mode-map (kbd "C-n") 'kuanyui/ibuffer-next-line)

(global-set-key (kbd "C-a") 'prelude-move-beginning-of-line)
(global-set-key (kbd "C-c i") 'indent-region-or-buffer)
(global-set-key (kbd "C-x k") 'kill-default-buffer)
(global-set-key (kbd "C-o") 'prelude-smart-open-line)
(global-set-key (kbd "M-o") 'open-line)

(provide 'base-global-keys)
