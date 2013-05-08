   ENP L0
; Comienzo del programa MAX
L0:
   SRF  0  3
   RD  1
   SRF  0  4
   RD  1
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   GT 
   JMF L2
   SRF  0  3
   DRF 
   WRT  1
   JMP L3
L2:
   SRF  0  4
   DRF 
   WRT  1
L3:
; Fin del programa MAX
L1:
   LVP 
