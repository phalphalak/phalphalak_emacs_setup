(setq backup-directory-alist `((".*" . ,"~/emacs-temp")))
(setq auto-save-file-name-transforms `((".*" ,"~/emacs-temp" t)))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(if window-system
    (tool-bar-mode -1))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'clojure-mode)
  (package-refresh-contents)
  (package-install 'clojure-mode))

(unless (package-installed-p 'cider)
  (package-install 'cider))

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-repl-result-prefix ";; => ")
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(add-to-list 'load-path "~/.emacs.d/addons/auto-complete")
(add-to-list 'load-path "~/.emacs.d/addons/smooth-scroll")
(add-to-list 'load-path "~/.emacs.d/addons/org-7.9.3d")
;;(add-to-list 'load-path "~/.emacs.d/addons/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/addons/emacs-color-theme-solarized")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; ---------------------------------------------------------------------------------
;;(require 'color-theme)
;;(eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)
;;     (color-theme-hober)))

(load-theme 'solarized-dark t)
;;(color-theme-gnome2)

;; ---------------------------------------------------------------------------------
;; nyan-mode
(if window-system
    (progn
      (add-to-list 'load-path "~/.emacs.d/addons/nyan-mode")
      (require 'nyan-mode)))

;; ---------------------------------------------------------------------------------
;; magit
(add-to-list 'load-path "~/.emacs.d/addons/magit")
(require 'magit)

;; ---------------------------------------------------------------------------------
;; highlieght parenthesis
;(add-to-list 'load-path "~/.emacs.d/addons/highlight-parentheses")
;(require 'highlight-parentheses)
;(add-hook 'clojure-mode-hook (lambda () (highlight-parentheses-mode +1)))
;(add-hook 'slime-repl-mode-hook (lambda () (highlight-parentheses-mode +1)))
;; ---------------------------------------------------------------------------------
;; rainbow delimiters
(add-to-list 'load-path "~/.emacs.d/addons/rainbow-delimiters")
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)
;; ---------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/addons/paredit")
(require 'paredit)
;; ---------------------------------------------------------------------------------
(require 'clojure-mode)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/addons/auto-complete/ac-dict")
(ac-config-default)

(require 'ido)
(ido-mode t)
;(setq ido-enable-prefix nil
;      ido-enable-flex-matching t
;      ido-create-new-buffer 'always
;      ido-use-filename-at-point 'guess
;      ido-max-prospects 10
;      ido-default-file-method 'selected-window)

(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
;(require 'clojure-test-mode)
;;       (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(setq inhibit-startup-message t) ;; No splash screen
(setq initial-scratch-message nil) ;; No scratch message

;;http://clojure.roboloco.net/?tag=paredit
;;(require 'slime)

;; require or autoload paredit-mode

(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq mode-require-final-newline t)
            (paredit-mode 1)))
(add-hook 'slime-repl-mode-hook 'turn-on-paredit)
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


(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

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
 '(css-indent-offset 2)
 '(ido-enable-flex-matching t)
 '(js-indent-level 2)
 '(safe-local-variable-values (quote ((eval put-clojure-indent (quote reify-with-assertions*) (quote defun))))))

;; Teach compile the syntax of the kibit output
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
         '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
(add-to-list 'compilation-error-regexp-alist 'kibit)

;; A convenient command to run "lein kibit" in the project to which
;; the current emacs buffer belongs to.
(defun kibit ()
  "Run kibit on the current project.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile "lein kibit"))

(defun kibit-current-file ()
  "Run kibit on the current file.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile (concat "lein kibit " buffer-file-name)))




(defun unicode-symbol (name)
  "Translate a symbolic name for a Unicode character -- e.g., LEFT-ARROW
  or GREATER-THAN into an actual Unicode character code. "
  (decode-char 'ucs (case name
                        ;; arrows
                        ('left-arrow 8592)
                        ('up-arrow 8593)
                        ('right-arrow 8594)
                        ('down-arrow 8595)
                        ;; boxes
                        ('double-vertical-bar #X2551)
                        ;; relational operators
                        ('equal #X003d)
                        ('not-equal #X2260)
                        ('identical #X2261)
                        ('not-identical #X2262)
                        ('less-than #X003c)
                        ('greater-than #X003e)
                        ('less-than-or-equal-to #X2264)
                        ('greater-than-or-equal-to #X2265)
                        ;; logical operators
                        ('logical-and #X2227)
                        ('logical-or #X2228)
                        ('logical-neg #X00AC)
                        ;; misc
                        ('nil #X2205)
                        ('horizontal-ellipsis #X2026)
                        ('double-exclamation #X203C)
                        ('prime #X2032)
                        ('double-prime #X2033)
                        ('for-all #X2200)
                        ('there-exists #X2203)
                        ('element-of #X2208)
                        ;; mathematical operators
                        ('square-root #X221A)
                        ('squared #X00B2)
                        ('cubed #X00B3)
                        ;; letters
                        ('lambda #X03BB)
                        ('alpha #X03B1)
                        ('beta #X03B2)
                        ('gamma #X03B3)
                        ('delta #X03B4))))

(defun substitute-pattern-with-unicode (pattern symbol)
  "Add a font lock hook to replace the matched part of PATTERN with the
  Unicode symbol SYMBOL looked up with UNICODE-SYMBOL."
  (interactive)
  (font-lock-add-keywords
   nil `((,pattern (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                             ,(unicode-symbol symbol))
                             nil))))))

(defun substitute-patterns-with-unicode (patterns)
  "Call SUBSTITUTE-PATTERN-WITH-UNICODE repeatedly."
  (mapcar #'(lambda (x)
              (substitute-pattern-with-unicode (car x)
                                               (cdr x)))
          patterns))

(defun clojure-unicode ()
  (interactive)
  (substitute-patterns-with-unicode
   (list (cons "\\(->\\)" 'right-arrow)
         (cons "\\(and\\)" 'logical-and)
         (cons "\\(fn\\)" 'lambda)
   )))

;(add-hook 'clojure-mode-hook 'clojure-unicode)
(if (not window-system)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray00" :foreground "gray00" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
