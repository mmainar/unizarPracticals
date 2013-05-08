;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;            Pedro R. Muro & Jose L. Villarroel
;;;
;;;                         20-2-1991
;;;
;;;      IERL: iaaa experimental representation language
;;;
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa  iaaa   ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Una form tiene tres partes: un IS-A, slots y metodos
;;;  esta implementada mediante la lista de propiedades del simbolo.
;;;
;;;
;;; FORM :: valor
;;; Modifica los valors de una form y la crea en caso de que no exista.
;;;
(defun form (&key name is-a slots)
  (let* ((la-form (if (get name 'is-a)
                    name
                    (progn (setf (get name 'is-a) is-a) name)))
         )
    (dolist (slot-conten slots)
      (funcall #'set-aspect la-form 
               (car slot-conten)
               (cadr slot-conten)
               (cadr(cdr slot-conten))))
    la-form))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;(SET-ASPECT form slot aspecto valor) :: valor
;;; Guarda el valor del aspecto del slot de la form.
;;;
;;; Cada slot corresponde con una propiedad del simbolo.
;;; El contenido del slot esta formado por listas de aspectos compuestas
;;;  por un simpbolo identificador del aspecto y su contenido:
;;;          =  para el valor
;;;  IF-NEEDED  para el metodo de acceso
;;;
(defun set-aspect (form slot aspecto valor)
  (let* ((contenido (get form slot)))
    (cond (contenido
           (if (assoc aspecto contenido)
             (rplacd (assoc aspecto contenido) (list valor))
             (setq contenido (cons (list aspecto valor) contenido))))
          (t
           (setq contenido (cons (list aspecto valor) contenido))))
    (setf (get form slot) contenido)))


;;; SET-VALUE esta especializado en el aspecto =
;;;  el parametro MENSAJE no es realmente necesario si no se utiliza el modo
;;;  orientado a objeto 
;;; (en POO normalmente todos los metodos reciben al menos dos parametros,
;;;  el primero es el OBJETO y el segundo el MENSAJE.
;;;
(defun set-value (form slot valor)
  (set-aspect form slot '= valor))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Aqui comienzan las definiciones del vocabulario de acceso y
;;;  manipulacion de datos
;;;
;;;(GET-ASPECT form slot aspecto) :: valor
;;; Devuelve el valor del aspecto del slot de la form
;;;


;;;
;;; GET-SIMPLE-ASPECT toma un aspecto de un slot sin acceder por la
;;;  jerarquia.
;;;
(defun get-simple-aspect (form slot aspecto)
  (cadr (assoc aspecto (get form slot))))


;;;
;;; GET-ASPECT toma un aspecto de un slot accediendo por la
;;;  jerarquia.
;;;
(defun get-aspect (form slot aspecto)
  (let* ((value (assoc aspecto (get form slot))))
    (if value 
      (cadr value)
      (if (get form 'is-a)
        (get-aspect (get form 'is-a) slot aspecto)
        ))))

;;;
;;; GET-VALUE toma el aspecto = de un slot accediendo por la
;;;  jerarquia.
;;; Amplia el vocabulario para el aspecto = pues es muy utilizado.
;;;
(defun get-value (form slot)
  (get-aspect form slot '=))


;;;
;;; GET-VALUE obtiene el valor del aspecto = de un slot con herencia
;;;  y aplicando ademas el demond en el aspecto IF-NEEDED.
;;;
(defun get-value (form slot)
  (let ((needed (get-aspect form slot 'if-needed)))
    (if needed
      (funcall needed form slot)
      (get-aspect form slot '=))))

;;;
;;; FIND-SLOT-FROM-SUPERS toma el contenido entero de un slot accediendo por la 
;;;  jerarquia.
;;; Puede ser utilizado para heredar mensajes en el estilo orientado a objeto
;;;
(defun find-slot-from-supers (form slot)
  (let* ((value (get form slot)))
    (if value 
      value
      (if (get form 'is-a)
        (find-slot-from-supers (get form 'is-a) slot)
        ))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Creacion de la estructura de conocimiento para el problema de
;;;  los apartamentos.
;;; El objetivo es disponer de una representacion del conocimiento
;;;  que permita obtener informacion a una empresa inmoviliaria.
;;;  Para ello se crea una base de datos de forms con algunos metodos.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Generacion de la jerarquia de forms
;;;   La funcion GBD genera la base de datos de las forms

(defun gbd ()
  (let ()
    (form :is-a nil :name 'object)
    (form :name 'cosa 
          :is-a 'object)
    
    (form :name 'vivienda
          :is-a 'cosa)
    
    (form :name 'apartamento
          :is-a 'vivienda
          :slots (list (list 'ruido-calle 'if-needed #'calcula-ruido)))
    
    (form :name 'chalet
          :is-a 'vivienda
          :slots (list (list 'ruido-calle 'if-needed #'calcula-ruido-en-casa)
                       ))
    
    (form :name 'apt-breton-22
          :is-a 'apartamento
          :slots '((calle-nombre = Breton)
                   (calle-numero = 22)
                   (color-pared = blanco)
                   (material-suelo = madera)))
    
    (form :name 'apt-22-1
          :is-a 'apt-breton-22
          :slots '((numero-habitaciones = 3)
                   (piso = 2)))
    
    (form :name 'chalet-montesol-5
          :is-a 'chalet
          :slots '((calle-nombre = urbanizacion-montesol)
                   (calle-numero = 5)
                   (numero-habitaciones = 5)
                   (pisos = 2)
                   (distancia-carretera = 200)))
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Generacion de funciones para los demonds
;;;

;;; CALCULA-RUIDO es una funcion IF-NEEDED que calcula el nivel de ruido
;;;  de un apartamento. 
;;; Si existe un valor = lo toma, si no lo calcula dependiendo de
;;;  la altura del piso.
;;;
;;; CALCULA-RUIDO-EN-CASA lo calcula en base a la distancia 
;;;  de la casa a la carretera.
;;;
(defun calcula-ruido (form slot)
  (let* ((valor (get-aspect form 'ruido-calle '=))
         piso)
    (cond (valor valor)
          (t (setq piso (get-value form 'piso))
             (cond ((> piso 15) 'muy-bajo)
                   ((> piso 8) 'bajo)
                   ((> piso 4) 'medio)
                   ((> piso 1) 'alto)
                   (t 'muy-alto))))))

(defun calcula-ruido-en-casa (form slot)
  (let* ((valor (get-aspect form 'ruido-calle '=))
         distancia)
    (cond (valor valor)
          (t (setq distancia (get-value form 'distancia-carretera))
             (cond ((> distancia 1000) 'muy-bajo)
                   ((> distancia 100) 'bajo)
                   ((> distancia 30) 'medio)
                   ((> distancia 10) 'alto)
                   (t 'muy-alto))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Puedes probar a obtener valores con la funcion GET-VALUE
;;;
;(get-value 'apt-22-1 'ruido-calle)
;--> ALTO
;(get-value 'chalet-montesol-5 'ruido-calle)
;--> BAJO
;;;
;(set-value 'apt-breton-22 'ruido-calle 'muy-alto)
;(set-value 'chalet 'ruido-calle 'muy-bajo)
;(get-value 'apt-22-1 'ruido-calle)
;--> MUY-ALTO



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; La funcion <-- implementa el protocolo de envio de mensajes
;;;  para simular el comportamiento orientado a objeto.
;;;
;;;  form: es el simbolo del form
;;;  mensaje: es nombre del mensaje a enviar
;;;  parms: recoge los parametros a necesarios en el metodo del mensaje
;;;
;;;(defun <-- (form mensaje &rest parms) ...)

;;;(defun create-method (form mensaje metodo) ...)




