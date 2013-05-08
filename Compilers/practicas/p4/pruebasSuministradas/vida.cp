; Programa JUEGODELAVIDA.
   ENP L0
; Accion INICIALIZAR.
; Recuperacion parametro COLONIA.
   SRF  0  3
   ASGI 
; Comienzo accion INICIALIZAR.
   JMP L1
L1:
; Direccion de variable ELEMENTOS.
   SRF  1 82
   STC 79
; Asignacion.
   ASG 
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
; Acceso a variable ELEMENTOS.
   SRF  1 82
   DRF 
   LTE 
   JMF L3
; Acceso a variable I.
   SRF  0  4
   DRF 
; Direccion de componente de parametro COLONIA.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
; Acceso a variable I.
   SRF  0  4
   DRF 
   STC 20
   MOD 
   STC  0
   EQ 
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
; Accion SIGUIENTEGENERACION.
; Recuperacion parametro COLONIA.
   SRF  0  3
   ASGI 
; Comienzo accion SIGUIENTEGENERACION.
   JMP L4
; Funcion VIVIRA.
; Recuperacion parametro I.
   SRF  0  4
   ASGI 
; Recuperacion parametro COLONIA.
   SRF  0  3
   ASGI 
; Comienzo funcion VIVIRA.
   JMP L5
L5:
; SI.
; Acceso a parametro I.
   SRF  0  4
   DRF 
   STC  1
   EQ 
   JMF L6
; ENT.
; Devolver.
   STC  0
   CSF 
   JMP L7
L6:
; SI_NO.
; SI.
; Acceso a parametro I.
   SRF  0  4
   DRF 
; Acceso a variable ELEMENTOS.
   SRF  2 82
   DRF 
   EQ 
   JMF L8
; ENT.
; Devolver.
   STC  0
   CSF 
   JMP L9
L8:
; SI_NO.
; Devolver.
; Acceso a parametro I.
   SRF  0  4
   DRF 
; Acceso a parametro COLONIA.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   NGB 
; Acceso a parametro I.
   SRF  0  4
   DRF 
   STC  1
   SBT 
; Acceso a parametro COLONIA.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
; Acceso a parametro I.
   SRF  0  4
   DRF 
   STC  1
   PLUS 
; Acceso a parametro COLONIA.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   NGB 
   AND 
; Acceso a parametro I.
   SRF  0  4
   DRF 
   STC  1
   SBT 
; Acceso a parametro COLONIA.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   NGB 
; Acceso a parametro I.
   SRF  0  4
   DRF 
   STC  1
   PLUS 
; Acceso a parametro COLONIA.
   STC -1
   PLUS 
   SRF  0  3
; Por referencia.
   DRF 
   PLUS 
   DRF 
   AND 
   OR 
   AND 
   CSF 
L9:
L7:
; Fin SI.
; Fin SI.
; Fin Acc/Func.
   CSF 
L4:
; Direccion de variable I.
   SRF  0  4
   STC  1
; Asignacion.
   ASG 
L10:
; MQ.
; Acceso a variable I.
   SRF  0  4
   DRF 
; Acceso a variable ELEMENTOS.
   SRF  1 82
   DRF 
   LTE 
   JMF L11
; Acceso a variable I.
   SRF  0  4
   DRF 
; Direccion de componente de vector SIGUIENTE.
   STC -1
   PLUS 
   SRF  0  5
   PLUS 
; Invocar funcion VIVIRA.
; Vector por referencia.
   SRF  0  3
; Es parametro por referencia.
   DRF 
; Acceso a variable I.
   SRF  0  4
   DRF 
; Invocacion a funcion VIVIRA.
   OSF 83  0 41
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
   JMP L10
