; 12.4 Ejercicios

; 1. Crea una matriz de 3 x 4, con los siguientes valores iniciales:
;      1 2 3 4
;      5 6 7 8
;      9 10 11 12
; 

(setq matriz (make-array '(3 4) :initial-contents '((1 2 3 4) (5 6 7 8) (9 10 11 12))))


; 2. Accede a la matriz creada en el ejercicio anterior para devolver
;    el valor 7.
; Nota: Recordar que los indices de la matriz empiezan por el 0.

(aref matriz 1 2)


; 3. Crea un vector de caracteres de 5 elementos e inicializado con un
;    espacio en cada posicion.

;(setq vect-car (make-array 5 :element-type 'string-char :initial-element '" ")) 


; 4. Escribe una funcion que dado un numero, genere una lista con los
;    valores del numero hasta cero.
;    Ejemplo: (cuentaatras1 5) 
;             (5 4 3 2 1 0)

(defun cuentaatras1 (n)
  (if (> 0 n) nil
    (cons n (cuentaatras1 (- n 1)))))


; 5. Realiza el ejercicio anterior, pero imprimiendo los valores en lugar
;    de ponerlos en una lista, tal como se describe en el ejemplo.
; USER(20): (cuentaatras2 6)
;   6
;   5
;   4
;   3
;   2
;   1
;   "Final"

(defun cuentaatras2 (n)
  (cond ((= 0 n) (print "Final"))
  (t (print n) (cuentaatras2 (- n 1)))))


; 6. Realizar el ejercicio 4 pero sin recursividad, de manera "iterativa".
; USER(27): (cuenta_atras_it 8)
;   (8 7 6 5 4 3 2 1 0)

(defun cuenta_atras_it (n)
  (cond ((> 0 n) nil)
  (t (let ((resultado nil))
           (dotimes (n (+ n 1) resultado)
	   (setq resultado (cons n resultado)))))))


; 7. Escribe una funcion que dados dos argumentos: un numero y un elemento,
;    construya una lista con el elemento repetido el numero de veces. 
;    Utiliza dotimes.
;    USER(15): (construye 2 '’X)
;      (X X)

(defun construye (n elem)
  (let ((resultado nil))
        (dotimes (n n resultado)
	(setq resultado (cons elem resultado)))))


; 8. Escribe una funcion que tome una lista de numeros y un elemento, y 
;    devuelva una lista de sublistas, de modo que cada numero especifique
;    la cantidad de veces que aparece el elemento dado en cada sublista.
;    Utiliza la iteracion.
;    USER(16): (construye ’(1 2 3) ’X)
;      ((X) (X X) (X X X))
;
; Comentarios:  Vamos a usar la funcion del ejercicio anterior.
;               De esta forma, solo tenemos que crear listas
;               con la funcion anterior y unirlas al final con
;               append.
;               construye2 es recursiva y construye3 es iterativa.


(defun construye2 (l elem)
  (cond ((null l) nil)
  (t (append (list (construye (car l) elem)) (construye2 (rest l) elem)))))
  
  
(defun construye3 (l elem)
  (let ((resultado nil))
       (dolist (a l resultado)
       (append resultado (construye a elem)))))



; 9. Haz tu propia funcion mapcar.
;  USER(36): (mapear ’evenp ’(1 2 3 4 5 6))
;     (NIL T NIL T NIL T)

; Nota: Creamos una lista de lo que devuelve
;       la llamada a la funcion prop con el
;       primer caracter de la lista l en cada
;       llamada recursiva:
;       (list (funcall prop (car l)))

(defun mapear (prop l)
  (cond ((null l) nil)
  ((append (list (funcall prop (car l))) (mapear prop (rest l))))))



; 10. Realiza una funcion que elimine los elementos de una lista que
;     cumplan una propiedad determinada.
;     USER(33): (eliminasi ’oddp ’(1 2 3 4 3))
;        (2 4)


(defun eliminasi (prop l)
  (cond ((null l) nil)
  ((funcall prop (car l)) (eliminasi prop (rest l)))
  (t (cons (car l) (eliminasi prop (rest l))))))
  

; 11. Realiza una funcion que dados un elemento y una lista, quite dicho
;     elemento de la lista.
;     USER(42): (quita ’2 ’(1 2 4 6 2 7)))
;        (1 4 6 7)
; Nota: Con la funcion remove es inmediato.

(defun quita (elem l)
  (remove elem l))

