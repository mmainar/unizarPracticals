   ENP L0
; Comienzo de accion A
A:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L5
; Comienzo de accion B
B:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L4
; Comienzo de accion C
C:
   SRF  0  3
   ASGI 
   JMP L2
L2:
   SRF  0  5
   STC  1
   ASG 
   SRF  3  3
   SRF  1  5
   DRF 
   SRF  3  5
   DRF 
   PLUS 
   SRF  3  7
   DRF 
   PLUS 
   SRF  0  4
   DRF 
   PLUS 
   ASG 
   SRF  2  5
   SRF  2  6
   DRF 
   STC  1
   PLUS 
   ASG 
   STC  8
   SRF  3  3
; Invocar B
   OSF  6  2 B
   STC  0
   SRF  0  3
   DRF 
; Invocar B
   OSF  6  2 B
   SRF  1  6
; Invocar C
   OSF  6  1 C
   STC  8
   SRF  0  4
; Invocar A
   OSF  6  3 A
; Fin de accion C
   CSF 
; Comienzo de accion D
D:
   JMP L3
L3:
   SRF  0  3
   SRF  3  5
   DRF 
   SRF  2  7
   DRF 
   PLUS 
   ASG 
   SRF  0  3
; Invocar C
   OSF  5  1 C
   SRF  0  3
   DRF 
   SRF  1  5
; Invocar B
   OSF  5  2 B
; Invocar D
   OSF  5  1 D
   STC  8
   SRF  2  6
; Invocar A
   OSF  5  3 A
; Fin de accion D
   CSF 
L4:
   SRF  0  5
   SRF  2  3
   DRF 
   SRF  1  7
   DRF 
   PLUS 
   SRF  2  7
   DRF 
   PLUS 
   ASG 
   SRF  0  5
; Invocar C
   OSF  8  0 C
; Invocar D
   OSF  8  0 D
   STC  8
   SRF  0  5
; Invocar B
   OSF  8  1 B
   STC  4
   SRF  2  5
; Invocar A
   OSF  8  2 A
; Fin de accion B
   CSF 
L5:
   SRF  1  5
   STC  2
   ASG 
   SRF  0  7
   SRF  1  5
   DRF 
   SRF  1  7
   DRF 
   PLUS 
   ASG 
   SRF  1  5
   DRF 
   SRF  0  7
; Invocar B
   OSF  9  0 B
   STC  7
   SRF  1  5
; Invocar A
   OSF  9  1 A
; Fin de accion A
   CSF 
; Comienzo del programa P
L0:
   SRF  0  3
   STC  1
   ASG 
   SRF  0  4
   STC  2
   ASG 
   SRF  0  5
   STC  3
   ASG 
   SRF  0  6
   STC  4
   ASG 
   SRF  0  7
   STC  5
   ASG 
   SRF  0  3
   SRF  0  6
   DRF 
   SRF  0  7
   DRF 
   PLUS 
   ASG 
   SRF  0  3
   DRF 
   SRF  0  4
; Invocar A
   OSF  8  0 A
; Fin del programa P
L1:
   LVP 
