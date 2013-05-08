   ENP L0
; Comienzo de accion ES_PRIMO
ES_PRIMO:
   JMP L7
L7:
   SRF  0  3
   STC  2
   ASG 
   SRF  0  4
   STC  0
   ASG 
   JMP L3
L4:
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
L3:
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
   JMT L4
   SRF  0  4
   DRF 
   NGB 
   JMF L5
   SRF  1  4
   DRF 
   WRT  1
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 112
   WRT  0
   STC 114
   WRT  0
   STC 105
   WRT  0
   STC 109
   WRT  0
   STC 111
   WRT  0
   STC 46
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L5:
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
   JMP L8
L9:
; Invocar ES_PRIMO
   OSF  5  0 ES_PRIMO
   SRF  0  4
   SRF  0  4
   DRF 
   STC  1
   PLUS 
   ASG 
L8:
   SRF  0  4
   DRF 
   SRF  0  3
   DRF 
   LTE 
   JMT L9
; Fin del programa NPRIMOS
L2:
   LVP 
