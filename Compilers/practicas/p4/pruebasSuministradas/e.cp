; Programa CALCULAR_E.
   ENP L0
; Accion INICIAR.
LINICIAR:
; Recuperacion parametro S.
   SRF  0  3
   ASGI 
; Comienzo accion INICIAR.
   JMP L1
L1:
; Direccion de variable I.
   SRF  0  4
   STC  0
; Asignacion.
   ASG 
L2:
; MQ.
; Acceso a variable I.
   SRF  0  4
   DRF 
   STC 40
   LTE 
   JMF L3
; Acceso a variable I.
   SRF  0  4
   DRF 
; Direccion de componente de parametro S.
   STC  0
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   STC  0
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
; Accion MOSTRAR_NUMERO.
LMOSTRAR_NUMERO:
; Recuperacion parametro S.
   SRF  0  3
   ASGI 
; Comienzo accion MOSTRAR_NUMERO.
   JMP L4
L4:
; Escribir.
   STC  0
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   WRT  1
   STC 46
   WRT  0
; Direccion de variable I.
   SRF  0  4
   STC  1
; Asignacion.
   ASG 
L5:
; MQ.
; Acceso a variable I.
   SRF  0  4
   DRF 
   STC 40
   LTE 
   JMF L6
; Escribir.
; Acceso a variable I.
   SRF  0  4
   DRF 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   WRT  1
; Direccion de variable I.
   SRF  0  4
; Acceso a variable I.
   SRF  0  4
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
; Accion SUMAR.
LSUMAR:
; Recuperacion parametro R.
   SRF  0  3
   ASGI 
; Recuperacion parametro S.
   SRF  0  4
   ASGI 
; Comienzo accion SUMAR.
   JMP L7
L7:
; Direccion de variable I.
   SRF  0  6
   STC 40
; Asignacion.
   ASG 
L8:
; MQ.
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  0
   GT 
   JMF L9
; Direccion de variable N.
   SRF  0  5
; Acceso a variable I.
   SRF  0  6
   DRF 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a variable I.
   SRF  0  6
   DRF 
; Acceso a parametro R.
   STC  0
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   PLUS 
; Asignacion.
   ASG 
; SI.
; Acceso a variable N.
   SRF  0  5
   DRF 
   STC  9
   GT 
   JMF L10
; ENT.
; Acceso a variable I.
   SRF  0  6
   DRF 
; Direccion de componente de parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
; Acceso a variable N.
   SRF  0  5
   DRF 
   STC 10
   MOD 
; Asignacion.
   ASG 
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  1
   SBT 
; Direccion de componente de parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  1
   SBT 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a variable N.
   SRF  0  5
   DRF 
   STC 10
   DIV 
   PLUS 
; Asignacion.
   ASG 
   JMP L11
L10:
; SI_NO.
; Acceso a variable I.
   SRF  0  6
   DRF 
; Direccion de componente de parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
; Acceso a variable N.
   SRF  0  5
   DRF 
; Asignacion.
   ASG 
L11:
; Fin SI.
; Direccion de variable I.
   SRF  0  6
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
   JMP L8
L9:
; Fin MQ.
; Fin Acc/Func.
   CSF 
; Accion DIVIDIR.
LDIVIDIR:
; Recuperacion parametro N.
   SRF  0  5
   ASGI 
; Recuperacion parametro R.
   SRF  0  3
   ASGI 
; Recuperacion parametro S.
   SRF  0  4
   ASGI 
; Comienzo accion DIVIDIR.
   JMP L12
L12:
; Direccion de variable I.
   SRF  0  6
   STC  0
; Asignacion.
   ASG 
L13:
; MQ.
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC 40
   LT 
   JMF L14
; SI.
; Acceso a variable I.
   SRF  0  6
   DRF 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a parametro N.
   SRF  0  5
   DRF 
   DIV 
   STC  0
   GT 
   JMF L15
; ENT.
; Acceso a variable I.
   SRF  0  6
   DRF 
; Direccion de componente de parametro R.
   STC  0
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
; Acceso a variable I.
   SRF  0  6
   DRF 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a parametro N.
   SRF  0  5
   DRF 
   DIV 
; Asignacion.
   ASG 
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Direccion de componente de parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
; Acceso a variable I.
   SRF  0  6
   DRF 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a parametro N.
   SRF  0  5
   DRF 
   MOD 
   STC 10
   TMS 
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
   DRF 
   PLUS 
; Asignacion.
   ASG 
   JMP L16
L15:
; SI_NO.
; Acceso a variable I.
   SRF  0  6
   DRF 
; Direccion de componente de parametro R.
   STC  0
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   STC  0
; Asignacion.
   ASG 
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Direccion de componente de parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
; Acceso a variable I.
   SRF  0  6
   DRF 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
   DRF 
   STC 10
   TMS 
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Acceso a parametro S.
   STC  0
   PLUS 
   SRF  0  4
; Por referencia.
   DRF 
   PLUS 
   DRF 
   PLUS 
