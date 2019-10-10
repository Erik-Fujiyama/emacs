(add-to-list 'default-frame-alist '(fullscreen . maximized))
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (global-linum-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))
;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)
;; Power line
(require 'powerline)
(powerline-revert)
(set-face-attribute 'mode-line nil
                    :foreground "White"
                    :background "Blue"
                    :box nil)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; autocomplete paired brackets
(electric-pair-mode 1)
(load "~/git/org-mode/contrib/lisp/org-effectiveness.el")
(show-paren-mode 1)

(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(pdf-tools-install)
;; turn off cua so copy works
(add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))

;;google translate
(require 'google-translate)
(require 'google-translate-default-ui)
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)
(global-set-key (kbd "C-c r") 'google-translate-at-point-reverse) (global-set-key (kbd "C-c R") 'google-translate-query-translate-reverse)
(defun pdf-google-translate()
  (interactive)
  (google-translate-translate
   google-translate-default-source-language
   google-translate-default-target-language
   (pdf-view-kill-ring-save)
   )
  )

(define-key pdf-view-mode-map (kbd "C-c t") 'pdf-google-translate)

(add-to-list 'load-path "/home/erik/Downloads/julia-emacs-master (1)/julia-emacs-master")
(require 'julia-mode)

(add-to-list 'load-path "/home/erik/Downloads/julia-repl-master")
(require 'julia-repl)
(add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode

(setq package-check-signature nil)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)

;;flyspell
(let ((langs '("english" "deutsch8" "pt_BR")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))
(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))
(global-set-key [f6] 'cycle-ispell-languages)

(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'LaTeX-mode-hook #'turn-on-flyspell)

;;music
(use-package emms
  :ensure t
  :config
  (require 'emms-setup)
  (require 'emms-player-mpd)
  (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
  (setq emms-seek-seconds 5)
  (setq emms-player-list '(emms-player-mpd))
  (setq emms-info-functions '(emms-info-mpd))
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6601"))
(setq mpc-host "localhost:6601")
(defun mpd/start-music-daemon ()
  "Start MPD, connects to it and syncs the metadata cache."
  (interactive)
  (shell-command "mpd")
  (mpd/update-database)
  (emms-player-mpd-connect)
  (emms-cache-set-from-mpd-all)
  (message "MPD Started!"))
(global-set-key (kbd "s-c") 'mpd/start-music-daemon)
(defun mpd/kill-music-daemon ()
  "Stops playback and kill the music daemon."
  (interactive)
  (emms-stop)
  (call-process "killall" nil nil nil "mpd")
  (message "MPD Killed!"))
(global-set-key (kbd "s-k") 'mpd/kill-music-daemon)
(defun mpd/update-database ()
  "Updates the MPD database synchronously."
  (interactive)
  (call-process "mpc" nil nil nil "update")
  (message "MPD Database Updated!"))
(global-set-key (kbd "s-u") 'mpd/update-database)

;; latex
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq langtool-language-tool-jar "/home/erik/Downloads/LanguageTool-4.5/languagetool-commandline.jar")
(require 'langtool)
(setq langtool-mother-tongue "pt-BR")
(global-set-key "\C-x4w" 'langtool-check)
(global-set-key "\C-x4W" 'langtool-check-done)
(global-set-key "\C-x4l" 'langtool-switch-default-language)
(global-set-key "\C-x44" 'langtool-show-message-at-point)
(global-set-key "\C-x4c" 'langtool-correct-buffer)
(setq-default TeX-master nil) ; Query for master file
(require 'reftex)
;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-ref-macro-prompt nil)
;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
:ensure t
:init
(ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
