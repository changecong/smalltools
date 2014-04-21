;;php-mode
(add-to-list 'load-path "~/.emacs-lisp")
(require 'php-mode)
(add-hook 'php-mode-user-hook 'turn-on-font-lock)

;;google c style
(add-to-list 'load-path (expand-file-name "/home/chenzc/.emacs.d/google-emacs"))
;;(require 'google-c-style)
;;(add-hook 'c-mode-common-hook 'google-set-c-style)
;;(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;(require 'cc-mode)
(require 'google-c-style)
(defun my-build-tab-stop-list (width)
  (let ((num-tab-stops (/ 80 width))
    (counter 1)
    (ls nil))
    (while (<= counter num-tab-stops)
      (setq ls (cons (* width counter) ls))
      (setq counter (1+ counter)))
    (set (make-local-variable 'tab-stop-list) (nreverse ls))))
(defun my-c-mode-common-hook ()
  (c-set-style "google")
  (setq tab-width 4) ;; change this to taste, this is what K&R uses <img src="http://zhanxw.com/blog/wp-includes/images/smilies/icon_smile.gif" alt=":)" class="wp-smiley"> 
  (my-build-tab-stop-list tab-width)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil) ;; force only spaces for indentation
  (local-set-key "\C-o" 'ff-get-other-file)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-intro c-lineup-arglist-intro-after-paren)
  )
;; google sytle is defined in above function
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-common-hook 'my-c-mode-common-hook)

;;auto header
(add-to-list 'load-path "/home/chenzc/.emacs.d/plugins")
(require 'auto-header)
;;set name
(setq header-full-name "Zhicong Chen")
;;set email address
(setq header-email-address "zhicong.chen@changecong.com")
;;set copyright
(setq header-copyright-notice "2014, Zhicong Chen")
;;set header fields
(setq header-field-list
      '(filename
        copyright
        version
        author
        created
        modified
        modified_by
        status
        description
))
;;field updated
(setq header-update-on-save
      '(filename
        modified
        counter
        copyright
))
;;; Call header-automatic-update upon writing files
;;(add-hook 'write-file-hooks 'header-automatic-update)

;;tab
;; (setq-default indent-tabs-mode  nil)  
;; (setq tab-width 4 c-basic-offset 4)  
;; (setq indent-tabs-mode nil)
;; (setq default-tab-width 4)
;; (setq tab-width 4)
;; (setq tab-stop-list ())
;; (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 
;; 44 48 52 56 60 64 68 72 76 80 84 88 92 96))

;;matlab
(add-to-list 'load-path "/home/chenzc/.emacs.d/matlab-emacs")  
(require 'matlab-load)  
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)  
(setq auto-mode-alist (cons '("//.m//'" . matlab-mode) auto-mode-alist))  
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)  

;;markdown
(add-to-list 'load-path "/home/chenzc/.emacs.d/markdown-emacs")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;w3m
(add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m")
(require 'w3m-load)
(require 'w3m-e21)
(provide 'w3m-e23)
(require 'mime-w3m)
(setq w3m-use-favicon nil)
(setq w3m-command-arguments '("-cookie" "-F"))
(setq w3m-use-cookies t)
(setq w3m-home-page "http://www.google.com")
(setq mm-text-html-renderer 'w3m)
(setq mm-inline-text-html-with-images t
      mm-w3m-safe-url-regexp nil)
(setq browse-url-browser-function 'w3m-browse-url) ;用w3m浏览网页

;;default browser
;(setq browse-url-generic-program (executable-find "google-chrome")) 
;(setq browse-url-browser-function 'browse-url-generic) 

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(matlab-shell-command "/usr/local/MATLAB/R2011a/bin/matlab"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; actex setup
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; latex compile
(setq TeX-output-view-style (quote (("^pdf$" "." "evince %o %(outpage)"))))

;; latex preview
(add-hook 'LaTeX-mode-hook
(lambda()
(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
(setq TeX-command-default "XeLaTeX")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gnus email settings
;; 存储设置
(setq gnus-startup-file "~/MyEmacs/Gnus/.newsrc")                  ;初始文件
(setq gnus-default-directory "~/MyEmacs/Gnus/")                    ;默认目录
(setq gnus-home-directory "~/MyEmacs/Gnus/")                       ;主目录
(setq gnus-dribble-directory "~/MyEmacs/Gnus/")                    ;恢复目录
(setq gnus-directory "~/MyEmacs/Gnus/News/")                       ;新闻组的存储目录
(setq gnus-article-save-directory "~/MyEmacs/Gnus/News/")          ;文章保存目录
(setq gnus-kill-files-directory "~/MyEmacs/Gnus/News/trash/")      ;文件删除目录
(setq gnus-agent-directory "~/MyEmacs/Gnus/News/agent/")           ;代理目录
(setq gnus-cache-directory "~/MyEmacs/Gnus/News/cache/")           ;缓存目录
(setq gnus-cache-active-file "~/MyEmacs/Gnus/News/cache/active")   ;缓存激活文件
(setq message-directory "~/MyEmacs/Gnus/Mail/")                    ;邮件的存储目录
(setq message-auto-save-directory "~/MyEmacs/Gnus/Mail/drafts")    ;自动保存的目录
(setq mail-source-directory "~/MyEmacs/Gnus/Mail/incoming")        ;邮件的源目录
(setq nnmail-message-id-cache-file "~/MyEmacs/Gnus/.nnmail-cache") ;nnmail的消息ID缓存
(setq nnml-newsgroups-file "~/MyEmacs/Gnus/Mail/newsgroup")        ;邮件新闻组解释文件
(setq nntp-marks-directory "~/MyEmacs/Gnus/News/marks")            ;nntp组存储目录
(setq mml-default-directory "~/.gnus/")                            ;附件的存储位置

(setq user-full-name "Zhicong Chen")   
(setq user-mail-address "zhicong.chen@changecong.com")   
  
(setq gnus-select-method  
      '(nnimap "gmail"  
	       (nnimap-address "imap.gmail.com")  
	       (nnimap-server-port 993)  
	       (nnimap-stream ssl)))  

(setq message-send-mail-function 'smtpmail-send-it  
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))  
      smtpmail-auth-credentials '(("smtp.gmail.com" 587  
				   "zhicong.chen@changecong.com" "changecong8861"))  
      smtpmail-default-smtp-server "smtp.gmail.com"  
      smtpmail-smtp-server "smtp.gmail.com"  
      smtpmail-smtp-service 587
      smtpmail-local-domain "changecong.com"
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")  

(setq message-confirm-send t) ; confirm before sendding
(setq gnus-inhibit-startup-message t)  ; no startup message
(setq gnus-newsgroup-maximum-articles 50) ; defaul number of articles

; window layout
(gnus-add-configuration
 '(article (horizontal 1.0
		       (summary 0.25 point)
		       (article 1.0))))
; '(article
;   (vertical 1.0
;             (summary .35 point)
;             (article 1.0))))   

;; 概要显示设置
(setq gnus-summary-gather-subject-limit 'fuzzy) ;聚集题目用模糊算法
(setq gnus-summary-line-format "%4P %U%R%z%O %{%5k%} %{%14&user-date;%}   %{%-20,20n%} %{%ua%} %B %(%I%-60,60s%)\n")
(defun gnus-user-format-function-a (header) ;用户的格式函数 `%ua'
  (let ((myself (concat "<zhicong.chen@changecong.com>"))
        (references (mail-header-references header))
        (message-id (mail-header-id header)))
    (if (or (and (stringp references)
                 (string-match myself references))
            (and (stringp message-id)
                 (string-match myself message-id)))
        "X" "│")))    

(setq gnus-user-date-format-alist             ;用户的格式列表 `user-date'
      '(((gnus-seconds-today) . "TD %H:%M")   ;当天
        (604800 . "W%w %H:%M")                ;七天之内
        ((gnus-seconds-month) . "%d %H:%M")   ;当月
        ((gnus-seconds-year) . "%m-%d %H:%M") ;今年
        (t . "%y-%m-%d %H:%M")))              ;其他
;; 线程的可视化外观, `%B'
(setq gnus-summary-same-subject "")
(setq gnus-sum-thread-tree-indent "    ")
(setq gnus-sum-thread-tree-single-indent "◎ ")
(setq gnus-sum-thread-tree-root "● ")
(setq gnus-sum-thread-tree-false-root "☆")
(setq gnus-sum-thread-tree-vertical "│")
(setq gnus-sum-thread-tree-leaf-with-other "├─► ")
(setq gnus-sum-thread-tree-single-leaf "╰─► ")
;; 时间显示
(add-hook 'gnus-article-prepare-hook 'gnus-article-date-local) ;将邮件的发出时间转换为本地时间
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)   ;跟踪组的时间轴
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)              ;新闻组分组         

;; 排序
(setq gnus-thread-sort-functions
      '(
        (not gnus-thread-sort-by-date)                               ;时间的逆序
        (not gnus-thread-sort-by-number)))                           ;跟踪的数量的逆序

(setq mm-text-html-renderer 'w3m)                     ;用W3M显示HTML格式的邮件
(setq mm-inline-large-images t)                       ;显示内置图片
(auto-image-file-mode)                                ;自动加载图片

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;org-mode
(global-set-key "\C-ca" 'org-agenda)
(setq org-agenda-files (list "~/MyOrg/task.org"))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq my-holidays
      '(
	(holiday-fixed  6  1 "Zhicong Chen's Birthday")
	(holiday-fixed 10 28 "Ge Ma's Birthday")
	))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;