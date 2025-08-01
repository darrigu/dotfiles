(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(defvar rc/package-contents-refreshed nil)

(defun rc/package-refresh-contents-once ()
  (unless rc/package-contents-refreshed
    (setq rc/package-contents-refreshed t)
    (message "Refreshing package archives...")
    (condition-case err
        (progn
          (package-refresh-contents :noasync) 
          (message "Refreshing package archives... done"))
      (error 
       (message "Package refresh failed: %s" (error-message-string err))
       (setq rc/package-contents-refreshed nil)))))

(defun rc/require-one-package (package)
  (unless (package-installed-p package)
    (rc/package-refresh-contents-once)
    (condition-case err
        (package-install package)
      (error 
       (message "Failed to install '%s': %s" package (error-message-string err))))))

(defun rc/require (&rest packages)
  (dolist (pkg packages)
    (rc/require-one-package pkg)))

(setopt
 inhibit-splash-screen t
 make-backup-files nil
 tab-width 4
 indent-tabs-mode nil
 compilation-scroll-output t
 confirm-kill-emacs 'yes-or-no-p
 display-line-numbers-type 'relative
 )

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(rc/require 'catppuccin-theme)
(load-theme 'catppuccin t)

(rc/require 'ido 'ido-completing-read+ 'amx)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)
(amx-mode 1)

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(rc/require 'sly)
(require 'sly-autoloads)
(setq inferior-lisp-program "/sbin/sbcl")

(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Switch to interactive Scheme buffer." t)
(setq auto-mode-alist (cons '("\\.ss" . scheme-mode) auto-mode-alist))

(defun rc/duplicate-line ()
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

(rc/require 'yasnippet)

(setopt yas-snippet-dirs '("~/.emacs.d/snippets/"))
(yas-global-mode 1)

(rc/require 'corfu 'cape)

(require 'corfu)
;; (define-key corfu-map [up] nil)
;; (define-key corfu-map [down] nil)
;; (define-key corfu-map [remap previous-line] nil)
;; (define-key corfu-map [remap next-line] nil)
(setopt corfu-cycle t)

(global-corfu-mode 1)

(add-hook 'completion-at-point-functions #'cape-dabbrev)
(add-hook 'completion-at-point-functions #'cape-file)

(rc/require 'magit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(amx cape catppuccin-theme corfu ido-completing-read+ magit
         multiple-cursors simpc-mode sly yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
