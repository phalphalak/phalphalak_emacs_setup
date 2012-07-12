(add-to-list 'load-path "~/.emacs.d/addons/clojure-mode")
(add-to-list 'load-path "~/.emacs.d/addons/paredit")
(add-to-list 'load-path "~/.emacs.d/addons/highlight-parentheses")
(add-to-list 'load-path "~/.emacs.d/addons/auto-complete")

(require 'paredit)
(require 'clojure-mode)
(require 'highlight-parentheses)

(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
;;       (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(setq inhibit-startup-message t) ;; No splash screen
(setq initial-scratch-message nil) ;; No scratch message

;;http://clojure.roboloco.net/?tag=paredit
;;(require 'slime)

;; require or autoload paredit-mode
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)
(add-hook 'clojure-mode-hook (lambda () (highlight-parentheses-mode +1)))

