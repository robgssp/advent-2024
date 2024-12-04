(defsystem "advent"
  :description "Advent 2024"
  :depends-on ("alexandria" "cl-ppcre" "trivia" "trivia.ppcre" "3d-math")
  :serial t
  :components ((:file "package")
               (:file "util")
               (:file "day1")
               (:file "day2")
               (:file "day3")
               (:file "day4")))
