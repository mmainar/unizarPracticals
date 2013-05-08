   ENP L0
; Comienzo de accion Q
Q:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L4
; Comienzo de accion R
R:
   SRF  0  3
   ASGI 
   JMP L3
L3:
   SRF  0  4
   DRF 
   SRF  1  4
   DRF 
; Invocar Q
   OSF  5  2 Q
   SRF  0  3
   DRF 
; Invocar R
   OSF  5  1 R
; Fin de accion R
   CSF 
L4:
   SRF  0  5
   DRF 
   SRF  0  6
; Invocar Q
   OSF  7  1 Q
   SRF  0  5
; Invocar R
   OSF  7  0 R
; Fin de accion Q
   CSF 
; Comienzo del programa P
L0:
   SRF  0  3
   DRF 
   SRF  0  4
; Invocar Q
   OSF  5  0 Q
; Fin del programa P
L2:
   LVP 
