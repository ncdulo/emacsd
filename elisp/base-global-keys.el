;; Add your keys here, as such

;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])

(global-set-key (kbd "C-c q") 'auto-fill-mode)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<RET>") 'newline-and-indent)


(global-set-key (kbd "C-a") 'prelude-move-beginning-of-line)
(global-set-key (kbd "C-c i") 'indent-region-or-buffer)
(global-set-key (kbd "C-x k") 'kill-default-buffer)
(global-set-key (kbd "C-o") 'prelude-smart-open-line)
(global-set-key (kbd "M-o") 'open-line)

(provide 'base-global-keys)
