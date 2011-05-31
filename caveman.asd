#|
  This file is a part of Caveman package.
  URL: http://github.com/fukamachi/caveman
  Copyright (c) 2011 Eitarow Fukamachi <e.arrows@gmail.com>

  Caveman is freely distributable under the LLGPL License.
|#

(in-package :cl-user)
(defpackage caveman-asd
  (:use :cl :asdf))
(in-package :caveman-asd)

(defsystem caveman
  :version "0.1-SNAPSHOT"
  :author "Eitarow Fukamachi"
  :license "LLGPL"
  :depends-on (:clack
               :cl-annot
               :cl-ppcre
               :cl-syntax
               :cl-syntax-annot
               :clsql
               :cl-fad)
  :components ((:module "src"
                :components
                ((:file "caveman" :depends-on ("route" "context" "view"))
                 ;; FIXME: removed dependence on skeleton, slurp-file.
                 (:file "app" :depends-on ("request" "context" "middleware/context" "config"))
                 (:file "request")
                 (:file "response")
                 (:file "config" :depends-on ("skeleton"))
                 (:file "context" :depends-on ("request" "response"))
                 (:file "middleware/context" :depends-on ("context"))
                 (:file "skeleton")
                 (:file "route" :depends-on ("app"))
                 (:file "view"))))
  :description "Web Application Framework for Common Lisp"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :direction :input)
      (let ((seq (make-array (file-length stream)
                             :element-type 'character
                             :fill-pointer t)))
        (setf (fill-pointer seq) (read-sequence seq stream))
        seq)))
