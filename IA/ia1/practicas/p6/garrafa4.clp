;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;    fichero: garrafa3.clp
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
;;;     Esta version hace busqueda en anchura. Muestra todas las 
;;;     soluciones hasta cierto nivel de profundidad mostrando el 
;;;     camino.
;;;
;;;     Para ejecutarlo load, reset y run.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;*******************************
;*         PLANTILLAS          *
;*******************************
;----------------------------------------------------------------
; la cantidad de agua en la garrafa
;
(deftemplate estado
    (slot jarra3
      		(type INTEGER)
      		(default 0))
    (slot jarra4
      		(type INTEGER)
      		(default 0))
	(slot profundidad          ; Profundidad del nodo en el arbol
		   (type INTEGER)
		   (default 0)
           (range 0 ?VARIABLE))
    (slot nodo
           (type INTEGER)
           (default 0))        ; Numero de nodo en el arbol
    (slot padre                ; Nodo padre
      (type FACT-ADDRESS SYMBOL) 
      (allowed-symbols no-padre))
    (slot operacion            ; Descripcion del movimiento
      (type STRING)))
;******************************
;*      ESTADO INICIAL        *
;******************************     
;----------------------------------------------------------------
; El estado inicial
(defrule Estado-Inicial
  ?inicial <- (initial-fact)
 =>
  (printout t "El estado inicial es la garrafa vacia" crlf)
  (printout t crlf
	    "El maximo nivel de profundidad es:->" crlf)
  (assert (maxima-profundidad 100))
  (assert (profundidad 0 0))       ;0 profundidad  0 nodos
  (assert (estado  (jarra3 0) (jarra4 0) (profundidad 0) (padre no-padre)
          (operacion "No movimiento")))
  (assert (nodos 1)))

;******************************
;*  BUSQUEDA EN PROFUNDIDAD   *
;******************************  
;----------------------------------------------------------------
;  Regla para Increntar la cuenta de nodos
;  LLevamos la cuenta de nodos en profundidad y en nodos, de forma
;  que si no se crean nuevos nodos al aplicar los operadores
;  a los nodos del nivel de profundidad en curso pararemos la 
;  busqueda
(defrule Incrementa-cuenta-nodos
    (declare (salience 1100))
    ?estado <- (estado (nodo ?estadoNodo))
    ?nodos <- (nodos ?cuentaNodos)
    (test (= ?estadoNodo 0))
 =>
    (assert (nodos (+ 1 ?cuentaNodos)))
    (modify ?estado (nodo ?cuentaNodos))
    (retract ?nodos))
;----------------------------------------------------------------
;  Regla para actualizar la profundidad
;  Llamada solo si se han expandido todos los nodos de un nivel 
;    (Por lo tanto prioridad mas baja)
;
(defrule actualiza-profundidad
	(declare (salience 100))
	?profundidad <- (profundidad ?nivel ?numNodosViejo)
	(nodos ?nodos)
	(test (> ?nodos ?numNodosViejo))
=>
	(retract ?profundidad)
	(assert (profundidad (+ 1 ?nivel) ?nodos)))
;******************************
;*        ESTADO FINAL        *
;******************************
;----------------------------------------------------------------
; Regla para detectar tarea realizada, es decir la jarra4 tiene 
; 2 litros. Tiene la prioridad mas alta para que cuando sea 
; reconocida sea la que se ejecute.
;
(defrule Hecho
	(declare (salience 1000))
	?estado <- (estado 
			(jarra4 2))
=>
	(assert (completa ?estado))
	(assert (lista "Hecho")))
;**************************************
;* FIN BUSQUEDA E IMPRESION SOLUCION  *
;**************************************
;----------------------------------------------------------------
; Regla para construir el camino una vez encontrada una solucion
;
(defrule Completa
    (declare (salience 2000))
    ?estado  <- (estado (padre ?padre) (operacion ?movimiento))
    ?completa <- (completa ?estado)
    ?lista-vieja <- (lista $?resto)
=>
    (assert (lista ?movimiento ?resto))
    (assert (completa ?padre))
    (retract ?completa)
    (retract ?lista-vieja))
;----------------------------------------------------------------
; Regla para imprimir la solucion
;
(defrule Camino-Completado
    (declare (salience 2000))
    ?completa <- (completa no-padre)
    ?lista-vieja <- (lista ?primero $?movimientos ?ultimo)
=>
    (printout t "Solucion:" crlf ?movimientos crlf)
    (printout t "- Solucion:" crlf)
    (progn$ (?m ?movimientos) (printout t ?m crlf))
    (retract ?completa ?lista-vieja))
;----------------------------------------------------------------
; Regla para acabar cuando se alcanze cierto nivel de profundidad
;
(defrule alcanza-maxima-profundidad
    (declare (salience 1000))
    (profundidad ?nivel ?)
    (maxima-profundidad =(+ 1 ?nivel))
 =>
    (printout t crlf "Sobrepasado el nivel de profundidad ", ?nivel "." crlf)
    (halt))
;----------------------------------------------------------------
; Regla para acabar cuando no se agnaden mas nodos
;
(defrule FIN
    (declare (salience 100))
    ?profundidad <- (profundidad ?nivel ?numNodosViejos)
    (nodos ?numNodos)
    (test (= ?numNodos ?numNodosViejos))
=>
    (printout t "Un total de " (- ?numNodos 1) " nodos en el arbol" crlf)
    (retract ?profundidad)
    (halt))   

