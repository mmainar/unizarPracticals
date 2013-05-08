   ENP L0
; Comienzo de accion SIONO
SIONO:
   JMP L4
L4:
   SRF  0  3
   STC 32
   ASG 
   JMP L2
L3:
   STC 63
   STC 41
   STC 78
   STC 47
   STC 83
   STC 40
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  3
   RD  0
   SRF  0  4
   RD  0
L2:
   SRF  0  3
   DRF 
   STC 83
   NEQ 
   SRF  0  3
   DRF 
   STC 78
   NEQ 
   AND 
   JMT L3
   SRF  1  3
   SRF  0  3
   DRF 
   ASG 
; Fin de accion SIONO
   CSF 
; Comienzo de accion PEDIRLETRA
PEDIRLETRA:
   JMP L7
L7:
   SRF  0  3
   STC 32
   ASG 
   JMP L5
L6:
   STC 58
   STC 97
   STC 114
   STC 116
   STC 101
   STC 108
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  3
   RD  0
   SRF  0  4
   RD  0
L5:
   SRF  0  3
   DRF 
   STC 65
   LT 
   SRF  0  3
   DRF 
   STC 90
   GT 
   OR 
   JMT L6
   SRF  1  3
   SRF  0  3
   DRF 
   ASG 
; Fin de accion PEDIRLETRA
   CSF 
; Comienzo del programa ADIVINAR
L0:
   STC 46
   STC 97
   STC 108
   STC 114
   STC 97
   STC 110
   STC 105
   STC 118
   STC 105
   STC 100
   STC 97
   STC 32
   STC 101
   STC 114
   STC 97
   STC 116
   STC 110
   STC 101
   STC 116
   STC 110
   STC 105
   STC 32
   STC 101
   STC 32
   STC 97
   STC 114
   STC 116
   STC 101
   STC 108
   STC 32
   STC 97
   STC 110
   STC 117
   STC 32
   STC 110
   STC 101
   STC 32
   STC 97
   STC 115
   STC 110
   STC 101
   STC 105
   STC 80
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
   STC 13
   WRT  0
   STC 10
   WRT  0
   STC 63
   STC 111
   STC 116
   STC 115
   STC 105
   STC 76
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
; Invocar SIONO
   OSF 10  0 SIONO
   SRF  0  5
   STC 65
   ASG 
   SRF  0  6
   STC 90
   ASG 
   SRF  0  7
   STC  0
   ASG 
   JMP L12
L13:
   SRF  0  4
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   PLUS 
   STC  2
   DIV 
   ASG 
   STC 40
   WRT  0
   SRF  0  5
   DRF 
   WRT  0
   STC 44
   WRT  0
   SRF  0  6
   DRF 
   WRT  0
   STC 41
   WRT  0
   STC 32
   STC 97
   STC 114
   STC 116
   STC 101
   STC 108
   STC 32
   STC 97
   STC 108
   STC 32
   STC 110
   STC 101
   STC 32
   STC 111
   STC 100
   STC 97
   STC 115
   STC 110
   STC 101
   STC 112
   STC 32
   STC 115
   STC 97
   STC 104
   STC 32
   STC 58
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
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  4
   DRF 
   WRT  0
   STC 63
   WRT  0
; Invocar SIONO
   OSF 10  0 SIONO
   SRF  0  3
   DRF 
   STC 78
   EQ 
   JMF L10
   STC 63
   STC 114
   STC 111
   STC 121
   STC 97
   STC 109
   STC 32
   STC 115
   STC 101
   STC 32
   STC 111
   STC 100
   STC 97
   STC 115
   STC 110
   STC 101
   STC 112
   STC 32
   STC 115
   STC 97
   STC 104
   STC 32
   STC 101
   STC 117
   STC 113
   STC 32
   STC 97
   STC 114
   STC 116
   STC 101
   STC 108
   STC 32
   STC 97
   STC 76
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
   WRT  0
; Invocar SIONO
   OSF 10  0 SIONO
   SRF  0  3
   DRF 
   STC 83
   EQ 
   JMF L8
   SRF  0  5
   SRF  0  4
   DRF 
   STC  1
   PLUS 
   ASG 
   JMP L9
L8:
   SRF  0  6
   SRF  0  4
   DRF 
   STC  1
   SBT 
   ASG 
L9:
   JMP L11
L10:
   SRF  0  7
   STC  1
   ASG 
L11:
L12:
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   NEQ 
   SRF  0  7
   DRF 
   NGB 
   AND 
   JMT L13
   SRF  0  7
   DRF 
   NGB 
   JMF L14
   STC 32
   STC 97
   STC 108
   STC 32
   STC 115
   STC 101
   STC 32
   STC 97
   STC 114
   STC 116
   STC 101
   STC 108
   STC 32
   STC 97
   STC 76
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
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  5
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L14:
; Fin del programa ADIVINAR
L1:
   LVP 
