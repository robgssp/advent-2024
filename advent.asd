(defsystem "advent"
  :description "Advent 2024"
  :depends-on ("alexandria" "cl-ppcre" "trivia" "trivia.ppcre")
  :serial t
  :components ((:file "package")
               (:file "util")
               (:file "day1")
               (:file "day2")))
