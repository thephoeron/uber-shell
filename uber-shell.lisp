;;;; -*- Mode: Lisp; Syntax: Common Lisp; Package: UBER-SHELL; Base: 10 -*- file: uber-shell.lisp

;;; Top-level UBER-SHELL package
(in-package #:uber-shell)

(defun cmd (name &rest rest)
  "The default CMD macro"
  #+(and sbcl (or darwin unix))
  (sb-ext:run-program name rest :search t :input t :output t))

;;; UBER-SHELL-USER package
(in-package #:uber-shell-user)

(defun cd (path)
  (setf *default-pathname-defaults* path)
  #+(and sbcl (or unix linux darwin)) (sb-posix:chdir (truename path)))

(defmacro pwd (&rest args)
  `(u-sh:cmd "pwd" ,@args))

(defmacro ls (&rest args)
  `(u-sh:cmd "ls" ,@args))

(defmacro ps (&rest args)
  `(u-sh:cmd "ps" ,@args))

;;; UBER-SHELL-ROOT package
(in-package #:uber-shell-root)

(defmacro ls (&rest args)
  `(u-sh:cmd "sudo" "ls" ,@args))