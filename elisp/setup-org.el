(use-package org
  :bind
  ("C-c b" . org-switchb)
  :config
  ;; Enable autofill mode
  (add-hook 'org-mode-hook 'turn-on-auto-fill)

  (setq org-startup-indented t
        org-hide-leading-stars t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-deadline-warning-days 7)

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
                                 "* %i%?\n%U\n")
                                ("j" "Journal" entry
                                 (file+datetree "~/org/journal.org")
                                 "* %?\nEntered on %U\n %i\n %a")))

  ;; Refile targets
  (setq org-refile-targets '(("~/org/gtd/tasks.org" :maxlevel . 1)
                             ("~/org/gtd/someday.org" :maxlevel . 1)
                             ("~/org/gtd/projects.org" :maxlevel . 3)
                             ("~/org/gtd/tickler.org" :maxlevel . 2)))

  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "APPT(a)"  "WAITING(w!)""|" "DONE(d!)" "CANCELED(c!)")))

  ;; Custom agenda commands
  ;; TODO: Still need to override header in some of these views.
  ;; TODO: Projects with next actions.
  ;; TODO: Further refine the custom views to my preference.
  (setq org-agenda-custom-commands
        ;; View of only tasks with @home or @computer context
        '(("h" "At home, on computer" ((agenda "" ((org-agenda-span 1)))
                                       (tags-todo "@home")
                                       (tags-todo "@computer")))
          ("d" "Dev tag" ((agenda "" ((org-agenda-span 1)))
                          (tags-todo "dev")))
          ;; View of only @errand or @work contexts
          ("e" "Errands, at work" ((agenda "" ((org-agenda-span 1)))
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
            (agenda "" ((org-agenda-span 1)
                        (org-agenda-overriding-header "Today's Agenda")))
            ;; Filter out any priority A tasks then list the remaining ones.
            ;; Note -- this seems to skip over priority B and C as well. See if
            ;; we can't fix that at some point. Alternatively, add more sections
            ;; or agenda views to cover other priorities.
            (alltodo ""
                     ((org-agenda-skip-function
                       '(or (air-org-skip-subtree-if-priority ?A)
                            (org-agenda-skip-if nil '(scheduled deadline))))
                      (org-agenda-overriding-header "All normal priority tasks:")))))
          ;; Dropped parens to next line for readability. New custom commands go here :)
          ))

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
