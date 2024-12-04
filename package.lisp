(defpackage advent
  (:use :common-lisp)
  (:export :nlet))

(defpackage advent/day1
  (:use :common-lisp :alexandria-2 :trivia :advent))

(defpackage advent/day2
  (:use :common-lisp :alexandria-2 :trivia :advent))

(defpackage advent/day3
  (:use :common-lisp :alexandria-2 :trivia :advent))

(defpackage advent/day4
  (:use :common-lisp :alexandria-2 :trivia :advent
        :org.shirakumo.fraf.math))
