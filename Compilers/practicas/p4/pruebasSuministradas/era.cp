; Programa ERATOSTENES.
   ENP L0
; Funcion PEDIRENTERO.
LPEDIRENTERO:
; Comienzo funcion PEDIRENTERO.
   JMP L1
L1:
; Escribir.
; cadena 'Dame un numero: '.
   STC "D"
   WRT  0
   STC "a"
   WRT  0
   STC "m"
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 117
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 110
   WRT  0
   STC 117
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
;
   STC " "
   WRT  0
   STC "("
   WRT  0
   STC "e"
   WRT  0
   STC "n"
   WRT  0
   STC "t"
   WRT  0
   STC "r"
   WRT  0
   STC "e"
   WRT  0
   STC " "
   WRT  0
   STC "1"
   WRT  0
   STC " "
   WRT  0
   STC "y"
   WRT  0
   STC " "
   WRT  0
   STC "1"
   WRT  0
   STC "0"
   WRT  0
   STC "0"
   WRT  0
   STC ")"
   WRT  0
;
   STC 58
   WRT  0
   STC 32
   WRT  0
; Leer.
; Direccion de variable N.
   SRF  0  3
   RD  1
; Devolver.
; Acceso a variable N.
   SRF  0  3
   DRF 
   CSF 
; Fin Acc/Func.
   CSF 
; Funcion ESPRIMO.
LESPRIMO:
; Recuperacion parametro V.
   SRF  0 103
   ASGI 
   SRF  0 102
   ASGI 
   SRF  0 101
   ASGI 
   SRF  0 100
   ASGI 
   SRF  0 99
   ASGI 
   SRF  0 98
   ASGI 
   SRF  0 97
   ASGI 
   SRF  0 96
   ASGI 
   SRF  0 95
   ASGI 
   SRF  0 94
   ASGI 
   SRF  0 93
   ASGI 
   SRF  0 92
   ASGI 
   SRF  0 91
   ASGI 
   SRF  0 90
   ASGI 
   SRF  0 89
   ASGI 
   SRF  0 88
   ASGI 
   SRF  0 87
   ASGI 
   SRF  0 86
   ASGI 
   SRF  0 85
   ASGI 
   SRF  0 84
   ASGI 
   SRF  0 83
   ASGI 
   SRF  0 82
   ASGI 
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
; Recuperacion parametro I.
   SRF  0  3
   ASGI 
; Comienzo funcion ESPRIMO.
   JMP L2
L2:
; Devolver.
; Acceso a parametro I.
   SRF  0  3
   DRF 
; Acceso a parametro V.
   STC -1
   PLUS 
   SRF  0  4
   PLUS 
   DRF 
   CSF 
; Fin Acc/Func.
   CSF 
; Accion ESCRIBVECT.
LESCRIBVECT:
; Recuperacion parametro V.
   SRF  0 102
   ASGI 
   SRF  0 101
   ASGI 
   SRF  0 100
   ASGI 
   SRF  0 99
   ASGI 
   SRF  0 98
   ASGI 
   SRF  0 97
   ASGI 
   SRF  0 96
   ASGI 
   SRF  0 95
   ASGI 
   SRF  0 94
   ASGI 
   SRF  0 93
   ASGI 
   SRF  0 92
   ASGI 
   SRF  0 91
   ASGI 
   SRF  0 90
   ASGI 
   SRF  0 89
   ASGI 
   SRF  0 88
   ASGI 
   SRF  0 87
   ASGI 
   SRF  0 86
   ASGI 
   SRF  0 85
   ASGI 
   SRF  0 84
   ASGI 
   SRF  0 83
   ASGI 
   SRF  0 82
   ASGI 
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
; Comienzo accion ESCRIBVECT.
   JMP L3
L3:
; Direccion de variable I.
   SRF  0 103
   STC  2
; Asignacion.
   ASG 
; Direccion de variable SALIR.
   SRF  0 104
   STC  0
; Asignacion.
   ASG 
L4:
; MQ.
; Acceso a variable SALIR.
   SRF  0 104
   DRF 
   NGB 
   JMF L5
; SI.
; Acceso a variable I.
   SRF  0 103
   DRF 
; Acceso a variable LIMITE.
   SRF  1  3
   DRF 
   GT 
   JMF L6
; ENT.
; Direccion de variable SALIR.
   SRF  0 104
   STC  1
; Asignacion.
   ASG 
   JMP L7