L11:
; Fin MQ.
; Asignacion.
   SRF  0  3
   DRF 
   STC  0
   PLUS 
   SRF  0  5
   STC  0
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   SRF  0  5
   STC  1
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  2
   PLUS 
   SRF  0  5
   STC  2
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  3
   PLUS 
   SRF  0  5
   STC  3
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  4
   PLUS 
   SRF  0  5
   STC  4
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  5
   PLUS 
   SRF  0  5
   STC  5
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  6
   PLUS 
   SRF  0  5
   STC  6
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  7
   PLUS 
   SRF  0  5
   STC  7
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  8
   PLUS 
   SRF  0  5
   STC  8
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC  9
   PLUS 
   SRF  0  5
   STC  9
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 10
   PLUS 
   SRF  0  5
   STC 10
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 11
   PLUS 
   SRF  0  5
   STC 11
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 12
   PLUS 
   SRF  0  5
   STC 12
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 13
   PLUS 
   SRF  0  5
   STC 13
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 14
   PLUS 
   SRF  0  5
   STC 14
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 15
   PLUS 
   SRF  0  5
   STC 15
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 16
   PLUS 
   SRF  0  5
   STC 16
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 17
   PLUS 
   SRF  0  5
   STC 17
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 18
   PLUS 
   SRF  0  5
   STC 18
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 19
   PLUS 
   SRF  0  5
   STC 19
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 20
   PLUS 
   SRF  0  5
   STC 20
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 21
   PLUS 
   SRF  0  5
   STC 21
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 22
   PLUS 
   SRF  0  5
   STC 22
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 23
   PLUS 
   SRF  0  5
   STC 23
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 24
   PLUS 
   SRF  0  5
   STC 24
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 25
   PLUS 
   SRF  0  5
   STC 25
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 26
   PLUS 
   SRF  0  5
   STC 26
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 27
   PLUS 
   SRF  0  5
   STC 27
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 28
   PLUS 
   SRF  0  5
   STC 28
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 29
   PLUS 
   SRF  0  5
   STC 29
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 30
   PLUS 
   SRF  0  5
   STC 30
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 31
   PLUS 
   SRF  0  5
   STC 31
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 32
   PLUS 
   SRF  0  5
   STC 32
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 33
   PLUS 
   SRF  0  5
   STC 33
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 34
   PLUS 
   SRF  0  5
   STC 34
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 35
   PLUS 
   SRF  0  5
   STC 35
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 36
   PLUS 
   SRF  0  5
   STC 36
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 37
   PLUS 
   SRF  0  5
   STC 37
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 38
   PLUS 
   SRF  0  5
   STC 38
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 39
   PLUS 
   SRF  0  5
   STC 39
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 40
   PLUS 
   SRF  0  5
   STC 40
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 41
   PLUS 
   SRF  0  5
   STC 41
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 42
   PLUS 
   SRF  0  5
   STC 42
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 43
   PLUS 
   SRF  0  5
   STC 43
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 44
   PLUS 
   SRF  0  5
   STC 44
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 45
   PLUS 
   SRF  0  5
   STC 45
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 46
   PLUS 
   SRF  0  5
   STC 46
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 47
   PLUS 
   SRF  0  5
   STC 47
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 48
   PLUS 
   SRF  0  5
   STC 48
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 49
   PLUS 
   SRF  0  5
   STC 49
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 50
   PLUS 
   SRF  0  5
   STC 50
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 51
   PLUS 
   SRF  0  5
   STC 51
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 52
   PLUS 
   SRF  0  5
   STC 52
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 53
   PLUS 
   SRF  0  5
   STC 53
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 54
   PLUS 
   SRF  0  5
   STC 54
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 55
   PLUS 
   SRF  0  5
   STC 55
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 56
   PLUS 
   SRF  0  5
   STC 56
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 57
   PLUS 
   SRF  0  5
   STC 57
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 58
   PLUS 
   SRF  0  5
   STC 58
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 59
   PLUS 
   SRF  0  5
   STC 59
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 60
   PLUS 
   SRF  0  5
   STC 60
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 61
   PLUS 
   SRF  0  5
   STC 61
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 62
   PLUS 
   SRF  0  5
   STC 62
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 63
   PLUS 
   SRF  0  5
   STC 63
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 64
   PLUS 
   SRF  0  5
   STC 64
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 65
   PLUS 
   SRF  0  5
   STC 65
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 66
   PLUS 
   SRF  0  5
   STC 66
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 67
   PLUS 
   SRF  0  5
   STC 67
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 68
   PLUS 
   SRF  0  5
   STC 68
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 69
   PLUS 
   SRF  0  5
   STC 69
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 70
   PLUS 
   SRF  0  5
   STC 70
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 71
   PLUS 
   SRF  0  5
   STC 71
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 72
   PLUS 
   SRF  0  5
   STC 72
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 73
   PLUS 
   SRF  0  5
   STC 73
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 74
   PLUS 
   SRF  0  5
   STC 74
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 75
   PLUS 
   SRF  0  5
   STC 75
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 76
   PLUS 
   SRF  0  5
   STC 76
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 77
   PLUS 
   SRF  0  5
   STC 77
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   DRF 
   STC 78
   PLUS 
   SRF  0  5
   STC 78
   PLUS 
   DRF 
   ASG 
