(in-package :advent/day4)

(defun collect (&optional (lines (uiop:read-file-lines "./day4-input.txt")))
  (let ((arr (make-array (list (length lines)
                               (length (first lines)))
                         :element-type 'character
                         :initial-element #\Space)))
    (loop for line in lines
          for r from 0
          do (loop for char across line
                   for c from 0
                   do (setf (aref arr r c) char)))
    arr))

(defun varef (array ind)
  (apply #'aref array (loop for n across (varr ind)
                            collecting n)))

(defun (setf varef) (val array ind)
  (apply #'(setf aref) val array
         (loop for n across (varr ind)
               collecting n)))

(defun varray-in-bounds-p (array ind)
  (apply #'array-in-bounds-p array
         (loop for n across (varr ind)
               collecting n)))

(defun check-dir (crossword word start dir)
  ;; (format t "check-dir ~a ~a ~a~%" word start dir)
  (loop for c across word
        for ind = (ivec2 0 0) then (v+ ind dir)
        do (unless (and (varray-in-bounds-p crossword (v+ start ind))
                        (equal (varef crossword (v+ start ind)) c))
             (return nil))
        finally (return t)))

(defun check (crossword word start)
  (+ (if (check-dir crossword word start (ivec2 1 0)) 1 0)
     (if (check-dir crossword (reverse word) start (ivec2 1 0)) 1 0)
     (if (check-dir crossword word start (ivec2 0 1)) 1 0)
     (if (check-dir crossword (reverse word) start (ivec2 0 1)) 1 0)
     (if (check-dir crossword word start (ivec2 1 1)) 1 0)
     (if (check-dir crossword (reverse word) start (ivec2 1 1)) 1 0)
     (if (check-dir crossword word
                    (v+ start (ivec2 (1- (length word)) 0))
                    (ivec2 -1 1))
         1 0)
     (if (check-dir crossword (reverse word)
                    (v+ start (ivec2 (1- (length word)) 0))
                    (ivec2 -1 1))
         1 0)))

(defparameter +example+
  '(".XMAS"
    "SAMX."
    "XS..S"
    "MMA.A"
    "A.AMM"
    "S..SX"))

(defun part1 (crossword)
  (let-match* (((list r c) (array-dimensions crossword))
               (word "XMAS"))
    (loop
      for i from 0 to r
      sum (loop
            for j from 0 to c
            sum (progn
                  (check crossword word (ivec2 i j)))))))

(defun check-x (crossword word start)
  (flet ((either (offset step)
           (or (check-dir crossword word (v+ start offset) step)
               (check-dir crossword (reverse word)
                          (v+ start offset) step))))
    (and (either (ivec2 0 0) (ivec2 1 1))
         (either (ivec2 0 (1- (length word))) (ivec2 1 -1)))))

(defparameter +example2+
  '(".M.S......"
    "..A..MSMS."
    ".M.S.MAA.."
    "..A.ASMSM."
    ".M.S.M...."
    ".........."
    "SSMSS.S.S."
    ".AAA.A.A.."
    "MMMMM.M.M."
    ".........."))

(defun part2 (crossword)
  (let-match* (((list r c) (array-dimensions crossword))
               (word "MAS"))
    (loop
      for i from 0 to (- r 2)
      sum (loop
            for j from 0 to (- c 2)
            sum (if (check-x crossword word (ivec2 i j))
                    1 0)))))
