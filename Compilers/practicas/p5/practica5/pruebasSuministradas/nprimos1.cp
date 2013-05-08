   ENP L0
; Comienzo de accion ES_PRIMO
ES_PRIMO:
   JMP L6
L6:
   SRF  0  3
   STC  2
   ASG 
   SRF  0  4
   STC  0
   ASG 
   JMP L2
L3:
   SRF  0  4
   SRF  1  4
   DRF 
   SRF  0  3
   DRF 
   MOD 
   STC  0
   EQ 
   ASG 
   SRF  0  3
   SRF  0  3
   DRF 
   STC  1
   PLUS 
   ASG 
L2:
   SRF  0  3
   DRF 
   SRF  1  4
   DRF 
   STC  2
   DIV 
   LT 
   SRF  0  4
   DRF 
   NGB 
   AND 
   JMT L3
   SRF  0  4
   DRF 
   NGB 
   JMF L4
   SRF  1  4
   DRF 
   WRT  1
   STC 46
   STC 111
   STC 109
   STC 105
   STC 114
   STC 112
   STC 32
   STC 115
   STC 101
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L4:
; Fin de accion ES_PRIMO
   CSF 
; Comienzo del programa NPRIMOS
L0:
   SRF  0  3
   STC 100
   ASG 
   SRF  0  4
   STC  2
   ASG 
   JMP L7
L8:
; Invocar ES_PRIMO
   OSF  5  0 ES_PRIMO
   SRF  0  4
   SRF  0  4
   DRF 
   STC  1
   PLUS 
   ASG 
L7:
   SRF  0  4
   DRF 
   SRF  0  3
   DRF 
   LTE 
   JMT L8
; Fin del programa NPRIMOS
L1:
   LVP 