; Fin Acc/Func.
   CSF 
; Accion MOSTRARCOLONIA.
; Recuperacion parametro COLONIA.
   SRF  0 81
   ASGI 
   SRF  0 80
   ASGI 
   SRF  0 79
   ASGI 
   SRF  0 78
   ASGI 
   SRF  0 77
   ASGI 
   SRF  0 76
   ASGI 
   SRF  0 75
   ASGI 
   SRF  0 74
   ASGI 
   SRF  0 73
   ASGI 
   SRF  0 72
   ASGI 
   SRF  0 71
   ASGI 
   SRF  0 70
   ASGI 
   SRF  0 69
   ASGI 
   SRF  0 68
   ASGI 
   SRF  0 67
   ASGI 
   SRF  0 66
   ASGI 
   SRF  0 65
   ASGI 
   SRF  0 64
   ASGI 
   SRF  0 63
   ASGI 
   SRF  0 62
   ASGI 
   SRF  0 61
   ASGI 
   SRF  0 60
   ASGI 
   SRF  0 59
   ASGI 
   SRF  0 58
   ASGI 
   SRF  0 57
   ASGI 
   SRF  0 56
   ASGI 
   SRF  0 55
   ASGI 
   SRF  0 54
   ASGI 
   SRF  0 53
   ASGI 
   SRF  0 52
   ASGI 
   SRF  0 51
   ASGI 
   SRF  0 50
   ASGI 
   SRF  0 49
   ASGI 
   SRF  0 48
   ASGI 
   SRF  0 47
   ASGI 
   SRF  0 46
   ASGI 
   SRF  0 45
   ASGI 
   SRF  0 44
   ASGI 
   SRF  0 43
   ASGI 
   SRF  0 42
   ASGI 
   SRF  0 41
   ASGI 
   SRF  0 40
   ASGI 
   SRF  0 39
   ASGI 
   SRF  0 38
   ASGI 
   SRF  0 37
   ASGI 
   SRF  0 36
   ASGI 
   SRF  0 35
   ASGI 
   SRF  0 34
   ASGI 
   SRF  0 33
   ASGI 
   SRF  0 32
   ASGI 
   SRF  0 31
   ASGI 
   SRF  0 30
   ASGI 
   SRF  0 29
   ASGI 
   SRF  0 28
   ASGI 
   SRF  0 27
   ASGI 
   SRF  0 26
   ASGI 
   SRF  0 25
   ASGI 
   SRF  0 24
   ASGI 
   SRF  0 23
   ASGI 
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
; Comienzo accion MOSTRARCOLONIA.
   JMP L12
L12:
; Direccion de variable I.
   SRF  0 82
   STC  1
; Asignacion.
   ASG 
L13:
; MQ.
; Acceso a variable I.
   SRF  0 82
   DRF 
; Acceso a variable ELEMENTOS.
   SRF  1 82
   DRF 
   LTE 
   JMF L14
; SI.
; Acceso a variable I.
   SRF  0 82
   DRF 
; Acceso a parametro COLONIA.
   STC -1
   PLUS 
   SRF  0  3
   PLUS 
   DRF 
   JMF L15
; ENT.
; Escribir.
   STC 42
   WRT  0
   JMP L16
L15:
; SI_NO.
; Escribir.
   STC 32
   WRT  0
