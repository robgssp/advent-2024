(in-package :advent/day3)

(defun collect ()
  (uiop:read-file-string "./day3-input.txt"))

(defun muls (string)
  (let ((acc 0))
    (ppcre:do-register-groups ((#'parse-integer left)
                               (#'parse-integer right))
        ("mul\\((\\d+),(\\d+)\\)" string)
      (incf acc (* left right)))
    acc))

(defun part1 ()
  (muls (collect)))

(defun muls1 (string)
  (let ((acc 0)
        (enabled t))
    (ppcre:do-register-groups (nil
                               (#'parse-integer left)
                               (#'parse-integer right)
                               do
                               dont)
        ("(mul\\((\\d+),(\\d+)\\))|(do\\(\\))|(don't\\(\\))" string)
      (cond
        (do (setf enabled t))
        (dont (setf enabled nil))
        (t (when enabled (incf acc (* left right))))))
    acc))

(defun part2 ()
  (muls1 (collect)))
