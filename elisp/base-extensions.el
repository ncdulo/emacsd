
;; This should allow paradox to play with packages in the background
(use-package async
  :commands (async-start))

(use-package restart-emacs
  :bind* (("C-x M-c" . restart-emacs)))

;; Reference: https://github.com/abo-abo/ace-window
(use-package ace-window
  :bind
  ("M-o" . ace-window))

(use-package aggressive-indent
  :config
  (add-hook 'prog-mode-hook #'aggressive-indent-mode))

(use-package avy
  :bind
  ("C-c SPC" . avy-goto-char))


(use-package company
  :diminish " Cmpny"
  :config
  (setq company-minimum-prefix-length 2
        company-require-match nil
        company-selection-wrap-around t
        company-show-numbers t
        ;;company-dabbrev-downcase nil
        company-tooltip-limit 10
        company-tooltip-align-annotations 't
        company-idle-delay 0.4
        company-begin-commands '(self-insert-command))
  (add-to-list 'company-backends '(company-elisp
                                   ;;company-css
                                   company-cmake
                                   ;;company-nxml
                                   company-capf
                                   company-files
                                   ;;company-keywords
                                   ;;company-dabbrev-code
                                   ;;company-dabbrev
                                   ))
  (add-hook 'after-init-hook 'global-company-mode))

;;(use-package dashboard
;;  :config
;;  (dashboard-setup-startup-hook))

(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "box"
	centaur-tabs-set-modified-marker t)
  (centaur-tabs-mode t)

  :ensure t)

;; Provide better line/region commenting
(use-package comment-dwim-2
  :bind ("M-;" . comment-dwim-2))

(use-package discover-my-major
  :bind
  ("C-h C-m" . discover-my-major)
  ("C-h M-m" . discover-my-mode)
  )

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w"))

(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package counsel
  :bind
  ;;("M-x" . counsel-M-x)
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x c k" . counsel-yank-pop))

;; Reference: https://github.com/ericdanan/counsel-projectile
(use-package counsel-projectile
  :bind
  ("C-x v" . counsel-projectile)
  ("C-x c p" . counsel-projectile-ag)
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (counsel-projectile-mode))

(use-package ido
  :config
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10
        ido-default-file-method 'selected-window
        ido-auto-merge-work-directories-length -1
        ido-use-faces nil)
  (ido-mode 1)

  (ido-everywhere 1))

(use-package ido-completing-read+
  :config
  (ido-ubiquitous-mode 1))

(use-package flx-ido
  :config
  (flx-ido-mode 1)
  (setq ido-use-faces nil))

(use-package ivy
  :bind
  ("C-s" . swiper)
  ("C-r" . swiper)
  ("C-x C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil
        ivy-count-format "(%d/%d) ")
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))

(use-package git-gutter-fringe
  :diminish
  :config
  (global-git-gutter-mode +1))

(use-package diminish)

(use-package golden-ratio
  :diminish
  :config
  (setq golden-ratio-exclude-modes '("ediff-mode"
				                     "dired-mode"
                                     "gud-mode"
                                     "gdb-locals-mode"
                                     "gdb-registers-mode"
                                     "gdb-breakpoints-mode"
                                     "gdb-threads-mode"
                                     "gdb-frames-mode"
                                     "gdb-inferior-io-mode"
                                     "gdb-disassembly-mode"
                                     "gdb-memory-mode"
                                     "magit-log-mode"
                                     "magit-reflog-mode"
                                     "magit-status-mode"
                                     "IELM"
                                     "eshell-mode"
                                     "dired-mode"))
  (golden-ratio-mode))

(use-package hlinum
  :config
  (hlinum-activate))

(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))

(use-package highlight-numbers
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

(use-package highlight-symbol
  :diminish
  :config
  (highlight-symbol-nav-mode)

  ;; I think there is a more recommended way to add this hook.
  ;; Research it and fix if need be.
  (add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
  (add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

  (setq highlight-symbol-idle-delay 0.2
        highlight-symbol-on-navigation-p t)
  (global-set-key [(control shift mouse-1)]
                  (lambda (event)
                    (interactive "e")
                    (goto-char (posn-point (event-start event)))
                    (highlight-symbol-at-point)))

  :bind
  ("M-n" . highlight-symbol-next)
  ("M-p" . highlight-symbol-prev))

(use-package ibuffer-vc
  :config
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-vc-set-filter-groups-by-vc-root)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic))))

  ;; Use human readable Size column instead of original one
  (define-ibuffer-column size-h
    (:name "Size"
           :inline t
           :summarizer
           (lambda (column-strings)
             (let ((total 0))
               (dolist (string column-strings)
                 (setq total
                       ;; like, ewww ...
                       (+ (float (ajv/human-readable-file-sizes-to-bytes string))
                          total)))
               (ajv/bytes-to-human-readable-file-sizes total)))	 ;; :summarizer nil
           )
    (ajv/bytes-to-human-readable-file-sizes (buffer-size)))

  (setq ibuffer-formats
        '((mark modified read-only vc-status-mini " "
                (name 18 18 :left :elide)
                " "
                (size-h 11 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                (vc-status 16 16 :left)
                " "
                filename-and-process)))
  )

