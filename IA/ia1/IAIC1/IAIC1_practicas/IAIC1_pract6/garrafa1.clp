;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;    fichero: garrafa1.clp
;;;    idea:    Edward Blurock 
;;;    creado:  bagnares 22-XI-1996
;;; --  Problema de la garrafa --  Un clasico problema de busqueda.
;;;
;;;     El objetivo es resolver el problema de las garrafas, que
;;;     ha sido simplificado considerando que solo hay una garrafa
;;;     y que las operaciones posibles son agnadir un litro o 
;;;     agnadir dos litros. El estado inicial es la garrafa vacia,
;;;     y el objetivo es llenar la garrafa con tres litros.
;;;
;;;     Esta version es una primera aproximacion al problema.
;;;
;;;     Para ejecutarlo load, reset y run.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------------------------------------
; la cantidad de agua en la garrafa
;
(deftemplate estado
    	(slot garrafa
		(type INTEGER)
		(default 0)))
;----------------------------------------------------------------
;  El estado inicial
;;
(defrule Estado-Inicial	
	?inicial <- (initial-fact)
=>
	(printout t "El estado inicial es la garrafa vacia" crlf)
	(assert (estado (garrafa 0))))
;----------------------------------------------------------------
; Regla para agnadir un litro a la garrafa
;
(defrule Agnade-Un-Litro
	?estado <- (estado 
			(garrafa ?cantidad))
=>
	(printout t "Agnadiendo 1 litro a " ?cantidad " quedando "
             (+ 1 ?cantidad) " litros" crlf)
	(modify ?estado (garrafa (+ ?cantidad 1))))
;----------------------------------------------------------------
; Regla para agnadir dos litros a la garrafa
;
(defrule Agnade-Dos-Litros 
	?estado <- (estado 
			(garrafa ?cantidad))
=>
	(printout t "Agnadiendo 2 litros a " ?cantidad " quedando " 
             (+ 2 ?cantidad) " litros" crlf)
	(modify ?estado (garrafa (+ ?cantidad 2))))
;----------------------------------------------------------------
; Regla para detectar tarea realizada (Es decir la garrafa tiene 3 litros)
;
(defrule Hecho
	?estado <- (estado 
			(garrafa 3))
=>
	(printout t "Hecho - La garrafa tiene tres litros." crlf))