L16:
; Fin SI.
; Direccion de variable I.
   SRF  0 82
; Acceso a variable I.
   SRF  0 82
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L13
L14:
; Fin MQ.
; Escribir.
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin Acc/Func.
   CSF 
L0:
; Comienzo del programa JUEGODELAVIDA.
; Invocar accion INICIALIZAR.
; Vector por referencia.
   SRF  0  3
   OSF 83  0  1
; Invocar accion MOSTRARCOLONIA.
; Vector por valor.
   SRF  0  3
   STC  0
   PLUS 
   DRF 
   SRF  0  3
   STC  1
   PLUS 
   DRF 
   SRF  0  3
   STC  2
   PLUS 
   DRF 
   SRF  0  3
   STC  3
   PLUS 
   DRF 
   SRF  0  3
   STC  4
   PLUS 
   DRF 
   SRF  0  3
   STC  5
   PLUS 
   DRF 
   SRF  0  3
   STC  6
   PLUS 
   DRF 
   SRF  0  3
   STC  7
   PLUS 
   DRF 
   SRF  0  3
   STC  8
   PLUS 
   DRF 
   SRF  0  3
   STC  9
   PLUS 
   DRF 
   SRF  0  3
   STC 10
   PLUS 
   DRF 
   SRF  0  3
   STC 11
   PLUS 
   DRF 
   SRF  0  3
   STC 12
   PLUS 
   DRF 
   SRF  0  3
   STC 13
   PLUS 
   DRF 
   SRF  0  3
   STC 14
   PLUS 
   DRF 
   SRF  0  3
   STC 15
   PLUS 
   DRF 
   SRF  0  3
   STC 16
   PLUS 
   DRF 
   SRF  0  3
   STC 17
   PLUS 
   DRF 
   SRF  0  3
   STC 18
   PLUS 
   DRF 
   SRF  0  3
   STC 19
   PLUS 
   DRF 
   SRF  0  3
   STC 20
   PLUS 
   DRF 
   SRF  0  3
   STC 21
   PLUS 
   DRF 
   SRF  0  3
   STC 22
   PLUS 
   DRF 
   SRF  0  3
   STC 23
   PLUS 
   DRF 
   SRF  0  3
   STC 24
   PLUS 
   DRF 
   SRF  0  3
   STC 25
   PLUS 
   DRF 
   SRF  0  3
   STC 26
   PLUS 
   DRF 
   SRF  0  3
   STC 27
   PLUS 
   DRF 
   SRF  0  3
   STC 28
   PLUS 
   DRF 
   SRF  0  3
   STC 29
   PLUS 
   DRF 
   SRF  0  3
   STC 30
   PLUS 
   DRF 
   SRF  0  3
   STC 31
   PLUS 
   DRF 
   SRF  0  3
   STC 32
   PLUS 
   DRF 
   SRF  0  3
   STC 33
   PLUS 
   DRF 
   SRF  0  3
   STC 34
   PLUS 
   DRF 
   SRF  0  3
   STC 35
   PLUS 
   DRF 
   SRF  0  3
   STC 36
   PLUS 
   DRF 
   SRF  0  3
   STC 37
   PLUS 
   DRF 
   SRF  0  3
   STC 38
   PLUS 
   DRF 
   SRF  0  3
   STC 39
   PLUS 
   DRF 
   SRF  0  3
   STC 40
   PLUS 
   DRF 
   SRF  0  3
   STC 41
   PLUS 
   DRF 
   SRF  0  3
   STC 42
   PLUS 
   DRF 
   SRF  0  3
   STC 43
   PLUS 
   DRF 
   SRF  0  3
   STC 44
   PLUS 
   DRF 
   SRF  0  3
   STC 45
   PLUS 
   DRF 
   SRF  0  3
   STC 46
   PLUS 
   DRF 
   SRF  0  3
   STC 47
   PLUS 
   DRF 
   SRF  0  3
   STC 48
   PLUS 
   DRF 
   SRF  0  3
   STC 49
   PLUS 
   DRF 
   SRF  0  3
   STC 50
   PLUS 
   DRF 
   SRF  0  3
   STC 51
   PLUS 
   DRF 
   SRF  0  3
   STC 52
   PLUS 
   DRF 
   SRF  0  3
   STC 53
   PLUS 
   DRF 
   SRF  0  3
   STC 54
   PLUS 
   DRF 
   SRF  0  3
   STC 55
   PLUS 
   DRF 
   SRF  0  3
   STC 56
   PLUS 
   DRF 
   SRF  0  3
   STC 57
   PLUS 
   DRF 
   SRF  0  3
   STC 58
   PLUS 
   DRF 
   SRF  0  3
   STC 59
   PLUS 
   DRF 
   SRF  0  3
   STC 60
   PLUS 
   DRF 
   SRF  0  3
   STC 61
   PLUS 
   DRF 
   SRF  0  3
   STC 62
   PLUS 
   DRF 
   SRF  0  3
   STC 63
   PLUS 
   DRF 
   SRF  0  3
   STC 64
   PLUS 
   DRF 
   SRF  0  3
   STC 65
   PLUS 
   DRF 
   SRF  0  3
   STC 66
   PLUS 
   DRF 
   SRF  0  3
   STC 67
   PLUS 
   DRF 
   SRF  0  3
   STC 68
   PLUS 
   DRF 
   SRF  0  3
   STC 69
   PLUS 
   DRF 
   SRF  0  3
   STC 70
   PLUS 
   DRF 
   SRF  0  3
   STC 71
   PLUS 
   DRF 
   SRF  0  3
   STC 72
   PLUS 
   DRF 
   SRF  0  3
   STC 73
   PLUS 
   DRF 
   SRF  0  3
   STC 74
   PLUS 
   DRF 
   SRF  0  3
   STC 75
   PLUS 
   DRF 
   SRF  0  3
   STC 76
   PLUS 
   DRF 
   SRF  0  3
   STC 77
   PLUS 
   DRF 
   SRF  0  3
   STC 78
   PLUS 
   DRF 
   OSF 83  0 860
