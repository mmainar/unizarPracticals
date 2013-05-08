;;;;----------------------------------------------------------------
;;;; Fichero:   bloques2manos.lisp
;;;; Autor:     Marcos Mainar Lalmolda
;;;; Version:   v1.0  29-4-2009
;;;; Proposito: Ejemplo para UCPOP: mundo de bloques robot 2 manos
;;;;----------------------------------------------------------------
;;; Para probar un ejemplo debes teclear:
;;;  (load "cargar")         ; Carga el planificador UCPOP
;;;  (in-package "UCPOP")    ; Hay que trabajar en el package UCPOP
;;;  (load "bloques2manos")  ; Carga la definicion del problema
;;;  (bf-control 'sussman)  ; Busca (best-first) la solucion al problema 


(in-package "UCPOP")       ;; Definir el problema en el paquete UCPOP

(define (domain bloques2manos)  ;; Mundo de bloques robot 2 manos
  (:operator cogerIzq
     :parameters (?x)
     :precondition (and (sobremesa ?x) (libre ?x) (manoIzqVacia))
     :effect (and (not (sobremesa ?x)) (not (manoIzqVacia)) 
                  (cogidoIzq ?x) (not (libre ?x))))
               
  (:operator dejarIzq
     :parameters (?x)
     :precondition (cogidoIzq ?x)
     :effect (and (not (cogidoIzq ?x)) 
                  (sobremesa ?x) (manoIzqVacia) (libre ?x)))
               
  (:operator desapilarIzq
     :parameters (?x ?y)
     :precondition (and (sobre ?x ?y) (libre ?x) (manoIzqVacia))
     :effect  (and (not (sobre ?x ?y)) (not (manoIzqVacia)) 
                   (cogidoIzq ?x) (libre ?y) (not (libre ?x))))
               
  (:operator apilarIzq
     :parameters (?x ?y)
     :precondition (and (cogidoIzq ?x) (libre ?y))
     :effect  (and (not (cogidoIzq ?x)) (not (libre ?y)) 
                   (sobre ?x ?y) (manoIzqVacia) (libre ?x)))

  (:operator cogerDer
     :parameters (?x)
     :precondition (and (sobremesa ?x) (libre ?x) (manoDerVacia))
     :effect (and (not (sobremesa ?x)) (not (manoDerVacia)) 
                  (cogidoDer ?x) (not (libre ?x))))
               
  (:operator dejarDer
     :parameters (?x)
     :precondition (cogidoDer ?x)
     :effect (and (not (cogidoDer ?x)) 
                  (sobremesa ?x) (manoDerVacia) (libre ?x)))
               
  (:operator desapilarDer
     :parameters (?x ?y)
     :precondition (and (sobre ?x ?y) (libre ?x) (manoDerVacia))
     :effect  (and (not (sobre ?x ?y)) (not (manoDerVacia)) 
                   (cogidoDer ?x) (libre ?y) (not (libre ?x))))
               
  (:operator apilarDer
     :parameters (?x ?y)
     :precondition (and (cogidoDer ?x) (libre ?y))
     :effect  (and (not (cogidoDer ?x)) (not (libre ?y)) 
                   (sobre ?x ?y) (manoDerVacia) (libre ?x))))
               

(define (problem facil2manos)     ;; Un problema que STRIPS resuelve bien
  :domain 'bloques2manos
  :inits ((sobre C A) (sobremesa A) (sobremesa B) 
	      (libre C) (libre B) (manoIzqVacia) (manoDerVacia))
  :goal (and (sobre A C) (sobre C B)))


(define (problem sussman2manos)   ;; La clasica anomalia de Sussman             
  :domain 'bloques2manos
  :inits ((sobre C A) (sobremesa A) (sobremesa B) 
	      (libre C) (libre B) (manoIzqVacia) (manoDerVacia))
  :goal (and (sobre A B) (sobre B C)))


(define (problem insertar2manos)   ;; Insertar el bloque B 
  :domain 'bloques2manos
  :inits ((sobre C A) (sobremesa A) (sobremesa B) 
	      (libre C) (libre B) (manoIzqVacia) (manoDerVacia))
  :goal (and (sobre C B) (sobre B A)))


(define (problem imposible2manos)  ;; ¿Que hace UCPOP en este caso?
  :domain 'bloques2manos
  :inits ((sobre C A) (sobremesa A) (sobremesa B) 
	      (libre C) (libre B) (manoIzqVacia) (manoDerVacia))
  :goal (and (sobre A B) (sobre B C) (sobre C A)))




