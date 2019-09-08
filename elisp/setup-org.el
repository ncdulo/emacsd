(use-package org
  :config
  (setq org-directory "~/org"
        org-default-notes-file (concat org-directory "/notes/notes.org")
	org-agenda-files (list (concat org-directory "/gtd/inbox.org")
			       (concat org-directory "/gtd/projects.org")
			       (concat org-directory "/gtd/tasks.org")
			       (concat org-directory "/gtd/tickler.org"))
	)
  :bind
  ("C-c c" . org-capture)
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda))

;;(use-package org-projectile
;;  :config
;;  (org-projectile-per-project)
;;  (setq org-projectile-per-project-filepath "todo.org"
;;	org-agenda-files (append org-agenda-files (org-projectile-todo-files))))

(use-package org-bullets
  :config
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-bullets-mode t))))

(provide 'setup-org)
