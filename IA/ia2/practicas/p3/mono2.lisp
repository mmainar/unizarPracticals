;;;;----------------------------------------------------------------
;;;; Fichero:   mono.lisp
;;;; Autor:     Marcos Mainar Lalmolda
;;;; Version:   v2.0  10-5-2009
;;;; Proposito: Mono con platanos parametrizado
;;;;----------------------------------------------------------------
;;; Para probar un ejemplo debes teclear:
;;;  (load "cargar")        ; Carga el planificador UCPOP
;;;  (in-package "UCPOP")   ; Hay que trabajar en el package UCPOP
;;;  (load "mono")       ; Carga la definicion del problema
;;;  (bf-control 'mono1)  ; Busca (best-first) la solucion al problema


(in-package "UCPOP")       ;; Definir el problema en el paquete UCPOP

(define (domain mono)   ;; Mundo de mono con platanos
        
 (:operator cerrar
    :parameters (?x ?y)
    :precondition (and (abierta ?x ?y) (abierta ?y ?x) (esta mono ?x)
                        (contigua ?x ?y))
    :effect (and (not (abierta ?x ?y)) (not (abierta ?y ?x))))
    
 (:operator ir
    :parameters (?origen ?destino)
    :precondition (and (esta mono ?origen) (contigua ?origen ?destino))
    :effect (and (not (esta mono ?origen)) (esta mono ?destino)
                      (abierta ?origen ?destino) (abierta ?destino ?origen)))
    
 (:operator ir-con-caja
    :parameters (?origen ?destino)
    :precondition (and (esta mono ?origen) (esta caja ?origen)  
		       (contigua ?origen ?destino))
    :effect (and (not (esta mono ?origen)) (not (esta caja ?origen)) 
                 (esta mono ?destino) (esta caja ?destino)
		 (abierta ?origen ?destino) (abierta ?destino ?origen)))

 (:operator coger-platanos
    :parameters (?x)
    :precondition (and (esta platanos ?x) (esta caja ?x) (esta mono ?x))
    :effect (tener-platanos)))


(define (problem mono1)
 :domain 'mono
 :inits ((esta mono A) (esta platanos A) (esta caja C)
             (not (abierta A B)) (not (abierta B C)) (not (abierta B A))
	     (not (abierta C B)) (contigua A B) (contigua B C) (contigua B A)
	     (contigua C B))
 :goal (tener-platanos))

(define (problem mono2)
 :domain 'mono
 :inits ((esta mono A) (esta platanos A) (esta caja C)
             (not (abierta A B)) (not (abierta B C)) (not (abierta B A))
	     (not (abierta C B)) (contigua A B) (contigua B C) (contigua B A)
	     (contigua C B))
 :goal (and (tener-platanos) (esta caja C) (esta mono A)
            (not (abierta A B)) (not (abierta B C))
	    (not (abierta B A)) (not (abierta C B))))


