;;; kanagawa-dragon-theme.el --- Kanagawa Dragon theme -*- lexical-binding: t; no-byte-compile: t; -*-
(require 'doom-themes)

(defgroup kanagawa-dragon-theme nil
  "Options for the `kanagawa-dragon' theme."
  :group 'doom-themes)

(defcustom doom-kanagawa-dragon-comment-bg nil
  "If non-nil, comments will have a subtle, darker background."
  :type 'boolean
  :group 'kanagawa-dragon-theme)

(def-doom-theme kanagawa-dragon
  "A theme based on Kanagawa Dragon color scheme."

  ;; name        default   256       16
  ((bg         '("#080606" nil       nil            ))
   (bg-alt     '("#181616" nil       nil            ))
   (base0      '("#0d0c0c" "black"   "black"        ))
   (base1      '("#181616" "#1e1e1e" "brightblack"  ))
   (base2      '("#2D4F67" "#2e2e2e" "brightblack"  ))
   (base3      '("#1e3f52" "#262626" "brightblack"  ))
   (base4      '("#a6a69c" "#3f3f3f" "brightblack"  ))
   (base5      '("#c5c9c5" "#525252" "brightblack"  ))
   (base6      '("#c8c093" "#6b6b6b" "brightblack"  ))
   (base7      '("#c5c9c5" "#979797" "brightblack"  ))
   (base8      '("#c5c9c5" "#dfdfdf" "white"        ))
   (fg         '("#c5c9c5" "#bfbfbf" "brightwhite"  ))
   (fg-alt     '("#a6a69c" "#2d2d2d" "white"        ))

   (grey       base4)
   (red        '("#c4746e" "#ff6655" "red"          ))
   (orange     '("#b6927b" "#dd8844" "brightred"    ))
   (green      '("#8a9a7b" "#99bb66" "green"        ))
   (teal       '("#8ea4a2" "#44b9b1" "brightgreen"  ))
   (yellow     '("#c4b28a" "#ECBE7B" "yellow"       ))
   (blue       '("#8ba4b0" "#51afef" "brightblue"   ))
   (dark-blue  '("#7FB4CA" "#2257A0" "blue"         ))
   (magenta    '("#a292a3" "#c678dd" "magenta"      ))
   (violet     '("#938AA9" "#a9a1e1" "brightmagenta"))
   (cyan       '("#7AA89F" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("#5699AF" "#5699AF" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      base2)
   (builtin        magenta)
   (comments       base4)
   (doc-comments   (doom-lighten base4 0.15))
   (constants      violet)
   (functions      blue)
   (keywords       magenta)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        red)
   (variables      blue)
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright t)
   (-modeline-pad
    (when -modeline-bright
      4))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-darken blue 0.45)
      `(,(doom-darken (car bg-alt) 0.1) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken blue 0.475)
      `(,(doom-darken (car bg-alt) 0.15) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-l `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg-alt))))

  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-kanagawa-dragon-comment-bg (doom-lighten bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background base2 :distant-foreground base0 :weight 'normal)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l))))

  ;;;; Base theme variable overrides-
  ())

;;; kanagawa-dragon-theme.el ends here
