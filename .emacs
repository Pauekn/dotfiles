;; we can require features
(require 'cl)
(require 'package)
 
;; add mirrors for list-packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
 
;; needed to use things downloaded with the package manager
(package-initialize)
 
;; install some packages if missing
(let* ((packages '(auto-complete
                   ido-vertical-mode
                   monokai-theme
                   multiple-cursors
                   undo-tree
                   ;; if you want more packages, add them here
                   php-mode
                   web-mode
                   autopair
                   paredit
                   slime
		   linum-relative
		   expand-region
                   ))
       (packages (remove-if 'package-installed-p packages)))
  (when packages
    (package-refresh-contents)
    (mapc 'package-install packages)))
 
;; no splash screen
(setq inhibit-splash-screen t)
 
;; show matching parenthesis
(show-paren-mode 1)
 
;; show column number in mode-line
(column-number-mode 1)
 
;; overwrite marked text
(delete-selection-mode 1)
 
;; enable ido-mode, changes the way files are selected in the minibuffer
(ido-mode 1)
 
;; use ido everywhere
(ido-everywhere 1)
 
;; show vertically
;(ido-vertical-mode 1)

;; Global autopair-mode
(autopair-global-mode 1) 
 
;; use undo-tree-mode globally
(global-undo-tree-mode 1)
 
;; stop blinking cursor
;(blink-cursor-mode 0)
 
;; no menubar
(menu-bar-mode 0)
 
;; no toolbar either
(tool-bar-mode 0)
 
;; scrollbar? no
(scroll-bar-mode 0)
 
;; global-linum-mode shows line numbers in all buffers, exchange 0
;; with 1 to enable this feature
(global-linum-mode 1)
 
;; Enable relative line numbers
(require 'linum-relative)

;; Enable expand region
(require 'expand-region)

;; answer with y/n
(fset 'yes-or-no-p 'y-or-n-p)
 
;; choose a color-theme
(load-theme 'monokai t)
 
;; get the default config for auto-complete (downloaded with
;; package-manager)
(require 'auto-complete-config)
 
;; load the default config of auto-complete
(ac-config-default)
 
;; kills the active buffer, not asking what buffer to kill.
(global-set-key (kbd "C-x k") 'kill-this-buffer)
 
;; adds all autosave-files (i.e #test.txt#, test.txt~) in one
;; directory, avoid clutter in filesystem.
(defvar emacs-autosave-directory (concat user-emacs-directory "autosaves/"))
(setq backup-directory-alist
      `((".*" . ,emacs-autosave-directory))
      auto-save-file-name-transforms
      `((".*" ,emacs-autosave-directory t)))
 
;; defining a function that sets more accessible keyboard-bindings to
;; hiding/showing code-blocs
(defun hideshow-on ()
  (local-set-key (kbd "C-c <right>") 'hs-show-block)
  (local-set-key (kbd "C-c <left>")  'hs-hide-block)
  (local-set-key (kbd "C-c <up>")    'hs-hide-all)
  (local-set-key (kbd "C-c <down>")  'hs-show-all)
  (hs-minor-mode t))
 
;; now we have to tell emacs where to load these functions. Showing
;; and hiding codeblocks could be useful for all c-like programming
;; (java is c-like) languages, so we add it to the c-mode-common-hook.
(add-hook 'c-mode-common-hook 'hideshow-on)
 
;; adding shortcuts to java-mode, writing the shortcut folowed by a
;; non-word character will cause an expansion.
(defun java-shortcuts ()
  (define-abbrev-table 'java-mode-abbrev-table
    '(("psv" "public static void main(String[] args) {" nil 0)
      ("sop" "System.out.printf" nil 0)
      ("sopl" "System.out.println" nil 0)))
  (abbrev-mode t))
 
;; the shortcuts are only useful in java-mode so we'll load them to
;; java-mode-hook.
(add-hook 'java-mode-hook 'java-shortcuts)
 
;; defining a function that guesses a compile command and bindes the
;; compile-function to C-c C-c
(defun java-setup ()
  (set (make-variable-buffer-local 'compile-command)
       (concat "javac " (buffer-name)))
  (local-set-key (kbd "C-c C-c") 'compile))
 
;; this is a java-spesific function, so we only load it when entering
;; java-mode
(add-hook 'java-mode-hook 'java-setup)
 
;; defining a function that sets the right indentation to the marked
;; text, or the entire buffer if no text is selected.
(defun tidy ()
  "Ident, untabify and unwhitespacify current buffer, or region if active."
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end)       (point-max))))
    (whitespace-cleanup)
    (indent-region beg end nil)
    (untabify beg end)))
 
;; bindes the tidy-function to C-TAB
(global-set-key (kbd "<C-tab>") 'tidy)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Custom functions

;; Create a function that inserts a line
;; 'above' the current cursor position.

(defun my/insert-line-after(times)
  "Inserts a newline(s) above the line containing the cursor"
  (interactive "p")
  (save-excursion
    (move-end-of-line 1)
    (newline times)))

;; Keybindings:
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-set-key (kbd "C-<up>") 'backward-page)
(global-set-key (kbd "C-<down>") 'forward-page)

(global-set-key (kbd "C-S-o") 'my/insert-line-after)

(global-set-key (kbd "C-.") 'er/expand-region)

;; Default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")
