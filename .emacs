(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((TeX-master . "master")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 89 :width normal)))))


;;设置有用的个人信息
(setq user-full-name "mudan")
(setq user-mail-address "mudand88@gmail.com")

;;--显示时间设置--
(display-time-mode 1);;启用时间显示设置
(setq display-time-24hr-format t);;时间使用24小时制
(setq display-time-day-and-date t);;时间显示包括日期和具体时间
(setq display-time-use-mail-icon t);;时间栏旁边启用邮件设置
(setq display-time-interval 10);;时间的变化频率
;;时间戳设置，插入文档内的
(defun my-timestamp ()
  "Insert the \"Time-stamp: <>\" string at point."
  (interactive)
  (if (interactive-p)
      (insert " Time-stamp: <>")
    " Time-stamp: <>"))
;;时间戳设置(time-stamp)，设定文档上次保存的信息
;;只要里在你文档里有Time-stamp:的设置，就会自动保存时间戳
(setq time-stamp-active t)
;;(setq time-stamp-start "最后更新时间:[ ]+\\\\?")
(setq time-stamp-start "最后更新时间:[     ]+\\\\?")
(setq time-stamp-end: "\n")
(setq time-stamp-format: "%:y年%:m月%:d日")
;;自动更新time-stamp
(add-hook 'write-file-hooks 'time-stamp)

;;语法加亮
(global-font-lock-mode t)

;;加快语法刷新速度
;(set-variable 'jit-lock-stealth-time 0)

;; 自动打开上次的文件
;;(desktop-save-mode 1)

;;Emacs窗口大小
;;(modify-frame-parameters
;; '((left + 14)
;; (top + 16)
;; (width . 80)
;; (height . 30)))