; Asignacion.
   ASG 
L16:
; Fin SI.
; Direccion de variable I.
   SRF  0  6
; Acceso a variable I.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L13
L14:
; Fin MQ.
; Fin Acc/Func.
   CSF 
L0:
; Comienzo del programa CALCULAR_E.
; Invocar accion INICIAR.
; Vector por referencia.
   SRF  0 44
   OSF 126  0  LINICIAR
; Invocar accion INICIAR.
; Vector por referencia.
   SRF  0 85
   OSF 126  0  LINICIAR
   STC  0
; Direccion de componente de vector SUMANDO.
   STC  0
   PLUS 
   SRF  0 44
   PLUS 
   STC  1
; Asignacion.
   ASG 
   STC  0
; Direccion de componente de vector E.
   STC  0
   PLUS 
   SRF  0 85
   PLUS 
   STC  2
; Asignacion.
   ASG 
; Direccion de variable N.
   SRF  0 126
   STC  2
; Asignacion.
   ASG 
L17:
; MQ.
; Acceso a variable N.
   SRF  0 126
   DRF 
   STC 40
   LT 
   JMF L18
; Invocar accion DIVIDIR.
; Vector por referencia.
   SRF  0 44
; Vector por referencia.
   SRF  0  3
; Acceso a variable N.
   SRF  0 126
   DRF 
   OSF 126  0 LDIVIDIR
; Invocar accion SUMAR.
; Vector por referencia.
   SRF  0 85
; Vector por referencia.
   SRF  0  3
   OSF 126  0 LSUMAR
; Asignacion.
   SRF  0 44
   STC  0
   PLUS 
   SRF  0  3
   STC  0
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  1
   PLUS 
   SRF  0  3
   STC  1
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  2
   PLUS 
   SRF  0  3
   STC  2
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  3
   PLUS 
   SRF  0  3
   STC  3
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  4
   PLUS 
   SRF  0  3
   STC  4
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  5
   PLUS 
   SRF  0  3
   STC  5
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  6
   PLUS 
   SRF  0  3
   STC  6
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  7
   PLUS 
   SRF  0  3
   STC  7
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  8
   PLUS 
   SRF  0  3
   STC  8
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC  9
   PLUS 
   SRF  0  3
   STC  9
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 10
   PLUS 
   SRF  0  3
   STC 10
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 11
   PLUS 
   SRF  0  3
   STC 11
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 12
   PLUS 
   SRF  0  3
   STC 12
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 13
   PLUS 
   SRF  0  3
   STC 13
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 14
   PLUS 
   SRF  0  3
   STC 14
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 15
   PLUS 
   SRF  0  3
   STC 15
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 16
   PLUS 
   SRF  0  3
   STC 16
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 17
   PLUS 
   SRF  0  3
   STC 17
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 18
   PLUS 
   SRF  0  3
   STC 18
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 19
   PLUS 
   SRF  0  3
   STC 19
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 20
   PLUS 
   SRF  0  3
   STC 20
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 21
   PLUS 
   SRF  0  3
   STC 21
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 22
   PLUS 
   SRF  0  3
   STC 22
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 23
   PLUS 
   SRF  0  3
   STC 23
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 24
   PLUS 
   SRF  0  3
   STC 24
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 25
   PLUS 
   SRF  0  3
   STC 25
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 26
   PLUS 
   SRF  0  3
   STC 26
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 27
   PLUS 
   SRF  0  3
   STC 27
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 28
   PLUS 
   SRF  0  3
   STC 28
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 29
   PLUS 
   SRF  0  3
   STC 29
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 30
   PLUS 
   SRF  0  3
   STC 30
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 31
   PLUS 
   SRF  0  3
   STC 31
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 32
   PLUS 
   SRF  0  3
   STC 32
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 33
   PLUS 
   SRF  0  3
   STC 33
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 34
   PLUS 
   SRF  0  3
   STC 34
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 35
   PLUS 
   SRF  0  3
   STC 35
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 36
   PLUS 
   SRF  0  3
   STC 36
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 37
   PLUS 
   SRF  0  3
   STC 37
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 38
   PLUS 
   SRF  0  3
   STC 38
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 39
   PLUS 
   SRF  0  3
   STC 39
   PLUS 
   DRF 
   ASG 
   SRF  0 44
   STC 40
   PLUS 
   SRF  0  3
   STC 40
   PLUS 
   DRF 
   ASG 
; Direccion de variable N.
   SRF  0 126
; Acceso a variable N.
   SRF  0 126
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L17
L18:
; Fin MQ.
; Escribir.
; cadena 'E con '.
   STC 69
   WRT  0
   STC 32
   WRT  0
   STC 99
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 40
   WRT  1
; cadena ' cifras decimales es: '.
   STC 32
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 102
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 109
   WRT  0
   STC 97
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
; Invocar accion MOSTRAR_NUMERO.
; Vector por referencia.
   SRF  0 85
   OSF 126  0 LMOSTRAR_NUMERO
   LVP 
