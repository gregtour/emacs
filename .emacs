;; .EMACS configuration file.
(require 'cl)

;; Show line numbers
(global-linum-mode t)

;; Add /usr/local/bin to path for npm tools
(add-to-list 'exec-path "/usr/local/bin")
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))

;; Atom Dark Theme - Sublime mix.
(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor/atom-one-dark-theme/")
(load-theme 'atom-one-dark t)

;; Default window size
(add-to-list 'default-frame-alist '(height . 56))
(add-to-list 'default-frame-alist '(width . 180))

;; CUA mode for C-x, C-c, C-v, C-z
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;; Mac OSX
(setq delete-by-moving-to-trash t)

;; Enable recent files mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 12)

;; Easy scrolling; 4-space tabs.
(custom-set-variables
;; '(mouse-wheel-progressive-speed nil)
;; '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control)))))
;; '(scroll-step 1)
 '(tab-width 4))

;; Better scrolling with mouse wheel/trackpad.
(unless (and (boundp 'mac-mouse-wheel-smooth-scroll) mac-mouse-wheel-smooth-scroll)
  (global-set-key [wheel-down] (lambda () (interactive) (scroll-up-command 1)))
  (global-set-key [wheel-up] (lambda () (interactive) (scroll-down-command 1)))
  (global-set-key [double-wheel-down] (lambda () (interactive) (scroll-up-command 2)))
  (global-set-key [double-wheel-up] (lambda () (interactive) (scroll-down-command 2)))
  (global-set-key [triple-wheel-down] (lambda () (interactive) (scroll-up-command 3)))
  (global-set-key [triple-wheel-up] (lambda () (interactive) (scroll-down-command 3))))

;; Character encodings default to utf-8.
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; Whatever this does
(custom-set-faces)

;; No beeps. No startup screen. No scratch message.
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Save backup files in the temporary directory
(setq backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Shorten yes/no answers to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Automatically update buffers when files change
(global-auto-revert-mode t)

;; Frameless UI.
(tool-bar-mode -1)
;;(scroll-bar-mode -1)
;;(menu-bar-mode -1)
;;(fringe-mode 0)

;; Page up, Page down, Home, & End behaviors.
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)
(global-set-key [next]
				(lambda () (interactive)
				  (condition-case nil (scroll-up)
					(end-of-buffer (goto-char (point-max))))
				  (move-to-window-line -1)))

(global-set-key [prior]
				(lambda () (interactive)
				  (condition-case nil (scroll-down)
					(beginning-of-buffer (goto-char (point-min))))
				  (move-to-window-line 0)))

;; Features

;; SR Speedbar
(add-to-list 'load-path "~/.emacs.d/vendor/sr-speedbar")
(require 'sr-speedbar)

(setq sr-speedbar-width 15)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-default-width 15)
(setq sr-speedbar-max-widt 20)

;;(sr-speedbar-open)
(add-hook 'after-init-hook 'sr-speedbar-open)

;; Powerline extension.
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)

;; Tab Bar Mode
(add-to-list 'load-path "~/.emacs.d/vendor/tabbarmode")
(require 'tabbar)
(tabbar-mode)

;; Autocomplete
;; Using Company
(add-hook 'after-init-hook 'global-company-mode)
;; Using autopair
(add-to-list 'load-path "~/.emacs.d/vendor/autopair")
(require 'autopair)
(autopair-global-mode)

;; free up some hotkeys
(global-unset-key (kbd "C-b")) ;; evals as left arrow, not very useful.
(global-unset-key (kbd "C-p")) ;; previous line
(global-unset-key (kbd "C-n")) ;; next line

;; JS/JSON/HTML beautify function.
(add-to-list 'load-path "~/.emacs.d/vendor/web-beautify")
(require 'web-beautify)

;; XML beautify function.
(defun xml-format ()
  (interactive)
  (save-excursion
	(shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t)))

;; Key bindings for prettify: ctrl + 'p', then press 'j', 'h', 'c', or 'x'.
(global-set-key (kbd "C-p j") 'web-beautify-js)
(global-set-key (kbd "C-p h") 'web-beautify-html)
(global-set-key (kbd "C-p c") 'web-beautify-css)
(global-set-key (kbd "C-p x") 'xml-format)

;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;;

;; Buffer manipulation

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
;;(add-hook 'window-setup-hook 'delete-other-windows)

;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;; ;;;;

;; Create new buffer.
(defun new-buffer ()
  (interactive)
  (switch-to-buffer (generate-new-buffer "*new buffer*")))

(global-set-key (kbd "C-n") 'new-buffer)

;; Create new Window.
(when window-system
  (defun new-emacs-instance ()
    "Create a new instance of Emacs."
    (interactive)
    (let ((path-to-emacs
           (locate-file invocation-name
                        (list invocation-directory) exec-suffixes)))
      (call-process path-to-emacs nil 0 nil))))

(global-set-key (kbd "C-c N") 'new-emacs-instance)

;; Handle <backtab>, comments, double home.

;; Set a nice screensaver ;-)
(require 'zone)
(zone-when-idle 500)

;; My own extensions.
(add-to-list 'load-path "~/.emacs.d/vendor/self-user-extensions")
(require 'user-extensions)
(ue-run-default)

