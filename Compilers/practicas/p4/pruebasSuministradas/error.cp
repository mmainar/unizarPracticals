; Programa QS.
   ENP L0
; Accion INICIALIZAR.
; Recuperacion parametro T.
   SRF  0  3
   ASGI 
; Comienzo accion INICIALIZAR.
   JMP L1
L1:
; Direccion de variable I.
   SRF  0  4
   STC  1
; Asignacion.
   ASG 
L2:
; MQ.
; Acceso a variable I.
   SRF  0  4
   DRF 
   STC 20
   LTE 
   JMF L3
; Acceso a variable I.
   SRF  0  4
   DRF 
; Direccion de componente de parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   STC 20
; Acceso a variable I.
   SRF  0  4
   DRF 
   SBT 
; Asignacion.
   ASG 
; Direccion de variable I.
   SRF  0  4
; Acceso a variable I.
   SRF  0  4
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L2
L3:
; Fin MQ.
; Fin Acc/Func.
   CSF 
; Accion MOSTRAR.
; Recuperacion parametro T.
   SRF  0 22
   ASGI 
   SRF  0 21
   ASGI 
   SRF  0 20
   ASGI 
   SRF  0 19
   ASGI 
   SRF  0 18
   ASGI 
   SRF  0 17
   ASGI 
   SRF  0 16
   ASGI 
   SRF  0 15
   ASGI 
   SRF  0 14
   ASGI 
   SRF  0 13
   ASGI 
   SRF  0 12
   ASGI 
   SRF  0 11
   ASGI 
   SRF  0 10
   ASGI 
   SRF  0  9
   ASGI 
   SRF  0  8
   ASGI 
   SRF  0  7
   ASGI 
   SRF  0  6
   ASGI 
   SRF  0  5
   ASGI 
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
; Comienzo accion MOSTRAR.
   JMP L4
L4:
; Direccion de variable I.
   SRF  0 23
   STC  1
; Asignacion.
   ASG 
L5:
; MQ.
; Acceso a variable I.
   SRF  0 23
   DRF 
   STC 20
   LTE 
   JMF L6
; Escribir.
; Acceso a variable I.
   SRF  0 23
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
   PLUS 
   DRF 
   WRT  1
   STC 32
   WRT  0
; Direccion de variable I.
   SRF  0 23
; Acceso a variable I.
   SRF  0 23
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L5
L6:
; Fin MQ.
; Escribir.
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin Acc/Func.
   CSF 
; Accion INTERCAMBIAR.
; Recuperacion parametro J.
   SRF  0  3
   ASGI 
; Recuperacion parametro I.
   SRF  0  4
   ASGI 
; Comienzo accion INTERCAMBIAR.
   JMP L7
L7:
; Direccion de variable K.
   SRF  0  5
; Acceso a parametro I.
   SRF  0  4
   DRF 
; Por referencia.
   DRF 
; Asignacion.
   ASG 
; Direccion de parametro I.
   SRF  0  4
; Por referencia.
   DRF 
; Acceso a parametro J.
   SRF  0  3
   DRF 
; Por referencia.
   DRF 
; Asignacion.
   ASG 
; Direccion de parametro J.
   SRF  0  3
; Por referencia.
   DRF 
; Acceso a variable K.
   SRF  0  5
   DRF 
; Asignacion.
   ASG 
; Fin Acc/Func.
   CSF 
; Accion ORDENAR.
; Recuperacion parametro J.
   SRF  0  3
   ASGI 
; Recuperacion parametro I.
   SRF  0  4
   ASGI 
; Comienzo accion ORDENAR.
   JMP L8
L8:
; SI.
; Acceso a parametro I.
   SRF  0  4
   DRF 
; Por referencia.
   DRF 
; Acceso a parametro J.
   SRF  0  3
   DRF 
; Por referencia.
   DRF 
   GT 
   JMF L9
; ENT.
; Invocar accion INTERCAMBIAR.
; Acceso a parametro I.
   SRF  0  4
   DRF 
; Por referencia.
; Acceso a parametro J.
   SRF  0  3
   DRF 
; Por referencia.
   OSF  4  1 103
L9:
; Fin SI.
; Fin Acc/Func.
   CSF 
; Accion DIVIDE.
; Recuperacion parametro ME.
   SRF  0  6
   ASGI 
; Recuperacion parametro DER.
   SRF  0  4
   ASGI 
; Recuperacion parametro IZQ.
   SRF  0  5
   ASGI 
; Recuperacion parametro T.
   SRF  0  3
   ASGI 
; Comienzo accion DIVIDE.
   JMP L11
L11:
; Direccion de variable P.
   SRF  0  8
; Acceso a parametro IZQ.
   SRF  0  5
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Asignacion.
   ASG 
; Direccion de variable K.
   SRF  0  7
; Acceso a parametro IZQ.
   SRF  0  5
   DRF 
; Asignacion.
   ASG 
; Direccion de parametro ME.
   SRF  0  6
; Por referencia.
   DRF 
; Acceso a parametro DER.
   SRF  0  4
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
; Direccion de variable K.
   SRF  0  7
