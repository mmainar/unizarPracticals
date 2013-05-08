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
    (slot garrafa 
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
  (assert (profundidad 0 0))       ;0 profundidad  0 nodos
  (assert (estado  (garrafa 0) (profundidad 0) (padre no-padre)
          (operacion "No moviento")))
  (assert (maxima-profundidad 6))
  (assert (nodos 1)))
;******************************
;*         OPERADORES         *
;******************************
;----------------------------------------------------------------
; Regla para agnadir un litro a la garrafa 
(defrule Agnade-Un-Litro
	(declare (salience 500))
	?estado <- (estado 
			    (garrafa ?cantidad)
			    (profundidad ?profundidad))
	(profundidad ?nivel ?)
	(test (= ?profundidad ?nivel))
	(test (< ?cantidad 3))
=>
	(assert (estado (garrafa (+ ?cantidad 1))
			        (profundidad (+ ?profundidad 1))
			        (padre ?estado)
			        (operacion "Agnade un litro")))
	)

;----------------------------------------------------------------
; Regla para agnadir dos litros a la garrafa
;
(defrule Agnade-Dos-Litros 
	(declare (salience 500))
	?estado <- (estado 
			(garrafa ?cantidad)
			(profundidad ?profundidad))
	(profundidad ?nivel ?)
	(test (= ?profundidad ?nivel))
	(test(< ?cantidad 3))
=>
	(assert (estado (garrafa (+ ?cantidad 2))
			(profundidad (+ ?profundidad 1))
			(padre ?estado)
			(operacion "Agnade dos litros")))
	)
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
; Regla para detectar tarea realizada, es decir la garrafa tiene 
; 3 litros. Tiene la prioridad mas alta para que cuando sea 
; reconocida sea la que se ejecute.
;
(defrule Hecho
	(declare (salience 1000))
	?estado <- (estado 
			(garrafa 3))
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
    ;(printout t "Solucion:" crlf ?movimientos crlf)
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
