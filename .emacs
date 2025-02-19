(setq native-comp-jit-compilation nil)

;; no .#. <file> -> sessions files on editing
(setq create-lockfiles nil)

;; moving cursor down at bottom scrolls
;; only a single line, not half page
(setq-default scroll-step 1)
(setq-default scroll-conservatively 0)
(setq-default scroll-margin 2)

;; typed text replaces the selection
(delete-selection-mode t)

;; y and n instead of yes and no
(fset 'yes-or-no-p 'y-or-n-p)

;; do not ask additional question if I want to kill a buffer with a
;; live process attached to it, I always aswer 'yes' anyway
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))

;; cutting and pasting uses the clipboard
(setq x-select-enable-clipboard t)

;; no backup files - use git instead
(setq make-backup-files nil)

;; bury *scratch* buffer instead of kill it
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))

;; create directories automaticaly
;; if we open file in directory that doesn't exist yet
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

;; save minibuffer history between sessions
(savehist-mode 1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; seems to help a bit with long lines:
;; http://comments.gmane.org/gmane.emacs.devel/159671,
;; http://debbugs.gnu.org/cgi/bugreport.cgi?bug=13675
(setq-default cache-long-line-scans t)
(setq-default bidi-display-reordering nil)

(setq calendar-week-start-day 1)

;; cua is usefull for rectagle editing
(setq cua-enable-cua-keys nil)
(setq cua-highlight-region-shift-only nil) ;no transient mark mode
(setq cua-toggle-set-mark nil) ;original set-mark behavior, i.e. no transient-mark-mode
(cua-mode)

;; new keymap experiment:
(global-set-key "\C-j" 'next-line)
(global-set-key "\C-k" 'previous-line)
(global-set-key "\C-l" 'forward-char)
(global-set-key "\C-h" 'backward-char)

(global-set-key "\C-\M-k" 'cua-scroll-down)
(global-set-key "\C-\M-j" 'cua-scroll-up)
(global-set-key "\C-\M-h" 'backward-word)
(global-set-key "\C-\M-l" 'forward-word)

(global-set-key "\C-\M-e" 'kill-line)

(global-set-key "\C-d" 'delete-char)
(global-set-key "\C-\M-d" 'kill-word)
(global-set-key "\C-b" 'backward-delete-char)
(global-set-key "\C-\M-b"  'backward-kill-word)

(global-set-key "\C-w" 'kill-ring-save)
(global-set-key "\C-\M-w" 'kill-region)
(global-set-key "\C-y" 'cua-paste)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-xm"    'execute-extended-command)

;; C-h delete backward char while search
(define-key isearch-mode-map "\C-b" 'isearch-del-char)
(global-set-key "\C-s"    'isearch-forward-regexp)
(global-set-key "\C-r"    'isearch-backward-regexp)
(global-set-key "\M-%"    'query-replace-regexp)

(global-set-key "\C-c\C-t" 'toggle-truncate-lines)

(global-set-key (kbd "C-c r") 'revert-buffer) ; reloads from disk

;; kill buffer
(defun kill-buffer-or-client ()
  "If buffer has clients - kill 'em, otherwise kill-buffer"
  (interactive)
  (if server-buffer-clients
      (server-edit)
    (ido-kill-buffer)))
(global-set-key (kbd "C-x k") 'kill-buffer-or-client)

(global-set-key "\C-x\C-h" 'help-command)
;; Help should search more than just commands (from emacs-starter-kit)
(global-set-key "\C-x\C-ha" 'apropos)

;; I don't use set-goal-column
(global-unset-key "\C-x\C-n")
;; I don't use suspend-frame
(global-unset-key "\C-x\C-z")

;; scroll down
(global-set-key "\C-z" '(lambda () (interactive) (scroll-down -1)))
;; scroll up
(global-set-key "\C-\M-z" '(lambda () (interactive) (scroll-down 1)))

(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(global-set-key [remap goto-line] 'goto-line-with-feedback)


;; no scrollbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; no toolbar
(if (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
;; no menu
(if (fboundp 'menu-bar-mode)   (menu-bar-mode -1))

;; maximum font decoration
(setq font-lock-mode-maximum-decoration t)
(global-font-lock-mode t)

;; show marked text
(setq transient-mark-mode 1)

;; show parens
(show-paren-mode 1)

;; not blinking cursor 
(blink-cursor-mode -1)

;; tab settings
(setq default-tab-width  2)
;; insert space instead of tab
(setq-default indent-tabs-mode nil) 

;; show column number in status bar
(setq column-number-mode t)

;; empty scratch message
(setq initial-scratch-message nil)
(setq inhibit-splash-screen t)

;; mark current line:
(global-hl-line-mode 1)

;; color for current line:
(set-face-background 'hl-line "#e0f8ff")

;; split window horizontally
(setq split-height-threshold 200)
;; don't split in more than 2 windows on my wide monitor:
(setq split-width-threshold 200)


(load-library "time")
(setq display-time-24hr-format t
      display-time-form-list (list 'time)
      display-time-default-load-average nil
      display-time-load-average-threshold 1
      display-time-day-and-date t)
(display-time)


(require 'ido)
(setq ido-enable-flex-matching t
      ido-use-filename-at-point nil
      ido-create-new-buffer 'always)

;; list all dirs in completion, by default ido has 30000 bytes limit on dir listing, which is too small, nil means no limit
(custom-set-variables '(ido-max-directory-size nil))

(ido-mode t)

(setq ido-auto-merge-inhibit-characters-regexp ".*")

(recentf-mode +1)

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
(global-set-key "\C-x\C-r" 'recentf-ido-find-file)

(defun nd-ido-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map "\C-\M-b" 'ido-delete-backward-word-updir)
  (define-key ido-completion-map "\C-i"    'ido-copy-current-file-name)
  (define-key ido-completion-map "\C-n"    'ido-next-match)
  (define-key ido-completion-map "\C-p"    'ido-prev-match)
  (define-key ido-completion-map " "       'ido-exit-minibuffer)
  (define-key ido-completion-map "\t"      'ido-exit-minibuffer))

(add-hook 'ido-setup-hook 'nd-ido-keys)

;; redefine ido-make-buffer-list so that buffers visible in other
;; windows are not moved to the end. Only current buffer is moved to
;; the end. Cannot do that via hook because for kill buffer command
;; current buffer should be the first and hook doesn't have access to
;; the DEFAULT param.
(defun ido-make-buffer-list (default)
  (let* ((ido-current-buffers (ido-get-buffers-in-frames 'current))
	 (ido-temp-list (ido-make-buffer-list-1 (selected-frame) (list (buffer-name (current-buffer))))))
    (if ido-temp-list
	(nconc ido-temp-list ido-current-buffers)
      (setq ido-temp-list ido-current-buffers))
    (if default
	(setq ido-temp-list
	      (cons default (delete default ido-temp-list))))
    (if (bound-and-true-p ido-enable-virtual-buffers)
	(ido-add-virtual-buffers-to-list))
    (run-hooks 'ido-make-buffer-list-hook)
    ido-temp-list))


(setq dired-recursive-deletes 'top
      dired-recursive-copies 'always
      dired-dwim-target t)

(setq ls-lisp-dirs-first t)

(defun nd-dired-keys ()
  (define-key dired-mode-map "%n" 'find-name-dired)
  (define-key dired-mode-map "%N"
    (lambda (pattern)
      (interactive "Mpattern: ")
      (find-name-dired (dired-current-directory) pattern)))
  (define-key dired-mode-map "%s" 'find-grep-dired)
  (define-key dired-mode-map "%S"
    (lambda (pattern)
      (interactive "Mpattern: ")
      (find-grep-dired (dired-current-directory) pattern)))
  (define-key dired-mode-map (kbd "C-c C-o") 'dired-gnome-open-file)
  (define-key dired-mode-map (kbd "C-c C-r") 'wdired-change-to-wdired-mode)
  (define-key dired-mode-map (kbd "j") 'dired-next-line)
  (define-key dired-mode-map (kbd "k") 'dired-previous-line)
  (define-key dired-mode-map (kbd "W") 'dired-copy-full-filename-as-kill))

(defun dired-copy-full-filename-as-kill ()
  (interactive)
  (dired-copy-filename-as-kill 0))

(add-hook 'dired-mode-hook 'nd-dired-keys)


(require 'epa)
(epa-file-enable)


(server-start)



(require 'cc-mode)
(define-key c-mode-map "\C-\M-b"  'backward-kill-word)
(define-key c++-mode-map "\C-\M-b"  'backward-kill-word)
(define-key c++-mode-map "\C-\M-b"  'backward-kill-word)
(define-key c-mode-map "," 'self-insert-command)
(define-key c-mode-map ";" 'self-insert-command)
(define-key c-mode-map "/" 'self-insert-command)


(setq default-directory "~")


(set-language-environment 'Russian)
(progn
  (set-default-coding-systems    'utf-8-unix)
  (set-buffer-file-coding-system 'utf-8-unix)
  (prefer-coding-system          'utf-8-unix))

;; To disable graphical prompt
;; - add 'allow-emacs-pinentry' line to /home/nd/.gnupg/gpg-agent.conf
;; - run 'gpgconf --reload gpg-agent'
;; - set epa-pinentry-mode:
(setq epa-pinentry-mode 'loopback)

(defun nd-sec-copy-pwd ()
  (interactive)
  (let* ((secrets (nd-sec-read-secrets))
         (names (mapcar #'(lambda (e) (plist-get e :name)) secrets))
         (name (ido-completing-read "Name: " names))
         (entry (car (seq-filter #'(lambda (e) (equal (plist-get e :name) name)) secrets)))
         (pwd (plist-get entry :pass)))
    (with-temp-buffer
      (insert pwd)
      (goto-char (point-min))
      (kill-whole-line))))

(defun nd-sec-show ()
  (interactive))

(defun nd-sec-add (name user pass)
  (interactive "sName: \nsUser: \nsPass: ")
  (let ((secrets (nd-sec-read-secrets)))
    (if (seq-filter #'(lambda (e) (equal (plist-get e :name) name)) secrets)
        (error "Entry with such a name already exist")
      (push `(:name ,name :user ,user :pass ,pass) secrets)
      (nd-sec-write-secrets secrets))))

(defun nd-sec-read-secrets ()
  (with-temp-buffer
    (insert-file-contents "~/pwd2.gpg")
    (goto-char (point-min))
    (let ((res (list)))
      (while (not (eobp))
        (let* ((str (buffer-substring (line-beginning-position) (line-end-position)))
               (parts (split-string str "\t")))
          (push `(:name ,(elt parts 0) :user ,(elt parts 1) :pass ,(elt parts 2)) res))
        (forward-line))
      res)))

(defun nd-sec-write-secrets (secrets)
  (with-temp-buffer
    (mapc #'(lambda (e)
              (insert (plist-get e :name))
              (insert "\t")
              (insert (plist-get e :user))
              (insert "\t")
              (insert (plist-get e :pass))
              (insert "\n"))
          secrets)
    (write-file "~/pwd2.gpg")))

;; end sec

; Stop Emacs from losing undo information by
; setting very high limits for undo buffers
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

(global-set-key (kbd "<f2>") 'next-error)
(global-set-key (kbd "S-<f2>") 'previous-error)

(setq c-electric-flag nil)


(require 'package)
(add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
(package-initialize)

;; org
(custom-set-faces
 '(org-level-1 ((t (:inherit bold :extend nil))))
 '(org-link ((t (:inherit text)))))
(require 'org)
(define-key org-mode-map "\M-n" 'org-next-visible-heading)
(define-key org-mode-map "\M-p" 'org-previous-visible-heading)
(define-key org-mode-map "\C-j" 'next-line)

;; load os-specific config
(cond
 ((and (string-match "linux" (symbol-name system-type))
       (file-exists-p "~/.emacs_linux"))
  (load-file "~/.emacs_linux"))

 ((and (string-match "darwin" (symbol-name system-type))
       (file-exists-p "~/.emacs_mac"))
  (load-file "~/.emacs_mac"))

 ((and (string-match "windows" (symbol-name system-type))
       (file-exists-p "~/.emacs_win"))
  (load-file "~/.emacs_win")))

(if (file-exists-p "~/.emacs_local")
    (load-file "~/.emacs_local"))

