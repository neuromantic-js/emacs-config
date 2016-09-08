;;; El-get package manager \n;;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
        (let (el-get-master-branch)
            (goto-char (point-max))
            (eval-print-last-sexp))))
(el-get 'sync)
;;; Ido mode
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)
;; Buffer Selection and ibuffer settings
(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer) ;; отдельный список буферов при нажатии C-x C-b
(global-set-key (kbd "<f2>") 'bs-show) ;; запуск buffer selection кнопкой F2
;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode             t) ;; включено с версии Emacs-22. На всякий...
(setq font-lock-maximum-decoration t)
;; Indent settings
(setq-default indent-tabs-mode nil) ;; отключить возможность ставить отступы TAB'ом
(setq-default tab-width          4) ;; ширина табуляции - 4 пробельных символа
(setq-default c-basic-offset     4)
(setq-default standart-indent    4) ;; стандартная ширина отступа - 4 пробельных символа
(setq-default lisp-body-indent   4) ;; сдвигать Lisp-выражения на 4 пробельных символа
(global-set-key (kbd "RET") 'newline-and-indent) ;; при нажатии Enter перевести каретку и сделать отступ
(setq lisp-indent-function  'common-lisp-indent-function)
;; Scrolling settings
(setq scroll-step               1) ;; вверх-вниз по 1 строке
(setq scroll-margin            10) ;; сдвигать буфер верх/вниз когда курсор в 10 шагах от верхней/нижней границы
(setq scroll-conservatively 10000)
;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)
;; End of file newlines
(setq require-final-newline    t) ;; добавить новую пустую строку в конец файла при сохранении
(setq next-line-add-newlines nil) ;; не добавлять новую строку в конец при смещении
;; курсора  стрелками
;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)
;; Easy transition between buffers: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))
;; Delete trailing whitespaces, format buffer and untabify when save buffer
(defun format-current-buffer()
    (indent-region (point-min) (point-max)))
(defun untabify-current-buffer()
    (if (not indent-tabs-mode)
        (untabify (point-min) (point-max)))
    nil)
(add-to-list 'write-file-functions 'format-current-buffer)
(add-to-list 'write-file-functions 'untabify-current-buffer)
(add-to-list 'write-file-functions 'delete-trailing-whitespace)
;;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;;; Autopair
(require 'autopair)
(autopair-global-mode)
;;; iMenu \n;;;
(require 'imenu)
(setq imenu-auto-rescan t)
(setq imenu-use-popup-menu t)
(global-set-key (kbd "<f6>") 'imenu)
;;; Window header \n;;;
(setq frame-title-format "GNU Emacs: %b")
;;; Org-mode \n;;;
(require 'org)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cl" 'org-store-link)
(add-to-list 'auto-mode-alist '("\\.org$" . Org-mode))
;;; Hello-screeen \n;;;
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
;; Show-paren-mode settings
(show-paren-mode t)
(setq show-paren-style 'expression)
;;; Electric pair-mode \n;;;
(electric-pair-mode 1)
(electric-indent-mode -1)
;;; Delete selectin \n;;;
(delete-selection-mode t)
;;; Disable autosave ;;;
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)
;;; Linum-mode \n;;;
(require 'linum)
(line-number-mode t)
(global-linum-mode t)
(column-number-mode t)
(setq linum-format " %d")
;; Fringe settings
(fringe-mode '(8 . 0)) ;; органичиталь текста только слева
(setq-default indicate-empty-lines t) ;; отсутствие строки выделить глифами рядом с полосой с номером строки
(setq-default indicate-buffer-boundaries 'left) ;; индикация только слева

;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode             t) ;; показывать часы в mode-line
(size-indication-mode          t) ;; размер файла в %-ах
;; Line wrapping
(setq word-wrap          t) ;; переносить по словам
(global-visual-line-mode t)
;; ; Bookmark settings
(require 'bookmark)
(setq bookmark-save-flag t) ;; автоматически сохранять закладки в файл
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t)) ;; попытаться найти и открыть файл с закладками
(global-set-key (kbd "<f3>") 'bookmark-set) ;; создать закладку по F3
(global-set-key (kbd "<f4>") 'bookmark-jump) ;; прыгнуть на закладку по F4
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list) ;; открыть список закладок
(setq bookmark-default-file (concat user-emacs-directory "bookmarks")) ;; хранить закладки в файл bookmarks в .emacs.d
;;; Yasnippet \n;;;
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))
;;; Web-mode \n;;;
(require 'web-mode)
                                        ; какими файлами ассоциировать web-mode
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
;;; отступов
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
;;подсвечивать текущий элемент
(setq web-mode-enable-current-element-highlight t)
;;; JS
(require 'json-mode)
(require 'js2-mode)
(require 'ac-js2)

(require 'tern)
(require 'tern-auto-complete)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
    '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
;;; Projective ;;;
(require 'projectile)
