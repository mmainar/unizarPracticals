   ENP L0
; Comienzo de accion PRIMER_DIA_ANHO
PRIMER_DIA_ANHO:
   JMP L4
L4:
   SRF  1  4
   SRF  1  4
   DRF 
   STC 1900
   SBT 
   ASG 
   SRF  0  6
   SRF  1  4
   DRF 
   STC  4
   MOD 
   STC  0
   EQ 
   SRF  1  4
   DRF 
   STC 100
   MOD 
   STC  0
   NEQ 
   AND 
   ASG 
   SRF  0  5
   SRF  1  4
   DRF 
   STC 400
   MOD 
   STC  0
   EQ 
   ASG 
   SRF  0  4
   SRF  0  6
   DRF 
   SRF  0  5
   DRF 
   OR 
   ASG 
   SRF  0  3
   SRF  1  4
   DRF 
   STC  4
   DIV 
   ASG 
   SRF  0  4
   DRF 
   JMF L2
   SRF  1  5
   SRF  1  4
   DRF 
   STC  1
   SBT 
   SRF  0  3
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L3
L2:
   SRF  1  5
   SRF  1  4
   DRF 
   SRF  0  3
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
L3:
; Fin de accion PRIMER_DIA_ANHO
   CSF 
; Comienzo de accion PRIMER_DIA_MES
PRIMER_DIA_MES:
   JMP L31
L31:
   SRF  1  4
   SRF  1  4
   DRF 
   STC 1900
   SBT 
   ASG 
   SRF  0  4
   SRF  1  4
   DRF 
   STC  4
   MOD 
   STC  0
   EQ 
   SRF  1  4
   DRF 
   STC 100
   MOD 
   STC  0
   NEQ 
   AND 
   ASG 
   SRF  0  5
   SRF  1  4
   DRF 
   STC 400
   MOD 
   STC  0
   EQ 
   ASG 
   SRF  0  3
   SRF  0  4
   DRF 
   SRF  0  5
   DRF 
   OR 
   ASG 
   SRF  0  3
   DRF 
   JMF L5
   SRF  1  7
   STC  1
   ASG 
   JMP L6
L5:
   SRF  1  7
   STC  0
   ASG 
L6:
   SRF  1  3
   DRF 
   STC  1
   EQ 
   JMF L29
   SRF  1  6
   SRF  1  5
   DRF 
   ASG 
   JMP L30
L29:
   SRF  1  3
   DRF 
   STC  2
   EQ 
   JMF L27
   SRF  1  6
   SRF  1  5
   DRF 
   STC 31
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L28
L27:
   SRF  1  3
   DRF 
   STC  3
   EQ 
   JMF L25
   SRF  1  6
   SRF  1  5
   DRF 
   STC 59
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L26
L25:
   SRF  1  3
   DRF 
   STC  4
   EQ 
   JMF L23
   SRF  1  6
   SRF  1  5
   DRF 
   STC 90
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L24
L23:
   SRF  1  3
   DRF 
   STC  5
   EQ 
   JMF L21
   SRF  1  6
   SRF  1  5
   DRF 
   STC 120
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L22
L21:
   SRF  1  3
   DRF 
   STC  6
   EQ 
   JMF L19
   SRF  1  6
   SRF  1  5
   DRF 
   STC 151
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L20
L19:
   SRF  1  3
   DRF 
   STC  7
   EQ 
   JMF L17
   SRF  1  6
   SRF  1  5
   DRF 
   STC 181
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L18
L17:
   SRF  1  3
   DRF 
   STC  8
   EQ 
   JMF L15
   SRF  1  6
   SRF  1  5
   DRF 
   STC 212
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L16
L15:
   SRF  1  3
   DRF 
   STC  9
   EQ 
   JMF L13
   SRF  1  6
   SRF  1  5
   DRF 
   STC 243
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L14
L13:
   SRF  1  3
   DRF 
   STC 10
   EQ 
   JMF L11
   SRF  1  6
   SRF  1  5
   DRF 
   STC 273
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L12
L11:
   SRF  1  3
   DRF 
   STC 11
   EQ 
   JMF L9
   SRF  1  6
   SRF  1  5
   DRF 
   STC 304
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L10
L9:
   SRF  1  3
   DRF 
   STC 12
   EQ 
   JMF L7
   SRF  1  6
   SRF  1  5
   DRF 
   STC 334
   PLUS 
   SRF  1  7
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L8
L7:
   STC 108
   STC 97
   STC 109
   STC 32
   STC 115
   STC 101
   STC 109
   STC 32
   STC 108
   STC 101
   STC 32
   STC 111
   STC 100
   STC 105
   STC 99
   STC 117
   STC 100
   STC 111
   STC 114
   STC 116
   STC 110
   STC 105
   STC 32
   STC 115
   STC 97
   STC 72
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
L8:
L10:
L12:
L14:
L16:
L18:
L20:
L22:
L24:
L26:
L28:
L30:
; Fin de accion PRIMER_DIA_MES
   CSF 
; Comienzo del programa CALENDARIO
L0:
   STC 79
   STC 73
   STC 82
   STC 65
   STC 68
   STC 78
   STC 69
   STC 76
   STC 65
   STC 67
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
   STC 58
   STC 115
   STC 97
   STC 114
   STC 102
   STC 105
   STC 99
   STC 32
   STC 110
   STC 101
   STC 32
   STC 115
   STC 101
   STC 109
   STC 32
   STC 110
   STC 117
   STC 32
   STC 101
   STC 99
   STC 117
   STC 100
   STC 111
   STC 114
   STC 116
   STC 110
   STC 73
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
   SRF  0  3
   RD  1
   SRF  0  8
   RD  0
   STC 58
   STC 115
   STC 97
   STC 114
   STC 102
   STC 105
   STC 99
   STC 32
   STC 110
   STC 101
   STC 32
   STC 111
   STC 105
   STC 110
   STC 97
   STC 32
   STC 110
   STC 117
   STC 32
   STC 101
   STC 99
   STC 117
   STC 100
   STC 111
   STC 114
   STC 116
   STC 110
   STC 73
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
   SRF  0  4
   RD  1
   SRF  0  8
   RD  0
; Invocar PRIMER_DIA_ANHO
   OSF  9  0 PRIMER_DIA_ANHO
; Invocar PRIMER_DIA_MES
   OSF  9  0 PRIMER_DIA_MES
   SRF  0  6
   DRF 
   WRT  1
; Fin del programa CALENDARIO
L1:
   LVP 
