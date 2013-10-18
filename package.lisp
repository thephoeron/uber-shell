;;;; -*- Mode: Lisp; Syntax: Common Lisp; Package: UBER-SHELL; Base: 10 -*- file: package.lisp

(in-package :cl-user)

(defpackage #:uber-shell
  (:nicknames #:u-sh)
  (:use #:cl #:cl-fad)
  (:import-from :uber-shell-asd #:*uber-shell-version*)
  (:export #:cmd))

(defpackage #:uber-shell-user
  (:nicknames #:user #:|$|)
  (:use #:cl #:uber-shell)
  (:export #:pwd
  		     #:ls
  		     #:ps))

(defpackage #:uber-shell-root
  (:nicknames #:root #:sudo)
  (:use #:cl #:uber-shell)
  (:export #:ls))