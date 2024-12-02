(in-package :advent)

(defmacro nlet (name args &body body)
  `(labels ((,name ,(mapcar #'first args) ,@body))
     (,name ,@(mapcar #'second args))))
