;;; siraben-programming.el -- siraben's programming configuration

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

;; This file makes managing the different programming modes that
;; need to be loaded easier.

;;; Code:

(global-set-key (kbd "M-C") 'comment-or-uncomment-region)

(require 'ispell)
(require 'cc-mode)

(define-key c-mode-base-map (kbd "s-b") 'recompile)

(defmacro enable-and-diminish (mode)
  "Enable MODE and diminish it."
  `(progn
     (,mode t)
     (diminish (quote ,mode))))


(defun siraben-prog-mode-defaults ()
  "Default programming mode hook, useful with any programming language."
  (when (executable-find ispell-program-name)
    (flyspell-prog-mode)
    (diminish 'flyspell-mode)
    (undo-tree-mode +1))
  
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  
  (font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook (lambda ()
                            (siraben-prog-mode-defaults)))

(require 'siraben-js)
(require 'siraben-c)
(require 'siraben-lisp)
(require 'siraben-prolog)
(require 'siraben-rust)
(require 'siraben-common-lisp)
(require 'siraben-haskell)
(require 'siraben-csharp)
(require 'siraben-forth)
(require 'siraben-sml)

(provide 'siraben-programming)
;;; siraben-programming.el ends here