; Direccion de variable I.
   SRF  0 83
   STC  1
; Asignacion.
   ASG 
L17:
; MQ.
; Acceso a variable I.
   SRF  0 83
   DRF 
   STC 50
   LTE 
   JMF L18
; Invocar accion SIGUIENTEGENERACION.
; Vector por referencia.
   SRF  0  3
   OSF 83  0 38
; Invocar accion MOSTRARCOLONIA.
; Vector por valor.
   SRF  0  3
   STC  0
   PLUS 
   DRF 
   SRF  0  3
   STC  1
   PLUS 
   DRF 
   SRF  0  3
   STC  2
   PLUS 
   DRF 
   SRF  0  3
   STC  3
   PLUS 
   DRF 
   SRF  0  3
   STC  4
   PLUS 
   DRF 
   SRF  0  3
   STC  5
   PLUS 
   DRF 
   SRF  0  3
   STC  6
   PLUS 
   DRF 
   SRF  0  3
   STC  7
   PLUS 
   DRF 
   SRF  0  3
   STC  8
   PLUS 
   DRF 
   SRF  0  3
   STC  9
   PLUS 
   DRF 
   SRF  0  3
   STC 10
   PLUS 
   DRF 
   SRF  0  3
   STC 11
   PLUS 
   DRF 
   SRF  0  3
   STC 12
   PLUS 
   DRF 
   SRF  0  3
   STC 13
   PLUS 
   DRF 
   SRF  0  3
   STC 14
   PLUS 
   DRF 
   SRF  0  3
   STC 15
   PLUS 
   DRF 
   SRF  0  3
   STC 16
   PLUS 
   DRF 
   SRF  0  3
   STC 17
   PLUS 
   DRF 
   SRF  0  3
   STC 18
   PLUS 
   DRF 
   SRF  0  3
   STC 19
   PLUS 
   DRF 
   SRF  0  3
   STC 20
   PLUS 
   DRF 
   SRF  0  3
   STC 21
   PLUS 
   DRF 
   SRF  0  3
   STC 22
   PLUS 
   DRF 
   SRF  0  3
   STC 23
   PLUS 
   DRF 
   SRF  0  3
   STC 24
   PLUS 
   DRF 
   SRF  0  3
   STC 25
   PLUS 
   DRF 
   SRF  0  3
   STC 26
   PLUS 
   DRF 
   SRF  0  3
   STC 27
   PLUS 
   DRF 
   SRF  0  3
   STC 28
   PLUS 
   DRF 
   SRF  0  3
   STC 29
   PLUS 
   DRF 
   SRF  0  3
   STC 30
   PLUS 
   DRF 
   SRF  0  3
   STC 31
   PLUS 
   DRF 
   SRF  0  3
   STC 32
   PLUS 
   DRF 
   SRF  0  3
   STC 33
   PLUS 
   DRF 
   SRF  0  3
   STC 34
   PLUS 
   DRF 
   SRF  0  3
   STC 35
   PLUS 
   DRF 
   SRF  0  3
   STC 36
   PLUS 
   DRF 
   SRF  0  3
   STC 37
   PLUS 
   DRF 
   SRF  0  3
   STC 38
   PLUS 
   DRF 
   SRF  0  3
   STC 39
   PLUS 
   DRF 
   SRF  0  3
   STC 40
   PLUS 
   DRF 
   SRF  0  3
   STC 41
   PLUS 
   DRF 
   SRF  0  3
   STC 42
   PLUS 
   DRF 
   SRF  0  3
   STC 43
   PLUS 
   DRF 
   SRF  0  3
   STC 44
   PLUS 
   DRF 
   SRF  0  3
   STC 45
   PLUS 
   DRF 
   SRF  0  3
   STC 46
   PLUS 
   DRF 
   SRF  0  3
   STC 47
   PLUS 
   DRF 
   SRF  0  3
   STC 48
   PLUS 
   DRF 
   SRF  0  3
   STC 49
   PLUS 
   DRF 
   SRF  0  3
   STC 50
   PLUS 
   DRF 
   SRF  0  3
   STC 51
   PLUS 
   DRF 
   SRF  0  3
   STC 52
   PLUS 
   DRF 
   SRF  0  3
   STC 53
   PLUS 
   DRF 
   SRF  0  3
   STC 54
   PLUS 
   DRF 
   SRF  0  3
   STC 55
   PLUS 
   DRF 
   SRF  0  3
   STC 56
   PLUS 
   DRF 
   SRF  0  3
   STC 57
   PLUS 
   DRF 
   SRF  0  3
   STC 58
   PLUS 
   DRF 
   SRF  0  3
   STC 59
   PLUS 
   DRF 
   SRF  0  3
   STC 60
   PLUS 
   DRF 
   SRF  0  3
   STC 61
   PLUS 
   DRF 
   SRF  0  3
   STC 62
   PLUS 
   DRF 
   SRF  0  3
   STC 63
   PLUS 
   DRF 
   SRF  0  3
   STC 64
   PLUS 
   DRF 
   SRF  0  3
   STC 65
   PLUS 
   DRF 
   SRF  0  3
   STC 66
   PLUS 
   DRF 
   SRF  0  3
   STC 67
   PLUS 
   DRF 
   SRF  0  3
   STC 68
   PLUS 
   DRF 
   SRF  0  3
   STC 69
   PLUS 
   DRF 
   SRF  0  3
   STC 70
   PLUS 
   DRF 
   SRF  0  3
   STC 71
   PLUS 
   DRF 
   SRF  0  3
   STC 72
   PLUS 
   DRF 
   SRF  0  3
   STC 73
   PLUS 
   DRF 
   SRF  0  3
   STC 74
   PLUS 
   DRF 
   SRF  0  3
   STC 75
   PLUS 
   DRF 
   SRF  0  3
   STC 76
   PLUS 
   DRF 
   SRF  0  3
   STC 77
   PLUS 
   DRF 
   SRF  0  3
   STC 78
   PLUS 
   DRF 
   OSF 83  0 860
; Direccion de variable I.
   SRF  0 83
; Acceso a variable I.
   SRF  0 83
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L17
L18:
; Fin MQ.
   LVP 
