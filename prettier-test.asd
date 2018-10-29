#|
  This file is a part of prettier project.
|#

(defsystem "prettier-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("prettier"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "prettier"))))
  :description "Test system for prettier"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
