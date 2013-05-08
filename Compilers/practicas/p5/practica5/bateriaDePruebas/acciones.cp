   ENP L0
; Comienzo de accion P1
P1:
   SRF  0  5
   ASGI 
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L2
L2:
   SRF  0  6
   STC 35
   ASG 
   SRF  0  3
   DRF 
   SRF  0  6
   DRF 
   ASG 
   SRF  0  4
   SRF  0  6
   DRF 
   STC  0
   EQ 
   ASG 
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   ASG 
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   SRF  0  5
   DRF 
; Invocar P1
   OSF  7  1 P1
; Fin de accion P1
   CSF 
; Comienzo de accion P2
P2:
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
   JMP L3
L3:
   SRF  0  9
   STC  8
   ASG 
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 97
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
   SRF  0  3
   STC 40
   ASG 
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 97
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
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 98
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  4
   DRF 
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  4
   DRF 
   STC  8
   ASG 
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 98
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  4
   DRF 
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 101
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  7
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  7
   STC 98
   ASG 
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 101
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  7
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 102
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  8
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  8
   STC 99
   ASG 
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 102
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  8
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin de accion P2
   CSF 
; Comienzo de accion P3
P3:
   JMP L4
L4:
   STC 97
   STC 97
   STC 97
   STC 97
   STC 97
   STC 108
   STC 111
   STC 104
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
; Fin de accion P3
   CSF 
; Comienzo del programa P
L0:
   SRF  0  6
   STC 97
   ASG 
   SRF  0  4
   STC  5
   ASG 
   SRF  0  3
   SRF  0  4
   DRF 
   STC  1
   PLUS 
   ASG 
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 105
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
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 106
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  4
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 104
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  6
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   SRF  0  3
   DRF 
   SRF  0  4
   STC  7
   STC  0
   LT 
   STC  8
   STC  5
   LTE 
   SRF  0  6
   DRF 
   SRF  0  6
   DRF 
; Invocar P2
   OSF  7  0 P2
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 105
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
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 106
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  4
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
   STC 32
   STC 58
   STC 101
   STC 108
   STC 97
   STC 118
   STC 32
   STC 104
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  6
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
; Invocar P3
   OSF  7  0 P3
; Fin del programa P
L1:
   LVP 