;;shell色彩信息能够被 Emacs 正确解析
(autoload 'ansi-color-for-comint-mode-on "ansi-color" t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

;;使用 Ctrl-c ← （对，就是向左的箭头键）组合键，退回你的上一个窗口设置
(when (fboundp 'winner-mode)
               (winner-mode)
               (windmove-default-keybindings))

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; No splash screen please ... jeez
;(setq inhibit-startup-message t)

;;鼠标自动避开指针
(mouse-avoidance-mode 'animate)

;; 指针颜色
(set-cursor-color "blue")

;; 用一个很大的kill ring. 这样防止我不小心删掉重要的东西
(setq kill-ring-max 200)

;;自动保存模式
(setq auto-save-mode nil)

;;括号匹配时显示另一端的括号，而不是跳过去
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 高亮显示要拷贝的区域
(transient-mark-mode t)

;; 缩小工具条
(tool-bar-mode -1)

;; 鼠标中键复制时复制到光标所在位置
(setq mouse-yank-at-point t)

;; 打入 TAB 无声
(setq visible-bell t)

;; 允许自动打开图片，如wiki里面
(auto-image-file-mode t)

;; 打开压缩文件时自动解压缩
(auto-compression-mode 1)

;; 靠近屏幕边沿3行时就开始滚动。
(setq scroll-margin 3 scroll-conservatively 10000)

;; 显示列号
(column-number-mode t)

;; 显示行号
;;(global-linum-mode t)

;; 以 y/n代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; 标题拦显示buffer的名字
(setq frame-title-format "emacs@%b")
;; 在标题栏提示你目前在什么位置
(setq frame-title-format "mudan@%b")

;; 对重名buffer的命名添加父目录
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

;; 把所有的文件备份都放在一个固定的地方("~/var/tmp")。对于每个备份文件，保留最原始的两个版本和最新的
;; 三个版本。并且备份的时候，备份文件是复本，而不是原件。
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/tmp")))
(setq backup-by-copying t)
;;不产生备份文件
;(setq make-backup-files nil)

;; 最近打开文件 -- ido 方法
(require 'recentf)
(recentf-mode t)
(setq recentf-max-saved-items 25)
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
    (message "Opening file...")
    (message "Aborting")))

;;将文件模式和文件后缀关联起来。append表示追加
(setq auto-mode-alist
    ( append
       '(("\\.py\\'" . python-mode)
        ("\\.s?html?\\'" . html-helper-mode)
        (" \\.asp\\'" . html-helper-mode)
        ("\\.phtml\\'" . html-helper-mode)
        ("\\.css\\'" . css-mode)
        ("\\.pc$" . c-mode)
    )
auto-mode-alist))

;; auto revert mode
;; 自动刷新 log 日志文件
;(add-hook 'find-file-hook
;          (lambda ()
;            (if (string-equal
;                 ".log"
;                (substring (buffer-file-name)
;                           (search "." (buffer-file-name))))
;                (progn
;                  (setq auto-revert-mode t)
		  ;; 以追加方式更新，用于大文件 (setq auto-revert-tail-mode t)
;                  (message "Enabling auto-revert-mode for log file")))))

;; eshell
;; 将alias保存到指定目录,以兹备份
;; 新建一文件alias,内容如：
;; alias 'ls 'ls -a
;; alias 'halt 'shutdown /p
(setq eshell-aliases-file "~/.emacs.d/alias")
;; 输入em file即可用Emacs在当前窗口进行文件编辑
(defalias 'em 'find-file)
;; 打开shell
(global-set-key (kbd "C-c z") 'eshell)
;; 设置
(setq   eshell-save-history-on-exit t
	eshell-history-size 512
	eshell-hist-ignoredups t
	eshell-cmpl-ignore-case t
	eshell-cp-interactive-query t
	eshell-ln-interactive-query t
	eshell-mv-interactive-query t
	eshell-rm-interactive-query t
	eshell-mv-overwrite-files nil
	eshell-highlight-prompt t
	eshell-prompt-function    (lambda nil
				    (concat
				     (abbreviate-file-name
				      (eshell/pwd))
				     (if
					 (=
					  (user-uid)
					  0)
					 " # " " >>> "))))
;; 计算每个命令花费时间
(add-hook 'eshell-load-hook
          (lambda()(setq last-command-start-time (time-to-seconds))))
(add-hook 'eshell-pre-command-hook
          (lambda()(setq last-command-start-time (time-to-seconds))))
(add-hook 'eshell-before-prompt-hook
          (lambda()
              (message "spend %g seconds"
                       (- (time-to-seconds) last-command-start-time))))

;;设置内置输入法
 (setq my-input-methods
       '("japanese"
         "japanese-katakana"
         "chinese-py-punct-b5")
       my-current-input-methods my-input-methods)
(defun my-cycle-input-method ()
       "Cycle `my-input-method-alist'."
       (interactive)
       (if (null (cdr my-current-input-methods))
          (setq my-current-input-methods my-input-methods)
          (setq my-current-input-methods (cdr my-current-input-methods)))
       (set-input-method (car my-current-input-methods)))
 (global-set-key (kbd "C-\\") 'toggle-input-method)
 (global-set-key (kbd "M-C-\\") 'my-cycle-input-method)
;; 不需要用 C-\ 调用 Emacs 内置输入法了
;; (global-unset-key (kbd "C-\\"))

;;-------------------------------------------------------
;; dired mode
;;允许复制和删除时将文件夹里所有内容一起带上
(setq dired-recursive-copies t)
(setq dired-recursive-deletes t)
;; 只打开一个 dired
(defadvice dired-find-file (around dired-find-file-single-buffer activate)
  "Replace current buffer if file is a directory."
  (interactive)
  (let ((orig (current-buffer))
        (filename (dired-get-file-for-visit)))
    ad-do-it
    (when (and (file-directory-p filename)
               (not (eq (current-buffer) orig)))
      (kill-buffer orig))))
(defadvice dired-up-directory (around dired-up-directory-single-buffer activate)
  "Replace current buffer if file is a directory."
  (interactive)
  (let ((orig (current-buffer)))
    ad-do-it
    (kill-buffer orig)))
;; s s 按照文件大小排序
;; s x 按照文件扩展名排序
;; s t 按照文件访问时间排序
;; s n 按照文件名称的字母顺序排序
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (make-local-variable 'dired-sort-map)
  (setq dired-sort-map (make-sparse-keymap))
  (define-key dired-mode-map "s" dired-sort-map)
  (define-key dired-sort-map "s"
              '(lambda () "sort by Size"
                (interactive) (dired-sort-other (concat dired-listing-switches "S"))))
  (define-key dired-sort-map "x"
              '(lambda () "sort by eXtension"
                 (interactive) (dired-sort-other (concat dired-listing-switches "X"))))
  (define-key dired-sort-map "t"
              '(lambda () "sort by Time"
                 (interactive) (dired-sort-other (concat dired-listing-switches "t"))))
  (define-key dired-sort-map "n"
              '(lambda () "sort by Name"
                 (interactive) (dired-sort-other (concat dired-listing-switches ""))))))

