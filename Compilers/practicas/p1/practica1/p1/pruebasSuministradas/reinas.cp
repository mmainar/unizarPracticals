; Programa AJEDREZ.
   ENP L0
; Funcion MIN.
; Recuperacion parametro Y.
   SRF  0  3
   ASGI 
; Recuperacion parametro X.
   SRF  0  4
   ASGI 
; Comienzo funcion MIN.
   JMP L1
L1:
; SI.
; Acceso a parametro X.
   SRF  0  4
   DRF 
; Acceso a parametro Y.
   SRF  0  3
   DRF 
   GT 
   JMF L2
; ENT.
; Devolver.
; Acceso a parametro Y.
   SRF  0  3
   DRF 
   CSF 
   JMP L3
L2:
; SI_NO.
; Devolver.
; Acceso a parametro X.
   SRF  0  4
   DRF 
   CSF 
L3:
; Fin SI.
; Fin Acc/Func.
   CSF 
; Funcion MAX.
; Recuperacion parametro Y.
   SRF  0  3
   ASGI 
; Recuperacion parametro X.
   SRF  0  4
   ASGI 
; Comienzo funcion MAX.
   JMP L4
L4:
; SI.
; Acceso a parametro X.
   SRF  0  4
   DRF 
; Acceso a parametro Y.
   SRF  0  3
   DRF 
   GT 
   JMF L5
; ENT.
; Devolver.
; Acceso a parametro X.
   SRF  0  4
   DRF 
   CSF 
   JMP L6
L5:
; SI_NO.
; Devolver.
; Acceso a parametro Y.
   SRF  0  3
   DRF 
   CSF 
L6:
; Fin SI.
; Fin Acc/Func.
   CSF 
; Accion LINEA.
; Comienzo accion LINEA.
   JMP L7
L7:
; Escribir.
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin Acc/Func.
   CSF 
; Funcion SITIO.
; Recuperacion parametro COLUMNA.
   SRF  0  3
   ASGI 
; Recuperacion parametro FILA.
   SRF  0  4
   ASGI 
; Comienzo funcion SITIO.
   JMP L8
L8:
; Devolver.
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
   STC  1
   SBT 
   STC  8
   TMS 
; Acceso a parametro COLUMNA.
   SRF  0  3
   DRF 
   PLUS 
   CSF 
; Fin Acc/Func.
   CSF 
; Funcion COMPONENTE.
; Recuperacion parametro COLUMNA.
   SRF  0  4
   ASGI 
; Recuperacion parametro FILA.
   SRF  0  5
   ASGI 
; Recuperacion parametro TABLERO.
   SRF  0  3
   ASGI 
; Comienzo funcion COMPONENTE.
   JMP L9
L9:
; Devolver.
; Invocar funcion SITIO.
; Acceso a parametro FILA.
   SRF  0  5
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  4
   DRF 
; Invocacion a funcion SITIO.
   OSF  5  1 45
; Acceso a parametro TABLERO.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   CSF 
; Fin Acc/Func.
   CSF 
; Funcion OCUPADA.
; Recuperacion parametro COLUMNA.
   SRF  0  4
   ASGI 
; Recuperacion parametro FILA.
   SRF  0  5
   ASGI 
; Recuperacion parametro TABLERO.
   SRF  0  3
   ASGI 
; Comienzo funcion OCUPADA.
   JMP L10
L10:
; Devolver.
; Invocar funcion SITIO.
; Acceso a parametro FILA.
   SRF  0  5
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  4
   DRF 
; Invocacion a funcion SITIO.
   OSF  5  1 45
; Acceso a parametro TABLERO.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   STC  0
   GT 
   CSF 
; Fin Acc/Func.
   CSF 
; Accion ASIGNAR_COMPONENTE.
; Recuperacion parametro VALOR.
   SRF  0  4
   ASGI 
; Recuperacion parametro COLUMNA.
   SRF  0  5
   ASGI 
; Recuperacion parametro FILA.
   SRF  0  6
   ASGI 
; Recuperacion parametro TABLERO.
   SRF  0  3
   ASGI 
; Comienzo accion ASIGNAR_COMPONENTE.
   JMP L11
L11:
; Invocar funcion SITIO.
; Acceso a parametro FILA.
   SRF  0  6
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  5
   DRF 
; Invocacion a funcion SITIO.
   OSF  6  1 45
; Direccion de componente de parametro TABLERO.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
; Acceso a parametro VALOR.
   SRF  0  4
   DRF 
; Asignacion.
   ASG 
; Fin Acc/Func.
   CSF 
