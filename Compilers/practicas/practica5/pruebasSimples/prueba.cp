   ENP L0
; Comienzo del programa P
L0:
   SRF  0  3
   STC  5
   ASG 
   SRF  0  3
   SRF  0  4
   DRF 
   STC  4
   PLUS 
   ASG 
   SRF  0  4
   SRF  0  4
   DRF 
   STC  1
   PLUS 
   ASG 
   SRF  0  3
   SRF  0  4
   DRF 
   SRF  0  3
   DRF 
   TMS 
   ASG 
   STC 97
   WRT  0
   STC 98
   WRT  0
   STC 99
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   SRF  0  4
   DRF 
   WRT  1
   SRF  0  3
   RD  1
   SRF  0  5
   RD  0
   STC  8
   WRT  1
   STC 28
   WRT  1
   SRF  0  5
   SRF  0  6
   DRF 
   ASG 
   JMP L3
L4:
   STC 97
   WRT  0
   STC 98
   WRT  0
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   SBT 
   ASG 
L3:
   SRF  0  3
   DRF 
   STC  0
   GT 
   JMT L4
   SRF  0  3
   DRF 
   STC  0
   GT 
   JMF L5
   SRF  0  3
   DRF 
   WRT  1
L5:
; Fin del programa P
L2:
   LVP 
