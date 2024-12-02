(in-package :advent/day1)

(defun collect ()
  (let ((file (uiop:read-file-lines "./day1-input.txt")))
    (nlet iter ((lines file) (left nil) (right nil))
      (ematch lines
        ((cons (trivia.ppcre:ppcre "^(\\d+)\\s+(\\d+)$" (and ln (type string)) (and rn (type string)))
               rest)
         (iter rest
           (cons (parse-integer ln) left)
           (cons (parse-integer rn) right)))
        (nil (list left right))))))

(defun part1 ()
  (ematch (collect)
    ((list left right)
     (diff left right))))

(defun diff (left right)
  (reduce #'+ (mapcar (lambda (l r) (abs (- l r)))
                      (sort left #'<)
                      (sort right #'<))
          :initial-value 0))

(defun part2 ()
  (ematch (collect)
    ((list left right)
     (dist left right))))

(defun dist (left right)
  (let ((hash (make-hash-table)))

    (nlet iter ((right right))
      (match right
        ((cons rn rest)
         (if (gethash rn hash)
             (incf (gethash rn hash))
             (setf (gethash rn hash) 1))
         (iter rest))
        (nil)))

    (reduce #'+
            (mapcar (lambda (ln)
                      (* ln (gethash ln hash 0)))
                    left)
            :initial-value 0)))
