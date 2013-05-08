   ENP L0
; Comienzo de accion FIBONACCI
FIBONACCI:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L7
L7:
   SRF  0  3
   DRF 
   STC  0
   EQ 
   JMF L5
   SRF  0  4
   DRF 
   STC  0
   ASG 
   JMP L6
L5:
   SRF  0  3
   DRF 
   STC  1
   EQ 
   JMF L3
   SRF  0  4
   DRF 
   STC  1
   ASG 
   JMP L4
L3:
   SRF  0  3
   DRF 
   STC  1
   SBT 
   SRF  0  5
; Invocar FIBONACCI
   OSF  7  1 FIBONACCI
   SRF  0  3
   DRF 
   STC  2
   SBT 
   SRF  0  6
; Invocar FIBONACCI
   OSF  7  1 FIBONACCI
   SRF  0  4
   DRF 
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   PLUS 
   ASG 
L4:
L6:
; Fin de accion FIBONACCI
   CSF 
; Comienzo de accion CAMBIAR_DE_LINEA
CAMBIAR_DE_LINEA:
   JMP L8
L8:
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin de accion CAMBIAR_DE_LINEA
   CSF 
; Comienzo de accion ESPRIMO
ESPRIMO:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L13
L13:
   SRF  0  3
   DRF 
   STC  1
   LTE 
   JMF L11
   SRF  0  4
   DRF 
   STC  0
   ASG 
   JMP L12
L11:
   SRF  0  6
   SRF  0  3
   DRF 
   STC  2
   EQ 
   SRF  0  3
   DRF 
   STC  2
   MOD 
   STC  0
   GT 
   OR 
   ASG 
   SRF  0  5
   STC  3
   ASG 
   JMP L9
L10:
   SRF  0  6
   SRF  0  3
   DRF 
   SRF  0  5
   DRF 
   MOD 
   STC  0
   GT 
   ASG 
   SRF  0  5
   SRF  0  5
   DRF 
   STC  2
   PLUS 
   ASG 
L9:
   SRF  0  5
   DRF 
   SRF  0  5
   DRF 
   TMS 
   SRF  0  3
   DRF 
   LTE 
   SRF  0  6
   DRF 
   AND 
   JMT L10
L12:
   SRF  0  4
   DRF 
   SRF  0  6
   DRF 
   ASG 
; Fin de accion ESPRIMO
   CSF 
; Comienzo de accion MCD
MCD:
   SRF  0  5
   ASGI 
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L16
L16:
   SRF  0  6
   SRF  0  3
   DRF 
   ASG 
   SRF  0  7
   SRF  0  4
   DRF 
   ASG 
   JMP L14
L15:
   SRF  0  8
   SRF  0  6
   DRF 
   SRF  0  7
   DRF 
   MOD 
   ASG 
   SRF  0  6
   SRF  0  7
   DRF 
   ASG 
   SRF  0  7
   SRF  0  8
   DRF 
   ASG 
L14:
   SRF  0  7
   DRF 
   STC  0
   EQ 
   NGB 
   JMT L15
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   ASG 
; Fin de accion MCD
   CSF 
; Comienzo de accion ESCAPICUA
ESCAPICUA:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L19
L19:
   SRF  0  5
   SRF  0  3
   DRF 
   STC 10
   MOD 
   ASG 
   SRF  0  6
   SRF  0  3
   DRF 
   STC 10
   DIV 
   ASG 
   JMP L17
L18:
   SRF  0  5
   STC 10
   SRF  0  5
   DRF 
   TMS 
   SRF  0  6
   DRF 
   STC 10
   MOD 
   PLUS 
   ASG 
   SRF  0  6
   SRF  0  6
   DRF 
   STC 10
   DIV 
   ASG 
L17:
   SRF  0  6
   DRF 
   STC  0
   GT 
   JMT L18
   SRF  0  4
   DRF 
   SRF  0  3
   DRF 
   SRF  0  5
   DRF 
   EQ 
   ASG 
; Fin de accion ESCAPICUA
   CSF 
; Comienzo de accion ELEGIROPCION
ELEGIROPCION:
   SRF  0  3
   ASGI 
   JMP L20
L20:
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 105
   WRT  0
   STC 103
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 117
   WRT  0
   STC 110
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 111
   WRT  0
   STC 112
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 49
   WRT  0
   STC 32
   WRT  0
   STC 45
   WRT  0
   STC 32
   WRT  0
   STC 67
   WRT  0
   STC 97
   WRT  0
   STC 108
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 102
   WRT  0
   STC 105
   WRT  0
   STC 98
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 97
   WRT  0
   STC 99
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 50
   WRT  0
   STC 32
   WRT  0
   STC 45
   WRT  0
   STC 32
   WRT  0
   STC 67
   WRT  0
   STC 97
   WRT  0
   STC 108
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 115
   WRT  0
   STC 105
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
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 51
   WRT  0
   STC 32
   WRT  0
   STC 45
   WRT  0
   STC 32
   WRT  0
   STC 67
   WRT  0
   STC 97
   WRT  0
   STC 108
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 109
   WRT  0
   STC 97
   WRT  0
   STC 120
   WRT  0
   STC 105
   WRT  0
   STC 109
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 99
   WRT  0
   STC 111
   WRT  0
   STC 109
   WRT  0
   STC 117
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 105
   WRT  0
   STC 118
   WRT  0
   STC 105
   WRT  0
   STC 115
   WRT  0
   STC 111
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
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 115
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
   STC 115
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 52
   WRT  0
   STC 32
   WRT  0
   STC 45
   WRT  0
   STC 32
   WRT  0
   STC 67
   WRT  0
   STC 97
   WRT  0
   STC 108
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 115
   WRT  0
   STC 105
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
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 99
   WRT  0
   STC 97
   WRT  0
   STC 112
   WRT  0
   STC 105
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 97
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 32
   WRT  0
   STC 48
   WRT  0
   STC 32
   WRT  0
   STC 45
   WRT  0
   STC 32
   WRT  0
   STC 83
   WRT  0
   STC 97
   WRT  0
   STC 108
   WRT  0
   STC 105
   WRT  0
   STC 114
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 105
   WRT  0
   STC 103
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 116
   WRT  0
   STC 117
   WRT  0
   STC 32
   WRT  0
   STC 111
   WRT  0
   STC 112
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  4
   RD  1
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   ASG 
; Fin de accion ELEGIROPCION
   CSF 
