;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;    fichero: garrafa2.clp
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
;;;     Esta segunda version hace busqueda en anchura, pero no
;;;      muestra el camino encontrado.
;;;
;;;     Para ejecutarlo load, reset y run.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------------------------------------
; la cantidad de agua en la garrafa
;
(deftemplate estado
    (slot garrafa 
      		(type INTEGER)
      		(default 0))
	(slot profundidad          ; Profundidad del nodo en el arbol
		   (type INTEGER)
		   (default 0)
           (range 0 ?VARIABLE)))
      
;----------------------------------------------------------------
; El estado inicial
(defrule Estado-Inicial
  ?inicial <- (initial-fact)
 =>
  (printout t "El estado inicial es la garrafa vacia" crlf)
  (assert (profundidad 0))
  (assert (estado  (garrafa 0) (profundidad 0))))
;---------------------------------------------------------------- ;
; Regla para agnadir un litro a la garrafa 
(defrule Agnade-Un-Litro
	(declare (salience 500))
	?estado <- (estado 
			    (garrafa ?cantidad)
			    (profundidad ?profundidad))
	(profundidad ?nivel)
	(test (= ?profundidad ?nivel))
=>
	(printout t "Agnadiendo 1 litro a " ?cantidad " para llegar a "
             (+ 1 ?cantidad) " litros" crlf)
	(assert (estado (garrafa (+ ?cantidad 1))
			        (profundidad (+ ?profundidad 1))))
	)

;----------------------------------------------------------------
; Regla para agnadir dos litros a la garrafa
;
(defrule Agnade-Dos-Litros 
	(declare (salience 500))
	?estado <- (estado 
			(garrafa ?cantidad)
			(profundidad ?profundidad))
	(profundidad ?nivel)
	(test (= ?profundidad ?nivel))
=>
	(printout t  "Agnadiendo 2 litros a " ?cantidad " para llegar a "
               (+ 2 ?cantidad) " litros" crlf)
	(assert (estado (garrafa (+ ?cantidad 2))
			(profundidad (+ ?profundidad 1))))
	)

;----------------------------------------------------------------
;  Regla para actualizar la profundidad
;   Llamada solo si se han expandido todos los nodos de un nivel 
;    (Por lo tanto prioridad mas baja)
;
(defrule actualiza-profundidad
	(declare (salience 100))
	?profundidad <- (profundidad ?nivel)
=>
	(retract ?profundidad)
	(assert (profundidad (+ 1 ?nivel)))
	)
;----------------------------------------------------------------
; Regla para detectar tarea realizada (es decir la garrafa tiene 3 litros)
; Tiene la prioridad mas alta para que cuando sea reconocida sea la que se ejecute.
;
(defrule Hecho
	(declare (salience 1000))
	?estado <- (estado 
			(garrafa 3))
=>
	(printout t "Hecho - La garrafa tiene tres litros" crlf)
	(retract ?estado))
