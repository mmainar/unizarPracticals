   ENP L0
L1:
   STC 65
   WRT  0
   STC 98
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 116
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 106
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 44
   WRT  0
   STC 32
   WRT  0
   STC 105
   WRT  0
   STC 110
   WRT  0
   STC 100
   WRT  0
   STC 105
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 118
   WRT  0
   STC 101
   WRT  0
   STC 99
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 102
   WRT  0
   STC 117
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 103
   WRT  0
   STC 111
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   JMP L2
; Comienzo del programa P
L0:
   SRF  0  9
   SRF  0  3
   STC  8
   DUP 
   DUP 
   STC  3
   GTE 
   JMF L1
   STC  5
   LTE 
   JMF L1
   STC  3
   SBT 
   PLUS 
   DRF 
   ASG 
   SRF  0  6
   STC  4
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L1
   STC  6
   LTE 
   JMF L1
   STC  4
   SBT 
   PLUS 
   STC 17
   ASG 
   SRF  0  6
   STC  5
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L1
   STC  6
   LTE 
   JMF L1
   STC  4
   SBT 
   PLUS 
   STC 27
   ASG 
   SRF  0  6
   STC  6
   DUP 
   DUP 
   STC  4
   GTE 
   JMF L1
   STC  6
   LTE 
   JMF L1
   STC  4
   SBT 
   PLUS 
   STC 69
   ASG 
   STC  0
   DUP 
   DUP 
   DUP 
   STC  3
   JMP L3
L4:
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
L3:
   LT 
   JMT L4
   POP 
   POP 
   POP 
; Fin del programa P
L2:
   LVP 
