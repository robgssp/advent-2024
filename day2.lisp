(in-package :advent/day2)

(defun collect ()
  (nlet iter ((file (uiop:read-file-lines "./day2-input.txt")) (reports nil))
    (ematch file
      ((cons line lines)
       (iter lines
         (cons (mapcar #'parse-integer
                       (uiop:split-string line))
               reports)))
      (nil (reverse reports)))))

(defun safe-p (report)
  (let ((diffs
          (butlast (maplist
                    (lambda-match
                      ((list* a b _)
                       (- a b)))
                    report))))
    (and (or (every (lambda (v) (> v 0)) diffs)
             (every (lambda (v) (< v 0)) diffs))
         (every (lambda (v)
                  (and (>= (abs v) 1)
                       (<= (abs v) 3)))
                diffs))))

(defun part1 ()
  (count-if #'safe-p (collect)))

(defun safe-step (l r sign)
  (let ((v (* sign (- r l))))
    (and (>= v 1) (<= v 3))))

(defun safeish-p (report sign skipped-p)
  ;; (format t "safeish-p ~a ~a ~a~%" report sign skipped-p)
  (ematch* (report skipped-p)
    (((guard (list l r _)
             (safe-step l r sign))
      nil)
     t)

    (((guard (list l r)
             (safe-step l r sign))
      _)
     t)

    (((guard (list* l r rest)
             (safe-step l r sign))
      skipped-p)
     (safeish-p (list* r rest)
                sign
                skipped-p))

    (((guard (list* l _ r rest)
             (safe-step l r sign))
      nil)
     (safeish-p (list* l r rest)
                sign
                t))

    ((_ _) nil)))

(defun safeish1-p (report)
  (or (safeish-p report 1 nil)
      (safeish-p report -1 nil)
      (safeish-p (cdr report) 1 t)
      (safeish-p (cdr report) -1 t)))

(defparameter +examples+
  '((7 6 4 2 1)
    (1 2 7 8 9)
    (9 7 6 2 1)
    (1 3 2 4 5)
    (8 6 4 4 1)
    (1 3 6 7 9)
    (1 10 11 12 13)
    (1 2 3 4 10)))

(defun part2 ()
  (count-if #'safeish1-p (collect)))
