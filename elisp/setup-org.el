(use-package org
  :config
  ;; Enable autofill mode
  (add-hook 'org-mode-hook 'turn-on-auto-fill)

  ;; Default directories and files
  (setq org-directory "~/org"
        org-default-notes-file (concat org-directory "/notes/notes.org")
	org-agenda-files (list (concat org-directory "/gtd/inbox.org")
			       (concat org-directory "/gtd/projects.org")
			       (concat org-directory "/gtd/tasks.org")
			       (concat org-directory "/gtd/tickler.org")))

  ;; Capture templates
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
				 (file+headline "~/org/gtd/inbox.org" "Inbox")
				 "* TODO %i%?\n%T\n")
				("T" "Tickler" entry
				 (file+headline "~/org/gtd/tickler.org" "Tickler")
				 "* %i%?\n%U\n")))

  ;; Refile targets
  (setq org-refile-targets '(("~/org/gtd/tasks.org" :maxlevel . 1)
			     ("~/org/gtd/someday.org" :maxlevel . 1)
			     ("~/org/gtd/projects.org" :maxlevel . 3)
			     ("~/org/gtd/tickler.org" :maxlevel . 2)))

  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w!/@)" "NEXT(n)" "APPT(a)" "|" "DONE(d!)" "CANCELED(c!/@)")))

  ;; Custom agenda commands
  (setq org-agenda-custom-commands
	'(("h" "At home, on computer" ((agenda)
                                   (tags-todo "@home")
                                   (tags-todo "@computer")))
	  ("e" "Errands, at work" ((agenda)
                               (tags-todo "@errand")
                               (tags-todo "@work")))
	  ("p" "Project view" tags-todo "project"
	   ((org-agenda-overriding-header "Projects")))
	  ("o" "Overview of all tasks"
       ((tags "PRIORITY=\"A\""
              ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
               (org-agenda-overriding-header "High priority unfinished tasks:")))
        ;; Figure out how to limit to daily agenda. Weekly seems to be
        ;; very cluttered. At minimum, reduce amount of information.
        ;; Too much at once will create stress.
        (agenda "")
        ;; Figure out how to override header here. Want to use label
        ;; "All tasks:" for alltodo section.
        (alltodo "")))))

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
