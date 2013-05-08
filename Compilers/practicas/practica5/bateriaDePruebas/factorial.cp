   ENP L0
; Comienzo del programa FACT
L0:
   SRF  0  3
   RD  1
   SRF  0  4
   STC  1
   ASG 
   SRF  0  5
   STC  2
   ASG 
   JMP L3
L4:
   SRF  0  4
   SRF  0  4
   DRF 
   SRF  0  5
   DRF 
   TMS 
   ASG 
   SRF  0  5
   SRF  0  5
   DRF 
   STC  1
   PLUS 
   ASG 
L3:
   SRF  0  5
   DRF 
   SRF  0  3
   DRF 
   LTE 
   JMT L4
   SRF  0  4
   DRF 
   WRT  1
; Fin del programa FACT
L2:
   LVP 
