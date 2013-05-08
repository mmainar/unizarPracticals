   ENP L0
; Comienzo de accion O
O:
   JMP L5
; Comienzo de accion P
P:
   JMP L4
; Comienzo de accion Q
Q:
   JMP L3
; Comienzo de accion R
R:
   JMP L2
L2:
   SRF  4  3
   SRF  4  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  3  3
   SRF  3  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  2  3
   SRF  2  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  1  3
   SRF  1  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  0  3
   STC  5
   ASG 
   SRF  4  3
   DRF 
   WRT  1
   SRF  3  3
   DRF 
   WRT  1
   SRF  2  3
   DRF 
   WRT  1
   SRF  1  3
   DRF 
   WRT  1
   SRF  0  3
   DRF 
   WRT  1
; Invocar R
   OSF  4  1 R
; Invocar Q
   OSF  4  2 Q
; Invocar P
   OSF  4  3 P
; Invocar O
   OSF  4  4 O
; Fin de accion R
   CSF 
L3:
   SRF  3  3
   SRF  3  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  2  3
   SRF  2  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  1  3
   SRF  1  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  0  3
   STC  4
   ASG 
; Invocar R
   OSF  4  0 R
; Invocar Q
   OSF  4  1 Q
; Invocar P
   OSF  4  2 P
; Invocar O
   OSF  4  3 O
; Fin de accion Q
   CSF 
L4:
   SRF  2  3
   SRF  2  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  1  3
   SRF  1  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  0  3
   STC  3
   ASG 
; Invocar Q
   OSF  4  0 Q
; Invocar P
   OSF  4  1 P
; Invocar O
   OSF  4  2 O
; Fin de accion P
   CSF 
L5:
   SRF  1  3
   SRF  1  3
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  0  3
   STC  2
   ASG 
; Invocar P
   OSF  4  0 P
; Invocar O
   OSF  4  1 O
; Fin de accion O
   CSF 
; Comienzo del programa NIVELES
L0:
   SRF  0  3
   STC  1
   ASG 
; Invocar O
   OSF  4  0 O
; Fin del programa NIVELES
L1:
   LVP 
