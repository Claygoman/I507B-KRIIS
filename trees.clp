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
	; (test (neq ?*answer* nil)) ; Debug -> Watch -> Globals -> ????
    =>
    (printout t crlf "Это " ?*answer* "!" crlf)
)

; ЛОГИКА ПРОГРАММЫ

(defrule question-1
    (declare (salience 40))
    =>
    (switch (check_input "Дерево лиственное (1) / хвойноe (2)? " 1 2)
        (case 1 then (assert (tree_leaves)))
        (case 2 then (assert (tree_needles)))
    )
)

(defrule question-2
    (declare (salience 30))
    (tree_leaves)
    =>
    (switch (check_input "Лист простой (3) / пальчатый(4)? " 3 4)
        (case 3 then (assert (leaf_simple)))
        (case 4 then (assert (leaf_finger)))
    )
)


(defrule question-3
    (declare (salience 30))
    (tree_needles)
    =>
    (switch (check_input "Хвоя игольчатая короткая (5) / игольчатая длинная (6) / чешуйчатая (7)? " 5 6 7)
        (case 5 then (bind ?*answer* ель))
        (case 6 then (bind ?*answer* сосна))
        (case 7 then (bind ?*answer* кипарис))
    )
)

(defrule question-4
    (declare (salience 20))
    (tree_leaves)
	(leaf_simple)
    =>
    (switch (check_input "Лист цельный(8) / не цельный (9)? " 8 9)
        (case 8 then (bind ?*answer* осина))
        (case 9 then (bind ?*answer* дуб))
    )
)

(defrule question-5
    (declare (salience 20))
    (tree_leaves)
	(leaf_finger)
    =>
    (switch (check_input "Лист рассеченный (10) / не рассеченный (11)? " 10 11)
        (case 10 then (bind ?*answer* конопля))
        (case 11 then (bind ?*answer* каштан))
    )
)