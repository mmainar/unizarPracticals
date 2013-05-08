;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;    idea:       Touretzky (1987)
;;;    creado:     prmuro 13-2-1991
;;;    modificado: prmuro, bagnares 6-11-95
;;;
;;;                      Misioneros y Canibales
;;;
;;;
;;; Un clasico problema de busqueda.
;;; Se ha programado por una parte el algoritmo generico
;;;  y por otra se han instanciado ciertas funciones para
;;;  el problema concreto de los misioneros.
;;; Las estructuras de datos permanecen ocultas para muchas de
;;;  las funciones.
;;;
;;;
;;; El juego se ejecuta llamando a la funcion: mc
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;
;;;


;;; Representacion del estado como una lista con 9 componentes:
;;;
(defconstant estado-inicial
  '(ribera-izq (m m m) (c c c) bote --rio-- nil nil nil ribera-der))

;;;Primitivas de acceso a la estructura de datos del estado
;;;
(defun misioneros-izq (estado) (nth 1 estado))
(defun misioneros-der (estado) (nth 7 estado))
(defun canibales-izq (estado) (nth 2 estado))
(defun canibales-der (estado) (nth 6 estado))
(defun bote-izq (estado) (nth 3 estado))
(defun bote-der (estado) (nth 5 estado))



;;; Variables utilizadas
;;;
(defvar el-nodo-inicial nil "Nodo que plantea la situacion inicial")
;; Lista ABIERTOS
(defvar nodos-a-expandir nil "Lista de estados a considerar")
;; Lista CERRADOS
(defvar nodos-expandidos nil "Lista de estados que ya han sido visitados una vez")
(setq nodos-expandidos nil)

;;; Representacion de un nodo como un simbolo con dos propiedades:
;;;   el estado y el nodo padre.
;;;
(defun crea-nodo (estado padre &optional (simbolo (gensym "NODO-")))
  (setf (get simbolo 'estado) estado)
  (setf (get simbolo 'padre) padre)
  simbolo)


;;;
;;;
;;; Esta funcion ejecuta la busqueda.
;;; Sigue el algoritmo generico visto en clase.
;;;
(defun mc ()
  (setq nodos-expandidos nil                          ;(1)
        el-nodo-inicial (crea-nodo estado-inicial nil 'nodo-inicial)
        nodos-a-expandir (list el-nodo-inicial)       ;(2)
        )
  (do* ((el-nodo (pop nodos-a-expandir) 
                 (if nodos-a-expandir 
                   (pop nodos-a-expandir)             ;(4)
                   (return (mensaje-de-error))))      ;(3)
        )
       ((objetivop el-nodo)                           ;(5)
        (escribe-solucion el-nodo)
        )
    (push el-nodo nodos-expandidos)
    (reorganizar-nodos-a-expandir                     ;(7)
     (expandir-nodo el-nodo))))                       ;(6)



;;;Mensaje de error si no es posible continuar la busqueda
;;;                                                   ;(3)
(defun mensaje-de-error ()
  (format t "~%~%ERROR!!!, no es posible seguir con el proceso de busqueda."))

                  
;;;                                                   ;(4)
;;; Cuando es alcanzado un estado para el que esta resuelto el problema, 
;;; ESCRIBE-SOLUCION devuelve el camino de la solucion.
;;; Una solucion es una secuencia de mundos generados por movimientos 
;;; legales que comienzan en el mundo inicial.
;;;
(defun escribe-solucion (solucion)
  (format t "~%~%Resuelto ! El camino de la solucion es: ")
  (escribe-un-camino solucion)
  'hecho)

(defun escribe-un-camino (nodo)
  (setf (estadisticas-busqueda-longitud-de-la-solucion *estadisticas*)
    (+ 1 (estadisticas-busqueda-longitud-de-la-solucion *estadisticas*)))
  (if (get nodo 'padre) (escribe-un-camino (get nodo 'padre)))
  (print (get nodo 'estado)))


;;;Test para encontrar el objetivo                    ;(5)
;;;
(defun objetivop (nodo)
  (let ((estado (get nodo 'estado)))
    (and (null (misioneros-izq estado))
         (null (canibales-izq estado)))))

;;;                                                   ;(6)
;;; Para cada estado del problema genera todos los siguientes movimientos 
;;; posibles y los aniade a la cola.
;;; Si el nuevo estado es no-NIL y no ha sido 
;;; alcanzado por ninguna secuencia previa de movimientos, el nuevo estado es 
;;; agnadido a la cola.
;;;
(defun expandir-nodo (nodo)
  (let* ((estado (get nodo 'estado))
         )
    (format t "~%--->~S" estado)
    (mapcan #'(lambda (x) 
                (let ((nuevo-estado (mueve x estado)))
                  (and nuevo-estado
                       (not (member nuevo-estado nodos-expandidos 
                                    :test #'equal 
                                    :key #'(lambda (y)
                                             (get y 'estado))))
                       (not (member nuevo-estado nodos-a-expandir 
                                    :test #'equal 
                                    :key #'(lambda (y)
                                             (get y 'estado))))
                       (progn (format t "~%Aniadiendo ~S" nuevo-estado)
                              (format t "~%de profundidad ~A" (+ 1 (get nodo 'profundidad)))
                              (setf (estadisticas-busqueda-maxima-profundidad *estadisticas*)
                                      (+ 1 (get nodo 'profundidad)))
                              (list (crea-nodo nuevo-estado nodo (+ 1 (get nodo 'profundidad))))))))
            '((m) (c) (m m) (c c) (m c)))))


;;; La funcion MUEVE toma algunas personas y un estado como entrada, y genera 
;;; un mundo en el que las personas se han movido a la ribera opuesta del rio.
;;; Si el requerimiento para un movimiento es ilegal, p.e., si no hay suficiente 
;;; gente del tipo adecuado en la ribera con el bote, o si el movimiento 
;;; propuesto dejaria mas canibales que misioneros en una de las orillas del 
;;; rio, entonces MUEVE devuelve NIL en lugar del estado sucesor.
;;; 
(defun mueve (personas estado)
  (block fuera-del-block
    (let* ((mi (misioneros-izq estado))   ;misioneros en la ribera izquierda
           (ci (canibales-izq estado))    ;canibales en la ribera izquierda
           (bi (bote-izq estado))         ;bote en la ribera izquierda
           (bd (bote-der estado))         ;bote en la ribera derecha
           (cd (canibales-der estado))    ;canibales en la ribera derecha
           (md (misioneros-der estado))  ;misioneros en la ribera derecha
           )

      (cond ((eq bi 'bote)                        ;el bote esta a la izquierda
             (dolist (persona personas)
               (when (eq persona 'm)
                 (if mi (push (pop mi) md) (return-from fuera-del-block nil)))
               (when (eq persona 'c)
                 (if ci (push (pop ci) cd) (return-from fuera-del-block nil))))
             )
            ((eq bd 'bote)                        ;el bote esta a la derecha
             (dolist (persona personas)
               (when (eq persona 'm)
                 (if md (push (pop md) mi) (return-from fuera-del-block nil)))
               (when (eq persona 'c)
                 (if cd (push (pop cd) ci) (return-from fuera-del-block nil))))
             ))

      (cond ((and mi (> (length ci) (length mi))) nil)  ;sobrenumero en la izq
            ((and md (> (length cd) (length md))) nil)  ;sobrenumero en la der
            (t (list 'ribera-izq mi ci bd '--rio-- bi cd md 'ribera-der))))))


;;; La funcion REORGANIZAR-LOS-NODOS-A-EXPANDIR       ;(7)
;;; trabaja con el metodo de busqueda en anchura.
;;; Agnade los nodos al final de la cola de nodos a expandir. 
;;;
(defun reorganizar-nodos-a-expandir (nodos)
  (and nodos
       (setq nodos-a-expandir (append nodos-a-expandir nodos))
       ))

;===========================================================================
;; A partir de aqui mio

;;;                                                   ;(6)
;;; Para cada estado del problema genera todos los siguientes movimientos 
;;; posibles y los aniade a la cola.
;;; Si el nuevo estado es no-NIL y no ha sido 
;;; alcanzado por ninguna secuencia previa de movimientos, el nuevo estado es 
;;; agnadido a la cola.
;;;
(defun expandir-estado (nodo)
    (format t "~%--->~S" estado)
    (mapcan #'(lambda (x) 
                (let ((nuevo-estado (mueve x estado)))
                  (and nuevo-estado
                       (not (member nuevo-estado nodos-expandidos 
                                    :test #'equal 
                                    :key #'(lambda (y)
                                             (get y 'estado))))
                       (not (member nuevo-estado nodos-a-expandir 
                                    :test #'equal 
                                    :key #'(lambda (y)
                                             (get y 'estado))))
                       (progn (format t "~%Aniadiendo ~S" nuevo-estado)
                              (list (crea-nodo nuevo-estado nodo))))))
      *operadores*))


;;; Lista de operadores

(defparameter *operadores* 
      '((m) (c) (m m) (c c) (m c)))

;;; Estado inicial
(defparameter *estado-inicial*
      '(ribera-izq (m m m) (c c c) bote --rio-- nil nil nil ribera-der))

;;;Test para encontrar el objetivo                    ;(5)
;;;
(defun estado-objetivop (estado)
    (and (null (misioneros-izq estado))
         (null (canibales-izq estado))))

;;; Funcion de bfs (Breadth-First-Search), busqueda en anchura
;;; con un limite de profundidad (maxProfundidad) y un limite
;;; de nodos (maxNodos)
;;;

(defun bfs (estado maxProfundidad maxNodos)
    (setq nodos-expandidos nil                          ;(1)
        el-nodo-inicial (crea-nodo estado nil profundidad-inicial 'nodo-inicial)
        nodos-a-expandir (list el-nodo-inicial)       ;(2)
        )
  (do* ;;; Bucle do*
       ;;; Inicializacion de parametros y su actualizacion de la forma:
       ;;; ((<parametro 1> <valor inicial 1> <forma de actualizacion 1>)
       ;;; ((<parametro 2> <valor inicial 2> <forma de actualizacion 2>)
       ((el-nodo (pop nodos-a-expandir)                  
                 (cond ((and nodos-a-expandir) (pop nodos-a-expandir))  ;(4)
                       ((> (length nodos-expandidos) maxNodos) (return (mensaje-max-nodos)))
                       ((> (+ 1 (get el-nodo 'profundidad)) maxProfundidad) (return (mensaje-max-prof)))
                       (t (return (mensaje-de-error)))))  ;(3)
        (prof-max 0 (setq *maxima-profundidad* (get el-nodo 'profundidad)))
        (nodos-cheq 0 (setq *nodos-chequeados* (+ 1 *nodos-chequeados*)))
       )
       ;; Test de salida del bucle en la forma:
       ;; (<test de terminacion> <formas intermedias, si las hay> <forma resultado>)
       ((objetivop el-nodo)                           ;(5)
        (escribe-solucion el-nodo)
        )
    ;; Cuerpo del do
    (push el-nodo nodos-expandidos)
    (reorganizar-nodos-a-expandir                     ;(7)
     (if (and (< (length nodos-expandidos) maxNodos) (< (get el-nodo 'profundidad) maxProfundidad)) 
         (expandir-nodo el-nodo) 
     nil)
     )
  )  ;(6)
)                        

;;; Funcion de dfs (Depth-First-Search), busqueda en profundidad
;;; con un limite de profundidad (maxProfundidad) y un limite
;;; de nodos (maxNodos)
;;;
(defun dfs (estado maxProfundidad maxNodos)
    (setq nodos-expandidos nil                          ;(1)
        el-nodo-inicial (crea-nodo estado nil profundidad-inicial 'nodo-inicial)
        nodos-a-expandir (list el-nodo-inicial)       ;(2)
        )
  ;;; Inicializacion de parametros y su actualizacion (en el bucle do*)
  (do* ((el-nodo (pop nodos-a-expandir) 
                 (if nodos-a-expandir 
                  (pop nodos-a-expandir)             ;(4)
                     (return (mensaje-de-error))))      ;(3)
        )
       ;; Test de salida
       ((objetivop el-nodo)                           ;(5)
        (escribe-solucion el-nodo)
        )
    ;; Cuerpo del do
    (push el-nodo nodos-expandidos)
    (reorganizar-nodos-a-expandir                     ;(7)
     (if (and (< (length nodos-expandidos) maxNodos) (< (get el-nodo 'profundidad) maxProfundidad)) 
         (expandir-nodo el-nodo) 
     nil)
     )))                        ;(6)

;;; Representacion de un nodo como un simbolo con dos propiedades:
;;;   el estado y el nodo padre.
;;;
(defun crea-nodo (estado padre profundidad &optional (simbolo (gensym "NODO-")))
  (setf (get simbolo 'estado) estado)
  (setf (get simbolo 'padre) padre)
  (setf (get simbolo 'profundidad) profundidad)
  (setf (estadisticas-busqueda-nodos-creados *estadisticas*) 
    (+ 1 (estadisticas-busqueda-nodos-creados *estadisticas*))) 
  (setf *nodos-creados* (+ 1 *nodos-creados*))
  simbolo)

(setq profundidad-inicial 0)

;;; La funcion REORGANIZAR-LOS-NODOS-A-EXPANDIR       ;(7)
;;; trabaja con el metodo de busqueda en profundidad.
;;; Agnade los nodos al principio de la cola de nodos a expandir. 
;;;
(defun reorganizar-nodos-a-expandir (nodos)
  (and nodos
       (setq nodos-a-expandir (append nodos nodos-a-expandir))
       ))


(defun mensaje-max-nodos ()
  (format t "~%~%ERROR!!!, el maximo numero de nodos ha sido alcanzado."))

(defun mensaje-max-prof ()
  (format t "~%~%ERROR!!!, la maxima profundidad ha sido alcanzada."))

;;; Estadisticas de las busquedas

(defstruct estadisticas-busqueda
  (maxima-profundidad 0)
  (nodos-chequeados 0) 
  (nodos-creados 0)
  (nodos-expandidos 0)
  (maxima-longitud-de-la-lista-de-nodos 0)
  (longitud-de-la-solucion 0)
  (factor-ramif 0))

(setq *estadisticas* (make-estadisticas-busqueda))

(setq *nodos-creados* 0)
(setq *nodos-chequeados* 0) ;; Numero total de nodos chequeados
(setq *nodos-expandidos* (length nodos-expandidos))
(setq *maxima-profundidad* 0)
(setq *longitud-de-la-solucion* 0)
(setq *maxima-longitud-de-la-lista-de-nodos* 0)
(setq *factor-ramif* (/ *nodos-creados* *nodos-expandidos*))

(defun actualiza-estadisticas()
    (if (> (length nodos-a-expandir) 
           (estadisticas-busqueda-maxima-longitud-de-la-lista-de-nodos
            *estadisticas*))
        (setf (estadisticas-busqueda-maxima-longitud-de-la-lista-de-nodos 
               *estadisticas*) 
          (length nodos-a-expandir)))
  (if (> (estadisticas-busqueda-nodos-expandidos *estadisticas*) 0)
      (setf (estadisticas-busqueda-factor-ramif *estadisticas*) 
            (/ (estadisticas-busqueda-nodos-creados *estadisticas*)
               (estadisticas-busqueda-nodos-expandidos *estadisticas*)))
    nil)
  )



;; Otra posibilidad: poner en el test de salida
;; lo de comprobar la maxProfundidad y maxNodos
;; Devolver mensajes de error diferentes segun
;; el tipo de salida
;; Poner el numero de nodo
;; Solo se puede hacer en la de anchura


(defun dfs (estado maxProfundidad maxNodos)
    (setq nodos-expandidos nil                          ;(1)
        el-nodo-inicial (crea-nodo estado nil profundidad-inicial 'nodo-inicial)
        nodos-a-expandir (list el-nodo-inicial)       ;(2)
        )
  ;;; Inicializacion de parametros y su actualizacion (en el bucle do*)
  (do* ;;; Bucle do*
       ;;; Inicializacion de parametros y su actualizacion de la forma:
       ;;; ((<parametro 1> <valor inicial 1> <forma de actualizacion 1>)
       ;;; ((<parametro 2> <valor inicial 2> <forma de actualizacion 2>)
       ((el-nodo (pop nodos-a-expandir) 
                 (if nodos-a-expandir 
                  (pop nodos-a-expandir)             ;(4)
                     (return (mensaje-de-error))))   ;(3)
        )
       ;; Test de salida del bucle en la forma:
       ;; (<test de terminacion> <formas intermedias, si las hay> <forma resultado>)
       ((estado-objetivop (get el-nodo 'estado))       ;(5)
        (escribe-solucion el-nodo)
        )
    ;; Cuerpo del do
    (push el-nodo nodos-expandidos)
    (reorganizar-nodos-a-expandir                     ;(7)
     (if (and (< (length nodos-expandidos) maxNodos) (< (get el-nodo 'profundidad) maxProfundidad)) 
         (expandir-nodo el-nodo) 
     nil)
     )))                        ;(6)

(defun bfs (estado maxProfundidad maxNodos)
    (setq nodos-expandidos nil                          ;(1)
        el-nodo-inicial (crea-nodo estado nil profundidad-inicial 'nodo-inicial)
        nodos-a-expandir (list el-nodo-inicial)       ;(2)
        )
  ;;; Inicializacion de parametros y su actualizacion (en el bucle do*)
  (do* ;;; Bucle do*
       ;;; Inicializacion de parametros y su actualizacion de la forma:
       ;;; ((<parametro 1> <valor inicial 1> <forma de actualizacion 1>)
       ;;; ((<parametro 2> <valor inicial 2> <forma de actualizacion 2>)
       ((el-nodo (pop nodos-a-expandir) 
                 (if nodos-a-expandir 
                  (pop nodos-a-expandir)             ;(4)
                   (return (mensaje-de-error))))   ;(3)
        (prof-max 0 (setf (estadisticas-busqueda-maxima-profundidad *estadisticas*)
                        (get el-nodo 'profundidad)))
        (nodos-cheq 0 (setf (estadisticas-busqueda-nodos-chequeados *estadisticas*)
                            (+ 1 (estadisticas-busqueda-nodos-chequeados 
                                  *estadisticas*)))) 
        )
       ;; Test de salida del bucle en la forma:
       ;; (<test de terminacion> <formas intermedias, si las hay> <forma resultado>)
       ((estado-objetivop (get el-nodo 'estado))       ;(5)
        (setf (estadisticas-busqueda-nodos-expandidos *estadisticas*) 
              (length nodos-expandidos))          
        (escribe-solucion el-nodo)
        )
    ;; Cuerpo del do
    (push el-nodo nodos-expandidos)
    (reorganizar-nodos-a-expandir                     ;(7)
     (if (and (< (length nodos-expandidos) maxNodos) (< (get el-nodo 'profundidad) maxProfundidad)) 
         (expandir-nodo el-nodo) 
       nil)
     )
    (actualiza-estadisticas)
    ))                        ;(6)


;;;===============================================
;;; Problema del 8-puzzle

;; Representacion del estado
;; mediante una matriz 3*3

(setq estado 
      (make-array '(3 3) 
                   :initial-contents
                   '((1 2 3)
                     (8 space 4)
                     (7 6 5))))

(setf (aref estado 1 2) 'space)
(aref estado 1 2)

;; Estado inicial

(defparameter *estado-inicial* 
  (make-array '(3 3) 
               :initial-contents 
               '((2 8 3)
                 (space 6 4)
                 (1 7 5))))

;; Estado objetivo

(defparameter *estado-objetivo* 
  (make-array '(3 3) 
              :initial-contents
              '((1 2 3)
                (8 space 4)
                (7 6 5))))

;; Chequeo o comprobacion del estado 
(defun estado-objetivop (estado)
  (equal estado *estado-objetivo*))

;; Para generar un nuevo estado se copia
;; el tablero del anterior y se hace el cambio

(defun copia-tablero (tablero)
  (let ((new-tablero (make-array '(3 3))))
    (loop for i from 0 to 2
        do (loop for j from 0 to 2 
               do (setf (aref new-tablero i j) 
                    (aref tablero i j) ))) 
    new-tablero))

;;Para encontrar el emplazamiento de una pieza
(defun encuentra-pieza (x tablero) 
  "devuelve una lista con las coordenadas x y de la pieza x en el tablero"
  (loop for i from 0 to 2 
      thereis (loop for j from 0 to 2 
                  thereis 
                    (when (eq (aref tablero i j) x) 
                      (list i j)))))

;;Para imprimir un estado
(defun imprime-tablero (tablero)
  (format t "~%-------")
  (loop for i from 0 to 2 
      do (format t "~%|")
        (loop for j from 0 to 2 
            do (format t "~A|"
              (if (eq (aref tablero i j) 'space)
                  " "
                (aref tablero i j))))
        (format t "~%-------")))

;; Conjunto o lista de operadores posibles
(setq *operadores* 
      '(move-up move-down move-left move-right))

;; Implementacion de los operadores

(defun move-up (state)
  (let* ((at-space (encuentra-pieza 'espacio state))
         (i (first at-space)) 
         (j (second at-space))
         (new-state (copia-tablero state)))
    (when (> i 0)
      (setf (aref new-state i j) 
            (aref new-state (-i 1) j))
      (setf (aref new-state (-i 1) j) 
        'espacio) 
      new-state)))

(defun move-down (state)
  (let* ((at-space (encuentra-pieza 'espacio state))
         (i (first at-space)) 
         (j (second at-space))
         (new-state (copia-tablero state)))
    (when (> i 0)
      (setf (aref new-state i j) 
            (aref new-state (+ i 1) j))
      (setf (aref new-state (+ i 1) j) 
        'espacio) 
      new-state)))

(defun move-left (state)
  (let* ((at-space (encuentra-pieza 'espacio state))
         (i (first at-space)) 
         (j (second at-space))
         (new-state (copia-tablero state)))
    (when(> i 0)
      (setf (aref new-state i j) 
            (aref new-state i (- j 1)))
      (setf (aref new-state i (- j 1)) 
        'espacio) 
      new-state)))

(defun move-right (state)
  (let* ((at-space (encuentra-pieza 'espacio state))
         (i (first at-space)) 
         (j (second at-space))
         (new-state (copia-tablero state)))
    (when(> i 0)
      (setf (aref new-state i j) 
            (aref new-state i (+ j 1)))
      (setf (aref new-state i (+ j 1)) 
        'espacio) 
      new-state)))

;; Elegir una situacion inicial aleatoriamente
;; Para hacer un movimiento aleatorio
(defun movimiento-aleatorio(state)
  "Coge aleatoriamente uno de los 4 operadores.
  Si el operador no es aplicable, elige otra vez"
  (let ((r (random 4)))
    (or (cond ((= r 0) (move-left state)) 
              ((= r 1) (move-right state))
              ((= r 2) (move-up state))
              ((= r 3) (move-down state)))
        (movimiento-aleatorio state))))

(defun movimientos-aleatorios (n state)
  "hace n movimientos aleatorios"
  (loop for i from 1 to n 
      do (setq state 
               (movimiento-aleatorio state)))
  state)

(defparameter *estado-inicial* 
  (movimientos-aleatorios 20 *estado-objetivo*))