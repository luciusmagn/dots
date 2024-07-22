;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "ProFontExtended" :size 12))
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'kanagawa-dragon)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
(setq org-roam-directory (file-truename "~/org"))
(org-roam-db-autosync-mode)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;(custom-set-faces!
;;  '(doom-dashboard-banner :background "#080606")
;;  '(doom-dashboard-footer :background "#080606")
;;  '(doom-dashboard-footer-icon :background "#080606")
;;  '(doom-dashboard-loaded :background "#080606")
;;  '(doom-dashboard-menu-desc :background "#080606")
;;  '(doom-dashboard-menu-title :background "#080606"))

(setq evil-move-beyond-eol t)
(setq evil-move-cursor-back nil)

;; drag my shit
(map! :nv "C-<up>"   #'drag-stuff-up
      :nv "C-<down>" #'drag-stuff-down)

;; make Left and Right navigation go to prev/next line
(defun my/evil-backward-char-wrap ()
  (interactive)
  (if (bolp)
      (progn
        (forward-line -1)
        (end-of-line))
    (evil-backward-char)))

(defun my/evil-forward-char-wrap ()
  (interactive)
  (if (eolp)
      (progn
        (forward-line)
        (evil-first-non-blank))
    (evil-forward-char)))

(map! :n "h" #'my/evil-backward-char-wrap
      :n "l" #'my/evil-forward-char-wrap
      :n "<left>" #'my/evil-backward-char-wrap
      :n "<right>" #'my/evil-forward-char-wrap)

(define-key evil-normal-state-map (kbd "<left>") #'my/evil-backward-char-wrap)
(define-key evil-normal-state-map (kbd "<right>") #'my/evil-forward-char-wrap)

;; X behavior from kakoune
(defun my/evil-select-line-or-next ()
  (interactive)
  (if (evil-visual-state-p)
      (progn
        (evil-end-of-line)
        (evil-visual-line))
    (evil-visual-line)))

(define-key evil-normal-state-map (kbd "X") #'my/evil-select-line-or-next)
(define-key evil-visual-state-map (kbd "X") #'my/evil-select-line-or-next)

;; Select current line or next line selection
(defun my/evil-select-line-or-next-line ()
  (interactive)
  (if (evil-visual-state-p)
      (if (and (eq evil-visual-selection 'line)
               (= (line-number-at-pos (point)) (line-number-at-pos (mark))))
          (progn
            (evil-exit-visual-state)
            (evil-next-line)
            (evil-visual-line))
        (evil-visual-line))
    (evil-visual-line)))

(define-key evil-normal-state-map (kbd "x") #'my/evil-select-line-or-next-line)
(define-key evil-visual-state-map (kbd "x") #'my/evil-select-line-or-next-line)


;; Select next word or extend word selection
(defun my/evil-select-word-or-next ()
  (interactive)
  (if (evil-visual-state-p)
      (evil-forward-word-end)
    (evil-visual-word)))

(define-key evil-normal-state-map (kbd "w") #'my/evil-select-word-or-next)
(define-key evil-visual-state-map (kbd "w") #'my/evil-select-word-or-next)

;; Select next WORD or extend WORD selection
(defun my/evil-select-WORD-or-next ()
  (interactive)
  (if (evil-visual-state-p)
      (evil-forward-WORD-end)
    (evil-visual-WORD)))

(define-key evil-normal-state-map (kbd "W") #'my/evil-select-WORD-or-next)
(define-key evil-visual-state-map (kbd "W") #'my/evil-select-WORD-or-next)


;; Unbind 'G' and rebind it to its original function
(define-key evil-motion-state-map (kbd "G") nil)
(define-key evil-motion-state-map (kbd "G G") 'evil-goto-line)

;; Select from cursor to end of file
(defun my/evil-select-to-file-end ()
  (interactive)
  (evil-visual-line)
  (evil-goto-line))

(define-key evil-normal-state-map (kbd "G j") #'my/evil-select-to-file-end)
(define-key evil-visual-state-map (kbd "G j") #'my/evil-select-to-file-end)

;; Select from beginning of file to cursor
(defun my/evil-select-to-file-begin ()
  (interactive)
  (evil-visual-line)
  (evil-goto-first-line))

(define-key evil-normal-state-map (kbd "G k") #'my/evil-select-to-file-begin)
(define-key evil-visual-state-map (kbd "G k") #'my/evil-select-to-file-begin)

;; Go to bottom of file
(define-key evil-normal-state-map (kbd "g j") #'evil-goto-line)

;; Go to top of file
(define-key evil-normal-state-map (kbd "g k") #'evil-goto-first-line)

;; Select whole file
(defun my/evil-select-whole-buffer ()
  (interactive)
  (evil-goto-first-line)
  (evil-visual-line)
  (evil-goto-line))

(define-key evil-normal-state-map (kbd "%") #'my/evil-select-whole-buffer)

;; Make sure evil-multiedit is loaded
(use-package! evil-multiedit)

;; Add cursor to next line
(defun my/evil-mc-add-cursor-next-line ()
  (interactive)
  (evil-mc-pause-cursors)
  (evil-mc-make-cursor-move-next-line 1)
  (evil-mc-resume-cursors))

;; Reduce to last cursor
(defun my/evil-mc-reduce-to-last-cursor ()
  (interactive)
  (evil-mc-undo-all-cursors))

;; Bind C to add cursor to next line
(define-key evil-normal-state-map (kbd "C") #'my/evil-mc-add-cursor-next-line)
(define-key evil-visual-state-map (kbd "C") #'my/evil-mc-add-cursor-next-line)

;; Unbind SPC SPC and rebind to reduce cursors
(map! :leader
      :desc "Reduce to last cursor" "SPC" #'my/evil-mc-reduce-to-last-cursor)

;; Make sub-selections based on pattern
(defun my/evil-select-pattern (pattern)
  (interactive "sEnter pattern: ")
  (when (evil-visual-state-p)
    (let ((start (region-beginning))
          (end (region-end)))
      (evil-exit-visual-state)
      (goto-char start)
      (evil-mc-pause-cursors)
      (evil-mc-make-cursor-here)
      (while (re-search-forward pattern end t)
        (evil-mc-make-cursor-at-pos (match-beginning 0))
        (goto-char (match-end 0)))
      (evil-mc-resume-cursors)
      (evil-mc-make-and-goto-first-cursor)
      (evil-visual-char)
      (evil-forward-char (- (match-end 0) (match-beginning 0))))))

(define-key evil-visual-state-map (kbd "s") #'my/evil-select-pattern)

;; Navigate to previous buffer
(defun my/previous-file ()
  (interactive)
  (previous-buffer))

;; Navigate to next buffer
(defun my/next-file ()
  (interactive)
  (next-buffer))

;; Bind Alt-left to previous file and Alt-right to next file
(define-key evil-normal-state-map (kbd "M-<left>") #'my/previous-file)
(define-key evil-normal-state-map (kbd "M-<right>") #'my/next-file)

;; Also bind for other states if needed
(define-key evil-insert-state-map (kbd "M-<left>") #'my/previous-file)
(define-key evil-insert-state-map (kbd "M-<right>") #'my/next-file)
(define-key evil-visual-state-map (kbd "M-<left>") #'my/previous-file)
(define-key evil-visual-state-map (kbd "M-<right>") #'my/next-file)

;; Rebind word swapping to Ctrl-Alt-left and Ctrl-Alt-right
;;(define-key evil-normal-state-map (kbd "S-M-<left>") #'evil-backward-word-exchange)
;;(define-key evil-normal-state-map (kbd "S-M-<right>") #'evil-forward-word-exchange)

;; Custom Ex commands for buffer management
(defun kill-this-buffer-volatile ()
    "Kill current buffer, even if it has been modified."
    (interactive)
    (set-buffer-modified-p nil)
    (kill-this-buffer))

(evil-ex-define-cmd "db!" (lambda () (interactive) (kill-this-buffer-volatile)))
(evil-ex-define-cmd "db" 'kill-this-buffer)
(evil-ex-define-cmd "b" 'consult-buffer)

(defun find-file-in-current-directory ()
  "Open file dialog starting from the directory of the current buffer."
  (interactive)
  (let ((default-directory (or (and (buffer-file-name)
                                    (file-name-directory (buffer-file-name)))
                               default-directory)))
    (call-interactively 'find-file)))

(evil-ex-define-cmd "e" 'find-file-in-current-directory)

;; Left-Right pane spawning
(defun my/split-window-right-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window-right)
  (windmove-right))

(defun my/split-window-left-and-focus ()
  "Split the window vertically to the left and focus the new window."
  (interactive)
  (split-window-right)
  (windmove-left))

(global-set-key (kbd "C-M-<right>") #'my/split-window-right-and-focus)
(global-set-key (kbd "C-M-<left>") #'my/split-window-left-and-focus)
(define-key evil-insert-state-map (kbd "C-M-<right>") #'my/split-window-right-and-focus)
(define-key evil-insert-state-map (kbd "C-M-<left>") #'my/split-window-left-and-focus)
(define-key evil-normal-state-map (kbd "C-M-<right>") #'my/split-window-right-and-focus)
(define-key evil-normal-state-map (kbd "C-M-<left>") #'my/split-window-left-and-focus)
(define-key evil-visual-state-map (kbd "C-M-<right>") #'my/split-window-right-and-focus)
(define-key evil-visual-state-map (kbd "C-M-<left>") #'my/split-window-left-and-focus)

(defun my/close-current-window ()
  "Close the current window."
  (interactive)
  (delete-window))

(global-set-key (kbd "C-M-q") #'my/close-current-window)

(evil-ex-define-cmd "ld" 'lsp-ui-flycheck-list)
(evil-ex-define-cmd "le" 'lsp-treemacs-errors-list)
(evil-ex-define-cmd "lf" 'flycheck-list-errors)
