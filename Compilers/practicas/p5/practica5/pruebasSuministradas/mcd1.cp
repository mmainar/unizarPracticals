   ENP L0
; Comienzo de accion DATO
DATO:
   JMP L6
L6:
   SRF  1  4
   STC  0
   ASG 
   JMP L4
L5:
   STC 32
   STC 58
   STC 111
   STC 114
   STC 101
   STC 109
   STC 117
   STC 110
   STC 32
   STC 110
   STC 117
   STC 32
   STC 101
   STC 98
   STC 105
   STC 114
   STC 99
   STC 115
   STC 69
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  1  4
   RD  1
   SRF  1  4
   DRF 
   STC  0
   LTE 
   JMF L2
   STC 46
   STC 111
   STC 118
   STC 105
   STC 116
   STC 115
   STC 111
   STC 112
   STC 32
   STC 114
   STC 101
   STC 115
   STC 32
   STC 101
   STC 98
   STC 101
   STC 100
   STC 32
   STC 111
   STC 114
   STC 101
   STC 109
   STC 117
   STC 110
   STC 32
   STC 108
   STC 69
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L2:
L4:
   SRF  1  4
   DRF 
   STC  0
   LTE 
   JMT L5
; Fin de accion DATO
   CSF 
; Comienzo de accion MCD
MCD:
   JMP L9
L9:
   SRF  0  3
   SRF  1  5
   DRF 
   SRF  1  6
   DRF 
   MOD 
   ASG 
   JMP L7
L8:
   SRF  1  5
   SRF  1  6
   DRF 
   ASG 
   SRF  1  6
   SRF  0  3
   DRF 
   ASG 
   SRF  0  3
   SRF  1  5
   DRF 
   SRF  1  6
   DRF 
   MOD 
   ASG 
L7:
   SRF  0  3
   DRF 
   STC  0
   NEQ 
   JMT L8
   SRF  1  3
   SRF  1  6
   DRF 
   ASG 
; Fin de accion MCD
   CSF 
; Comienzo del programa MAXIMO_COMUN_DIVISOR
L0:
; Invocar DATO
   OSF  7  0 DATO
   SRF  0  5
   SRF  0  4
   DRF 
   ASG 
; Invocar DATO
   OSF  7  0 DATO
   SRF  0  6
   SRF  0  4
   DRF 
   ASG 
; Invocar MCD
   OSF  7  0 MCD
   STC 32
   STC 58
   STC 115
   STC 101
   STC 32
   STC 68
   STC 67
   STC 77
   STC 32
   STC 108
   STC 69
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  3
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin del programa MAXIMO_COMUN_DIVISOR
L1:
   LVP 
