; AUTOR: Marcos Mainar Lalmolda
; NIP: 550710
; FECHA: 23-MAY-08
; ASIGNATURA: Lenguajes de Programacion



; 12. Realiza un programa que calcule la derivada simbolica de una expresion,
;     considerando las reglas de derivacion para las siguientes operaciones:
;     suma, resta, producto, cociente, seno, coseno y tangente. Simplifica
;     el resultado en la medida de lo posible. 
;
; Nota: a es la variable (o expresion simbolica) respecto a la cual derivamos y b
;       es la expresion simbolica a derivar.


; eq: Compara 2 objetos cualesquiera y verifica si son exactamente el mismo
;     (mismo lugar en la memoria).
; eql: Compara punteros (T si apuntan a la misma zona de memoria y NIL si no).
; equal: Verifica si los contenidos de una lista son los mismos

(defun s (b) ; Funcion de simplificaciones
 (cond 
 ((and (eql (first b) '*) (eql (nth 1 b) '0)) 0)  ; 0 * x = 0
 ((and (eql (first b) '*) (eql (nth 2 b) '0)) 0)  ; x * 0 = 0
 ((and (eql (first b) '+) (eql (nth 2 b) '0)) (nth 1 b))  ;  x + 0 = x
 ((and (eql (first b) '+) (eql (nth 1 b) '0)) (nth 2 b))  ;  0 + x = x
 ((and (eql (first b) '+) (numberp (nth 1 b)) (numberp (nth 2 b)) (+ (nth 1 b) (nth 2 b))))
 ((and (eql (first b) '-) (eql (nth 2 b) '0)) (nth 1 b)) ; x - 0 = x 
 ((and (eql (first b) '-) (numberp (nth 1 b)) (numberp (nth 2 b)) (- (nth 1 b) (nth 2 b))))
 ((and (eql (first b) '*) (eql (nth 1 b) '1)) (nth 2 b)) ; 1 * x = x
 ((and (eql (first b) '*) (eql (nth 2 b) '1)) (nth 1 b)) ; x * 1 = x
 ((and (eql (first b) '*) (numberp (nth 1 b)) (numberp (nth 2 b)) (* (nth 1 b) (nth 2 b))))
 ((and (eql (first b) '/) (eql (nth 1 b) '0)) 0)  ; 0 / x = 0
 ((and (eql (first b) '/) (numberp (nth 1 b)) (numberp (nth 2 b)) (/ (nth 1 b) (nth 2 b))))
 ((and (eql (first b) '/) (eql (nth 2 b) '1)) (nth 1 b)) ; x / 1 = x
 ((and (eql (first b) '+) (equal (nth 1 b) (nth 2 b)) (cons '* (cons '2 (append (list (nth 1 b)))))))
   ; x + x = 2x
 ((and (eql (rest b) nil) (numberp (first b))) (first b)) ; si una lista tiene un solo elemento y este 
                                                          ; es un numero, devolvemos solo el numero.
 ((and (eql (first b) '/) (equal (nth 1 b) (nth 2 b))) 1)  ; x / x = 1 
 ((and (eql (first b) '-) (equal (nth 1 b) (nth 2 b))) 0)  ; x - x = 0
 ((and (eql (first b) '/) (equal (nth 1 b) 'sin) (equal (nth 2 b) 'cos) (equal (nth 1 (nth 1 b)) (nth 1
 (nth 2 b)))) (append (list (cons 'tan (list (nth 1 (nth 1 b)))))))	; sin x / cos x = tan x	
 ;((and (eql (first b) '+) (eql (nth 1 b (nth 0 b)) '*) (equal (nth 1 b (nth 1 b)) 'sin		
 ; Ecuacion fundamental de la trigonometria
 (t b)))


(defun d (b a)  ; funcion que calcula la derivada (+, -, *, /, sen, cos, tan).
 (cond 
 ((equal a b) 1) ; equal para poder derivar respecto a expresiones tambien
 ((atom b) 0) ; derivada de una constante

 ((eql (first b) '+) (s (cons '+ (append (list (d (nth 1 b) a)) (list (d (nth 2 b) a))))))

 ((eql (first b) '-) (s (cons '- (append (list (d (nth 1 b) a)) (list (d (nth 2 b) a))))))

 ((eql (first b) '*) (s (cons '+ (append (list (s (cons '* (append (list (d (nth 1 b) a)) (list (nth 2 b)))))) 
                                   (list (s (cons '* (append (list (nth 1 b)) (list (d (nth 2 b) a))))))))))

 ((eql (first b) '/) (s (cons '/ (append (list (append (s (cons '- (append (list (cons '* (append (list (d (nth 1 b) a)) 
 (list (nth 2 b))))) (list (s (cons '* (append (list (nth 1 b)) (list (d (nth 2 b) a)))))))))))
 (list (s (cons '* (append (list (nth 2 b)) (list (nth 2 b))))))))))

 ((eql (first b) 'sin) (s (cons '* (append (list (cons 'cos (list (nth 1 b))))
                                                              (list (d (nth 1 b) a))))))

 ((eql (first b) 'cos) (s (cons '* (append (list (append (cons '- (cons '0 (list (cons 'sin (list (nth 1 b)))))))
                                              (s (list  (d (nth 1 b) a))))))))
		     	      
 ((eql (first b) 'tan) (s (cons '/ (append (list (d (nth 1 b) a)) 
                                      (list (cons '* (append (list (cons 'cos (list (nth 1 b)))) 
				                           (list (cons 'cos (list (nth 1 b)))))))))))))


