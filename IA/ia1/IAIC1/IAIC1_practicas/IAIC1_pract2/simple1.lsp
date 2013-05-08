;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;; 
;;; Idea original 
;;;     1991        Code from Paradigms of Artificial Intelligence Programming 
;;;                 Copyright (c) 1991 Peter Norvig 
;;; 
;;; Modificaciones: 
;;;     17-10-97    muro    Modificaciones para practicas. Paso a castellano, cambio en  
;;;                         mappend 
;;; 
 
 
(defun Sentencia ()    (append (Nombre-frase) (Verbo-frase))) 
(defun Nombre-frase () (append (Articulo) (Nombre))) 
(defun Verbo-frase ()  (append (Verbo) (Nombre-frase))) 
(defun Articulo ()     (uno-de '(the a))) 
(defun Nombre ()       (uno-de '(man ball woman table))) 
(defun Verbo ()        (uno-de '(hit took saw liked))) 
 
;;; ============================== 
 
(defun uno-de (conjunto) 
  "Elige un elemento del conjunto y lo mete en una lista." 
  (list (random-elt conjunto))) 
 
(defun random-elt (choices) 
  "Elige aleatoriamente un elemento de una lista." 
  (elt choices (random (length choices)))) 
  
;;; ============================== 
  
(defun Adj* () 
  (if (= (random 2) 0) 
      nil 
      (append (Adj) (Adj*)))) 
  
(defun PP* () 
  (if (random-elt '(t nil)) 
      (append (PP) (PP*)) 
      nil)) 
  
(defun Nombre-frase () (append (Articulo) (Adj*) (Nombre) (PP*))) 
(defun PP () (append (Prep) (Nombre-frase))) 
(defun Adj () (uno-de '(big little blue green adiabatic))) 
(defun Prep () (uno-de '(to in by with on))) 
  
;;; ============================== 
  
(defparameter *gramatica-simple* 
  '((Sentencia -> (Nombre-frase Verbo-frase)) 
    (Nombre-frase -> (Articulo Nombre)) 
    (Verbo-frase -> (Verbo Nombre-frase)) 
    (Articulo -> the a) 
    (Nombre -> man ball woman table) 
    (Verbo -> hit took saw liked)) 
  "Gramatica para un subconjunto trivial de Ingles.") 
  
(defvar *gramatica* *gramatica-simple* 
  "Gramatica utilizada para generar. Inicialmente esta es la  
  *gramatica-simple*, pero puede conmutarse por otras gramaticas.") 
  
;;; ============================== 
  
(defun regla-pir (regla) 
  "Parte izquierda de una regla." 
  (first regla)) 
  
(defun regla-pdr (regla) 
  "Parte derecha de una regla." 
  (rest (rest regla))) 
  
(defun sustituciones (categoria) 
  "Devuelve una lista con todas las posibles sustituciones de una categoria." 
  (regla-pdr (assoc categoria *gramatica*))) 
  
;;; ============================== 
  
(defun genera (frase) 
  "Genera una sentencia o frase aleatoria." 
  (cond ((listp frase)               ;caso de lista 
         (mapcan #'genera frase)) 
        ((sustituciones frase)       ;caso de simbolo con sustituciones 
         (genera (random-elt (sustituciones frase)))) 
        (t (list frase))))           ;caso de palabra 
   
;;; ============================== 
  
(defparameter *gramatica-mas-grande* 
  '((Sentencia -> (Nombre-frase Verbo-frase)) 
    (Nombre-frase -> (Articulo Adj* Nombre PP*) (Nombre-propio) (ProNombre)) 
    (Verbo-frase -> (Verbo Nombre-frase PP*)) 
    (PP* -> () (PP PP*)) 
    (Adj* -> () (Adj Adj*)) 
    (PP -> (Prep Nombre-frase)) 
    (Prep -> to in by with on) 
    (Adj -> big little blue green adiabatic) 
    (Articulo -> the a) 
    (Nombre-propio -> Pat Kim Lee Terry Robin) 
    (Nombre -> man ball woman table) 
    (Verbo -> hit took saw liked) 
    (ProNombre -> he she it these those that))) 
  
(setf *gramatica* *gramatica-mas-grande*) 
  
;;; ============================== 
  
(defun genera-arbol (frase) 
  "Genera una sentencia o frase aleatoria con su arbol completo." 
  (cond ((listp frase) 
         (mapcar #'genera-arbol frase)) 
        ((sustituciones frase) 
         (cons frase 
               (genera-arbol (random-elt (sustituciones frase))))) 
        (t (list frase)))) 
  
;;; ============================== 
 
(defun genera-todas (frase) 
   "Genera una lista de todas las posibles expansiones de esta frase." 
   (cond ((null frase) (list nil)) 
         ((listp frase) 
          (combina-todas  
           (genera-todas (first frase)) 
           (genera-todas (rest frase)))) 
         ((sustituciones frase) 
          (mapcan #'genera-todas (sustituciones frase))) 
         (t (list (list frase)))) 
   ) 
 
(defun combina-todas (xlist ylist) 
  "Devuelve una lista de listas formada añadiendo una y a una x. 
  P.e¡., (combina-todas '((a) (b)) '((1) (2))) 
  -> ((A 1) (B 1) (A 2) (B 2))." 
   (mapcan #'(lambda (y) 
               (mapcar #'(lambda (x) (append x y)) xlist)) 
           ylist)) 
 
 
 
