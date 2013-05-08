(defstruct libro
    (titulo nil)
    (autor nil)
    (clasificacion nil)
    (agno nil))
    
    
; make-libro es el procedimiento constructor craedo automaticamente
; al evaluarse la forma defstruct.    
    
(defun crea-libro (titulo autor clasificacion agno)
    (make-libro :titulo titulo :autor autor 
      :clasificacion clasificacion :agno agno))

(setf libro-ejemplo
     (crea-libro '(Common Lisp)
                 '(Guy Steele)
		 '(Tecnico Lisp)
		 '1991))

; Al definir con defstruct la estructura libro, esta nos crea
; de forma automatica procedimientos de lectura de nombres:
; libro-titulo, libro-autor, libro-clasificacion y libro-agno.


; setf esta generalizado a fin de que sirva como procedimiento de
; escritura cuando se usa en combinacion con los procedimientos de
; lectura, que acceden a un campo.

(defun libro-cambio-autor (libro autor)
    (setf (libro-autor libro) autor))

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
		  
(defun lista-autores (libros)
   (if (null libros) 
     nil
     (cons (libro-autor (first libros))
           (lista-autores (rest libros)))))

(defun ficcionp (libro)
   (member 'ficcion (libro-clasificacion libro)))


(defun lista-libros-ficcion (libros)
   (cond ((null libros) nil)
         ((ficcionp (first libros))
	  (cons (first libros)
	        (lista-libros-ficcion (rest libros))))
	 (t (lista-libros-ficcion (rest libros)))))


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
	 
	 
(defun libro-autor-apellido (libro)
    (first (last (libro-autor libro))))		
	 
	 
; Nuevas funciones creadas

(defun escribir-libro-en-bonito (libro)
      (print 'titulo ) (prin1 (libro-titulo libro))
      (print 'autor ) (prin1 (libro-autor libro))
      (print 'clasificacion ) (prin1 (libro-clasificacion libro))
      (print 'agno ) (prin1 (libro-agno libro)))
      

(defun pertenece (l a)
       (cond ((null l) nil)
             ((eq a (first (first l))) t)
	     (t (pertenece (rest l) a))))
	     
(defun elimina-repeticiones (l)
       (cond ((null l) nil)
             ((member (first l) (rest l)) (elimina-repeticiones (rest l)))
	     (t (cons (first l) (elimina-repeticiones (rest l))))))	     

	  
(defun listado-palabras-clave (libros)
    (if (null libros) nil
    (cons (libro-clasificacion (first libros))
           (listado-palabras-clave (rest libros)))))
	   

(defun listado-palabras-clave2 (libros)
    (cond ((null libros) nil)
          ((elimina-repeticiones 
	    (append 
	    (list (first (libro-clasificacion (first libros))))
            (rest (libro-clasificacion (first libros)))
      (listado-palabras-clave2 (rest libros)))))))


(defun listado-agnos (libros)
  (if (null libros) nil
    (cons (libro-agno (first libros))
           (listado-agnos (rest libros)))))
                    
(defun por-antiguedad (a b)
  (if (< a b) T nil))

(defun por-palabrasclave (a b)
  (if (< (length a) (length b)) T nil))

(defun ordenar (libros f)
  (sort libros f :key #'libro-agno))

(defun ordenar2 (libros f)
  (ordenarClave (sort libros f :key #'libro-agno) #'por-palabrasclave))

(defun ordenarClave (libros f)
   (sort libros f :key #'libro-clasificacion))