;;erc,irc客户端
(setq erc-default-coding-system '(utf-8 . utf-8))
;;保存聊天记录
(require 'erc-log)
(erc-log-mode 1)
(setq erc-log-channels-directory "~/.erc/"
      erc-save-buffer-on-part t
      erc-log-file-coding-system 'utf-8
      erc-log-write-after-send t
      erc-log-write-after-insert t)
(unless (file-exists-p erc-log-channels-directory)
(mkdir erc-log-channels-directory t))

;;org mode 自动折行
(require 'org-install)
(require 'org-publish)
(require 'org-latex)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook
(lambda () (setq truncate-lines )))
(setq org-mobile-directory "~/Dropbox/note")
;;iimage mode
;;M-x org-toggle-iimage-in-org 或 M-x iimage-mode 命令来激活 iimage模式
(load "~/.emacs.d/iimage.el")
(require 'iimage)
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
; 显示图片
(setq org-startup-with-inline-images t)
;org mode show image
(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link)
      (set-face-underline-p 'org-link t))
  (iimage-mode))
;; org capture
(define-key global-map (kbd "C-c c") 'org-capture)
(setq org-default-notes-file (concat org-directory "~/Dropbox/note/notes.org"))
(setq org-capture-templates
      '(("j" "Journal" plain (file+datetree (concat org-directory "journal.org"))
         "* %?\n  -- %T\n")
	("n" "Note" entry (file+headline (concat org-directory "notes.org") "Notes")
	 "* %?\t%^G\nTime: %U\n %i")
	("t" "Todo" entry (file+headline (concat org-directory "Todo.org") "Tasks")
	 "* TODO %?\t%^G \nTime: %U\n %i")))
;; 在一个任务完成后，写心得或者备注并加上时间戳
(setq org-log-done 'time)
(setq org-log-done 'note)
;; org-clock 计时功能
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
;; M-x gtd 命令之后，在新的窗口中就打开了我的Org-mode文件
;; (defun gtd ()
;;   (interactive)
;;   (find-file "c:/homes/charles/gtd/gtd/mygtd.org")
;; )

;; org docbook
(load "~/.emacs.d/org-docbook.el")
(require 'org-docbook)

;; org w3m
;; 从w3m拷贝到org，自动标记语法，如加粗等
(load "~/.emacs.d/org-w3m.el")
(require 'org-w3m)

;; org-tree-slide-mode org 幻灯片演示
;(load "~/.emacs.d/org-tree-slide.el")
;(require 'org-tree-slide)
;(global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)

;; deft
(load "~/.emacs.d/deft.el")
(require 'deft)
(setq deft-extension "org")
(setq deft-text-mode 'org-mode)
(setq deft-use-filename-as-title t)
(setq deft-directory "~/Dropbox/note/deft")

;;emacs muse
;(load "~/.emacs.d/muse/muse.el")
;(require 'muse-mode)
;(require 'muse-wiki)
;(require 'muse-html)         ;添加html格式的支持
;(require 'muse-latex)        ; 添加latex格式的支持
;(require 'muse-texinfo)      ; 添加texinfo格式的支持
;(require 'muse-docbook)      ; 添加docbook格式的支持
;(require 'muse-project)      ; 添加wiki project的支持
;;muse
;;设置编码方式为utf-8
;(setq muse-html-meta-content-type (concat "text/html; charset=utf-8"))
;;新建一个wiki工程
;(setq muse-project-alist
;      '(("Think"
;         ("~/Dropbox/note/wiki" :default "index")
;         (:base "html" :path "~/Dropbox/note/wiki/html"))))

;; linum
(load "~/.emacs.d/linum+.el")
(require 'linum+)

;; autorevert
;; 恢复缓冲区时，文件在磁盘上的变化
;(load "~/.emacs.d/autorevert.el")
;(require 'autorevert)
;(global-auto-revert-mode 1)

;; nXhtml
(load "~/.emacs.d/nxhtml/autostart.el")

;; hexrgd.el
;(load "~/.emacs.d/hexrgb.el")
;(require 'hexrgb)

;; vimpulse
;(load "~/.emacs.d/vimpulse.el")
;(require 'vimpulse)

;; tab-display 用来'<'字符标识出文件中的tab字符
;(load "~/.emacs.d/tab-display.el")
;(require 'tab-display)

;; thumbs.el 图片浏览器
;(load "~/.emacs.d/thumbs.el")
;(require 'thumbs)

;; window-number buffer快速定位
;; M-指定buffer number，如：M-1
(load "~/.emacs.d/window-number.el")
(require 'window-number)
(autoload 'window-number-mode "window-number" t)
(autoload 'window-number-meta-mode "windows-number" t)
(window-number-mode 1)
(window-number-meta-mode 1)

;; 让 speedbar 不再独立一个窗口
;; M-x sr-speedbar-open
(load "~/.emacs.d/sr-speedbar.el")
(require 'sr-speedbar)

;; tomorrow theme
(load "~/.emacs.d/tomorrow/color-theme-tomorrow.el")
(load "~/.emacs.d/tomorrow/tomorrow-day-theme.el")
(require 'tomorrow-day-theme)
(load-theme `tomorrow-day t)

;; tron-theme.el
;(load "~/.emacs.d/tron-theme.el")
;(require 'tron-theme)
;(load-theme `tron t)

;; 让dired只使用一个buffer
(load "~/.emacs.d/dired-single.el")
(require 'dired-single)

;; thinks.el
(load "~/.emacs.d/thinks.el")
(require 'thinks)

;; easymenu.el
;(load "~/.emacs.d/easymenu.el")
;(require 'easymenu)

;; git-emacs.el
;(add-to-list 'load-path' "~/.emacs.d/git-emacs/")
;(require 'git-emacs)

;; markdown-mode
(load "~/.emacs.d/markdown-mode.el")
(require 'markdown-mode)
(defun markdown-custom ()
  "markdown-mode-hook"
  (setq markdown-command "markdown | smartypants"))
(add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; mediawiki
;(load "~/.emacs.d/mediawiki.el")
;(require 'mediawiki)
;(setq mediawiki-site-alist (quote (("Think" "http://localhost/wiki/" "mudan" "mudan88" "首页"))))
;"ArchWiki" "wiki.archlinux.org:80" "mudan" "kuchanzhu" "Main Page"


;; Web Jump
;; 快速访问某网站
;(load "~/.emacs.d/webjump-plus.el")
;(require 'webjump-plus)
;(global-set-key (kbd "C-x g") 'webjump)
;(setq webjump-sites
;      (append '(
;		("Google" . "www.google.com")
;                ("baidu"   . "www.baidu.com")
;                )
;              webjump-sample-sites))

;; browse-kill-ring
(load "~/.emacs.d/browse-kill-ring.el")
(require 'browse-kill-ring)
(global-set-key (kbd "C-c k") 'browse-kill-ring)

;; 新版 Emacs 自带包管理工具
;(require 'package)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; 自动保存上次光标所在的位置
;(load "~/.emacs.d/saveplace.el")
;(require 'saveplace)
;(setq save-place-file "~/.emacs.d/saved-places")
;(setq-default save-place t)

;;直观矩形操作
(load "~/.emacs.d/rect-mark.el")
(require 'rect-mark)

;; lazy-set-key.el
;(load "~/.emacs.d/lazy-set-key.el")
;(require 'lazy-set-key)
;(lazy-set-key
; '(
;   ("s-M" . rm-set-mark)                         ;矩形标记
;   ("s-X" . rm-exchange-point-and-mark)          ;矩形对角交换
;   ("s-D" . rm-kill-region)                      ;矩形删除
;   ("s-S" . rm-kill-ring-save)                   ;矩形保存
;   ("s-Y" . yank-rectangle)                      ;粘帖矩形
;   ("s-O" . open-rectangle)                      ;用空白填充矩形, 并向右移动文本
;   ("s-C" . clear-rectangle)                     ;清空矩形
;   ("s-T" . string-rectangle)                    ;用字符串替代矩形的每一行
;   ("s-I" . string-insert-rectangle)             ;插入字符串在矩形的每一行
;   ("s-F" . delete-whitespace-rectangle)         ;删除矩形中空格
;   ("s-:" . mark-rectangle-to-end)               ;标记矩形到行末
;   ("s-H" . execute-command-with-region-replace) ;在选择的区域中执行命令并替换
;   ("s-P" . execute-command-with-region-kill)    ;在选择的区域中执行命令并删除
;   ("s-\"" . copy-rectangle-to-register)         ;拷贝矩形到寄存器
;  ))

;; 把文件或buffer彩色输出成html
(load "~/.emacs.d/htmlize.el")
(require 'htmlize)

;; powerline.el
;(load "~/.emacs.d/powerline.el")
;(require 'powerline)
;(setq powerline-arrow-shape 'arrow)   ;; the default
;(custom-set-faces
;   '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil)))))

;; 像 Window 中那样用 Ctrl-Tab 来切换窗口
(load "~/.emacs.d/wcy-swbuff.el")
(global-set-key (kbd "<f6>") 'wcy-switch-buffer)
(setq wcy-switch-buffer-active-buffer-face  'highlight)
(setq wcy-switch-buffer-inactive-buffer-face  'secondary-selection)

;; color-theme
(add-to-list 'load-path' "~/.emacs.d/color-theme/")
(require 'color-theme)
(defun color-theme-eshell ()
  (interactive)
  (color-theme-install
   '(color-theme-eshell
     nil
     (eshell-ls-archive-face ((t (:bold t :foreground "indianred1"))))
     (eshell-ls-backup-face ((t (:foreground "indianred3"))))
     (eshell-ls-clutter-face ((t (:foreground "DimGray"))))
     (eshell-ls-directory-face ((t (:bold t :foreground "seagreen3"))))
     (eshell-ls-executable-face ((t (:foreground "Coral"))))
     (eshell-ls-missing-face ((t (:foreground "black"))))
     (eshell-ls-picture-face ((t (:foreground "Violet")))) ; non-standard face
     (eshell-ls-product-face ((t (:foreground "LightSalmon"))))
     (eshell-ls-readonly-face ((t (:foreground "Aquamarine"))))
     (eshell-ls-special-face ((t (:foreground "Gold"))))
     (eshell-ls-symlink-face ((t (:foreground "White"))))
     (eshell-ls-text-face ((t (:foreground "medium aquamarine")))) ; non-standard face
     (eshell-ls-todo-face ((t (:bold t :foreground "aquamarine")))) ; non-standard face
     (eshell-ls-unreadable-face ((t (:foreground "DimGray"))))
     (eshell-prompt-face ((t (:bold t :foreground "gold"))))
)))
(provide 'color-theme-eshell)

;; evernote
;(load "~/.emacs.d/evernote-mode.el")
;(require 'evernote-mode)
;(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; option
;(add-to-list 'load-path "<your load path>")
;(require 'evernote-mode)
;(global-set-key "\C-cec" 'evernote-create-note)
;(global-set-key "\C-ceo" 'evernote-open-note)
;(global-set-key "\C-ces" 'evernote-search-notes)
;(global-set-key "\C-ceS" 'evernote-do-saved-search)
;(global-set-key "\C-cew" 'evernote-write-note)
;(global-set-key "\C-cep" 'evernote-post-region)
;(global-set-key "\C-ceb" 'evernote-browser)

;; AucTex
(add-to-list 'load-path' "~/.emacs.d/")
(add-to-list 'load-path' "~/.emacs.d/auctex/")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
;; 多文件进行组织和管理
;; 通知所有的文件 master 文件总为 master.tex 文件
(setq-default TeX-master "master")
;; 加入 hook 自动换行，数学公式，reftex 和显示行号的功能
(mapc (lambda (mode)
      (add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
            'LaTeX-math-mode
            'turn-on-reftex
            'linum-mode))
;; 默认使用 xelatex 直接生成 pdf 文件，而不用每次用 ‘C-c C-t C-p’ 进行切换
;; 设置 ‘Tex-show-compilation’ 为 t，在另一个窗口显示编译信息，对于错误的排除很方便
;; 编译时默认直接保存文件，绑定补全符号到 TAB 键
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-engine 'xetex       ; use xelatex default
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))
;; AucTeX 预定义的 viewer
;; 对于 windows 平台而言，需要确保命令在 PATH 路径下，如果没有在 PATH 路径下，使用路径全名进行调。
(setq TeX-view-program-list
      '(("zathura" "zathura %o")
        ("Okular" "okular --unique %o")
        ("Evince" "evince %o")
        ("SumatraPDF" "SumatraPDF.exe %o")
	("Firefox" "firefox %o")))

;; emms
(add-to-list 'load-path "~/.emacs.d/emms/")
(require 'emms-setup)
(emms-standard)
(require 'emms-score)
(emms-score 1)
(require 'emms-i18n)
(require 'emms-history)
(emms-default-players)
;; 状态栏
(defun bigclean-emms-mode-line-playlist-current ()
    "Return a description of the current track."
      (let* ((track (emms-playlist-current-selected-track))
              (type (emms-track-type track))
               (title (emms-track-get track 'info-title)))
    (format "[ %s ]"
               (cond ((and title)
                       title)))))
(setq emms-mode-line-mode-line-function
      'bigclean-emms-mode-line-playlist-current)
(global-set-key (kbd "C-c e e") 'emms)
(global-set-key (kbd "C-c e s") 'emms-stop)
(global-set-key (kbd "C-c e p") 'emms-pause)
(global-set-key (kbd "C-c e f") 'emms-show)
;;; ### Emms Playlist ###
;;; --- EMMS 播放列表
;(lazy-unset-key
; '("s" "m" "u" "M-<" "M->")
;	emms-playlist-mode-map)                ;卸载按键
;(lazy-set-key
; '(
;   ("C-x C-s" . emms-playlist-save)             ;保存播放列表
;   ("C-y" . emms-playlist-mode-yank)            ;剪切
;   ("C-k" . emms-playlist-mode-kill-track)      ;删除当前TRACK
;   ("C-/" . emms-playlist-mode-undo)            ;撤销
;   ("." . emms-playlist-mode-first)             ;浏览最上面一行
;   ("," . emms-playlist-mode-last)              ;浏览最下面一行
;   ("C-j" . emms-playlist-mode-insert-newline)  ;新建一行
;   ("M-n" . emms-playlist-mode-next)            ;下一个播放列表
;   ("M-p" . emms-playlist-mode-previous)        ;上一个播放列表
;   ("d" . emms-playlist-mode-kill-entire-track) ;从播放列表中移除当前TRACK
;   ("C" . emms-playlist-mode-clear)             ;清空当前的播放列表
;   ("f" . emms-playlist-mode-play-smart)        ;播放当前TRACK
;   ("b" . emms-playlist-set-playlist-buffer)    ;设定当前播放列表BUFFER
;   ("n" . emms-next)                            ;播放下一首
;   ("p" . emms-previous)                        ;播放上一首
;   ("r" . emms-random)                          ;随机播放下一首
;   (">" . emms-seek-forward)                    ;前进
;   ("<" . emms-seek-backward)                   ;后退
;   ("X" . emms-pause)                           ;暂停
;   ("T" . emms-stop)                            ;停止
;   ("Z" . emms-show)                            ;显示播放信息
;   ("q" . emms-playlist-mode-bury-buffer)       ;退出
;   ("?" . describe-mode)                        ;帮助
;   ("g" . emms-playlist-mode-center-current)    ;跳转到当前播放TRACK
;   ("D" . emms-delete-file-from-disk)           ;丛磁盘删除当前的文件
;   (";" . emms-tag-editor-edit-marked-tracks)   ;编辑标记的TAG
;   ("H" . emms-last-mark-track)                 ;最后一个标记
;   ("L" . emms-first-mark-track)                ;第一个标记
;   ("N" . emms-next-mark-track)                 ;下一个标记
;   ("P" . emms-prev-mark-track)                 ;上一个标记
;   )
; emms-playlist-mode-map
; )

;; w3m
;(add-to-list 'load-path' "~/.emacs.d/emacs-w3m/")
;(setq w3m-coding-system 'utf-8
;          w3m-file-coding-system 'utf-8
;          w3m-file-name-coding-system 'utf-8
;          w3m-input-coding-system 'utf-8
;          w3m-output-coding-system 'utf-8
;          w3m-terminal-coding-system 'utf-8)
;(setq w3m-display-inline-image t)
;(setq w3m-tab-width 8)
;(setq w3m-home-page "http://127.0.0.1/wiki")
;;使用工具包
;(setq w3m-use-toolbar t)
;(setq browse-url-generic-program "w3m")

;; calendar
(require 'calendar)
(setq calendar-latitude +30.15)
(setq calendar-longitude +120.10)
(setq calendar-location-name "Shanghai, China")
;; 设置颜色显示                         
(setq calendar-load-hook  
      '(lambda ()  
         (set-face-foreground 'diary-face   "skyblue")  
         (set-face-background 'holiday-face "slate blue")  
         (set-face-foreground 'holiday-face "white")))
;; display chinese holidays
(setq calendar-chinese-all-holidays-flag t)
;; by default show all holidays
(setq calendar-mark-holidays-flag t)
;; 设置阴历显示，在 calendar 上用 pC 显示阴历
(setq chinese-calendar-celestial-stem
      ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
      ["子" "丑" "寅" "卯" "辰" "巳" "戊" "未" "申" "酉" "戌" "亥"])
;; 设置 calendar 的显示
(setq calendar-remove-frame-by-deleting t)
(setq calendar-week-start-day 1)            ; 设置星期一为每周的第一天
(setq mark-diary-entries-in-calendar t)     ; 标记calendar上有diary的日期
(setq mark-holidays-in-calendar t)   ; 为了突出有diary的日期，calendar上不标记节日
(setq view-calendar-holidays-initially t) ; 打开calendar的时候不显示一堆节日

;; 也许有的事情没有那么重要，写不成todo的，这个时候就用 appointment 。
;; 约会提醒，用appt-add命令就可以加入新的约会提醒，用 M-x appt-delete命令删掉提醒好了。
(setq appt-issue-message t)

;; 也许有的事情没有那么重要，写不成todo的，这个时候就用 appointment 。
;; 约会提醒，用appt-add命令就可以加入新的约会提醒，用 M-x appt-delete命令删掉提醒好了。
(setq appt-issue-message t)
;; 在每次启动的时候，自动按照diary中的记录进行提醒
;; Monday
;;   9:30am Coffee break
;;   12:00pm Lunch
(appt-activate 1)
;; Diary-mode
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)
(setq todo-file-do "~/Dropbox/think world/todo-do")
(setq todo-file-done "~/Dropbox/think world/todo-done")
(setq todo-file-top "~/Dropbox/think world/todo-top")
(setq diary-file "~/Dropbox/think world/diary")
(setq diary-mail-addr "mudand88@gmail.com")
(add-hook 'diary-hook 'appt-make-list)

;;临时记号  
;;类似 vi 那样的 ma, mb, 'a, 'bnn
(global-set-key "\C-cp" 'ska-point-to-register)  
(global-set-key "\C-cn" 'ska-jump-to-register)  
(defun ska-point-to-register()
  (interactive)  
  (setq zmacs-region-stays t)  
  (point-to-register 8))  
(defun ska-jump-to-register()  
  (interactive)  
  (setq zmacs-region-stays t)  
  (let ((tmp (point-marker)))  
    (jump-to-register 8)  
    (set-register 8 tmp))) 

(global-set-key (kbd "<f1>") 'deft)
;; calendar
(global-set-key (kbd "C-c C-d") 'calendar)
;; align regexp 对齐选定文本
;; (global-set-key (kbd "<f1>") 'align-regexp)
;; 逐个询问式查找替换
(global-set-key (kbd "<f2>") 'query-replace)
;; rect-mark.el 直观矩形操作
(global-set-key (kbd "<f3>") 'rm-exchange-point-and-mark)
;; 无条件替换指定文字
(global-set-key (kbd "<f4>") 'replace-regexp)
;; 跳至指定行数
(global-set-key (kbd "<f5>")  'goto-line)
;; Linum mode
;(global-set-key (kbd "<f7>")  'linum-mode)
;(put 'upcase-region 'disabled nil)
;; 注销 C-SPC,在输入法无法使用的时候可用
;(global-set-key (kbd "C-SPC") 'nil)
;; 既然 emacs 默认 C-c C-c 为对源代码选区进行注释，那么就用我们就用 C-c C-v 进行反注释
;;(global-set-key "\C-c\C-v" 'uncomment-region)
