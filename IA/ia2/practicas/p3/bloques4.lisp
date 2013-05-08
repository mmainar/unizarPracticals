;;;;----------------------------------------------------------------
;;;; Fichero:   bloques4.lisp
;;;; Autor:     J.D.Tardos
;;;; Version:   v1.0  27-2-2002
;;;; Proposito: Ejemplo para UCPOP: mundo de bloques con 4 acciones
;;;;----------------------------------------------------------------
;;; Para probar un ejemplo debes teclear:
;;;  (load "cargar")         ; Carga el planificador UCPOP
;;;  (in-package "UCPOP")    ; Hay que trabajar en el package UCPOP
;;;  (load "bloques4")       ; Carga la definicion del problema
;;;  (bf-control 'sussman4)  ; Busca (best-first) la solucion al problema 


(in-package "UCPOP")       ;; Definir el problema en el paquete UCPOP

(define (domain bloques4)  ;; Mundo de bloques con 4 acciones
  (:operator coger
     :parameters (?x)
     :precondition (and (sobremesa ?x) (libre ?x) (manovacia))
     :effect (and (not (sobremesa ?x)) (not (manovacia)) 
                  (cogido ?x)))
               
  (:operator dejar
     :parameters (?x)
     :precondition (cogido ?x)
     :effect (and (not (cogido ?x)) 
                  (sobremesa ?x) (manovacia)))
               
  (:operator desapilar
     :parameters (?x ?y)
     :precondition (and (sobre ?x ?y) (libre ?x) (manovacia))
     :effect  (and (not (sobre ?x ?y)) (not (manovacia)) 
                   (cogido ?x) (libre ?y)))
               
  (:operator apilar
     :parameters (?x ?y)
     :precondition (and (cogido ?x) (libre ?y))
     :effect  (and (not (cogido ?x)) (not (libre ?y)) 
                   (sobre ?x ?y) (manovacia))))
               

(define (problem facil4)     ;; Un problema que STRIPS resuelve bien
  :domain 'bloques4
  :inits ((sobre C A) (sobremesa A) (sobremesa B) 
	      (libre C) (libre B) (manovacia))
  :goal (and (sobre A C) (sobre C B)))


(define (problem sussman4)   ;; La clasica anomalia de Sussman             
  :domain 'bloques4
  :inits ((sobre C A) (sobremesa A) (sobremesa B) 
	      (libre C) (libre B) (manovacia))
  :goal (and (sobre A B) (sobre B C)))


(define (problem insertar4)   ;; Insertar el bloque B 
  :domain 'bloques4
  :inits ((sobre C A) (sobremesa A) (sobremesa B) 
	      (libre C) (libre B) (manovacia))
  :goal (and (sobre C B) (sobre B A)))


(define (problem imposible4)  ;; ¿Que hace UCPOP en este caso?
  :domain 'bloques4
  :inits ((sobre C A) (sobremesa A) (sobremesa B) 
	      (libre C) (libre B) (manovacia))
  :goal (and (sobre A B) (sobre B C) (sobre C A)))




