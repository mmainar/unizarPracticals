; Programa TORRES.
   ENP L0
; Accion HANOI.
; Recuperacion parametro AUXILIAR.
   SRF  0  4
   ASGI 
; Recuperacion parametro DESTINO.
   SRF  0  5
   ASGI 
; Recuperacion parametro ORIGEN.
   SRF  0  6
   ASGI 
; Recuperacion parametro N.
   SRF  0  3
   ASGI 
; Comienzo accion HANOI.
   JMP L1
L1:
; SI.
; Acceso a parametro N.
   SRF  0  3
   DRF 
   STC  1
   EQ 
   JMF L2
; ENT.
; Escribir.
; cadena 'Mover de la torre '.
   STC 77
   WRT  0
   STC 111
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 114
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
; Acceso a parametro ORIGEN.
   SRF  0  6
   DRF 
   WRT  0
; cadena ' a la torre '.
   STC 32
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 114
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
; Acceso a parametro DESTINO.
   SRF  0  5
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
; Direccion de variable PASOS.
   SRF  1  3
; Acceso a variable PASOS.
   SRF  1  3
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L3
L2:
; SI_NO.
; Invocar accion HANOI.
; Acceso a parametro N.
   SRF  0  3
   DRF 
   STC  1
   SBT 
; Acceso a parametro ORIGEN.
   SRF  0  6
   DRF 
; Acceso a parametro AUXILIAR.
   SRF  0  4
   DRF 
; Acceso a parametro DESTINO.
   SRF  0  5
   DRF 
   OSF  6  1  1
; Invocar accion HANOI.
   STC  1
; Acceso a parametro ORIGEN.
   SRF  0  6
   DRF 
; Acceso a parametro DESTINO.
   SRF  0  5
   DRF 
; Acceso a parametro AUXILIAR.
   SRF  0  4
   DRF 
   OSF  6  1  1
; Invocar accion HANOI.
; Acceso a parametro N.
   SRF  0  3
   DRF 
   STC  1
   SBT 
; Acceso a parametro AUXILIAR.
   SRF  0  4
   DRF 
; Acceso a parametro DESTINO.
   SRF  0  5
   DRF 
; Acceso a parametro ORIGEN.
   SRF  0  6
   DRF 
   OSF  6  1  1
L3:
; Fin SI.
; Fin Acc/Func.
   CSF 
L0:
; Comienzo del programa TORRES.
; Direccion de variable PASOS.
   SRF  0  3
   STC  0
; Asignacion.
   ASG 
; Invocar accion HANOI.
   STC  4
   STC 49
   STC 51
   STC 50
   OSF  3  0  1
; Escribir.
; Acceso a variable PASOS.
   SRF  0  3
   DRF 
   WRT  1
   STC 13
   WRT  0
   LVP 