L6:
; SI_NO.
; SI.
; Invocar funcion ESPRIMO.
; Acceso a variable I.
   SRF  0 103
   DRF 
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
   SRF  0  3
   STC 79
   PLUS 
   DRF 
   SRF  0  3
   STC 80
   PLUS 
   DRF 
   SRF  0  3
   STC 81
   PLUS 
   DRF 
   SRF  0  3
   STC 82
   PLUS 
   DRF 
   SRF  0  3
   STC 83
   PLUS 
   DRF 
   SRF  0  3
   STC 84
   PLUS 
   DRF 
   SRF  0  3
   STC 85
   PLUS 
   DRF 
   SRF  0  3
   STC 86
   PLUS 
   DRF 
   SRF  0  3
   STC 87
   PLUS 
   DRF 
   SRF  0  3
   STC 88
   PLUS 
   DRF 
   SRF  0  3
   STC 89
   PLUS 
   DRF 
   SRF  0  3
   STC 90
   PLUS 
   DRF 
   SRF  0  3
   STC 91
   PLUS 
   DRF 
   SRF  0  3
   STC 92
   PLUS 
   DRF 
   SRF  0  3
   STC 93
   PLUS 
   DRF 
   SRF  0  3
   STC 94
   PLUS 
   DRF 
   SRF  0  3
   STC 95
   PLUS 
   DRF 
   SRF  0  3
   STC 96
   PLUS 
   DRF 
   SRF  0  3
   STC 97
   PLUS 
   DRF 
   SRF  0  3
   STC 98
   PLUS 
   DRF 
   SRF  0  3
   STC 99
   PLUS 
   DRF 
; Invocacion a funcion ESPRIMO.
   OSF 104  1 LESPRIMO
   JMF L8
; ENT.
; Escribir.
; Acceso a variable I.
   SRF  0 103
   DRF 
   WRT  1
; cadena ' es primo.'.
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 112
   WRT  0
   STC 114
   WRT  0
   STC 105
   WRT  0
   STC 109
   WRT  0
   STC 111
   WRT  0
   STC 46
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L8:
; Fin SI.
; Direccion de variable I.
   SRF  0 103
; Acceso a variable I.
   SRF  0 103
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
L7:
; Fin SI.
   JMP L4
L5:
; Fin MQ.
; Fin Acc/Func.
   CSF 
; Accion PROCESAR.
LPROCESAR:
; Comienzo accion PROCESAR.
   JMP L10
; Accion INICIALIZAR.
LINICIALIZAR:
; Comienzo accion INICIALIZAR.
   JMP L11
L11:
; Direccion de variable I.
   SRF  0  3
   STC  1
; Asignacion.
   ASG 
L12:
; MQ.
; Acceso a variable I.
   SRF  0  3
   DRF 
; Acceso a variable LIMITE.
   SRF  2  3
   DRF 
   LTE 
   JMF L13
; Acceso a variable I.
   SRF  0  3
   DRF 
; Direccion de componente de vector V.
   STC -1
   PLUS 
   SRF  1  3
   PLUS 
   STC  1
; Asignacion.
   ASG 
; Direccion de variable I.
   SRF  0  3
; Acceso a variable I.
   SRF  0  3
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L12
L13:
; Fin MQ.
; Fin Acc/Func.
   CSF 
; Accion ELIMINAR.
LELIMINAR:
; Comienzo accion ELIMINAR.
   JMP L14
L14:
; Direccion de variable I.
   SRF  0  4
   STC  2
; Asignacion.
   ASG 
L15:
; MQ.
; Acceso a variable I.
   SRF  0  4
   DRF 
; Acceso a variable LIMITE.
   SRF  2  3
   DRF 
   STC  2
   DIV 
   LTE 
   JMF L16
; SI.
; Invocar funcion ESPRIMO.
; Acceso a variable I.
   SRF  0  4
   DRF 
