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
   STC 101
   STC 100
   STC 99
   STC 98
   STC 97
   WRT  0
   WRT  0
   WRT  0
   WRT  0
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
   JMP L2
L3:
   STC 98
   STC 97
   WRT  0
   WRT  0
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   SBT 
   ASG 
L2:
   SRF  0  3
   DRF 
   STC  0
   GT 
   JMT L3
   SRF  0  3
   DRF 
   STC  0
   GT 
   JMF L4
   SRF  0  3
   DRF 
   WRT  1
L4:
; Fin del programa P
L1:
   LVP 
