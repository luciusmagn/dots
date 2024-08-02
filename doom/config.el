;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Lukáš Hozda"
      user-mail-address "luk.hozda@gmail.com")

(setq doom-font (font-spec :family "ProFontExtended" :size 12))
(setq doom-theme 'kanagawa-dragon)

(setq display-line-numbers-type t)

;; RUST
(minimap-mode)
(setq rust-format-on-save t)

;; ORG SETTINGS GO HERE
;; added to resolve issues in the past with org-appear
(setq org-fold-core-style 'text-properties)

;; org appear
(use-package org-appear
  :after org
  :ensure t
  :hook (org-mode . org-appear-mode)
  :config
  (setq
    org-link-descriptive t
    org-hide-emphasis-markers t
    org-appear-trigger 'manual
    org-appear-autolinks t
    org-appear-autoemphasis t
    org-appear-autosubmarkers t
    org-appear-autoentities t
    org-appear-autokeywords t
    org-appear-inside-latex t
    org-appear-delay 0.0))
(add-hook 'org-mode-hook (lambda ()
        (add-hook 'evil-insert-state-entry-hook
                #'org-appear-manual-start
                nil
                t)
        (add-hook 'evil-insert-state-exit-hook
                #'org-appear-manual-stop
                nil
                t)))

(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
(setq org-roam-directory (file-truename "~/org"))
(setq org-log-done 'time)
(setq org-export-with-broken-links t)
(org-roam-db-autosync-mode)

(use-package! org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

;;
;;
;; MEOWBINDINGS
;;
;;

(setq meow-use-clipboard t)
(setq meow-visit-sanitize-completion nil)
(meow-setup-indicator)

;; redos are fucking weird in emacs, man
(defun meow-redo ()
  "Custom redo function for Meow."
  (interactive)
  (ignore-errors (meow-cancel))
  (meow-undo))

(defun meow-kakoune-x ()
  "Implement Kakoune-like behavior for x key."
  (interactive)
  (if (region-active-p)
      (progn
        (meow-next 1)
        (meow-line 1))
    (meow-line 1)))

(defun meow-move-and-cancel (move-func)
  "Move using MOVE-FUNC and cancel the selection."
  (lambda ()
    (interactive)
    (funcall move-func 1)
    (meow-cancel-selection)))

(defun meow-kakoune-end-of-buffer ()
  "Move to the end of the buffer without selecting."
  (interactive)
  (goto-char (point-max))
  (meow-cancel-selection))

(defun meow-kakoune-beginning-of-buffer ()
  "Move to the beginning of the buffer without selecting."
  (interactive)
  (goto-char (point-min))
  (meow-cancel-selection))

(defun meow-kakoune-select-to-end-of-buffer ()
  "Select from current point to the end of the buffer."
  (interactive)
  (unless (region-active-p)
    (push-mark (point) t t))
  (goto-char (point-max)))

(defun meow-kakoune-select-to-beginning-of-buffer ()
  "Select from current point to the beginning of the buffer."
  (interactive)
  (unless (region-active-p)
    (push-mark (point) t t))
  (goto-char (point-min)))

(defvar meow-kakoune-g-map (make-sparse-keymap)
  "Keymap for g prefix in Kakoune-like setup.")

(defvar meow-kakoune-G-map (make-sparse-keymap)
  "Keymap for G prefix in Kakoune-like setup.")

(defun meow-kakoune-g-prefix ()
  "Handle g prefix commands."
  (interactive)
  (let ((next-key (read-key "g-")))
    (let ((cmd (lookup-key meow-kakoune-g-map (vector next-key))))
      (if cmd
          (call-interactively cmd)
        (message "No such g- command: %c" next-key)))))

(defun meow-kakoune-G-prefix ()
  "Handle G prefix commands."
  (interactive)
  (let ((next-key (read-key "G-")))
    (let ((cmd (lookup-key meow-kakoune-G-map (vector next-key))))
      (if cmd
          (call-interactively cmd)
        (message "No such G- command: %c" next-key)))))

(defun force-kill-current-buffer ()
  "Kill the current buffer without confirmation."
  (interactive)
  (set-buffer-modified-p nil)
  (kill-buffer (current-buffer)))

(defun force-kill-emacs ()
  "Kill Emacs without confirmation."
  (interactive)
  (kill-emacs))

(defun save-buffer-or-file (file)
  "Save the current buffer, or write it to FILE if provided."
  (if file
      (write-file file)
    (save-buffer)))

(map! :leader
      :desc "Reload config" "h r r" #'doom/reload
      :desc "Open dired here" "." #'find-file
      :desc "Open org-agenda" "o a" #'org-agenda)

(defun simulate-vim-command-line ()
  (interactive)
  (let* ((input (read-string ":"))
         (parts (split-string input " " t))
         (cmd (car parts))
         (args (cdr parts)))
    (cond
     ((string= cmd "e") (call-interactively #'find-file))
     ((string= cmd "b") (call-interactively #'consult-buffer))
     ((string= cmd "db") (call-interactively #'kill-current-buffer))
     ((string= cmd "db!") (force-kill-current-buffer))
     ((string= cmd "q") (save-buffers-kill-terminal))
     ((string= cmd "q!") (force-kill-emacs))
     ((string= cmd "w") (save-buffer-or-file (car args)))
     ((string= cmd "wq") (progn
                           (save-buffer)
                           (save-buffers-kill-terminal)))
     ((string= cmd "%") (meow-select-buffer))
     (t (message "Unknown command: %s" cmd)))))

(map! :map meow-normal-state-keymap
      ":" #'simulate-vim-command-line)

(defun meow-select-buffer ()
  "Select the entire buffer."
  (interactive)
  (meow-bounds-of-thing ?b))

(defun indent-selection ()
  "Indent the current selection or line."
  (interactive)
  (let ((deactivate-mark nil)  ; Preserve the selection
        (indent-size 4))       ; Use 4 spaces for indentation
    (if (region-active-p)
        (indent-rigidly (region-beginning) (region-end) indent-size)
      (indent-rigidly (line-beginning-position) (line-end-position) indent-size))))

(defun unindent-selection ()
  "Unindent the current selection or line."
  (interactive)
  (let ((deactivate-mark nil)  ; Preserve the selection
        (indent-size -4))      ; Use 4 spaces for unindentation (negative)
    (if (region-active-p)
        (indent-rigidly (region-beginning) (region-end) indent-size)
      (indent-rigidly (line-beginning-position) (line-end-position) indent-size))))

(defun meow-kakoune-w ()
  "Implement Kakoune-like behavior for w key."
  (interactive)
  (if (region-active-p)
      (progn
        (meow-next-word 1)
        (meow-mark-word 1))
    (meow-mark-word 1)))

(defun meow-kakoune-W ()
  "Implement Kakoune-like behavior for W key."
  (interactive)
  (if (region-active-p)
      (meow-next-word 1)
    (meow-mark-word 1)))

(defun meow-goto-line-and-center ()
  "Go to a specific line number and center the view."
  (interactive)
  (let ((line (read-number "Go to line: ")))
    (goto-char (point-min))
    (forward-line (1- line))
    (recenter)))

(defun meow-setup-kakoune ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("h" . meow-left)
   '("l" . meow-right))

  (meow-leader-define-key
   ;;'("." . find-file)
   '("j" . "H-j")
   '("k" . "H-k")
   '("/" . meow-visit)
   '("?" . (lambda () (interactive) (let ((current-prefix-arg '-)) (meow-visit))))
   '("n" . meow-search)
   '("N" . (lambda () (interactive) (let ((current-prefix-arg '-)) (meow-search))))
   '("s" . save-buffer)
   '("b" . switch-to-buffer)
   '("w" . kill-current-buffer))

  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("/" . meow-visit)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-grab)
   '("c" . meow-change)
   '("d" . meow-kill)
   '("D" . meow-backward-delete)
   '("g" . meow-kakoune-g-prefix)
   '("G" . meow-kakoune-G-prefix)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("t" . meow-till)
   '("f" . meow-find)
   '("u" . meow-undo)
   '("U" . meow-redo)
   '("v" . meow-visit)
   '("w" . meow-kakoune-w)
   '("W" . meow-kakoune-W)
   '("x" . meow-kakoune-x)
   '("X" . meow-line-expand)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("B" . meow-pop-selection)
   '("'" . repeat)
   '("<" . unindent-selection)
   '(">" . indent-selection)
   '("<escape>" . meow-cancel-selection)
   '("%" . meow-select-buffer)
   '(":" . simulate-vim-command-line)
   '("<M-left>" . previous-buffer)
   '("<M-right>" . next-buffer)
   '("<C-up>" . drag-stuff-up)
   '("<C-down>" . drag-stuff-down)
   '("<up>" . (lambda () (interactive) (funcall (meow-move-and-cancel #'previous-line))))
   '("<down>" . (lambda () (interactive) (funcall (meow-move-and-cancel #'next-line))))
   '("<left>" . (lambda () (interactive) (funcall (meow-move-and-cancel #'left-char))))
   '("<right>" . (lambda () (interactive) (funcall (meow-move-and-cancel #'right-char))))
   '("S-<up>" . meow-prev-expand)
   '("S-<down>" . meow-next-expand)
   '("S-<left>" . meow-left-expand)
   '("S-<right>" . meow-right-expand)

  ;; Define g prefix keymap
  (define-key meow-kakoune-g-map (kbd "g") #'meow-goto-line-and-center)
  (define-key meow-kakoune-g-map (kbd "j") #'meow-kakoune-end-of-buffer)
  (define-key meow-kakoune-g-map (kbd "k") #'meow-kakoune-beginning-of-buffer)

  ;; Define G prefix keymap
  (define-key meow-kakoune-G-map (kbd "j") #'meow-kakoune-select-to-end-of-buffer)
  (define-key meow-kakoune-G-map (kbd "k") #'meow-kakoune-select-to-beginning-of-buffer)))

(meow-setup-kakoune)

(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "<C-up>") 'drag-stuff-up)
(global-set-key (kbd "<C-down>") 'drag-stuff-down)

;; I need THIS
(after! org
  (map! :map org-mode-map
        :localleader
        "s" nil))  ; This unbinds SPC m s in org-mode

(after! org
  (map! :map org-mode-map
        "C-c o ." #'org-time-stamp))
