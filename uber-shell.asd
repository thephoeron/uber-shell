;;;; -*- Mode: Lisp; Syntax: Common Lisp; Package: UBER-SHELL; Base: 10 -*- file: uber-shell.asd

(in-package :cl-user)

(require :asdf)

(defpackage uber-shell-asd
  (:nicknames #:u-sh-asd)
  (:use :cl :asdf)
  (:export #:cmd))

(in-package :uber-shell-asd)

(defvar *uber-shell-version* "0.0.1"
  "Uber-Shell's version number as a string.")

;; we export its name so we can import it later
(export '*uber-shell-version*)

(defsystem uber-shell
  :serial t
  :version #.*uber-shell-version*
  :description "Ultimate POSIX-Shell Integration for Steel Bank Common Lisp"
  :author "\"the Phoeron\" Colin J.E. Lupton <sysop@thephoeron.com>"
  :license "MIT"
  :depends-on (:cl-fad)
  :components ((:file "package")
               (:file "uber-shell")))

;; EOF
