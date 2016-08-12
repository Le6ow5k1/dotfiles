(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     auto-completion
     emacs-lisp
     git
     markdown
     html
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     version-control
     ruby-on-rails
     ruby
     (ruby :variables ruby-enable-enh-ruby-mode t)
     (ruby :variables ruby-version-manager 'rvm)
     (ruby :variables ruby-test-runner 'rspec)
     )
   dotspacemacs-additional-packages '(multiple-cursors org-jira jira-markup-mode ox-jira ox-gfm)
   dotspacemacs-excluded-packages '(evil-jumper)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'emacs
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-scratch-mode 'org-mode
   dotspacemacs-themes '(monokai
                         spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  )

(defun dotspacemacs/user-config ()
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  (define-key key-translation-map (kbd "C-ф") (kbd "C-a"))
  (define-key key-translation-map (kbd "C-у") (kbd "C-e"))
  (define-key key-translation-map (kbd "C-ч") (kbd "C-x"))
  (define-key key-translation-map (kbd "C-ы") (kbd "C-s"))
  (define-key key-translation-map (kbd "C-н") (kbd "C-y"))

  (add-hook 'org-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c C-h") 'org-toggle-link-display))

            (defun my-conf-item (item contents info)
              (let* ((plain-list (org-export-get-parent item))
                     (type (org-element-property :type plain-list)))
                (case type
                      (ordered
                       (concat (make-string (1+ (org-confluence--li-depth item)) ?\#)
                               " "
                               (org-trim contents)))
                      (unordered (org-export-with-backend 'confluence item contents info))
                      (descriptive (org-export-with-backend 'confluence item contents info)))))

            (org-export-define-derived-backend 'better-confluence 'confluence
              :translate-alist '((item . better-confluence-item)))

            (defun org-better-confluence-export-as-conf
                (&optional async subtreep visible-only body-only ext-plist)
              (interactive)
              (org-export-to-buffer 'better-confluence "*org CONFLUENCE Export*"
                async subtreep visible-only body-only ext-plist (lambda () (text-mode))))
            (setq org-startup-align-all-tables t)
            )

  (setq truncate-lines 'nil)

  (setq jiralib-url "https://jira.railsc.ru")
  (setq-default ruby-version-manager 'rvm)
  (setq flycheck-rubocoprc "~/rubocop.yml")
  (setq enh-ruby-add-encoding-comment-on-save nil)
  (setq exec-path-from-shell-arguments '("-l"))
  (add-hook 'after-make-frame-functions
            (lambda ()
              (if (not window-system)
                  (setq global-hl-line-mode nil))))
  (add-hook 'after-init-hook
            (lambda ()
              (if (not window-system)
                  (setq global-hl-line-mode nil))))
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-export-backends (quote (ascii html icalendar latex md confluence)))
 '(org-support-shift-select t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
