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
   JMF L3
   SRF  0  3
   DRF 
   WRT  1
   JMP L4
L3:
   SRF  0  4
   DRF 
   WRT  1
L4:
; Fin del programa MAX
L2:
   LVP 