; Vector por valor.
   SRF  1  3
   STC  0
   PLUS 
   DRF 
   SRF  1  3
   STC  1
   PLUS 
   DRF 
   SRF  1  3
   STC  2
   PLUS 
   DRF 
   SRF  1  3
   STC  3
   PLUS 
   DRF 
   SRF  1  3
   STC  4
   PLUS 
   DRF 
   SRF  1  3
   STC  5
   PLUS 
   DRF 
   SRF  1  3
   STC  6
   PLUS 
   DRF 
   SRF  1  3
   STC  7
   PLUS 
   DRF 
   SRF  1  3
   STC  8
   PLUS 
   DRF 
   SRF  1  3
   STC  9
   PLUS 
   DRF 
   SRF  1  3
   STC 10
   PLUS 
   DRF 
   SRF  1  3
   STC 11
   PLUS 
   DRF 
   SRF  1  3
   STC 12
   PLUS 
   DRF 
   SRF  1  3
   STC 13
   PLUS 
   DRF 
   SRF  1  3
   STC 14
   PLUS 
   DRF 
   SRF  1  3
   STC 15
   PLUS 
   DRF 
   SRF  1  3
   STC 16
   PLUS 
   DRF 
   SRF  1  3
   STC 17
   PLUS 
   DRF 
   SRF  1  3
   STC 18
   PLUS 
   DRF 
   SRF  1  3
   STC 19
   PLUS 
   DRF 
   SRF  1  3
   STC 20
   PLUS 
   DRF 
   SRF  1  3
   STC 21
   PLUS 
   DRF 
   SRF  1  3
   STC 22
   PLUS 
   DRF 
   SRF  1  3
   STC 23
   PLUS 
   DRF 
   SRF  1  3
   STC 24
   PLUS 
   DRF 
   SRF  1  3
   STC 25
   PLUS 
   DRF 
   SRF  1  3
   STC 26
   PLUS 
   DRF 
   SRF  1  3
   STC 27
   PLUS 
   DRF 
   SRF  1  3
   STC 28
   PLUS 
   DRF 
   SRF  1  3
   STC 29
   PLUS 
   DRF 
   SRF  1  3
   STC 30
   PLUS 
   DRF 
   SRF  1  3
   STC 31
   PLUS 
   DRF 
   SRF  1  3
   STC 32
   PLUS 
   DRF 
   SRF  1  3
   STC 33
   PLUS 
   DRF 
   SRF  1  3
   STC 34
   PLUS 
   DRF 
   SRF  1  3
   STC 35
   PLUS 
   DRF 
   SRF  1  3
   STC 36
   PLUS 
   DRF 
   SRF  1  3
   STC 37
   PLUS 
   DRF 
   SRF  1  3
   STC 38
   PLUS 
   DRF 
   SRF  1  3
   STC 39
   PLUS 
   DRF 
   SRF  1  3
   STC 40
   PLUS 
   DRF 
   SRF  1  3
   STC 41
   PLUS 
   DRF 
   SRF  1  3
   STC 42
   PLUS 
   DRF 
   SRF  1  3
   STC 43
   PLUS 
   DRF 
   SRF  1  3
   STC 44
   PLUS 
   DRF 
   SRF  1  3
   STC 45
   PLUS 
   DRF 
   SRF  1  3
   STC 46
   PLUS 
   DRF 
   SRF  1  3
   STC 47
   PLUS 
   DRF 
   SRF  1  3
   STC 48
   PLUS 
   DRF 
   SRF  1  3
   STC 49
   PLUS 
   DRF 
   SRF  1  3
   STC 50
   PLUS 
   DRF 
   SRF  1  3
   STC 51
   PLUS 
   DRF 
   SRF  1  3
   STC 52
   PLUS 
   DRF 
   SRF  1  3
   STC 53
   PLUS 
   DRF 
   SRF  1  3
   STC 54
   PLUS 
   DRF 
   SRF  1  3
   STC 55
   PLUS 
   DRF 
   SRF  1  3
   STC 56
   PLUS 
   DRF 
   SRF  1  3
   STC 57
   PLUS 
   DRF 
   SRF  1  3
   STC 58
   PLUS 
   DRF 
   SRF  1  3
   STC 59
   PLUS 
   DRF 
   SRF  1  3
   STC 60
   PLUS 
   DRF 
   SRF  1  3
   STC 61
   PLUS 
   DRF 
   SRF  1  3
   STC 62
   PLUS 
   DRF 
   SRF  1  3
   STC 63
   PLUS 
   DRF 
   SRF  1  3
   STC 64
   PLUS 
   DRF 
   SRF  1  3
   STC 65
   PLUS 
   DRF 
   SRF  1  3
   STC 66
   PLUS 
   DRF 
   SRF  1  3
   STC 67
   PLUS 
   DRF 
   SRF  1  3
   STC 68
   PLUS 
   DRF 
   SRF  1  3
   STC 69
   PLUS 
   DRF 
   SRF  1  3
   STC 70
   PLUS 
   DRF 
   SRF  1  3
   STC 71
   PLUS 
   DRF 
   SRF  1  3
   STC 72
   PLUS 
   DRF 
   SRF  1  3
   STC 73
   PLUS 
   DRF 
   SRF  1  3
   STC 74
   PLUS 
   DRF 
   SRF  1  3
   STC 75
   PLUS 
   DRF 
   SRF  1  3
   STC 76
   PLUS 
   DRF 
   SRF  1  3
   STC 77
   PLUS 
   DRF 
   SRF  1  3
   STC 78
   PLUS 
   DRF 
   SRF  1  3
   STC 79
   PLUS 
   DRF 
   SRF  1  3
   STC 80
   PLUS 
   DRF 
   SRF  1  3
   STC 81
   PLUS 
   DRF 
   SRF  1  3
   STC 82
   PLUS 
   DRF 
   SRF  1  3
   STC 83
   PLUS 
   DRF 
   SRF  1  3
   STC 84
   PLUS 
   DRF 
   SRF  1  3
   STC 85
   PLUS 
   DRF 
   SRF  1  3
   STC 86
   PLUS 
   DRF 
   SRF  1  3
   STC 87
   PLUS 
   DRF 
   SRF  1  3
   STC 88
   PLUS 
   DRF 
   SRF  1  3
   STC 89
   PLUS 
   DRF 
   SRF  1  3
   STC 90
   PLUS 
   DRF 
   SRF  1  3
   STC 91
   PLUS 
   DRF 
   SRF  1  3
   STC 92
   PLUS 
   DRF 
   SRF  1  3
   STC 93
   PLUS 
   DRF 
   SRF  1  3
   STC 94
   PLUS 
   DRF 
   SRF  1  3
   STC 95
   PLUS 
   DRF 
   SRF  1  3
   STC 96
   PLUS 
   DRF 
   SRF  1  3
   STC 97
   PLUS 
   DRF 
   SRF  1  3
   STC 98
   PLUS 
   DRF 
   SRF  1  3
   STC 99
   PLUS 
   DRF 
