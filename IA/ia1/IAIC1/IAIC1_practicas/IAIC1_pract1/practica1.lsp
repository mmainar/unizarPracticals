;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;
;;;    idea: 	    winston
;;;    creado:      13-2-1991 prmuro
;;;    modificado : 14-4-94   prmuro
;;;                 20-10-95 bagnares
;;;    Departamento de Informatica e Ingenieria de Sistemas
;;;    Centro Politecnico Superior
;;;    Universidad de Zaragoza
;;;
;;;    Titulo: Libros de una Biblioteca
;;;


; Esta practica es la organizacion de una pequena base de datos para 
;almacenar la informacion de libros de una biblioteca.  
; Para ello hemos creado una libreria de funciones de utilidad que nos 
;facilitan el tratamiento.

; La base de datos contiene informacion acerca del titulo, autor y 
;clasificacion por palabras claves de cada libro.
; En la version propuesta la estructura de datos elegida para cada libro 
;consiste en una lista con tres listas internas  cuyos 'car' respectivos 
;son las palabras clave 'titulo', 'autor' y 'clasificacion'.
;Para abstraer al usuario de la estructura de datos utilizada se ha 
;definido el constructor (los parametros identifican los valores de 
;cada campo):'(crea-libro titulo autor clasificacion)'.



(defun crea-libro (titulo autor clasificacion agno)
   (LIST (LIST 'TITULO TITULO)
         (LIST 'AUTOR AUTOR)
         (LIST 'CLASIFICACION CLASIFICACION)
	 (LIST 'AGNO AGNO)))

;Este constructor crea un nuevo libro

(setf libro-ejemplo
      (crea-libro '(Common Lisp)
                  '(Guy steele)
                  '(Tecnico Lisp)
		  '1991))

; Para seguir con el constuctor creamos un conjunto de lectores:

(defun libro-titulo (libro)
   (second (assoc 'titulo libro)))

(defun libro-autor (libro)
   (second (assoc 'autor libro)))

(defun libro-clasificacion (libro)
  (second (assoc 'clasificacion libro)))

(defun libro-agno (libro)
   (second (assoc 'agno libro)))


;Creamos ahora un procedimiento para cambiar el autor
(defun libro-cambio-autor (libro autor)
  (if (eql 'autor (first (first libro)))
    (cons (list 'autor autor) (rest libro))
    (cons (first libro)
          (libro-cambio-autor (rest libro) autor))))


;Ahora construimos mas libros en la base de datos:
(setf bdlibros 
      (list
       (crea-libro '(Common Lisp)
                   '(Guy L. Steele)
                   '(Tecnico Lisp)
		   '1991)
       (crea-libro '(Artificial Intelligence)
                   '(P. H. Winston)
                   '(Tecnico IA)
		   '1989)
       (crea-libro '(Moby Dick)
                   '(H. Melville)
                   '(Ficcion)
		   '1850)
       (crea-libro '(Tom Sawyer)
                   '(M. Twain)
                   '(Ficcion)
		   '1894)
       (crea-libro '(The Black Orchid)
                   '(Rex Stout)
                   '(Ficcion Misterio)
		   '1710)))


;FILTRADO DE DATOS
; Puede ser interesante sacar listados que contengan informacion parcial de
;la base de datos. Esto es, se requiere un filtrado.

(defun lista-autores (libros)
  (if (null libros)
    nil
    (cons (libro-autor (first libros))
          (lista-autores (rest libros)))))


; Se puede hacer un filtro que acceda a mayor profundidad:
; Primero creamos una funcion booleana que diga si un libro cumple la
;condicion, p.e. que sea de ficcion.

(defun ficcionp (libro)
  (member 'ficcion (libro-clasificacion libro)))

; Ahora la podemos usar para encontrar todos los libros de ficcion:

(defun lista-libros-de-ficcion (libros)
  (cond ((null libros) nil)
        ((ficcionp (first libros))
         (cons (first libros)
               (lista-libros-de-ficcion (rest libros))))
        (t (lista-libros-de-ficcion (rest libros)))))


;;;  TAMBIEN ES POSIBLE CONTAR Y ENCONTRAR

;(length (LISTA-LIBROS-DE-FICCION bdlibros))

; Tambien se puede acceder a uno cualquiera de la lista:
; (first (LISTA-LIBROS-DE-FICCION bdlibros))

;Pero esto es muy poco eficiente porque se necesita crear nuevas listas.
;Pero puede contarse directamente:
(defun cuenta-libros-ficcion (libros)
  (cond ((null libros) 0)
        ((ficcionp (first libros))
         (+ 1 (cuenta-libros-ficcion (rest libros))))
        (t (cuenta-libros-ficcion (rest libros)))))


(defun encuentra-primer-libro-ficcion (libros)
  (cond ((null libros) nil)
        ((ficcionp (first libros))
         (first libros))
        (t (encuentra-primer-libro-ficcion (rest libros)))))


;Observar los patrones que se repiten en las funciones anteriores.
;;; Funciones de MAPPING
;Para facilitar las cosas
;(lista-autores bdlibros)
;(mapcar #'libro-autor bdlibros)

(defun libro-autor-apellido (libro)
  (first (last (libro-autor libro))))

;(mapcar #'libro-autor-apellido bdlibros)
;(mapcar #'(lambda (libro) (first (last (libro-autor libro)))) bdlibros)

;;; Para simplificar las operaciones de filtrado: REMOVE-IF y REMOVE-IF-NOT
;(remove-if-not #'ficcionp bdlibros)  ;elimina si NO se verifica la condicion
;(remove-if #'ficcionp bdlibros)   ;elimina SI se verifica la condicion

;(count-if #'ficcionp bdlibros)   ;cuenta SI se verifica la condicion
;(find-if #'ficcionp bdlibros)   ;encuentra SI se verifica la condicion


