   ENP L0
L1:
   STC 65
   WRT  0
   STC 98
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 116
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 106
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 44
   WRT  0
   STC 32
   WRT  0
   STC 105
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 105
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 102
   WRT  0
   STC 117
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 103
   WRT  0
   STC 111
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   JMP L2
; Comienzo de accion INICIALIZARVECTORENTEROS
INICIALIZARVECTORENTEROS:
   JMP L5
L5:
   SRF  0  3
   STC  4
   ASG 
   JMP L3
L4:
   SRF  1  5
   SRF  0  3
   DRF 
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L1
   STC 10
   LTE 
   JMF L1
   STC  4
   SBT 
   PLUS 
   SRF  0  3
   DRF 
   ASG 
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L3:
   SRF  0  3
   DRF 
   STC 10
   LTE 
   JMT L4
; Fin de accion INICIALIZARVECTORENTEROS
   CSF 
; Comienzo de accion INICIALIZARVECTORCARACTERES
INICIALIZARVECTORCARACTERES:
   JMP L8
L8:
   SRF  0  3
   STC  5
   ASG 
   SRF  0  4
   STC 65
   ASG 
   JMP L6
L7:
   SRF  1 35
   SRF  0  3
   DRF 
   DUP 
   DUP 
   STC  5
   GTE 
   JMF L1
   STC  9
   LTE 
   JMF L1
   STC  5
   SBT 
   PLUS 
   SRF  0  4
   DRF 
   ASG 
   SRF  0  4
   SRF  0  4
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L6:
   SRF  0  3
   DRF 
   STC  9
   LTE 
   JMT L7
; Fin de accion INICIALIZARVECTORCARACTERES
   CSF 
; Comienzo de accion INICIALIZARVECTORBOOLEANOS
INICIALIZARVECTORBOOLEANOS:
   JMP L11
L11:
   SRF  1  3
   STC  8
   ASG 
   JMP L9
L10:
   SRF  1 19
   SRF  1  3
   DRF 
   DUP 
   DUP 
   STC  8
   GTE 
   JMF L1
   STC 15
   LTE 
   JMF L1
   STC  8
   SBT 
   PLUS 
   SRF  1  3
   DRF 
   STC 12
   GT 
   ASG 
   SRF  1  3
   SRF  1  3
   DRF 
   STC  1
   PLUS 
   ASG 
L9:
   SRF  1  3
   DRF 
   STC 15
   LTE 
   JMT L10
; Fin de accion INICIALIZARVECTORBOOLEANOS
   CSF 
; Comienzo de accion MOSTRARVECTORES
MOSTRARVECTORES:
   JMP L28
L28:
   STC 77
   WRT  0
   STC 111
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 49
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   STC  4
   ASG 
   JMP L12
L13:
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
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
   SRF  1  5
   SRF  0  3
   DRF 
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L1
   STC 10
   LTE 
   JMF L1
   STC  4
   SBT 
   PLUS 
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L12:
   SRF  0  3
   DRF 
   STC 10
   LTE 
   JMT L13
   STC 77
   WRT  0
   STC 111
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 50
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   STC  8
   ASG 
   JMP L14
L15:
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
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
   SRF  1 12
   SRF  0  3
   DRF 
   DUP 
   DUP 
   STC  8
   GTE 
   JMF L1
   STC 14
   LTE 
   JMF L1
   STC  8
   SBT 
   PLUS 
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L14:
   SRF  0  3
   DRF 
   STC 14
   LTE 
   JMT L15
   STC 77
   WRT  0
   STC 111
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 51
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   STC  8
   ASG 
   JMP L18