(use-package magit
  :config

  (setq magit-completing-read-function 'ivy-completing-read)

  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)

;; Reference: https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Disabling because it gets weird and I'm not sure how to turn
;; off the extra cursors
;; (use-package multiple-cursors
;;   :bind
;;   ("C-S-c C-S-c" . mc/edit-lines)
;;   ("C->" . mc/mark-next-like-this)
;;   ("C-<" . mc/mark-previous-like-this)
;;   ("C-c C->" . mc/mark-all-like-this))

(use-package page-break-lines)

(use-package paradox
  :config
  ;; Set this to nil as I have had emacs freeze/crash when attempting to use it
  ;; Maybe it was just dependency issues or something related to my confif
  ;; at the time
  (setq paradox-execute-asynchronously nil
        paradox-github-token t)
  ;; Paradox set as default package interface
  (paradox-enable))

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir))

  ;; Set a custom mode-line display here as I'm not sure the
  ;; diminish style syntax for this one.
  (setq projectile-mode-line-function
        (lambda () (if (and (ignore-errors (projectile-project-p))
                            (not (file-remote-p default-directory)))
                       (format " [%s]" (projectile-project-name))
                     "")))

  (setq projectile-completion-system 'ivy)

  (projectile-mode))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  :delight)

(use-package rainbow-mode
  :diminish " Rb"
  :config
  (add-hook 'prog-mode-hook 'rainbow-mode)
  :delight)

(use-package recentf
  :config
  (setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf")
        recentf-max-saved-items 100
        recentf-exclude '("/tmp/" "/ssh:"))
  (recentf-mode 1))

(use-package shell-pop
  ;; Try to find a different keybind.
  ;; C-t is normally bound to transpose character, which I
  ;; think could be useful
  ;; Fix this: shell-pop does not toggle with keybind. It will
  ;; open but not close.
  :bind (("C-t" . shell-pop))
  :config
  (setq shell-pop-shell-type '("ansi-term" "*ansi-term*"
                               (lambda nil (ansi-term shell-pop-term-shell))))
  ;; I would prefer ZSH but something is wonky with the way it echo's text back to us.
  ;; Prompt is fine, output is corrupt or misread. Maybe encoding problem? Fix this.
  (setq shell-pop-term-shell "/bin/bash")
  ;; need to do this manually or not picked up by shell-pop
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))

(use-package smart-mode-line
  :config
  (setq sml/name-width 36
        sml/mode-width 'full
        sml/shorten-directory t
        sml/shorten-modes t)
  ;; If we need to set a theme, do it *before* the following line
  (sml/setup))

(use-package smartparens
  :config
  (require 'smartparens-config)
  ;; This removes "'" from counting as a parens
  ;; pair when running in emacs-lisp-mode.
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  ;; Commenting out to try new set of keybinds
  (add-hook 'prog-mode-hook #'smartparens-strict-mode)

   ;; SmartParens keybinds
   ;; Source: https://ebzzry.io/en/emacs-pairs/
   ;; NOTE: These should probably use the ":bind" section
   ;; but I could not get it working properly.
   :bind
   (:map smartparens-mode-map
   ("C-M-a" . sp-beginning-of-sexp)
   ("C-M-e" . sp-end-of-sexp)

   ("C-<down>" . sp-down-sexp)
   ("C-<up>" . sp-up-sexp)
   ("M-<down>" . sp-backward-down-sexp)
   ("M-<up>" . sp-backward-up-sexp)

   ("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)

   ("C-M-n" . sp-next-sexp)
   ("C-M-p" . sp-previous-sexp)

   ("C-S-f" . sp-forward-symbol)
   ("C-S-b" . sp-backward-symbol)

   ("C-<right>" . sp-forward-slurp-sexp)
   ("M-<right>" . sp-forward-barf-sexp)
   ("C-<left>" . sp-backward-slurp-sexp)
   ("M-<left>" . sp-backward-barf-sexp)

   ("C-M-t" . sp-transpose-sexp)
   ("C-M-k" . sp-kill-sexp)
   ("C-k" . sp-kill-hybrid-sexp)
   ("M-k" . sp-backward-kill-sexp)
   ("C-M-w" . sp-copy-sexp)
   ("C-M-d" . delete-sexp)

   ("M-<backspace>" . backward-kill-word)
   ("C-<backspace>" . sp-backward-kill-word)
   ([remap sp-backward-kill-word] . backward-kill-word)

   ("M-[" . sp-backward-unwrap-sexp)
   ("M-]" . sp-unwrap-sexp)

   ("C-x C-t" . sp-transpose-hybrid-sexp)))

(use-package smex
  :config
  (setq smex-history-length 25)
  (smex-initialize)
  :bind
  ("M-x" . smex)
  ("M-X" . smex-major-mode-commands))

(use-package undo-tree
  :diminish
  :config
  ;; Remember undo history
  (setq
   undo-tree-auto-save-history nil
   undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/"))))
  (global-undo-tree-mode 1))

(use-package volatile-highlights
  :diminish
  :config
  (volatile-highlights-mode t))

(use-package which-key
  :diminish
  :config
  (which-key-mode))

(use-package windmove
  :bind
  ("C-x <up>" . windmove-up)
  ("C-x <down>" . windmove-down)
  ("C-x <left>" . windmove-left)
  ("C-x <right>" . windmove-right))

(use-package wgrep)

(use-package writegood-mode
  ;;:diminish writegood-mode
  :config
  (add-hook 'text-mode-hook 'writegood-mode)
  ;; (add-hook 'org-mode-hook 'writegood-mode)
  )

;; Might want to hotkey this.
;; Or default to opening in a new frame. Wrapper function probably.
;; Or figure out how to default to a certain city. (through hotkey?)
;; Reference: https://wttr.in/:help
(use-package wttrin
  :commands (wttrin)
  :config
  (setq wttrin-default-cities '("33328?F"
                                "Hollywood, FL?F"
                                "Dallas, TX?F")))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(provide 'base-extensions)
