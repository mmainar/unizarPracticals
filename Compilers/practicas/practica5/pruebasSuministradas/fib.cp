   ENP L0
; Comienzo de accion CAMBIAR_DE_LINEA
CAMBIAR_DE_LINEA:
   JMP L3
L3:
   STC 13
   WRT  0
   STC 10
   WRT  0
; Fin de accion CAMBIAR_DE_LINEA
   CSF 
; Comienzo de accion DATO
DATO:
   SRF  0  3
   ASGI 
   JMP L9
; Comienzo de accion PEDIR_DATO
PEDIR_DATO:
   JMP L4
L4:
   STC 69
   WRT  0
   STC 115
   WRT  0
   STC 99
   WRT  0
   STC 114
   WRT  0
   STC 105
   WRT  0
   STC 98
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
   STC 110
   WRT  0
   STC 117
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  1  3
   DRF 
   RD  1
; Fin de accion PEDIR_DATO
   CSF 
L9:
   SRF  0  3
   DRF 
   STC  0
   ASG 
   SRF  0  4
   STC  0
   ASG 
   JMP L7
L8:
; Invocar PEDIR_DATO
   OSF  5  0 PEDIR_DATO
   SRF  0  4
   SRF  0  3
   DRF 
   DRF 
   STC  0
   GT 
   ASG 
   SRF  0  4
   DRF 
   NGB 
   JMF L5
   STC 69
   WRT  0
   STC 108
   WRT  0
   STC 32
   WRT  0
   STC 110
   WRT  0
   STC 117
   WRT  0
   STC 109
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 111
   WRT  0
   STC 32
   WRT  0
   STC 100
   WRT  0
   STC 101
   WRT  0
   STC 98
   WRT  0
   STC 101
   WRT  0
   STC 32
   WRT  0
   STC 115
   WRT  0
   STC 101
   WRT  0
   STC 114
   WRT  0
   STC 32
   WRT  0
   STC 112
   WRT  0
   STC 111
   WRT  0
   STC 115
   WRT  0
   STC 116
   WRT  0
   STC 105
   WRT  0
   STC 118
   WRT  0
   STC 111
   WRT  0
   STC 46
   WRT  0
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
L5:
L7:
   SRF  0  4
   DRF 
   NGB 
   JMT L8
; Fin de accion DATO
   CSF 
; Comienzo de accion FIB
FIB:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L12
L12:
   SRF  0  3
   DRF 
   STC  1
   GT 
   JMF L10
   SRF  0  3
   DRF 
   STC  1
   SBT 
   SRF  0  5
; Invocar FIB
   OSF  7  1 FIB
   SRF  0  3
   DRF 
   STC  2
   SBT 
   SRF  0  6
; Invocar FIB
   OSF  7  1 FIB
   SRF  0  4
   DRF 
   SRF  0  5
   DRF 
   SRF  0  6
   DRF 
   PLUS 
   ASG 
   JMP L11
L10:
   SRF  0  4
   DRF 
   SRF  0  3
   DRF 
   ASG 
L11:
; Fin de accion FIB
   CSF 
; Comienzo del programa FIBBONACI
L0:
   SRF  0  3
; Invocar DATO
   OSF  5  0 DATO
   SRF  0  3
   DRF 
   SRF  0  4
; Invocar FIB
   OSF  5  0 FIB
   STC 70
   WRT  0
   STC 105
   WRT  0
   STC 98
   WRT  0
   STC 98
   WRT  0
   STC 111
   WRT  0
   STC 110
   WRT  0
   STC 97
   WRT  0
   STC 99
   WRT  0
   STC 105
   WRT  0
   STC 40
   WRT  0
   SRF  0  3
   DRF 
   WRT  1
   STC 41
   WRT  0
   STC 32
   WRT  0
   STC 101
   WRT  0
   STC 115
   WRT  0
   STC 58
   WRT  0
   STC 32
   WRT  0
   SRF  0  4
   DRF 
   WRT  1
; Invocar CAMBIAR_DE_LINEA
   OSF  5  0 CAMBIAR_DE_LINEA
; Fin del programa FIBBONACI
L2:
   LVP 
