(in-package :cl-user)
(defpackage :prettier.builder
  (:use :cl))
(in-package :prettier.builder)

(defstruct empty (nil))
(defmacro empty () (make-empty))

(defstruct text string length)
(defmacro text (string)
  `(make-text :string ,string :length ,(length string)))

(defstruct text-with-length string length)
(defmacro text-with-length (string length)
  `(make-text-with-length :string ,string :length ,length))

(defstruct line (flatten-to-space t))
(defmacro line () (make-line))

(defstruct line-break (flatten-to-space nil))
(defmacro line-break () (make-line-or-space))

(defmacro line-or-space () (group (line)))

;; todo
(defstruct concat a b)
(defun concat (doc-list)
  (let ((f #'(lambda (a b) (make-concat :a a :b b))))
    (fold-docs f doc-list)))

(defstruct nest indent doc)
(defmacro nest (indent doc)
  `(make-nest :indent ,indent :doc ,doc))


(defun bracket-by% (left right body indent ln)
  (concat (doc ) ...))

(defmacro bracket-by (left right body indent ln)
  `(bracket-by% ,left ,right ,body ,indent (line)))
(defmacro tight-bracket-by (left right body indent ln)
  `(bracket-by% ,left ,right ,body ,indent (line-break)))


(defmacro spaces (n)
  (if (plusp n)
      (make-text :string (make-string n :initial-element #\ ))
      (make-empty)))

;; group
(defmacro group (doc)
  `(multiple-value-bind (flattened changed) (flatten-bool)
    (let ((sep-group (group sep)))
      (if changed
          (union :a flattened :b ,doc)
          flattened))))

;; fill
;; todo

;; folddocs
;; === fold?
(defmacro folddocs (f ds)
  `(if (zerop (length ,ds))
       (empty)
       (if (eq (length ,ds) 1)
           (car ,ds)
           (funcall ,f (car ,ds) (folddocs ,f (cdr ,ds))))))

;; intercalate
(defun intercalate (sep ds)
  (iter
    (for doc in ds)
    (let ((spacer (if-first-time nil sep)))
      (appending (if spacer (list sep doc) (list doc))))))

;; lazy
;; todo
