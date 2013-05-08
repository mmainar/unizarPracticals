   ENP L0
; Comienzo del programa P
L0:
   SRF  0  6
   STC  4
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L2
   STC  6
   LTE 
   JMF L2
   STC  4
   SBT 
   PLUS 
   STC 17
   ASG 
   JMP L3
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
L3:
   SRF  0  6
   STC  5
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L4
   STC  6
   LTE 
   JMF L4
   STC  4
   SBT 
   PLUS 
   STC 27
   ASG 
   JMP L5
L4:
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
L5:
   SRF  0  6
   STC  6
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L6
   STC  6
   LTE 
   JMF L6
   STC  4
   SBT 
   PLUS 
   STC 69
   ASG 
   JMP L7
L6:
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
L7:
   STC  0
   DUP 
   DUP 
   DUP 
   STC  3
   JMP L8
L9:
   SRF  0  3
   PLUS 
   SWP 
   SRF  0  6
   PLUS 
   DRF 
   ASG 
   STC  1
   PLUS 
   DUP 
   DUP 
   DUP 
   STC  3
L8:
   LT 
   JMT L9
   POP 
   POP 
   POP 
; Fin del programa P
L1:
   LVP 
