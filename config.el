;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Su Yue"
      user-mail-address "l@damenly.su")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "Monaco" :size 16)
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
(setq doom-theme 'doom-solarized-dark)
(setq doom-solarized-dark-brighter-comments t)

(setq mu4e-mu-binary "/usr/bin/mu")
(after! mu4e
  (setq! mu4e-maildir (expand-file-name "/data/mail_r/eu/") ; the rest of the mu4e folders are RELATIVE to this one
         mu4e-get-mail-command "mbsync -a"
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
(set-email-account! "l@damenly.su"
                    '((user-mail-address      . "l@damenly.su")
                      (user-full-name         . "Su Yue")
                      (smtpmail-smtp-server   . "mail.inbox.eu")
                      (smtpmail-smtp-service  . 465)
                      (smtpmail-stream-type   . ssl)
                      (smtpmail-debug-info    . t)
                      (mu4e-drafts-folder     . "/Drafts")
                      (mu4e-refile-folder     . "/Archive")
                      (mu4e-sent-folder       . "/Sent")
;;                      (mu4e-trash-folder      . "/Trash")
                      (mu4e-update-interval   . 600)
                      ;(mu4e-sent-messages-behavior . 'delete)
                      )
                    nil)

;;; fci-mode
;;;
;;;

;;(setq fci-rule-width 1)
;;(setq fci-rule-color "black")
;;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;(global-fci-mode 1)

;;;mu4e mouse bindings
;;;
;;;

(global-unset-key [mouse-3])

;; Since the cleanup "mu4e-(actions|control|org|update).el: tidy up", '/' was
;; move to 'mu4e-main-mode-hook, tried to remap the key but failed.
;; For now, just disable the minor mode.
;;
(defun my-mu4e-hook ()
  (let ((oldmap (cdr (assoc 'mu4e-search-minor-mode minor-mode-map-alist)))
        (newmap (make-sparse-keymap)))
    (set-keymap-parent newmap oldmap)
    (define-key newmap (kbd "/") nil)
    (make-local-variable 'minor-mode-overriding-map-alist)
    (push `('mu4e-search-minor-mode . ,newmap) minor-mode-overriding-map-alist))
  (mu4e-search-minor-mode -1)
  (define-key mu4e-main-mode-map (kbd "/") 'mu4e~headers-jump-to-maildir)
  )

(add-hook 'mu4e-main-mode-hook 'my-mu4e-hook)

;;
;; for fly-spell
;;
(setq ispell-program-name "aspell")
;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))

;;
;; auto copy
(setq x-select-enable-primary t)

;; Whatever... it's easy enough to implement that part ourselves
;;(setq interprogram-paste-function
;;      (lambda ()
;;        (shell-command-to-string "pbpaste")))

(setq mouse-drag-copy-region t)

(setq confirm-kill-emacs nil)

(setq doom-theme 'wheatgrass)
(setq doom-solarized-dark-brighter-comments t)