; Accion MARCAR_COMPONENTE.
; Recuperacion parametro COLUMNA.
   SRF  0  4
   ASGI 
; Recuperacion parametro FILA.
   SRF  0  5
   ASGI 
; Recuperacion parametro TABLERO.
   SRF  0  3
   ASGI 
; Comienzo accion MARCAR_COMPONENTE.
   JMP L12
L12:
; Invocar funcion SITIO.
; Acceso a parametro FILA.
   SRF  0  5
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  4
   DRF 
; Invocacion a funcion SITIO.
   OSF  5  1 45
; Direccion de componente de parametro TABLERO.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
; Invocar funcion SITIO.
; Acceso a parametro FILA.
   SRF  0  5
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  4
   DRF 
; Invocacion a funcion SITIO.
   OSF  5  1 45
; Acceso a parametro TABLERO.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
; Fin Acc/Func.
   CSF 
; Accion DESMARCAR_COMPONENTE.
; Recuperacion parametro COLUMNA.
   SRF  0  4
   ASGI 
; Recuperacion parametro FILA.
   SRF  0  5
   ASGI 
; Recuperacion parametro TABLERO.
   SRF  0  3
   ASGI 
; Comienzo accion DESMARCAR_COMPONENTE.
   JMP L13
L13:
; Invocar funcion SITIO.
; Acceso a parametro FILA.
   SRF  0  5
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  4
   DRF 
; Invocacion a funcion SITIO.
   OSF  5  1 45
; Direccion de componente de parametro TABLERO.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
; Invocar funcion SITIO.
; Acceso a parametro FILA.
   SRF  0  5
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  4
   DRF 
; Invocacion a funcion SITIO.
   OSF  5  1 45
; Acceso a parametro TABLERO.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
; Fin Acc/Func.
   CSF 
; Accion COLOCAR_REINA.
; Recuperacion parametro COLUMNA.
   SRF  0  3
   ASGI 
; Recuperacion parametro FILA.
   SRF  0  4
   ASGI 
; Comienzo accion COLOCAR_REINA.
   JMP L14
L14:
; Invocar accion MARCAR_COMPONENTE.
; Vector por referencia.
   SRF  1 67
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  3
   DRF 
   OSF  6  1 126
; Direccion de variable F.
   SRF  0  6
   STC  1
; Asignacion.
   ASG 
L15:
; MQ.
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  8
   LTE 
   JMF L16
; Invocar accion MARCAR_COMPONENTE.
; Vector por referencia.
   SRF  1  3
; Acceso a variable F.
   SRF  0  6
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  3
   DRF 
   OSF  6  1 126
; Direccion de variable F.
   SRF  0  6
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L15
L16:
; Fin MQ.
; Direccion de variable C.
   SRF  0  5
   STC  1
; Asignacion.
   ASG 
L17:
; MQ.
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  8
   LTE 
   JMF L18
; Invocar accion MARCAR_COMPONENTE.
; Vector por referencia.
   SRF  1  3
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
; Acceso a variable C.
   SRF  0  5
   DRF 
   OSF  6  1 126
; Direccion de variable C.
   SRF  0  5
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L17
L18:
; Fin MQ.
; Direccion de variable F.
   SRF  0  6
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
; Asignacion.
   ASG 
; Direccion de variable C.
   SRF  0  5
; Acceso a parametro COLUMNA.
   SRF  0  3
   DRF 
; Asignacion.
   ASG 
L19:
; MQ.
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  1
   GT 
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  1
   GT 
   AND 
   JMF L20
; Direccion de variable F.
   SRF  0  6
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
; Direccion de variable C.
   SRF  0  5
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
   JMP L19
L20:
L21:
; Fin MQ.
; MQ.
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  8
   LTE 
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  8
   LTE 
   AND 
   JMF L22
; Invocar accion MARCAR_COMPONENTE.
; Vector por referencia.
   SRF  1  3
; Acceso a variable F.
   SRF  0  6
   DRF 
; Acceso a variable C.
   SRF  0  5
   DRF 
   OSF  6  1 126
; Direccion de variable F.
   SRF  0  6
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
; Direccion de variable C.
   SRF  0  5
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L21
L22:
; Fin MQ.
; Direccion de variable F.
   SRF  0  6
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
; Asignacion.
   ASG 
; Direccion de variable C.
   SRF  0  5
; Acceso a parametro COLUMNA.
   SRF  0  3
   DRF 
; Asignacion.
   ASG 
L23:
; MQ.
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  1
   GT 
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  8
   LT 
   AND 
   JMF L24
; Direccion de variable F.
   SRF  0  6
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
; Direccion de variable C.
   SRF  0  5
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L23
L24:
L25:
; Fin MQ.
; MQ.
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  8
   LTE 
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  1
   GTE 
   AND 
   JMF L26
