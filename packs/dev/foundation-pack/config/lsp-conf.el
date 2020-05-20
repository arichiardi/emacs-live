;;; lsp-conf.el --- LSP Config

;;; Commentary:

;;; Code:

(use-package lsp-mode
  :commands (lsp)

  :config
  (setq lsp-keymap-prefix "C-c l")
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)

  :custom
  (lsp-enable-snippet t "Enable snippet support"))

(use-package helm-lsp
    :defer t
    :after helm lsp-mode
    :commands (helm-lsp-workspace-symbol helm-lsp-code-actions)
    :bind (([remap lsp-execute-code-action] . helm-lsp-code-actions)
           ([remap lsp-ui-peek-find-workspace-symbol] . helm-lsp-workspace-symbol)))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (add-hook 'lsp-mode-hook #'lsp-ui-mode))

;; https://emacs.stackexchange.com/questions/10431/get-company-to-show-suggestions-for-yasnippet-names
(defun ar-emacs--add-yas-backend (backend)
  "Add yasnippet to the BACKEND."
  (if (or (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(use-package company-lsp
  :defer t
  :after company

  :config
  (setq company-backends (mapcar #'ar-emacs--add-yas-backend company-backends))

  :custom
  ((company-lsp-enable-snippet t "Enable snippet support")
   (company-lsp-cache-candidates t "Enable cache candidates")))

;;; lsp-conf.el ends here
