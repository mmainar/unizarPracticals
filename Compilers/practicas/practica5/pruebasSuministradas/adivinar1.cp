   ENP L0
; Comienzo de accion SIONO
SIONO:
   JMP L5
L5:
   SRF  0  3
   STC 32
   ASG 
   JMP L3
L4:
   STC 40
   WRT  0
   STC 83
   WRT  0
   STC 47
   WRT  0
   STC 78
   WRT  0
   STC 41
   WRT  0
   STC 63
   WRT  0
   SRF  0  3
   RD  0
   SRF  0  4
   RD  0
L3:
   SRF  0  3
   DRF 
   STC 83
   NEQ 
   SRF  0  3
   DRF 
   STC 78
   NEQ 
   AND 
   JMT L4
   SRF  1  3
   SRF  0  3
   DRF 
   ASG 
; Fin de accion SIONO
   CSF 
; Comienzo de accion PEDIRLETRA
PEDIRLETRA:
   JMP L8
L8:
   SRF  0  3
   STC 32
   ASG 
   JMP L6
L7:
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 58
   WRT  0
   SRF  0  3
   RD  0
   SRF  0  4
   RD  0
L6:
   SRF  0  3
   DRF 
   STC 65
   LT 
   SRF  0  3
   DRF 
   STC 90
   GT 
   OR 
   JMT L7
   SRF  1  3
   SRF  0  3
   DRF 
   ASG 
; Fin de accion PEDIRLETRA
   CSF 
; Comienzo del programa ADIVINAR
L0:
   STC 80
   WRT  0
   STC 105
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 115
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 117
   WRT  0
   STC 110
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 105
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 97
   WRT  0
   STC 114
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 97
   WRT  0
   STC 100
   WRT  0
   STC 105
   WRT  0
   STC 118
   WRT  0
   STC 105
   WRT  0
   STC 110
   WRT  0
   STC 97
   WRT  0
   STC 114
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 46
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
   STC 76
   WRT  0
   STC 105
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 111
   WRT  0
   STC 63
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
   JMP L13
L14:
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
   STC 58
   WRT  0
   STC 32
   WRT  0
   STC 104
   WRT  0
   STC 97
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 112
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 115
   WRT  0
   STC 97
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 32
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
   JMF L11
   STC 76
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 113
   WRT  0
   STC 117
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 104
   WRT  0
   STC 97
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 112
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 115
   WRT  0
   STC 97
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 109
   WRT  0
   STC 97
   WRT  0
   STC 121
   WRT  0
   STC 111
   WRT  0
   STC 114
   WRT  0
   STC 63
   WRT  0
; Invocar SIONO
   OSF 10  0 SIONO
   SRF  0  3
   DRF 
   STC 83
   EQ 
   JMF L9
   SRF  0  5
   SRF  0  4
   DRF 
   STC  1
   PLUS 
   ASG 
   JMP L10
L9:
   SRF  0  6
   SRF  0  4
   DRF 
   STC  1
   SBT 
   ASG 
L10:
   JMP L12
L11:
   SRF  0  7
   STC  1
   ASG 
L12:
L13:
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   NEQ 
   SRF  0  7
   DRF 
   NGB 
   AND 
   JMT L14
   SRF  0  7
   DRF 
   NGB 
   JMF L15
   STC 76
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 101
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 108
   WRT  0
   STC 97
   WRT  0
   STC 32
   WRT  0
   SRF  0  5
   DRF 
   WRT  0
   STC 13
   WRT  0
   STC 10
   WRT  0
L15:
; Fin del programa ADIVINAR
L2:
   LVP 