; Invocar accion MARCAR_COMPONENTE.
; Vector por referencia.
   SRF  1  3
; Acceso a variable F.
   SRF  0  6
   DRF 
; Acceso a variable C.
   SRF  0  5
   DRF 
   OSF  6  1 126
; Direccion de variable F.
   SRF  0  6
; Acceso a variable F.
   SRF  0  6
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
; Direccion de variable C.
   SRF  0  5
; Acceso a variable C.
   SRF  0  5
   DRF 
   STC  1
   SBT 
; Asignacion.
   ASG 
   JMP L25
L26:
; Fin MQ.
; Fin Acc/Func.
   CSF 
; Accion INICIAR_TABLERO.
; Comienzo accion INICIAR_TABLERO.
   JMP L27
L27:
; Direccion de variable F.
   SRF  0  4
   STC  1
; Asignacion.
   ASG 
L28:
; MQ.
; Acceso a variable F.
   SRF  0  4
   DRF 
   STC  8
   LTE 
   JMF L29
; Direccion de variable C.
   SRF  0  3
   STC  1
; Asignacion.
   ASG 
L30:
; MQ.
; Acceso a variable C.
   SRF  0  3
   DRF 
   STC  8
   LTE 
   JMF L31
; Invocar accion ASIGNAR_COMPONENTE.
; Vector por referencia.
   SRF  1  3
; Acceso a variable F.
   SRF  0  4
   DRF 
; Acceso a variable C.
   SRF  0  3
   DRF 
   STC  0
   OSF  4  1 103
; Invocar accion ASIGNAR_COMPONENTE.
; Vector por referencia.
   SRF  1 67
; Acceso a variable F.
   SRF  0  4
   DRF 
; Acceso a variable C.
   SRF  0  3
   DRF 
   STC  0
   OSF  4  1 103
; Direccion de variable C.
   SRF  0  3
; Acceso a variable C.
   SRF  0  3
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L30
L31:
; Fin MQ.
; Direccion de variable F.
   SRF  0  4
; Acceso a variable F.
   SRF  0  4
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L28
L29:
; Fin MQ.
; Fin Acc/Func.
   CSF 
; Accion MOSTRAR_TABLERO.
; Recuperacion parametro TABLERO.
   SRF  0  3
   ASGI 
; Comienzo accion MOSTRAR_TABLERO.
   JMP L32
L32:
; Invocar accion LINEA.
   OSF  5  1 39
; Direccion de variable F.
   SRF  0  5
   STC  1
; Asignacion.
   ASG 
L33:
; MQ.
; Acceso a variable F.
   SRF  0  5
   DRF 
   STC  8
   LTE 
   JMF L34
; Direccion de variable C.
   SRF  0  4
   STC  1
; Asignacion.
   ASG 
L35:
; MQ.
; Acceso a variable C.
   SRF  0  4
   DRF 
   STC  8
   LTE 
   JMF L36
; SI.
; Invocar funcion COMPONENTE.
; Vector por referencia.
   SRF  0  3
; Es parametro por referencia.
   DRF 
; Acceso a variable F.
   SRF  0  5
   DRF 
; Acceso a variable C.
   SRF  0  4
   DRF 
; Invocacion a funcion COMPONENTE.
   OSF  5  1 61
   STC  0
   GT 
   JMF L37
; ENT.
; Escribir.
; cadena ' +'.
   STC 32
   WRT  0
   STC 43
   WRT  0
   JMP L38
L37:
; SI_NO.
; Escribir.
; cadena ' .'.
   STC 32
   WRT  0
   STC 46
   WRT  0
L38:
; Fin SI.
; Direccion de variable C.
   SRF  0  4
; Acceso a variable C.
   SRF  0  4
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L35
L36:
; Fin MQ.
; Invocar accion LINEA.
   OSF  5  1 39
; Direccion de variable F.
   SRF  0  5
; Acceso a variable F.
   SRF  0  5
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L33
L34:
; Fin MQ.
; Fin Acc/Func.
   CSF 
; Funcion LIBRE.
; Recuperacion parametro COLUMNA.
   SRF  0  3
   ASGI 
; Recuperacion parametro FILA.
   SRF  0  4
   ASGI 
; Comienzo funcion LIBRE.
   JMP L39
L39:
; Direccion de parametro FILA.
   SRF  0  4
; Por referencia.
   DRF 
   STC  1
; Asignacion.
   ASG 
; Direccion de parametro COLUMNA.
   SRF  0  3
