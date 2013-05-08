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
   SRF  0  5
   STC  3
   ASG 
   SRF  0  6
   STC  4
   ASG 
   JMP L3
L4:
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
   JMF L1
   STC  5
   LTE 
   JMF L1
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
   JMF L1
   STC  6
   LTE 
   JMF L1
   STC  4
   SBT 
   PLUS 
   DRF 
   ASG 
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L3:
   SRF  0  3
   DRF 
   SRF  0  4
   DRF 
   LT 
   JMT L4
; Fin del programa P
L2:
   LVP 
