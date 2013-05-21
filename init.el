(setq backup-directory-alist `((".*" . ,"~/emacs-temp")))
(setq auto-save-file-name-transforms `((".*" ,"~/emacs-temp" t)))

(add-to-list 'load-path "~/.emacs.d/addons/nrepl")
(add-to-list 'load-path "~/.emacs.d/addons/clojure-mode")
(add-to-list 'load-path "~/.emacs.d/addons/paredit")
(add-to-list 'load-path "~/.emacs.d/addons/highlight-parentheses")
(add-to-list 'load-path "~/.emacs.d/addons/auto-complete")
(add-to-list 'load-path "~/.emacs.d/addons/smooth-scroll")
(add-to-list 'load-path "~/.emacs.d/addons/org-7.9.3d")
;;(add-to-list 'load-path "~/.emacs.d/addons/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/addons/emacs-color-theme-solarized")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
;;(require 'color-theme)
;;(eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)
;;     (color-theme-hober)))

(load-theme 'solarized-dark t)
;;(color-theme-gnome2)

(require 'nrepl)
(require 'paredit)
(require 'clojure-mode)
(require 'highlight-parentheses)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/addons/auto-complete/ac-dict")
(ac-config-default)

(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
(require 'clojure-test-mode)
;;       (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(setq inhibit-startup-message t) ;; No splash screen
(setq initial-scratch-message nil) ;; No scratch message

;;http://clojure.roboloco.net/?tag=paredit
;;(require 'slime)

;; require or autoload paredit-mode
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)
(add-hook 'slime-repl-mode-hook 'turn-on-paredit)
(add-hook 'clojure-mode-hook (lambda () (highlight-parentheses-mode +1)))
(add-hook 'slime-repl-mode-hook (lambda () (highlight-parentheses-mode +1)))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-linum-mode t) ;;show line numbers

(global-hl-line-mode t) ;; highlight current line

;;; Prevent Extraneous Tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
;;(setq standard-indent 2)
;;(setq soft-tab-size 2)
(setq tab-stop-list '(2 4 6 8 12 14 16 18))
;;(setq tabbar-background-color "black")

(setq highlight-tabs t)
(setq highlight-trailing-whitespace t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key [up] (lambda () (interactive) (scroll-down 1)))
(global-set-key [down] (lambda () (interactive) (scroll-up 1)))

(global-set-key [left] (lambda () (interactive) (scroll-right tab-width t)))
(global-set-key [right] (lambda () (interactive) (scroll-left tab-width t)))


;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(global-set-key [C-down] 'enlarge-window)
(global-set-key [C-up] 'shrink-window)
(global-set-key [C-right] 'enlarge-window-horizontally)
(global-set-key [C-left] 'shrink-window-horizontally)

;;(set-scroll-bar-mode 'right)

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
<<<<<<< HEAD
 '(css-indent-offset 2)
=======
>>>>>>> 6e6b1db83a30f6c45bf8529d63b2c85b24a899e9
 '(js-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