; Acceso a variable K.
   SRF  0  7
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
L12:
L12:
; MQ.
; Acceso a variable K.
   SRF  0  7
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a variable P.
   SRF  0  8
   DRF 
   LTE 
; Acceso a variable K.
   SRF  0  7
   DRF 
; Acceso a parametro DER.
   SRF  0  4
   DRF 
   LT 
   AND 
   JMF L13
; Direccion de variable K.
   SRF  0  7
; Acceso a variable K.
   SRF  0  7
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L12
L13:
; Fin MQ.
; Direccion de parametro ME.
   SRF  0  6
; Por referencia.
   DRF 
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
L14:
; MQ.
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a variable P.
   SRF  0  8
   DRF 
   GT 
   JMF L15
; Direccion de parametro ME.
   SRF  0  6
; Por referencia.
   DRF 
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
   JMP L14
L15:
L16:
; Fin MQ.
; MQ.
; Acceso a variable K.
   SRF  0  7
   DRF 
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
   LT 
   JMF L17
; Invocar accion INTERCAMBIAR.
; Acceso a variable K.
   SRF  0  7
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   OSF  8  1 103
; Direccion de variable K.
   SRF  0  7
; Acceso a variable K.
   SRF  0  7
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
L18:
; MQ.
; Acceso a variable K.
   SRF  0  7
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a variable P.
   SRF  0  8
   DRF 
   LTE 
   JMF L19
; Direccion de variable K.
   SRF  0  7
; Acceso a variable K.
   SRF  0  7
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L18
L19:
; Fin MQ.
; Direccion de parametro ME.
   SRF  0  6
; Por referencia.
   DRF 
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
L20:
; MQ.
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a variable P.
   SRF  0  8
   DRF 
   GT 
   JMF L21
; Direccion de parametro ME.
   SRF  0  6
; Por referencia.
   DRF 
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
   JMP L20
L21:
; Fin MQ.
   JMP L16
L17:
; Fin MQ.
; Invocar accion INTERCAMBIAR.
; Acceso a parametro IZQ.
   SRF  0  5
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
; Acceso a parametro ME.
   SRF  0  6
   DRF 
; Por referencia.
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   OSF  8  1 103
; Fin Acc/Func.
   CSF 
; Accion QUICKSORT.
; Recuperacion parametro DER.
   SRF  0  4
   ASGI 
; Recuperacion parametro IZQ.
   SRF  0  5
   ASGI 
; Recuperacion parametro T.
   SRF  0  3
   ASGI 
; Comienzo accion QUICKSORT.
   JMP L22
L22:
; SI.
; Acceso a parametro DER.
   SRF  0  4
   DRF 
; Acceso a parametro IZQ.
   SRF  0  5
   DRF 
   GT 
   JMF L23
; ENT.
; Invocar accion MOSTRAR.
; Vector por valor.
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  0
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  1
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  2
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  3
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  4
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  5
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  6
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  7
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  8
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC  9
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 10
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 11
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 12
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 13
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 14
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 15
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 16
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 17
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 18
   PLUS 
   DRF 
   SRF  0  3
; Es parametro por referencia.
   DRF 
   STC 19
   PLUS 
   DRF 
   OSF  6  1 32
; SI.
; Acceso a parametro DER.
   SRF  0  4
   DRF 
; Acceso a parametro IZQ.
   SRF  0  5
   DRF 
   SBT 
   STC  1
   EQ 
   JMF L24
; ENT.
; Invocar accion ORDENAR.
; Acceso a parametro IZQ.
   SRF  0  5
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
; Acceso a parametro DER.
   SRF  0  4
   DRF 
; Acceso a parametro T.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   OSF  6  1 125
   JMP L25
L24:
; SI_NO.
; Invocar accion DIVIDE.
; Vector por referencia.
   SRF  0  3
; Es parametro por referencia.
   DRF 
; Acceso a parametro IZQ.
   SRF  0  5
   DRF 
; Acceso a parametro DER.
   SRF  0  4
   DRF 
; Acceso a variable ME.
   SRF  0  6
   OSF  6  1 144
; Invocar accion QUICKSORT.
; Vector por referencia.
   SRF  0  3
; Es parametro por referencia.
   DRF 
; Acceso a parametro IZQ.
   SRF  0  5
   DRF 
; Acceso a variable ME.
   SRF  0  6
   DRF 
   STC  1
   SBT 
   OSF  6  1 331
; Invocar accion QUICKSORT.
; Vector por referencia.
   SRF  0  3
; Es parametro por referencia.
   DRF 
; Acceso a variable ME.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Acceso a parametro DER.
   SRF  0  4
   DRF 
   OSF  6  1 331
L25:
L23:
; Fin SI.
; Fin SI.
; Fin Acc/Func.
   CSF 
L1:
; Comienzo del programa QS.
; Invocar accion INICIALIZAR.
; Vector por referencia.
   SRF  0  3
   OSF 22  0  1
; Invocar accion QUICKSORT.
; Vector por referencia.
   SRF  0  3
   STC  1
   STC 20
   OSF 22  0 331
   LVP 
L1000:

