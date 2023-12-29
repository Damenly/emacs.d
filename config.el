;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Su Yue"
      user-mail-address "Damely_Su@gmx.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-14"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "Monaco" :size 19)
      doom-variable-pitch-font (font-spec :family "PT sans"))
(set-face-bold-p 'bold nil)


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;;(setq doom-theme 'doom-one)

;; If you intend to use org, it is recommended you change this!
;;(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)

;; Display time
(display-time-mode t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;(setq doom-theme 'doom-vibrant)
;;(setq doom-theme 'doom-solarized-dark)

(setq doom-theme 'wheatgrass)
(setq doom-solarized-dark-brighter-comments t)
;;(setq doom-solarized-dark-comment-bg t)

;;(def-package-hook! doom-themes :disable)


(setq mu4e-mu-binary "/usr/local/bin/mu")
(after! mu4e
  (setq! mu4e-maildir (expand-file-name "~/.mail/gmx") ; the rest of the mu4e folders are RELATIVE to this one
         mu4e-get-mail-command "/usr/local/bin/mbsync -a"
         mu4e-index-update-in-background t
         mu4e-compose-signature-auto-include t
         mu4e-use-fancy-chars t
         mu4e-view-show-addresses t
         mu4e-view-show-images t
         mu4e-compose-format-flowed t
         ;mu4e-compose-in-new-frame t
         mu4e-change-filenames-when-moving t ;; http://pragmaticemacs.com/emacs/fixing-duplicate-uid-errors-when-using-mbsync-and-mu4e/
         mu4e-maildir-shortcuts
         '( ("/Inbox" . ?i)
;;            ("/Archive" . ?a)
            ("/Drafts" . ?d)
            ("/Deleted" . ?t)
            ("/Sent" . ?s))

         ;; Message Formatting and sending
         message-send-mail-function 'smtpmail-send-it
         ;;message-signature-file "~/Documents/dotfiles/Emacs/.doom.d/.mailsignature"
         message-citation-line-format "On %a %d %b %Y at %R, %f wrote:\n"
         message-citation-line-function 'message-insert-formatted-citation-line
         message-kill-buffer-on-exit t

         ;; Org mu4e
         ;;org-mu4e-convert-to-html t
         ))
(set-email-account! "Damenly_Su@gmx.com"
                    '((user-mail-address      . "Damenly_Su@gmx.com")
                      (user-full-name         . "Su Yue")
                      (smtpmail-smtp-server   . "mail.gmx.com")
                      (smtpmail-smtp-service  . 465)
                      (smtpmail-stream-type   . ssl)
                      (smtpmail-debug-info    . t)
                      (mu4e-drafts-folder     . "/Drafts")
                      (mu4e-refile-folder     . "/Archive")
                      (mu4e-sent-folder       . "/Sent")
                      (mu4e-trash-folder      . "/Trash")
                      (mu4e-update-interval   . 600)
                      ;(mu4e-sent-messages-behavior . 'delete)
                      )
                    nil)

;;; wanderlust
;;;
(setq elmo-imap4-default-server "imap.gmx.com"
      elmo-imap4-default-user "Damenly_Su@gmx.com"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '993
      elmo-imap4-default-stream-type 'ssl

      ;; For non ascii-characters in folder-names
      elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 465
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "Damenly_Su@gmx.com"
      wl-smtp-posting-server "smtp.gmx.com"
      wl-local-domain "gmx.com"
      wl-message-id-domain "smtp.gmx.com")

(setq wl-from "Su Yue <Damenly_Su@gmx.com>"

      ;; All system folders (draft, trash, spam, etc) are placed in the
      ;; [Gmail]-folder, except inbox. "%" means it's an IMAP-folder
      wl-default-folder "%inbox"
      wl-draft-folder   "%Drafts"
      wl-trash-folder   "%Trash"
      ;; The below is not necessary when you send mail through Gmail's SMTP server,
      ;; see https://support.google.com/mail/answer/78892?hl=en&rd=1
      ;; wl-fcc            "%[Gmail]/Sent"

      ;; Mark sent messages as read (sent messages get sent back to you and
      ;; placed in the folder specified by wl-fcc)
      wl-fcc-force-as-read    t

      ;; For auto-completing foldernames
      wl-default-spec "%")


;;; fci-mode
;;;
;;;

(setq fci-rule-width 1)
(setq fci-rule-color "black")
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;;
;; for fly-spell
;;
(setq ispell-program-name "aspell")
;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))

;;
;; auto copy
(setq x-select-enable-primary t)

(setq mouse-drag-copy-region t)

(setq confirm-kill-emacs nil)

(setq python-shell-interpreter "/usr/local/bin/python3")

(defun dummy ())

(global-hl-line-mode 1)
(set-face-background 'hl-line "#0c586e")

(add-to-list 'load-path "~/.doom.d/modules")
(require 'kernel)

(setq large-file-warning-threshold nil)

(savehist-mode -1)

;; Disable exit confirmation
;; (setq confirm-kill-emacs nil)
;;
(setq ccls-executable "/sbin/ccls")

(setq lsp-prefer-flymake nil)

(setq lsp-file-watch-threshold 200000)

(defun lsp-completion-disable ()
  (interactive)
  (lambda ()
    (lsp-lens-hide)
    (lsp-completion-mode -1)
    (setq lsp-completion-provider :none)
    (setq lsp-completion-mode nil)
    (setq lsp-enable-symbol-highlighting nil)
    (lsp-lens-hide)
  )
  )

(add-hook 'lsp-after-open-hook #'lsp-completion-disable)

(with-eval-after-load "lsp-mode"
  (lambda ()
    (lsp-lens-hide)
  (setq lsp-completion-provider :none)
  (setq lsp-completion-mode nil)
  (lsp-completion--disable adwddw)
  (setq lsp-enable-symbol-highlighting nil)

)
  )

(setq lsp-lens-enable nil)
(setq lsp-completion-provider :none)
(setq lsp-ui-sideline-enable nil)

(require 'fill-column-indicator)
;;(setq fci-rule-width 1)
;;(setq fci-rule-color "#303030")
(fci-make-overlay-strings)