;--------------------------------------------------------------------
(defrule camino-circular
  (declare (salience 2000))
  (estado (profundidad ?p1) (jarra3 ?cantidad3)
			    (jarra4 ?cantidad4))
  ?nodo <- (estado (profundidad ?p2&:(< ?p1 ?p2))
		   (jarra3 ?cantidad3)
		   (jarra4 ?cantidad4))
  =>
    (retract ?nodo))
;----------------------------------------------------------------
;******************************
;*         OPERADORES         *
;******************************

; Regla para llenar la garrafa de 3 litros (jarra3)
(defrule llena-tres
	(declare (salience 500))
	?estado <- (estado 
			    (jarra3 ?cantidad3)
                            (jarra4 ?cantidad4)
			    (profundidad ?profundidad))
	(profundidad ?nivel ?)
	(test (= ?profundidad ?nivel))
	(test (< ?cantidad3 3))
=>
	(assert (estado (jarra3 3)
                        (jarra4 ?cantidad4)
			        (profundidad (+ ?profundidad 1))
			        (padre ?estado)
			        (operacion "Llena-tres")))
	)

;----------------------------------------------------------------
; Regla para llenar la garrafa de 4 litros (jarra4)
(defrule llena-cuatro
	(declare (salience 500))
	?estado <- (estado 
			    (jarra4 ?cantidad4)
                            (jarra3 ?cantidad3)
			    (profundidad ?profundidad))
	(profundidad ?nivel ?)
	(test (= ?profundidad ?nivel))
	(test (< ?cantidad4 4))
=>
	(assert (estado (jarra4 4)
                        (jarra3 ?cantidad3)
			        (profundidad (+ ?profundidad 1))
			        (padre ?estado)
			        (operacion "Llena-cuatro")))
	)
;----------------------------------------------------------------
; Regla para vaciar la garrafa de 4 litros (jarra4)
(defrule vacia-cuatro
	(declare (salience 500))
	?estado <- (estado 
			    (jarra4 ?cantidad4)
                            (jarra3 ?cantidad3)
			    (profundidad ?profundidad))
	(profundidad ?nivel ?)
	(test (= ?profundidad ?nivel))
	(test (> ?cantidad4 0))
=>
	(assert (estado (jarra4 0)
                        (jarra3 ?cantidad3)
			        (profundidad (+ ?profundidad 1))
			        (padre ?estado)
			        (operacion "Vacia-cuatro")))
	)
;----------------------------------------------------------------
; Regla para vaciar la garrafa de 3 litros (jarra3)
(defrule vacia-tres
	(declare (salience 500))
	?estado <- (estado 
			    (jarra3 ?cantidad3)
                            (jarra4 ?cantidad4)
			    (profundidad ?profundidad))
	(profundidad ?nivel ?)
	(test (= ?profundidad ?nivel))
	(test (> ?cantidad3 0))
=>
	(assert (estado (jarra3 0)
                        (jarra4 ?cantidad4)
			        (profundidad (+ ?profundidad 1))
			        (padre ?estado)
			        (operacion "Vacia-tres")))
	)

;----------------------------------------------------------------
; Regla para echar la garrafa de 3 litros en la de 4 litros
(defrule echa-la-tres-a-la-cuatro
	(declare (salience 500))
	?estado <- (estado 
			    (jarra3 ?cantidad3)
			    (jarra4 ?cantidad4)
			    (profundidad ?profundidad))
	(profundidad ?nivel ?)
	(test (= ?profundidad ?nivel))
	(test (> ?cantidad3 0))  ; algo en jarra3 que echar a la jarra4
        (test (< ?cantidad4 4)) ; jarra4 no esta llena
=>
        (if (> (+ ?cantidad3 ?cantidad4) 4) then
                           (bind ?se-echa (- 4 ?cantidad4))
                           else (bind ?se-echa ?cantidad3)) 
	(assert (estado (jarra3 (- ?cantidad3 ?se-echa))
                        (jarra4 (+ ?cantidad4 ?se-echa))
			        (profundidad (+ ?profundidad 1))
			        (padre ?estado)
			        (operacion "Echa la tres a la cuatro")))
	)
;----------------------------------------------------------------
; Regla para echar la garrafa de 4 litros en la de 3 litros
(defrule echa-la-cuatro-a-la-tres
	(declare (salience 500))
	?estado <- (estado 
			    (jarra3 ?cantidad3)
			    (jarra4 ?cantidad4)
			    (profundidad ?profundidad))
	(profundidad ?nivel ?)
	(test (= ?profundidad ?nivel))
	(test (> ?cantidad4 0))  ; algo en jarra4 que echar a la jarra3
        (test (< ?cantidad3 3)) ; jarra3 no esta llena
=>
        (if (> (+ ?cantidad3 ?cantidad4) 3) then
                           (bind ?se-echa (- 3 ?cantidad3))
                           else (bind ?se-echa ?cantidad4)) 
	(assert (estado (jarra4 (- ?cantidad4 ?se-echa))
                        (jarra3 (+ ?cantidad3 ?se-echa))
			        (profundidad (+ ?profundidad 1))
			        (padre ?estado)
			        (operacion "Echa la cuatro a la tres")))
	)
;----------------------------------------------------------------