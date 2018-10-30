#|
  This file is a part of prettier project.
|#

(defsystem "prettier"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (:iterate)
  :components ((:module "src"
                :components
                ((:file "prettier"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "prettier-test"))))
