;;; siraben-lisp.el --- Specific modes and packages for Lisp code.

;;; License:
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(defun siraben-enable-lisp-editing-modes ()
  "Enables a collection of modes for editing Lisp code."
  (interactive)
  (progn (setq show-paren-style 'mixed)
         
         ;; Change to paredit because I haven't figured out how to get
         ;; smartparens to stop trying to pair single quotes.
         
         (smartparens-mode -1)
	 (paredit-mode t)
	 (rainbow-delimiters-mode t)
	 (aggressive-indent-mode t)
	 (show-paren-mode t)
	 (global-undo-tree-mode t)
	 (company-mode t)))

(defvar siraben-lispy-mode-hooks
  '(clojure-mode-hook
    emacs-lisp-mode-hook
    lisp-mode-hook
    scheme-mode-hook))

(dolist (hook siraben-lispy-mode-hooks)
  (add-hook hook #'(lambda ()
                     (siraben-enable-lisp-editing-modes))))

;; Enable some Lisp modes like paredit and rainbow delimiters, but no
;; need to undo and auto complete.
(add-hook 'geiser-repl-mode-hook
          #'(lambda ()
              (siraben-enable-lisp-editing-modes)
              (undo-tree-mode -1)
              (aggressive-indent-mode -1)))

(use-package racket-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode)))

(provide 'siraben-lisp)
;;; siraben-lisp.el ends here
