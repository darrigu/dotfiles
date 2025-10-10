(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)

(setq-default inhibit-startup-screen t
	          display-line-numbers-type 'relative
	          tab-width 4
	          indent-tabs-mode nil)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      custom-file "~/.emacs.custom")

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))

(eval-when-compile
  (require 'use-package)
  (require 'vc-use-package))

(use-package everforest-theme
  :vc (everforest :url "https://github.com/Theory-of-Everything/everforest-emacs"
		  :branch "master2")
  :config
  (load-theme 'everforest-hard-dark t))

(use-package ido-completing-read+
  :ensure t
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))

(use-package smex
  :ensure t
  :bind (("M-x" . smex)))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  :config
  (custom-set-faces
   `(corfu-default
     ((t (:background "#2D353B" :foreground "#D3C6AA"))))
   `(corfu-current
     ((t (:background "#3D484D" :foreground "#D3C6AA" :weight bold))))
   `(corfu-bar
     ((t (:background "#A7C080" :foreground "#A7C080"))))
   `(corfu-border
     ((t (:background "#475258" :foreground "#475258"))))
   `(corfu-deprecated
     ((t (:background "#2D353B" :foreground "#E67E80" :strike-through t))))
   `(corfu-annotations
     ((t (:foreground "#7FBBB3" :slant italic))))
   `(corfu-doc
     ((t (:background "#343F44" :foreground "#D3C6AA"))))
   `(corfu-popupinfo
     ((t (:background "#343F44" :foreground "#D3C6AA"))))
   `(corfu-popupinfo-border
     ((t (:background "#475258" :foreground "#475258"))))
   `(completions-common-part
     ((t (:foreground "#A7C080" :weight bold))))
   `(completions-first-difference
     ((t (:foreground "#DBBC7F" :weight bold)))))
  (global-corfu-mode 1))

(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package zig-mode
  :ensure t)

(defun duplicate-line ()
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'duplicate-line)
