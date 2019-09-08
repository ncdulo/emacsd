;; Set up perl language support

;; Prefer cperl-mode over default perl-mode
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\[a]\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(provide 'lang-perl)
