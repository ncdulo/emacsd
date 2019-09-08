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

  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w!)" "NEXT(n)" "APPT(a)" "|" "DONE(d!)" "CANCELED(c!)")))

  ;; Custom agenda commands
  (setq org-agenda-custom-commands
       ;; View of only tasks with @home or @computer context
	'(("h" "At home, on computer" ((agenda)
                                   (tags-todo "@home")
                                   (tags-todo "@computer")))
      ;; View of only @errand or @work contexts
      ("e" "Errands, at work" ((agenda)
                               (tags-todo "@errand")
                               (tags-todo "@work")))
      ;; View of only project tasks. Maybe we can make this into a tree
      ;; view, or otherwise separate projects. May also want to limit
      ;; to only NEXT states. That way an entire project tree can be
      ;; created, but only NEXT items are displayed. That will make it
      ;; easier to pick one and dive in. Reduce stress/clutter and
      ;; help 'get things done'!
	  ("p" "Project view" tags-todo "project"
	   ((org-agenda-overriding-header "Projects")))
      ;; This overview will show a view with:
      ;;  - Priority A
      ;;  - Daily agenda
      ;;  - Normal priority tasks
	  ("o" "Overview of all tasks"
       ((tags "PRIORITY=\"A\""
              ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
               (org-agenda-overriding-header "High priority unfinished tasks:")))
        ;; Display agenda for today only
        (agenda "" ((org-agenda-span 1)))
        ;; Filter out any priority A tasks then list the remaining ones.
        ;; Note -- this seems to skip over priority B and C as well. See if
        ;; we can't fix that at some point. Alternatively, add more sections
        ;; or agenda views to cover other priorities.
        (alltodo ""
                 ((org-agenda-skip-function
                   '(or (air-org-skip-subtree-if-priority ?A)
                        (org-agenda-skip-if nil '(scheduled deadline))))
                  (org-agenda-overriding-header "All normal priority tasks:"))))
        ((org-agenda-compact-blocks t)))))

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
