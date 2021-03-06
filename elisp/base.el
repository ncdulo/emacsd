(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Disabling as I do not think I saw much difference in speed.
;; Also testing to see if this was the cause of the 'lisp-nesting'
;; error I have been encountering.
;; Reference: https://github.com/emacscollective/auto-compile
;; (use-package auto-compile
;;   :config
;;   (auto-compile-on-load-mode)
;;   (auto-compile-on-save-mode)

;;   ;; If compile log gets bothersome..
;;   ;; fix the errors, or uncomment..
;;   (setq auto-compile-display-buffer nil)
;;   (setq auto-compile-mode-line-counter t)
;;   )

(setq user-full-name "Nick Cardullo"
      user-mail-address "nick.cardullo@gmail.com")

(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories.")

;; Core settings
(setq gc-cons-threshold (* 100 1024 1024)
      large-file-warning-threshold (* 15 1024 1024))
;; UTF-8 please
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)   ; pretty
(set-terminal-coding-system  'utf-8)   ; pretty
(set-keyboard-coding-system  'utf-8)   ; pretty
(set-selection-coding-system 'utf-8)   ; please
(prefer-coding-system        'utf-8)   ; with sugar on top
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Emacs customizations
(setq confirm-kill-emacs                  'y-or-n-p
      confirm-nonexistent-file-or-buffer  t
      column-number-mode                  t
      save-interprogram-paste-before-kill t
      mouse-yank-at-point                 t
      require-final-newline               t
      sentence-end-double-space           nil ; sentences end in a single space
      savehist-file                       (concat temp-dir "/history")
      visible-bell                        nil
      ring-bell-function                  'ignore
      custom-file                         "~/.emacs.d/.custom.el"
      ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
      minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)

      ;; Disable non selected window highlight
      cursor-in-non-selected-windows     nil
      highlight-nonselected-windows      nil
      ;; PATH
      exec-path                          (append exec-path '("/usr/local/bin/"))
      indent-tabs-mode                   nil
      inhibit-startup-message            t
      fringes-outside-margins            t
      select-enable-clipboard            t
      use-package-always-ensure          t)

;; Enable persistent history for minibuffer
(savehist-mode)

;; Editing defaults
(setq-default indent-tabs-mode nil
	      tab-width 4)
(delete-selection-mode)
(setq kill-whole-line t)

;; Update ibuffer when changes occur
(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)))
(setq ibuffer-use-other-window t) ;; always display ibuffer in another window

;; Bookmarks
(setq
 ;; persistent bookmarks
 bookmark-save-flag                      t
 bookmark-default-file              (concat temp-dir "/bookmarks"))

;; Backups enabled, use nil to disable
(setq
 history-length                     1000
 backup-inhibited                   nil
 make-backup-files                  t
 auto-save-default                  t
 auto-save-list-file-name           (concat temp-dir "/autosave")
 make-backup-files                  t
 create-lockfiles                   nil
 backup-by-copying                  t ; don't clobber symlinks
 delete-old-versions                t
 kept-new-versions                  4
 kept-old-versions                  2
 version-control                    t
 backup-directory-alist            `((".*" . ,(concat temp-dir "/backup/")))
 auto-save-file-name-transforms    `((".*" ,(concat temp-dir "/auto-save-list/") t)))

(unless (file-exists-p (concat temp-dir "/auto-save-list"))
		       (make-directory (concat temp-dir "/auto-save-list") :parents))

(fset 'yes-or-no-p 'y-or-n-p)
;;(global-auto-revert-mode t)

;; Smoother scrolling options
(setq scroll-margin 1
      scroll-step 1
      scroll-conservatively 100
      scroll-preserve-screen-position 1
      mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Disable toolbar & menubar
;; "C-<mouse3>" for menu :)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (  fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Highlight the line containing the point, globally
(global-hl-line-mode)

(show-paren-mode 1)

;; Enable fringe markings for buffer start, end and empty lines
(setq-default indicate-buffer-boundaries 'left
              indicate-empty-lines +1)

;; Save our session on exit and auto restore on start
(desktop-save-mode 1)

;; default size of.. initial frame
(setq initial-frame-alist
      '((width . 90) ; characters in a line
        (height . 40))) ; number of lines
;; and subsequent frames
(setq default-frame-alist
      '((width . 90) ; characters in a line
        (height . 40))) ; number of lines

;; set our cursor type to something more familiar
(setq-default cursor-type '(bar . 1))

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable autofill mode for text
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Dired customizations
(setq dired-dwim-target t
      dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-listing-switches "-lha")
;;(add-hook 'dired-mode-hook 'auto-revert-mode)

(provide 'base)
;;; base ends here
