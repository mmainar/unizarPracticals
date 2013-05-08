;;;;----------------------------------------------------------------
;;;; Fichero:   mono.lisp
;;;; Autor:     Marcos Mainar Lalmolda
;;;; Version:   v1.0  29-4-2004
;;;; Proposito: Mono con platanos
;;;;----------------------------------------------------------------
;;; Para probar un ejemplo debes teclear:
;;;  (load "cargar")        ; Carga el planificador UCPOP
;;;  (in-package "UCPOP")   ; Hay que trabajar en el package UCPOP
;;;  (load "mono")       ; Carga la definicion del problema
;;;  (bf-control 'mono1)  ; Busca (best-first) la solucion al problema


(in-package "UCPOP")       ;; Definir el problema en el paquete UCPOP

(define (domain mono)   ;; Mundo de mono con platanos
 (:operator ir-de-A-a-B
    :precondition (and (esta mono A) (abierta AB) (en-suelo))
    :effect (and (not (esta mono A)) (esta mono B)))

 (:operator ir-de-B-a-A
    :precondition (and (esta mono B) (abierta AB) (en-suelo))
    :effect (and (not (esta mono B)) (esta mono A)))

 (:operator ir-de-B-a-C
    :precondition (and (esta mono B) (abierta BC) (en-suelo))
    :effect (and (not (esta mono B)) (esta mono C)))

 (:operator ir-de-C-a-B
    :precondition (and (esta mono C) (abierta BC) (en-suelo))
    :effect (and (not (esta mono C)) (esta mono B)))

 (:operator ir-de-A-a-B-con-caja
    :precondition (and (esta mono A) (esta caja A) (abierta AB) (en-suelo))
    :effect (and (not (esta mono A)) (not (esta caja A)) (esta mono B) (esta caja B)))

 (:operator ir-de-B-a-A-con-caja
    :precondition (and (esta mono B) (esta caja B) (abierta AB) (en-suelo))
    :effect (and (not (esta mono B)) (not (esta caja B)) (esta mono A) (esta caja A)))

 (:operator ir-de-B-a-C-con-caja
    :precondition (and (esta mono B) (esta caja B) (abierta BC) (en-suelo))
    :effect (and (not (esta mono B)) (not (esta caja B)) (esta mono C) (esta caja C)))

 (:operator ir-de-C-a-B-con-caja
    :precondition (and (esta mono C) (esta caja C) (abierta BC) (en-suelo))
    :effect (and (not (esta mono C)) (not (esta caja C)) (esta mono B) (esta caja B)))

 (:operator abrir-AB-desde-A
    :precondition (and (not (abierta AB)) (esta mono A) (en-suelo))
    :effect (abierta AB))

 (:operator abrir-AB-desde-B
    :precondition (and (not (abierta AB)) (esta mono B) (en-suelo))
    :effect (abierta AB))

 (:operator abrir-BC-desde-B
    :precondition (and (not (abierta BC)) (esta mono B) (en-suelo))
    :effect (abierta BC))

 (:operator abrir-BC-desde-C
    :precondition (and (not (abierta BC)) (esta mono C) (en-suelo))
    :effect (abierta BC))

 (:operator cerrar-AB-desde-A
    :precondition (and (abierta AB) (esta mono A) (en-suelo))
    :effect (not (abierta AB)))

 (:operator cerrar-AB-desde-B
    :precondition (and (abierta AB) (esta mono B) (en-suelo))
    :effect (not (abierta AB)))

 (:operator cerrar-BC-desde-B
    :precondition (and (abierta BC) (esta mono B) (en-suelo))
    :effect (not (abierta BC)))

 (:operator cerrar-BC-desde-C
    :precondition (and (abierta BC) (esta mono C) (en-suelo))
    :effect (not (abierta BC)))

 (:operator subir
    :parameters (?x)
    :precondition (and (esta mono ?x) (esta caja ?x) (en-suelo))
    :effect (and (not (en-suelo)) (subido-caja ?x)))

 (:operator bajar
    :parameters (?x)
    :precondition (subido-caja ?x)
    :effect (and (en-suelo) (not (subido-caja ?x))))

 (:operator coger-platanos
    :parameters (?x)
    :precondition (and (esta platanos ?x) (subido-caja ?x))
    :effect (tener-platanos)))


(define (problem mono1)
 :domain 'mono
 :inits ((esta mono A) (esta platanos A) (esta caja C)
             (not (abierta AB)) (not (abierta BC)) (en-suelo))
 :goal (tener-platanos))

(define (problem mono2)
 :domain 'mono
 :inits ((esta mono A) (esta platanos A) (esta caja C)
             (not (abierta AB)) (not (abierta BC)) (en-suelo))
 :goal (and (tener-platanos) (esta caja C) (esta mono A)
            (not (abierta AB)) (not (abierta BC))))


