   ENP L0
; Comienzo del programa NOVENTA_Y_NUEVE
L0:
   SRF  0  5
   STC  0
   ASG 
   JMP L3
L4:
   STC 110
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  5
   RD  1
L3:
   SRF  0  5
   DRF 
   STC  0
   LTE 
   SRF  0  5
   DRF 
   STC 100
   GTE 
   OR 
   SRF  0  5
   DRF 
   STC 10
   DIV 
   SRF  0  5
   DRF 
   STC 10
   MOD 
   EQ 
   OR 
   JMT L4
   SRF  0  5
   DRF 
   WRT  1
   STC 32
   WRT  0
   STC 115
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 99
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 118
   WRT  0
   STC 105
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 116
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   SRF  0  3
   SRF  0  5
   DRF 
   STC 10
   DIV 
   ASG 
   SRF  0  4
   SRF  0  5
   DRF 
   STC 10
   MOD 
   ASG 
   SRF  0  6
   STC 10
   SRF  0  4
   DRF 
   TMS 
   SRF  0  3
   DRF 
   PLUS 
   ASG 
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   GT 
   JMF L5
   SRF  0  5
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   SBT 
   ASG 
   JMP L6
L5:
   SRF  0  5
   SRF  0  6
   DRF 
   SRF  0  5
   DRF 
   SBT 
   ASG 
L6:
   SRF  0  3
   SRF  0  5
   DRF 
   STC 10
   DIV 
   ASG 
   SRF  0  4
   SRF  0  5
   DRF 
   STC 10
   MOD 
   ASG 
   SRF  0  6
   STC 10
   SRF  0  4
   DRF 
   TMS 
   SRF  0  3
   DRF 
   PLUS 
   ASG 
   SRF  0  5
   SRF  0  6
   DRF 
   SRF  0  5
   DRF 
   PLUS 
   ASG 
   SRF  0  5
   DRF 
   WRT  1
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin del programa NOVENTA_Y_NUEVE
L2:
   LVP 
