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
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
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
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
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

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   (quote
    ("99743f232b349dae52aa4dc1fc5bab430506cf7bb9857b27dc3cb2eb7d8288b8" "37c1120ec1c1f91008335a38d0f800be524da6113df02cda2c727c297d31309f" default)))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#151515" t)
 '(package-selected-packages
   (quote
    (wgrep smex ivy-hydra flyspell-correct-ivy counsel-projectile counsel swiper ivy satori-theme rainbow-mode meghanada all-the-icons-dired doom-themes zonokai-theme zenburn-theme zen-and-art-theme yaml-mode xterm-color web-mode vagrant-tramp vagrant underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme tronesque-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit sunny-day-theme sublime-themes subatomic256-theme subatomic-theme sql-indent spacegray-theme soothe-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle slim-mode shell-pop seti-theme scss-mode sass-mode reverse-theme railscasts-theme purple-haze-theme pug-mode professional-theme plantuml-mode planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme pastels-on-dark-theme ox-reveal orgit organic-green-theme org-projectile org-present org org-pomodoro alert log4e gntp org-download omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme niflheim-theme naquadah-theme mustang-theme multi-term monokai-theme monochrome-theme molokai-theme moe-theme mmm-mode minimal-theme memory-usage material-theme markdown-toc markdown-mode majapahit-theme magit-gitflow lush-theme light-soap-theme less-css-mode jinja2-mode jbeans-theme jazz-theme ir-black-theme inkpot-theme htmlize heroku-theme hemisu-theme helm-gitignore helm-css-scss helm-company helm-c-yasnippet hc-zenburn-theme haml-mode gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md gandalf-theme flyspell-correct-helm flyspell-correct flycheck-pos-tip flycheck flatui-theme flatland-theme firebelly-theme fasd farmhouse-theme evil-magit magit magit-popup git-commit with-editor espresso-theme eshell-z eshell-prompt-extras esh-help erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks emmet-mode dracula-theme django-theme darktooth-theme darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme csv-mode company-web web-completion-data company-statistics company-quickhelp pos-tip company-emacs-eclim eclim company-ansible company color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme auto-yasnippet yasnippet auto-dictionary apropospriate-theme anti-zenburn-theme ansible-doc ansible ample-zen-theme ample-theme alect-themes afternoon-theme ac-ispell auto-complete ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide ido-vertical-mode hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump f s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed dash aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async quelpa package-build spacemacs-theme)))
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
