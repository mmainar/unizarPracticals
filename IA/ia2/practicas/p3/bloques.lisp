;;;;----------------------------------------------------------------
;;;; Fichero:   bloques.lisp
;;;; Autor:     J.D.Tardos
;;;; Version:   v1.0  27-2-2002
;;;; Proposito: Ejemplo para UCPOP: mundo de bloques con una accion
;;;;----------------------------------------------------------------
;;; Para probar un ejemplo debes teclear:
;;;  (load "cargar")        ; Carga el planificador UCPOP
;;;  (in-package "UCPOP")   ; Hay que trabajar en el package UCPOP
;;;  (load "bloques")       ; Carga la definicion del problema
;;;  (bf-control 'sussman)  ; Busca (best-first) la solucion al problema 


(in-package "UCPOP")       ;; Definir el problema en el paquete UCPOP

(define (domain bloques)   ;; Mundo de bloques con una accion
  (:operator mover
     :parameters (?obj ?orig ?dest )
     :precondition (and (sobre ?obj ?orig) (libre ?obj) (libre ?dest))
     :effect (and (not (sobre ?obj ?orig)) (not (libre ?dest)) 
                  (sobre ?obj ?dest) (libre ?orig) (libre Mesa))))


(define (problem facil)     ;; Un problema que STRIPS resuelve bien
  :domain 'bloques
  :inits ((sobre C A) (sobre A Mesa) (sobre B Mesa) 
	      (libre C) (libre B) (libre Mesa))
  :goal (and (sobre A C) (sobre C B)))


(define (problem sussman)   ;; La clasica anomalia de Sussman             
  :domain 'bloques
  :inits ((sobre C A) (sobre A Mesa) (sobre B Mesa) 
	      (libre C) (libre B) (libre Mesa))
  :goal (and (sobre A B) (sobre B C)))


(define (problem insertar)   ;; Insertar el bloque B 
  :domain 'bloques
  :inits ((sobre C A) (sobre A Mesa) (sobre B Mesa) 
	      (libre C) (libre B) (libre Mesa))
  :goal (and (sobre C B) (sobre B A)))


(define (problem imposible)  ;; ¿Que hace UCPOP en este caso?
  :domain 'bloques
  :inits ((sobre C A) (sobre A Mesa) (sobre B Mesa) 
	      (libre C) (libre B) (libre Mesa))
  :goal (and (sobre A B) (sobre B C) (sobre C A)))




