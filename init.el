(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
;;                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)
(setq mouse-drag-copy-region t)

(setq sh-basic-offset 8)
(setq c-default-style "linux"
	c-basic-offset 8)
(setq c-basic-offset 8)
(setq indent-tabs-mode nil)
(setq default-tab-width 8)
(setq tab-width 8)

(fset 'yes-or-no-p 'y-or-n-p)

(setq explicit-shell-file-name "/usr/bin/zsh")
(setq shell-file-name "zsh")
(setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
(setenv "SHELL" shell-file-name)
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

(setq make-backup-files nil)
;; bigfile warnning
(setq large-file-warning-threshold nil)

;; Save all tempfiles in $TMPDIR/emacs$UID/                                                        
;;(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
;;(setq backup-directory-alist
;;      `(("/tmp/*" . ,emacs-tmp-dir)))
;;(setq auto-save-file-name-transforms
;;      `(("/tmp/*" ,emacs-tmp-dir t)))
;;(setq auto-save-list-file-prefix
;;      emacs-tmp-dir)
;;python-style
(c-add-style
  "python-new"
  '((indent-tabs-mode . nil)
    (fill-column      . 80)
    (c-basic-offset   . 4)
    (c-offsets-alist  . ((substatement-open . 0)
                         (inextern-lang . 0)
                         (arglist-intro . +)
                         (knr-argdecl-intro . +)))
    (c-hanging-braces-alist . ((brace-list-open)
                               (brace-list-intro)
                               (brace-list-close)
                               (brace-entry-open)
                               (substatement-open after)
                               (block-close . c-snug-do-while)))
    (c-block-comment-prefix . "* "))
  )

;; This is a very crude hook that auto-selects the C style depending on
;; whether it finds a line starting with tab in the first 3000 characters
;; in the file
(defun c-select-style ()
   (save-excursion
     (if (re-search-forward "^\t" 3000 t)
         (c-set-style "python")
       (c-set-style "python-new"))))
(add-hook 'c-mode-hook 'c-select-style)

(global-auto-revert-mode 1)
(menu-bar-mode -1)

(defun is-in-terminal()
  (not (display-graphic-p)))

(defmacro when-grap (&rest body)
  "Works just like `progn' but will only evaluate expressions in VAR when Emacs is running in a terminal else just nil."
  `(when (display-graphic-p) ,@body))

(when-grap
 (toggle-scroll-bar -1)
 (tool-bar-mode -1))

(add-to-list 'default-frame-alist
	     '(font . "monaco-16"))

;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
;;(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
;;(add-to-list 'default-frame-alist '(alpha . (85 . 50)))

;;set theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (misterioso)))
 '(custom-safe-themes
   (quote
    ("736ee2716b496b9020a6440900db8902a2655876e5b7630882d1b5c80ddbb358" "18bb406622513062e8e49e4c1c66307ae6c05a182bed87ef49f810ad26257a20" "3183da097587780e32908abd2c3beb010fd94e8af9dac32a0a559bbfd3d9831f" "5c9a449700788f2e3d242cb84f110eba0f816f1bee41dc75d9a2d6098b2c25d3" "b2ea955e1c78fa63d9b61f8b41a7820ad12d6b5e76a30dd0d223e5f50e354354" "5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fci-rule-color "#073642" t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-sexp-background-color "#121212")
 '(inhibit-startup-screen t)
 '(lsp-enable-symbol-highlighting nil)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (lsp-clangd wanderlust markdown-mode racket-mode flymake-racket scheme-complete flycheck-rtags ac-rtags company-rtags fill-column-indicator material-theme py-autopep8 ivy elpy auto-package-update smartparens company-irony-c-headers company-c-headers auto-complete-c-headers xcscope ggtags color-theme-solarized color-theme-sanityinc-solarized which-key solarized-theme flycheck-irony company-irony irony-eldoc irony yasnippet rtags)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c37300")
     (60 . "#b97d00")
     (80 . "#b58900")
     (100 . "#a18700")
     (120 . "#9b8700")
     (140 . "#948700")
     (160 . "#8d8700")
     (180 . "#859900")
     (200 . "#5a942c")
     (220 . "#439b43")
     (240 . "#2da159")
     (260 . "#16a870")
     (280 . "#2aa198")
     (300 . "#009fa7")
     (320 . "#0097b7")
     (340 . "#008fc7")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq fci-rule-width 1)
;;(setq fci-rule-color "black")
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)


(defun sanityinc/fci-enabled-p () (symbol-value 'fci-mode))
  (defvar sanityinc/fci-mode-suppressed nil)
  (make-variable-buffer-local 'sanityinc/fci-mode-suppressed)

  (defadvice popup-create (before suppress-fci-mode activate)
    "Suspend fci-mode while popups are visible"
    (let ((fci-enabled (sanityinc/fci-enabled-p)))
      (when fci-enabled
        (setq sanityinc/fci-mode-suppressed fci-enabled)
        (turn-off-fci-mode))))

  (defadvice popup-delete (after restore-fci-mode activate)
    "Restore fci-mode when all popups have closed"
    (when (and sanityinc/fci-mode-suppressed
               (null popup-instances))
      (setq sanityinc/fci-mode-suppressed nil)
      (turn-on-fci-mode)))

(defun c-lineup-arglist-tabs-only (ignored)
    "Line up argument lists by tabs, not spaces"
    (let* ((anchor (c-langelem-pos c-syntactic-element))
           (column (c-langelem-2nd-pos c-syntactic-element))
           (offset (- (1+ column) anchor))
           (steps (floor offset c-basic-offset)))
      (* (max steps 1)
         c-basic-offset)))

  (add-hook 'c-mode-common-hook
            (lambda ()
              ;; Add kernel style
              (c-add-style
               "linux-tabs-only"
               '("linux" (c-offsets-alist
                          (arglist-cont-nonempty
                           c-lineup-gcc-asm-reg
                           c-lineup-arglist-tabs-only))))))

  (add-hook 'c-mode-hook
            (lambda ()
              (let ((filename (buffer-file-name)))
                ;; Enable kernel mode for the appropriate files
                (when (and filename
                           (string-match (expand-file-name "/")
                                         filename))
                  (setq indent-tabs-mode t)
                  (setq show-trailing-whitespace t)
                  (c-set-style "linux-tabs-only")))))

;; racket-mode
(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)))
(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
(setq tab-always-indent 'complete)

(add-hook 'c-mode-hook 'electric-pair-mode)
(add-hook 'c++-mode-hook 'electric-pair-mode)

;; MarkDown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; =============
;; company mode
;; =============
(use-package company
  :ensure t
  :hook (c-mode . company-mode)
  :hook (c++-mode . company-mode)
  :config
  ;; Global
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 1
        company-show-numbers t
        company-tooltip-limit 20)
  :bind
  ("C-c o" . company-complete-common)
  )

(require 'company-lsp)
(setq company-auto-complete-chars t)
(setq company-lsp-enable-recompletion t)
(push 'company-lsp company-backends)

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(add-hook 'xref-after-return-hook 'delete-other-windows)
(cl-defun jump-next-xref()
  (interactive)
  (xref-next-line)
  ;;  (next-multiframe-window)
  )

(cl-defun jump-prev-xref()
  (interactive)
  (xref-prev-line)
  ;;  (next-multiframe-window)
  )

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (c-mode . lsp)
  :hook (c++-mode . lsp)
  :pin melpa
  :init
  (require 'lsp-clients)
  (when (equal system-type 'darwin)
    (setq lsp-clients-clangd-executable "/usr/local/opt/llvm/bin/clangd"))
  :bind
;;  ("M-." . lsp-find-definition)
  ("M-[" . lsp-find-references)
  ("M-n" . jump-next-xref)
  ("M-p" . jump-prev-xref)
  :config
  (setq lsp-enable-snippet nil)
  (setq lsp-enable-completion-at-point t)
  (setq lsp-enable-indentation t)
  (setq lsp-auto-execute-action t)
  (setq lsp-auto-configure t)
  (setq lsp-enable-xref t)
  )