; Invocacion a funcion ESPRIMO.
   OSF  4  2 LESPRIMO
   JMF L17
; ENT.
; Direccion de variable J.
   SRF  0  3
   STC  2
; Acceso a variable I.
   SRF  0  4
   DRF 
   TMS 
; Asignacion.
   ASG 
L18:
; MQ.
; Acceso a variable J.
   SRF  0  3
   DRF 
; Acceso a variable LIMITE.
   SRF  2  3
   DRF 
   LTE 
   JMF L19
; Acceso a variable J.
   SRF  0  3
   DRF 
; Direccion de componente de vector V.
   STC -1
   PLUS 
   SRF  1  3
   PLUS 
   STC  0
; Asignacion.
   ASG 
; Direccion de variable J.
   SRF  0  3
; Acceso a variable J.
   SRF  0  3
   DRF 
; Acceso a variable I.
   SRF  0  4
   DRF 
   PLUS 
; Asignacion.
   ASG 
   JMP L18
L19:
L17:
; Fin MQ.
; Fin SI.
; Direccion de variable I.
   SRF  0  4
; Acceso a variable I.
   SRF  0  4
   DRF 
   STC  1
   PLUS 
; Asignacion.
   ASG 
   JMP L15
L16:
; Fin MQ.
; Fin Acc/Func.
   CSF 
L10:
; Invocar accion INICIALIZAR.
   OSF 102  0 LINICIALIZAR
; Invocar accion ELIMINAR.
   OSF 102  0 LELIMINAR
; Invocar accion ESCRIBVECT.
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
   SRF  0  3
   STC 79
   PLUS 
   DRF 
   SRF  0  3
   STC 80
   PLUS 
   DRF 
   SRF  0  3
   STC 81
   PLUS 
   DRF 
   SRF  0  3
   STC 82
   PLUS 
   DRF 
   SRF  0  3
   STC 83
   PLUS 
   DRF 
   SRF  0  3
   STC 84
   PLUS 
   DRF 
   SRF  0  3
   STC 85
   PLUS 
   DRF 
   SRF  0  3
   STC 86
   PLUS 
   DRF 
   SRF  0  3
   STC 87
   PLUS 
   DRF 
   SRF  0  3
   STC 88
   PLUS 
   DRF 
   SRF  0  3
   STC 89
   PLUS 
   DRF 
   SRF  0  3
   STC 90
   PLUS 
   DRF 
   SRF  0  3
   STC 91
   PLUS 
   DRF 
   SRF  0  3
   STC 92
   PLUS 
   DRF 
   SRF  0  3
   STC 93
   PLUS 
   DRF 
   SRF  0  3
   STC 94
   PLUS 
   DRF 
   SRF  0  3
   STC 95
   PLUS 
   DRF 
   SRF  0  3
   STC 96
   PLUS 
   DRF 
   SRF  0  3
   STC 97
   PLUS 
   DRF 
   SRF  0  3
   STC 98
   PLUS 
   DRF 
   SRF  0  3
   STC 99
   PLUS 
   DRF 
   OSF 102  1 LESCRIBVECT
; Fin Acc/Func.
   CSF 
L0:
; Comienzo del programa ERATOSTENES.
; Direccion de variable LIMITE.
   SRF  0  3
; Invocacion a funcion PEDIRENTERO.
   OSF  3  0  LPEDIRENTERO
; Asignacion.
   ASG 
; Invocar accion PROCESAR.
   OSF  3  0 LPROCESAR
   LVP 
