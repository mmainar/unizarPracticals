   ENP L0
; Comienzo de accion PRIMER_DIA_ANHO
PRIMER_DIA_ANHO:
   JMP L5
L5:
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
   JMF L3
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
   JMP L4
L3:
   SRF  1  5
   SRF  1  4
   DRF 
   SRF  0  3
   DRF 
   PLUS 
   STC  7
   MOD 
   ASG 
L4:
; Fin de accion PRIMER_DIA_ANHO
   CSF 
; Comienzo de accion PRIMER_DIA_MES
PRIMER_DIA_MES:
   JMP L32
L32:
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
   JMF L6
   SRF  1  7
   STC  1
   ASG 
   JMP L7
L6:
   SRF  1  7
   STC  0
   ASG 
L7:
   SRF  1  3
   DRF 
   STC  1
   EQ 
   JMF L30
   SRF  1  6
   SRF  1  5
   DRF 
   ASG 
   JMP L31
L30:
   SRF  1  3
   DRF 
   STC  2
   EQ 
   JMF L28
   SRF  1  6
   SRF  1  5
   DRF 
   STC 31
   PLUS 
   STC  7
   MOD 
   ASG 
   JMP L29
L28:
   SRF  1  3
   DRF 
   STC  3
   EQ 
   JMF L26
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
   JMP L27
L26:
   SRF  1  3
   DRF 
   STC  4
   EQ 
   JMF L24
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
   JMP L25
L24:
   SRF  1  3
   DRF 
   STC  5
   EQ 
   JMF L22
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
   JMP L23
L22:
   SRF  1  3
   DRF 
   STC  6
   EQ 
   JMF L20
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
   JMP L21
L20:
   SRF  1  3
   DRF 
   STC  7
   EQ 
   JMF L18
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
   JMP L19
L18:
   SRF  1  3
   DRF 
   STC  8
   EQ 
   JMF L16
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
   JMP L17
L16:
   SRF  1  3
   DRF 
   STC  9
   EQ 
   JMF L14
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
   JMP L15
L14:
   SRF  1  3
   DRF 
   STC 10
   EQ 
   JMF L12
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
   JMP L13
L12:
   SRF  1  3
   DRF 
   STC 11
   EQ 
   JMF L10
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
   JMP L11
L10:
   SRF  1  3
   DRF 
   STC 12
   EQ 
   JMF L8
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
   JMP L9
L8:
   STC 72
   WRT  0
   STC 97
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 105
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 100
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 100
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 109
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
   STC 108
   WRT  0
L9:
L11:
L13:
L15:
L17:
L19:
L21:
L23:
L25:
L27:
L29:
L31:
; Fin de accion PRIMER_DIA_MES
   CSF 
; Comienzo del programa CALENDARIO
L0:
   STC 67
   WRT  0
   STC 65
   WRT  0
   STC 76
   WRT  0
   STC 69
   WRT  0
   STC 78
   WRT  0
   STC 68
   WRT  0
   STC 65
   WRT  0
   STC 82
   WRT  0
   STC 73
   WRT  0
   STC 79
   WRT  0
   STC 73
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 100
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 117
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 102
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 115
   WRT  0
   STC 58
   WRT  0
   SRF  0  3
   RD  1
   SRF  0  8
   RD  0
   STC 73
   WRT  0
   STC 110
   WRT  0
   STC 116
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 100
   WRT  0
   STC 117
   WRT  0
   STC 99
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 117
   WRT  0
   STC 110
   WRT  0
   STC 32
   WRT  0
   STC 97
   WRT  0
   STC 110
   WRT  0
   STC 105
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
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 102
   WRT  0
   STC 114
   WRT  0
   STC 97
   WRT  0
   STC 115
   WRT  0
   STC 58
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
L2:
   LVP 