; Por referencia.
   DRF 
   STC  1
; Asignacion.
   ASG 
; Direccion de variable FINAL.
   SRF  0  5
   STC  0
; Asignacion.
   ASG 
L40:
; MQ.
; Acceso a variable FINAL.
   SRF  0  5
   DRF 
   NGB 
   JMF L41
; SI.
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
; Por referencia.
   DRF 
   STC  8
   GT 
   JMF L42
; ENT.
; Direccion de variable FINAL.
   SRF  0  5
   STC  1
; Asignacion.
   ASG 
   JMP L43
L42:
; SI_NO.
; SI.
; Acceso a parametro COLUMNA.
   SRF  0  3
   DRF 
; Por referencia.
   DRF 
   STC  8
   GT 
   JMF L44
; ENT.
; Direccion de parametro COLUMNA.
   SRF  0  3
; Por referencia.
   DRF 
   STC  1
; Asignacion.
   ASG 
; Direccion de parametro FILA.
   SRF  0  4
; Por referencia.
   DRF 
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
; Por referencia.
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L45
L44:
; SI_NO.
; SI.
; Invocar funcion OCUPADA.
; Vector por referencia.
   SRF  1  3
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
; Por referencia.
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  3
   DRF 
; Por referencia.
   DRF 
; Invocacion a funcion OCUPADA.
   OSF  5  1 81
   JMF L46
; ENT.
; Direccion de parametro COLUMNA.
   SRF  0  3
; Por referencia.
   DRF 
; Acceso a parametro COLUMNA.
   SRF  0  3
   DRF 
; Por referencia.
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L47
L46:
; SI_NO.
; Direccion de variable FINAL.
   SRF  0  5
   STC  1
; Asignacion.
   ASG 
L47:
L45:
L43:
; Fin SI.
; Fin SI.
; Fin SI.
   JMP L40
L41:
; Fin MQ.
; SI.
; Acceso a parametro FILA.
   SRF  0  4
   DRF 
; Por referencia.
   DRF 
   STC  8
   GT 
   JMF L48
; ENT.
; Devolver.
   STC  0
   CSF 
   JMP L49
L48:
; SI_NO.
; Devolver.
   STC  1
   CSF 
L49:
; Fin SI.
; Fin Acc/Func.
   CSF 
L0:
; Comienzo del programa AJEDREZ.
; Direccion de variable FILA.
   SRF  0 134
   STC  1
; Asignacion.
   ASG 
L50:
; MQ.
; Acceso a variable FILA.
   SRF  0 134
   DRF 
   STC  8
   LTE 
   JMF L51
; Direccion de variable COLUMNA.
   SRF  0 133
   STC  1
; Asignacion.
   ASG 
L52:
; MQ.
; Acceso a variable COLUMNA.
   SRF  0 133
   DRF 
   STC  8
   LTE 
   JMF L53
; Direccion de variable NREINAS.
   SRF  0 135
   STC  1
; Asignacion.
   ASG 
; Invocar accion INICIAR_TABLERO.
   OSF 135  0 364
; Invocar accion COLOCAR_REINA.
; Acceso a variable FILA.
   SRF  0 134
   DRF 
; Acceso a variable COLUMNA.
   SRF  0 133
   DRF 
   OSF 135  0 190
L54:
; MQ.
; Acceso a variable NREINAS.
   SRF  0 135
   DRF 
   STC  8
   LT 
; Invocar funcion LIBRE.
; Acceso a variable F.
   SRF  0 132
; Acceso a variable C.
   SRF  0 131
; Invocacion a funcion LIBRE.
   OSF 135  0 465
   AND 
   JMF L55
; Invocar accion COLOCAR_REINA.
; Acceso a variable F.
   SRF  0 132
   DRF 
; Acceso a variable C.
   SRF  0 131
   DRF 
   OSF 135  0 190
; Direccion de variable NREINAS.
   SRF  0 135
; Acceso a variable NREINAS.
   SRF  0 135
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L54
L55:
; Fin MQ.
; SI.
; Acceso a variable NREINAS.
   SRF  0 135
   DRF 
   STC  8
   EQ 
   JMF L56
; ENT.
; Invocar accion MOSTRAR_TABLERO.
; Vector por referencia.
   SRF  0 67
   OSF 135  0 410
L56:
; Fin SI.
; Direccion de variable COLUMNA.
   SRF  0 133
; Acceso a variable COLUMNA.
   SRF  0 133
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L52
L53:
; Fin MQ.
; Direccion de variable FILA.
   SRF  0 134
; Acceso a variable FILA.
   SRF  0 134
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L50
L51:
; Fin MQ.
   LVP 
