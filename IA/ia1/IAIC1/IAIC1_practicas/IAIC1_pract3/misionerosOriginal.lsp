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
(defvar nodos-a-expandir nil "Lista de estados a considerar")
(defvar nodos-expandidos nil "Lista de estados que ya han sido visitados una vez")

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
                              (list (crea-nodo nuevo-estado nodo))))))
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



               



