;;;;----------------------------------------------------------
;;;; Fichero:   cargar.lisp
;;;; Autor:     J.D.Tardos
;;;; Version:   v1.0  27-2-2002
;;;; Proposito: cargar el planificador UCPOP v4.1
;;;;----------------------------------------------------------

;;; Directorio donde esta instalado el planificador
(defparameter *ucpop41-dir* "/users2/IAIC2/salidas/ucpop41/")

(load (concatenate 'string *ucpop41-dir* "loader"))
(setf *ucpop-dir* *ucpop41-dir*)
(load-ucpop)
(in-package "UCPOP")
(setf *search-limit* 20000)
