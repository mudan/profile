;;; tab-display.el --- tab display code for managing tabs visually.

;; 用来以'<'字符标识出文件中的那些tab字符
;; (require 'tab-display)

;; Copyright (C) 1997-2000 Free Software Foundation, Inc.

;; Author: Kevin A. Burton (burton@openprivacy.org)
;; Maintainer: Kevin A. Burton (burton@openprivacy.org)
;; Location: http://relativity.yi.org
;; Keywords: tab, width, display
;; Version: 1.3.2

;; This file is [not yet] part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation; either version 2 of the License, or any later version.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
;; details.
;;
;; You should have received a copy of the GNU General Public License along with
;; this program; if not, write to the Free Software Foundation, Inc., 59 Temple
;; Place - Suite 330, Boston, MA 02111-1307, USA.

;;; Commentary:

;; This is an attempt to handle tab display in a way that makes things obvious
;; when working with buffers.  I personally don't like using hard \t chars in my
;; source files because of width differences.

;;; Install:
;;
;; You should turn font-lock-mode on globally in order to see your tabs in
;; color.

;;; History:
;;
;; Thu Oct 25 2001 11:53 PM (burton@openprivacy.org): changed the tab width to 8
;; which seems like this is more popular.
;;
;; Sun Jul 22 2001 03:43 AM (burton@relativity.yi.org): now keeping the menu
;; under tools.
;;
;; Sat Jan 13 18:14:31 2001 (burton): Version 1.3.1.  Fixed another small bug
;; with standard-display-table vs buffer-display-table.
;;
;; Wed Dec 27 12:48:27 2000 (burton): Version 1.3.0.  Was making a brand new
;; display table for every new buffer.  This was a bad idea because if the user
;; made any changes to standard-display-table tab-display killed this.  Now if
;; the buffer-display-table is null it gets the value of
;; standard-display-table.  This should have been the behavior all along.  For
;; example, some gnus e-mail needs escaping but tab-display will kill this.
;;
;; Mon Dec 25 13:38:18 2000 (burton): Created version 1.2.0.  Using
;; font-lock-mode as the hook used to turn on tab-display (since it requires its
;; use).  No messages when tab-display-mode is on.  -on and -off functions
;; renamed. 
;;
;; 1.1.0: Turned it (correctly) into a minor mode with a menu
;;
;; 1.0.0: init

;;; TODO:


(require 'easymenu)
(require 'font-lock)
(require 'disp-table)

;;; Code:
(defface tab-display-face '((t (:foreground "MediumBlue" :bold t)))
  "Face used to highlight the annotation lines to the left of the annotate buffer.")

(defvar tab-display-tab-width 8 "Tab width.  See `tab-width'.")
(make-variable-buffer-local 'tab-display-tab-width)

(defvar tab-display-mode-map (make-sparse-keymap) "Mode specific keymap for `section-mode'.")

(defvar tab-display-mode nil  "Non-nil means tab-display-mode local minor mode is enabled.")
(make-variable-buffer-local 'tab-display-mode)

(defvar tab-display-show nil "True if the user is currently showing their tabs.")
(make-variable-buffer-local 'tab-display-show)

(defvar tab-display-mode-string " Tabs" "String for the mode-line to indicate `tab-display-mode'.")

(defvar tab-display-mode-hook nil "Hook to run after tab-display is started.")

(defun tab-display-toggle-tab-width()
  "Toggle tab-width between four and eight chars"
  (interactive)
  
  (if (= tab-width 4)
      (setq tab-width 8)
    (setq tab-width 4))

  (if tab-display-show
      (tab-display-show))
 
  (message "tab-width is now %s" tab-width))

(defun tab-display-mode()
  (interactive)
  "Toggle using tab-display"

  (if tab-display-mode
      (tab-display-mode-off)
    (tab-display-mode-on)))

(defun tab-display-mode-on()
  "Turn ON tab-display"
  (interactive)

  (setq tab-display-mode t)
  (tab-display-show)
  
  (run-hooks 'tab-display-mode-hook))

(defun tab-display-mode-off()
  "Turn OFF tab-display"
  (interactive)

  (setq tab-display-mode nil)
  (tab-display-hide))

(defun tab-display-toggle()
  ;;toggle hiding/showing tabs
  (interactive)
  
  (if tab-display-show
      (tab-display-hide)
    (tab-display-show)))

(defun tab-display-show()
  ;;show tabs

  (setq tab-display-show t)
  
  ;;set the buffer-display-table to use the width of `tab-width'"
  
  ;;setup buffer display options...
  (if (null buffer-display-table)
      (setq buffer-display-table (copy-sequence standard-display-table)))
  
  (aset buffer-display-table ?\t (vconcat (make-string tab-width ?>))))

(defun tab-display-toggle-indent-tabs-mode()
  "Enable/disable the use of tabs."
  (interactive)
  
  (if indent-tabs-mode
      (progn
        (setq indent-tabs-mode nil)
        (message "Tabs: off"))
    (progn 
      (setq indent-tabs-mode t)
      (message "Tabs: on"))))

(defun tab-display-hide()
  ;;hide tabs...

  (message "Tabs will be hidden.")
  (setq tab-display-show nil)
  (aset buffer-display-table ?\t nil))

(defun tab-display-mode-hook()
  "Highlight tabs in font-lock-mode turning on tabs mode if necessary."

  (if (or (and (not (string-match "\\*" (buffer-name (current-buffer))))
               (not (equal major-mode 'dired-mode)))
          (or (equal major-mode 'gnus-article-mode)
              (equal major-mode 'message-mode)))
      (progn 

        (tab-display-mode-on)
        
        ;; color the TAB character

        (font-lock-add-keywords nil '(("\\(\t\\\)" 1 'tab-display-face t)))
        (font-lock-fontify-buffer))))
  
;;add it as a minor mode.
(add-to-list 'minor-mode-alist
             '(tab-display-mode tab-display-mode-string))

(let ((a (assoc 'tab-display-mode minor-mode-map-alist)))
  (if a
      (setcdr a tab-display-mode-map)
    (add-to-list 'minor-mode-map-alist
                 (cons 'tab-display-mode tab-display-mode-map))))

;;add the tab highlight code to font-lock
(add-hook 'font-lock-mode-hook 'tab-display-mode-hook)

(easy-menu-add-item 'menu-bar-tools-menu
                    nil
                    '("Tab Display"
                      ["Hide/show tabs" tab-display-toggle t]
                      ["Toggle tab width (4/8)" tab-display-toggle-tab-width t]
                      ["Toggle hard tabs use: \\t" tab-display-toggle-indent-tabs-mode t]))

(provide 'tab-display)

;;; tab-display.el ends here
