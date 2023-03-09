
(deffunction check_input (?question $?allowed_values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer ?allowed_values)) do
      (printout t crlf "Некорректный ввод данных, повторите попытку." crlf)
      (printout t crlf ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
    ?answer
)

(defglobal ?*answer* = nil)

; ВЫВОД ОТВЕТА

(defrule output_answer
    (declare (salience -10))
    =>
    (printout t crlf "Это " ?*answer* "!" crlf)
)

; ЛОГИКА ПРОГРАММЫ

(defrule question-1
    (declare (salience 40))
    =>
    (switch (check_input "Гитара бас-гитара (1) или электрогитара (2)? " 1 2)
        (case 1 then (assert (guitar_type_first)))
        (case 2 then (assert (guitar_type_second)))
    )
)

(defrule question-2
    (declare (salience 30))
    (guitar_type_first)
    =>
    (switch (check_input "Бас-гитара ладовая (1) / безладовая (2) / полуакустическая (3)? " 1 2 3)
        (case 1 then (bind ?*answer* Ibanez GSR200-TR))
        (case 2 then (bind ?*answer* Fender SQ VM Jazz Bass Fretless))
        (case 3 then (bind ?*answer* WARWICK ALIEN 6 NT FL))
    )
)

(defrule question-3
    (declare (salience 30))
    (guitar_type_second)
    =>
    (switch (check_input "Сколько звукоснимателей до 2-х (1) или больше 2-х (2)? " 1 2)
        (case 1 then (assert (pickups_type up_to_2)))
        (case 2 then (assert (pickups_type more_than_2)))
    )
)

(defrule question-4
    (declare (salience 20))
    (guitar_type_second)
    (pickups_type up_to_2)
    =>
    (switch (check_input "Какая форма гитары Telecaster (1) или Les Paul (2)? " 1 2)
        (case 1 then (bind ?*answer* Fender NOVENTA TELE PF 2TSB))
        (case 2 then (bind ?*answer* CORT SUNSET TC WWB))
    )
)

(defrule question-5
    (declare (salience 20))
    (guitar_type_second)
    (pickups_type more_than_2)
    =>
    (switch (check_input "Floyd Rose есть (1) или нет (2)? " 1 2)
        (case 1 then (bind ?*answer* SCHECTER DEMON-7 FR ABSN))
        (case 2 then (bind ?*answer* CORT KX300-OPCB))
    )
)