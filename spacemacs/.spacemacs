;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-complete-with-key-sequence "jk"
                      auto-completion-enable-help-tooltip t)
     ansible
     csv
     erc
     helm
     html
     emacs-lisp
     fasd
     git
     gnus
     markdown
     (org :variables
          org-enable-reveal-js-support t)
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     plantuml
     sql
     spell-checking
     syntax-checking
     themes-megapack
     vagrant
     yaml
     )
   dotspacemacs-additional-packages '(
                                      rainbow-mode
                                      company-ansible
                                      memory-usage)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'nil
   dotspacemacs-startup-lists '((recents . 10)
                                (projects . 10))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(
                         gotham
                         )
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Consolas"
                               :size 19
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 100
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  )

(defun dotspacemacs/user-config ()
  (set-face-attribute hl-line-face nil :underline t)
  (add-to-list 'company-backends 'company-ansible)
  (add-hook 'yaml-mode-hook 'ansible)

  ;; get email, and store in nnml
  (setq gnus-secondary-select-methods
        '(
          (nnimap "gmail"
                  (nnimap-address
                   "imap.gmail.com")
                  (nnimap-server-port 993)
                  (nnimap-stream ssl))
          ))

  ;; send email via gmail:
  (setq message-send-mail-function 'smtpmail-send-it
        send-mail-function 'smtpmail-send-it
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587)

  (load-library "smtpmail")

  ;; archive outgoing email in sent folder on imap.gmail.com:
  (setq gnus-message-archive-method '(nnimap "imap.gmail.com")
        gnus-message-archive-group "[gmail]/sent mail")


  ;; set return email address based on incoming email address
  (setq gnus-posting-styles
        '(((header "to" "address@outlook.com")
           (address "address@outlook.com"))
          ((header "to" "address@gmail.com")
           (address "address@gmail.com"))))

  ;; store email in ~/gmail directory
  (setq nnml-directory "~/.gmail")
  (setq message-directory "~/.gmail")

  ;; disable line truncation in sql interpreters
  (add-hook 'sql-interactive-mode-hook
            (lambda ()
              (toggle-truncate-lines t)))

  ;; key bindings - network
  (spacemacs/declare-prefix "a n" "network")
  (evil-leader/set-key "a n a" 'arp)
  (evil-leader/set-key "a n i" 'ifconfig)
  (evil-leader/set-key "a n d" 'dig)
  (evil-leader/set-key "a n w" 'iwconfig)
  (evil-leader/set-key "a n p" 'ping)
  (evil-leader/set-key "a n r" 'route)
  (evil-leader/set-key "a n l" 'nslookup)
  (evil-leader/set-key "a n t" 'traceroute)
  (evil-leader/set-key "a n n" 'netstat)

  ;; Powerline customization
  (setq powerline-default-separator 'arrow)
  (spaceline-compile)

  (define-key helm-map (kbd "M-x") 'helm-select-action)

  (ido-mode -1)
  (global-company-mode)
  (setq python-shell-interpreter "ipython3"
        python-shell-interpreter-args "-i")

)
