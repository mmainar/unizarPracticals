   ENP L0
; Comienzo del programa P
L0:
   SRF  0  5
   STC  3
   ASG 
   SRF  0  6
   STC  4
   ASG 
   JMP L4
L5:
   SRF  0  7
   SRF  0  5
   DRF 
   SRF  0  3
   DRF 
   PLUS 
   DUP 
   DUP 
   STC  3
   GTE 
   JMF L3
   STC  3
   LTE 
   JMF L3
   STC  3
   SBT 
   PLUS 
   SRF  0 10
   SRF  0  6
   DRF 
   SRF  0  3
   DRF 
   PLUS 
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L2
   STC  4
   LTE 
   JMF L2
   STC  4
   SBT 
   PLUS 
   DRF 
L2:
   STC 13
   STC 10
   STC 111
   STC 100
   STC 110
   STC 97
   STC 116
   STC 114
   STC 111
   STC 98
   STC 65
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   JMP L1
   ASG 
L3:
   STC 13
   STC 10
   STC 111
   STC 100
   STC 110
   STC 97
   STC 116
   STC 114
   STC 111
   STC 98
   STC 65
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   JMP L1
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L4:
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   LT 
   JMT L5
; Fin del programa P
L1:
   LVP 
