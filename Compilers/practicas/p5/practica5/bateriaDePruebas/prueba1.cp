   ENP L0
; Comienzo de accion Q
Q:
   SRF  0  3
   ASGI 
   JMP L2
L2:
   SRF  0  3
   DRF 
   DRF 
   WRT  1
   SRF  0  3
   DRF 
   STC  0
   ASG 
; Fin de accion Q
   CSF 
; Comienzo de accion R
R:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L3
L3:
   SRF  0  3
   DRF 
   WRT  1
   SRF  0  4
   DRF 
   DRF 
   WRT  1
   SRF  0  4
   DRF 
   STC  0
   ASG 
   SRF  0  4
   DRF 
; Invocar Q
   OSF  5  1 Q
; Fin de accion R
   CSF 
; Comienzo del programa P
L0:
   SRF  0  3
   DRF 
   SRF  0  4
; Invocar R
   OSF  5  0 R
; Fin del programa P
L1:
   LVP 