; Comienzo de accion TRATAROPCION
TRATAROPCION:
   SRF  0  3
   ASGI 
   JMP L33
L33:
   SRF  0  3
   DRF 
   STC  1
   EQ 
   JMF L31
   STC 73
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 100
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
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
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  4
   RD  1
   SRF  0  4
   DRF 
   SRF  0  7
; Invocar FIBONACCI
   OSF  9  1 FIBONACCI
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 102
   WRT  0
   STC 105
   WRT  0
   STC 98
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 97
   WRT  0
   STC 99
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   SRF  0  4
   DRF 
   WRT  1
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
   SRF  0  7
   DRF 
   WRT  1
; Invocar CAMBIAR_DE_LINEA
   OSF  9  1 CAMBIAR_DE_LINEA
   JMP L32
L31:
   SRF  0  3
   DRF 
   STC  2
   EQ 
   JMF L29
   STC 73
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 100
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
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
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  4
   RD  1
   SRF  0  4
   DRF 
   SRF  0  8
; Invocar ESPRIMO
   OSF  9  1 ESPRIMO
   SRF  0  8
   DRF 
   JMF L21
   STC 69
   WRT  0
   STC 108
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
; Invocar CAMBIAR_DE_LINEA
   OSF  9  1 CAMBIAR_DE_LINEA
   JMP L22
L21:
   STC 69
   WRT  0
   STC 108
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
   STC 32
   WRT  0
   STC 110
   WRT  0
   STC 111
   WRT  0
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
; Invocar CAMBIAR_DE_LINEA
   OSF  9  1 CAMBIAR_DE_LINEA
L22:
   JMP L30
L29:
   SRF  0  3
   DRF 
   STC  3
   EQ 
   JMF L27
   STC 73
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 100
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
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
   STC 101
   WRT  0
   STC 114
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
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  5
   RD  1
   STC 73
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 100
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 115
   WRT  0
   STC 101
   WRT  0
   STC 103
   WRT  0
   STC 117
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
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
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  6
   RD  1
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   SRF  0  7
; Invocar MCD
   OSF  9  1 MCD
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 109
   WRT  0
   STC 99
   WRT  0
   STC 100
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 97
   WRT  0
   STC 109
   WRT  0
   STC 98
   WRT  0
   STC 111
   WRT  0
   STC 115
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
   SRF  0  7
   DRF 
   WRT  1
; Invocar CAMBIAR_DE_LINEA
   OSF  9  1 CAMBIAR_DE_LINEA
   JMP L28
L27:
   SRF  0  3
   DRF 
   STC  4
   EQ 
   JMF L25
   STC 73
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 100
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
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
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  4
   RD  1
   SRF  0  4
   DRF 
   SRF  0  8
; Invocar ESCAPICUA
   OSF  9  1 ESCAPICUA
   SRF  0  8
   DRF 
   JMF L23
   STC 69
   WRT  0
   STC 108
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
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 99
   WRT  0
   STC 97
   WRT  0
   STC 112
   WRT  0
   STC 105
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 97
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  9  1 CAMBIAR_DE_LINEA
   JMP L24
L23:
   STC 69
   WRT  0
   STC 108
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
   STC 32
   WRT  0
   STC 110
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 99
   WRT  0
   STC 97
   WRT  0
   STC 112
   WRT  0
   STC 105
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 97
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  9  1 CAMBIAR_DE_LINEA
L24:
   JMP L26
L25:
   STC 79
   WRT  0
   STC 112
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 105
   WRT  0
   STC 110
   WRT  0
   STC 99
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 114
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 97
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  9  1 CAMBIAR_DE_LINEA
L26:
L28:
L30:
L32:
; Fin de accion TRATAROPCION
   CSF 
; Comienzo del programa PRINCIPAL
L0:
   SRF  0  3
   STC  0
   ASG 
   JMP L36
L37:
   SRF  0  4
; Invocar ELEGIROPCION
   OSF  5  0 ELEGIROPCION
   SRF  0  3
   SRF  0  4
   DRF 
   STC  0
   EQ 
   ASG 
   SRF  0  3
   DRF 
   NGB 
   JMF L34
   SRF  0  4
   DRF 
; Invocar TRATAROPCION
   OSF  5  0 TRATAROPCION
L34:
L36:
   SRF  0  3
   DRF 
   NGB 
   JMT L37
; Fin del programa PRINCIPAL
L2:
   LVP 
