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
; Comienzo de accion CAMBIAR_DE_LINEA
CAMBIAR_DE_LINEA:
   JMP L3
L3:
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin de accion CAMBIAR_DE_LINEA
   CSF 
; Comienzo de accion INICIALIZARNUMERO
INICIALIZARNUMERO:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L4
L4:
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   ASG 
; Fin de accion INICIALIZARNUMERO
   CSF 
; Comienzo de accion MOSTRARELEMENTO
MOSTRARELEMENTO:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L5
L5:
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
   SRF  0  4
   DRF 
   DRF 
   WRT  1
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
; Fin de accion MOSTRARELEMENTO
   CSF 
; Comienzo del programa P
L0:
   SRF  0 23
   STC  1
   ASG 
   JMP L6
L7:
   SRF  0  3
   SRF  0 23
   DRF 
   DUP 
   DUP 
   STC  1
   GTE 
   JMF L1
   STC 10
   LTE 
   JMF L1
   STC  1
   SBT 
   PLUS 
   SRF  0 23
   DRF 
; Invocar INICIALIZARNUMERO
   OSF 24  0 INICIALIZARNUMERO
   SRF  0 23
   SRF  0 23
   DRF 
   STC  1
   PLUS 
   ASG 
L6:
   SRF  0 23
   DRF 
   STC 10
   LTE 
   JMT L7
   STC 77
   WRT  0
   STC 117
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF 24  0 CAMBIAR_DE_LINEA
   SRF  0 23
   STC  1
   ASG 
   JMP L8
L9:
   SRF  0 23
   DRF 
   SRF  0  3
   SRF  0 23
   DRF 
   DUP 
   DUP 
   STC  1
   GTE 
   JMF L1
   STC 10
   LTE 
   JMF L1
   STC  1
   SBT 
   PLUS 
; Invocar MOSTRARELEMENTO
   OSF 24  0 MOSTRARELEMENTO
   SRF  0 23
   SRF  0 23
   DRF 
   STC  1
   PLUS 
   ASG 
L8:
   SRF  0 23
   DRF 
   STC 10
   LTE 
   JMT L9
   STC 72
   WRT  0
   STC 97
   WRT  0
   STC 103
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 50
   WRT  0
   STC 32
   WRT  0
   STC 58
   WRT  0
   STC 61
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF 24  0 CAMBIAR_DE_LINEA
   STC  0
   DUP 
   DUP 
   DUP 
   STC 10
   JMP L10
L11:
   SRF  0 13
   PLUS 
   SWP 
   SRF  0  3
   PLUS 
   DRF 
   ASG 
   STC  1
   PLUS 
   DUP 
   DUP 
   DUP 
   STC 10
L10:
   LT 
   JMT L11
   POP 
   POP 
   POP 
   STC 77
   WRT  0
   STC 117
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 50
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF 24  0 CAMBIAR_DE_LINEA
   SRF  0 23
   STC  1
   ASG 
   JMP L12
L13:
   SRF  0 23
   DRF 
   SRF  0 13
   SRF  0 23
   DRF 
   DUP 
   DUP 
   STC  1
   GTE 
   JMF L1
   STC 10
   LTE 
   JMF L1
   STC  1
   SBT 
   PLUS 
; Invocar MOSTRARELEMENTO
   OSF 24  0 MOSTRARELEMENTO
   SRF  0 23
   SRF  0 23
   DRF 
   STC  1
   PLUS 
   ASG 
L12:
   SRF  0 23
   DRF 
   STC 10
   LTE 
   JMT L13
; Fin del programa P
L2:
   LVP 