L19:
   SRF  1 19
   SRF  0  3
   DRF 
   DUP 
   DUP 
   STC  8
   GTE 
   JMF L1
   STC 15
   LTE 
   JMF L1
   STC  8
   SBT 
   PLUS 
   DRF 
   STC  1
   EQ 
   JMF L16
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
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
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 117
   WRT  0
   STC 101
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   JMP L17
L16:
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
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
   STC 102
   WRT  0
   STC 97
   WRT  0
   STC 108
   WRT  0
   STC 115
   WRT  0
   STC 101
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L17:
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L18:
   SRF  0  3
   DRF 
   STC 15
   LTE 
   JMT L19
   STC 77
   WRT  0
   STC 111
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 52
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   STC  1
   ASG 
   JMP L22
L23:
   SRF  1 27
   SRF  0  3
   DRF 
   DUP 
   DUP 
   STC  1
   GTE 
   JMF L1
   STC  8
   LTE 
   JMF L1
   STC  1
   SBT 
   PLUS 
   DRF 
   STC  1
   EQ 
   JMF L20
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
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
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 117
   WRT  0
   STC 101
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   JMP L21
L20:
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
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
   STC 102
   WRT  0
   STC 97
   WRT  0
   STC 108
   WRT  0
   STC 115
   WRT  0
   STC 101
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L21:
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L22:
   SRF  0  3
   DRF 
   STC  8
   LTE 
   JMT L23
   STC 77
   WRT  0
   STC 111
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 53
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   STC  5
   ASG 
   JMP L24
L25:
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
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
   SRF  1 35
   SRF  0  3
   DRF 
   DUP 
   DUP 
   STC  5
   GTE 
   JMF L1
   STC  9
   LTE 
   JMF L1
   STC  5
   SBT 
   PLUS 
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L24:
   SRF  0  3
   DRF 
   STC  9
   LTE 
   JMT L25
   STC 77
   WRT  0
   STC 111
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 54
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   STC  1
   ASG 
   JMP L26
L27:
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
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
   SRF  1 40
   SRF  0  3
   DRF 
   DUP 
   DUP 
   STC  1
   GTE 
   JMF L1
   STC  5
   LTE 
   JMF L1
   STC  1
   SBT 
   PLUS 
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L26:
   SRF  0  3
   DRF 
   STC  5
   LTE 
   JMT L27
; Fin de accion MOSTRARVECTORES
   CSF 
; Comienzo del programa P
L0:
; Invocar INICIALIZARVECTORENTEROS
   OSF 45  0 INICIALIZARVECTORENTEROS
   STC  0
   DUP 
   DUP 
   DUP 
   STC  7
   JMP L29
L30:
   SRF  0 12
   PLUS 
   SWP 
   SRF  0  5
   PLUS 
   DRF 
   ASG 
   STC  1
   PLUS 
   DUP 
   DUP 
   DUP 
   STC  7
L29:
   LT 
   JMT L30
   POP 
   POP 
   POP 
; Invocar INICIALIZARVECTORBOOLEANOS
   OSF 45  0 INICIALIZARVECTORBOOLEANOS
   STC  0
   DUP 
   DUP 
   DUP 
   STC  8
   JMP L31
L32:
   SRF  0 27
   PLUS 
   SWP 
   SRF  0 19
   PLUS 
   DRF 
   ASG 
   STC  1
   PLUS 
   DUP 
   DUP 
   DUP 
   STC  8
L31:
   LT 
   JMT L32
   POP 
   POP 
   POP 
; Invocar INICIALIZARVECTORCARACTERES
   OSF 45  0 INICIALIZARVECTORCARACTERES
   STC  0
   DUP 
   DUP 
   DUP 
   STC  5
   JMP L33
L34:
   SRF  0 40
   PLUS 
   SWP 
   SRF  0 35
   PLUS 
   DRF 
   ASG 
   STC  1
   PLUS 
   DUP 
   DUP 
   DUP 
   STC  5
L33:
   LT 
   JMT L34
   POP 
   POP 
   POP 
; Invocar MOSTRARVECTORES
   OSF 45  0 MOSTRARVECTORES
; Fin del programa P
L2:
   LVP 
