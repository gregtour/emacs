;; User Additions to Emacs
(require 'cl)

;; Unset Keys.
(global-unset-key (kbd "C-z")) ;; minimize

;; Ctrl+z does undo.
(defun ue-ctrl-z-undo ()
  (global-set-key (kbd "C-z") 'undo))

;; <backtab> removes indents by one tab or four spaces for line or selection.
(defun ue-add-backtab-macro ())

;; Ctrl+Tab adds four spaces.
(defun ue-add-single-indent ()
  (global-set-key (kbd "C-<tab>")
				  (lambda ()
				    (interactive)
					(insert "    "))))

;; Double-home goes to first non-whitespace character.
(defun ue-add-double-home ())

;; Ctrl+/ takes the line or selection and adds // to all or removes // from all lines.
(defun ue-add-control-comment ())

;; Other user extensions


(defun ue-run-default ()
;;  (ue-ctrl-z-undo)
;;  (ue-add-backtab-macro)
;;  (ue-add-single-indent)
;;  (ue-add-double-home)
  (ue-add-control-comment))

(provide 'user-extensions)
(ue-run-default)

