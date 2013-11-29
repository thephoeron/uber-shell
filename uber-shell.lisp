;;;; -*- Mode: Lisp; Syntax: Common Lisp; Package: UBER-SHELL; Base: 10 -*- file: uber-shell.lisp

;;; Top-level UBER-SHELL package
(in-package #:uber-shell)

;; customize prompt and install to REPL
;; currently still conflicting with linedit -- I'm guessing that package doesn't
;; push its name to FEATURES
(defun custom-prompt ()
  "If running SBCL and not linedit on darwin or unix/linux, installs the custom UBER-SHELL prompt to the REPL."
  #+(and sbcl (or darwin unix) (not linedit))
  (setf sb-int:*repl-prompt-fun*
        (lambda (stream)
          (format stream "~%~C[31m#[~A::~A]>~C[0m " #\Escape (lisp-implementation-type) (or (first (package-nicknames *package*))(package-name *package*)) #\Escape))))
(custom-prompt)
  
;; default cmd function
(defun cmd (name &rest rest)
  "The default CMD function, wrapper around SB-EXT:RUN-PROGRAM"
  #+(and sbcl (or darwin unix))
  (sb-ext:run-program name rest :search t :input t :output t))

;;; UBER-SHELL-USER package
(in-package #:uber-shell-user)

(defun cd (path)
  "Change SBCL's present-working-directory to *path*."
  (setf *default-pathname-defaults* path)
  #+(and sbcl (or unix linux darwin)) (sb-posix:chdir (truename path)))

(defmacro pwd (&rest args)
  "Print SBCL's present-working-directory to `*STANDARD-OUTPUT*`."
  `(uber-shell:cmd "pwd" ,@args))

(defmacro ls (&rest args)
  "Print contents of SBCL's present-working-directory to `*STANDARD-OUTPUT*`."
  `(uber-shell:cmd "ls" ,@args))

(defmacro ps (&rest args)
  "Print running processes to `*STANDARD-OUTPUT*`."
  `(uber-shell:cmd "ps" ,@args))

;;; UBER-SHELL-ROOT package
(in-package #:uber-shell-root)

(defmacro ls (&rest args)
  "Run LS as superuser."
  `(uber-shell:cmd "sudo" "ls" ,@args))

;; EOF
