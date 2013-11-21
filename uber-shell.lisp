;;;; -*- Mode: Lisp; Syntax: Common Lisp; Package: UBER-SHELL; Base: 10 -*- file: uber-shell.lisp

;;; Top-level UBER-SHELL package
(in-package #:uber-shell)
;; customize prompt and install to REPL
(defun custom-prompt ()
  "If running SBCL and not linedit on darwin or unix/linux, installs the custom UBER-SHELL prompt to the REPL."
  #+(and sbcl (or darwin unix) (not linedit))
  (setf sb-int:*repl-prompt-fun*
        (lambda (stream)
          (format stream "~%~C[31m#[~A::~A]>~C[0m " #\Escape (lisp-implementation-type) (or (first (package-nicknames *package*))(package-name *package*)) #\Escape))))
(custom-prompt)
  
;; default cmd function
(defun cmd (name &rest rest)
  "The default CMD function"
  #+(and sbcl (or darwin unix))
  (sb-ext:run-program name rest :search t :input t :output t))

;;; UBER-SHELL-USER package
(in-package #:uber-shell-user)

(defun cd (path)
  (setf *default-pathname-defaults* path)
  #+(and sbcl (or unix linux darwin)) (sb-posix:chdir (truename path)))

(defmacro pwd (&rest args)
  `(uber-shell:cmd "pwd" ,@args))

(defmacro ls (&rest args)
  `(uber-shell:cmd "ls" ,@args))

(defmacro ps (&rest args)
  `(uber-shell:cmd "ps" ,@args))

;;; UBER-SHELL-ROOT package
(in-package #:uber-shell-root)

(defmacro ls (&rest args)
  `(uber-shell:cmd "sudo" "ls" ,@args))

;; EOF
