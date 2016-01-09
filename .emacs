(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(package-initialize)

(require 'ergoemacs-mode)
(setq ergoemacs-theme nil)
(setq ergoemacs-keyboard-layout "us")
(ergoemacs-mode 1)

(setq backup-directory-alist '((".*" . "~/.Trash")))
(setq auto-save-list-file-name  nil)
(setq auto-save-default         nil)

(setq show-paren-style 'expression)
(show-paren-mode 2)

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

(menu-bar-mode -1)
(tool-bar-mode -1)

(add-to-list 'load-path "~/.emacs.d/vendor")

(require 'linum+)
(global-linum-mode 1)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(require 'haml-mode)

(require 'web-mode)

(setq-default fill-column 120)
(add-hook 'prog-mode-hook 'highlight-beyond-fill-column)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-beyond-fill-column-face ((t (:foreground "red")))))

(require 'rvm)
(rvm-use-default)

(require 'yasnippet)
(yas-global-mode 1)

(require 'projectile)
(projectile-global-mode)

(require 'smartparens-config)
(add-hook 'prog-mode-hook #'smartparens-mode)
(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)

(add-hook 'ruby-mode-hook 'robe-mode)

(require 'hideshow)

(require 'ag)

(require 'powerline)
(powerline-default-theme)

(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(require 'neotree)
(global-set-key (kbd "<f5>") 'neotree-toggle)

(load-theme 'misterioso)

(set-face-attribute 'default nil :height 140)

(defun duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )
(global-set-key (kbd "C-d") 'duplicate-line)

(require 'move-text)
(global-set-key (kbd "C-K") 'ergoemacs-move-text-down)
(global-set-key (kbd "C-I") 'ergoemacs-move-text-up)
(global-set-key (kbd "TAB") 'indent-for-tab-command)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq split-width-threshold nil)
(setq split-height-threshold 0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ergoemacs-ctl-c-or-ctl-x-delay 0.2)
 '(ergoemacs-handle-ctl-c-or-ctl-x (quote both))
 '(ergoemacs-ini-mode t)
 '(ergoemacs-keyboard-layout "us")
 '(ergoemacs-mode t)
 '(ergoemacs-smart-paste nil)
 '(ergoemacs-theme "standard")
 '(ergoemacs-theme-options nil)
 '(ergoemacs-use-menus t)
 '(initial-scratch-message
   ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

")
 '(scroll-error-top-bottom nil)
 '(set-mark-command-repeat-pop nil)
 '(shift-select-mode t))
