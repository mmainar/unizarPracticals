   ENP L0
; Comienzo de accion DATO
DATO:
   SRF  0  3
   ASGI 
   JMP L7
L7:
   SRF  0  3
   DRF 
   STC  0
   ASG 
   JMP L5
L6:
   STC 69
   WRT  0
   STC 115
   WRT  0
   STC 99
   WRT  0
   STC 114
   WRT  0
   STC 105
   WRT  0
   STC 98
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
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
   DRF 
   RD  1
   SRF  0  3
   DRF 
   DRF 
   STC  0
   LTE 
   JMF L3
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
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 98
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 115
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 112
   WRT  0
   STC 111
   WRT  0
   STC 115
   WRT  0
   STC 105
   WRT  0
   STC 116
   WRT  0
   STC 105
   WRT  0
   STC 118
   WRT  0
   STC 111
   WRT  0
   STC 46
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L3:
L5:
   SRF  0  3
   DRF 
   DRF 
   STC  0
   LTE 
   JMT L6
; Fin de accion DATO
   CSF 
; Comienzo de accion MCD
MCD:
   SRF  0  5
   ASGI 
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L10
L10:
   SRF  0  6
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   MOD 
   ASG 
   JMP L8
L9:
   SRF  0  3
   SRF  0  4
   DRF 
   ASG 
   SRF  0  4
   SRF  0  6
   DRF 
   ASG 
   SRF  0  6
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   MOD 
   ASG 
L8:
   SRF  0  6
   DRF 
   STC  0
   NEQ 
   JMT L9
   SRF  0  5
   DRF 
   SRF  0  4
   DRF 
   ASG 
; Fin de accion MCD
   CSF 
; Comienzo del programa P
L0:
   SRF  0  3
; Invocar DATO
   OSF  6  0 DATO
   SRF  0  4
; Invocar DATO
   OSF  6  0 DATO
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   SRF  0  5
; Invocar MCD
   OSF  6  0 MCD
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 77
   WRT  0
   STC 67
   WRT  0
   STC 68
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
   SRF  0  5
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin del programa P
L2:
   LVP 
