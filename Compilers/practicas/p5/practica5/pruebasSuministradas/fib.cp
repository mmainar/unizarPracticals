   ENP L0
; Comienzo de accion CAMBIAR_DE_LINEA
CAMBIAR_DE_LINEA:
   JMP L2
L2:
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
   JMP L8
; Comienzo de accion PEDIR_DATO
PEDIR_DATO:
   JMP L3
L3:
   STC 32
   STC 58
   STC 111
   STC 114
   STC 101
   STC 109
   STC 117
   STC 110
   STC 32
   STC 110
   STC 117
   STC 32
   STC 101
   STC 98
   STC 105
   STC 114
   STC 99
   STC 115
   STC 69
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
   SRF  1  3
   DRF 
   RD  1
; Fin de accion PEDIR_DATO
   CSF 
L8:
   SRF  0  3
   DRF 
   STC  0
   ASG 
   SRF  0  4
   STC  0
   ASG 
   JMP L6
L7:
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
   JMF L4
   STC 46
   STC 111
   STC 118
   STC 105
   STC 116
   STC 115
   STC 111
   STC 112
   STC 32
   STC 114
   STC 101
   STC 115
   STC 32
   STC 101
   STC 98
   STC 101
   STC 100
   STC 32
   STC 111
   STC 114
   STC 101
   STC 109
   STC 117
   STC 110
   STC 32
   STC 108
   STC 69
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
; Invocar CAMBIAR_DE_LINEA
   OSF  5  1 CAMBIAR_DE_LINEA
L4:
L6:
   SRF  0  4
   DRF 
   NGB 
   JMT L7
; Fin de accion DATO
   CSF 
; Comienzo de accion FIB
FIB:
   SRF  0  4
   ASGI 
   SRF  0  3
   ASGI 
   JMP L11
L11:
   SRF  0  3
   DRF 
   STC  1
   GT 
   JMF L9
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
   JMP L10
L9:
   SRF  0  4
   DRF 
   SRF  0  3
   DRF 
   ASG 
L10:
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
   STC 40
   STC 105
   STC 99
   STC 97
   STC 110
   STC 111
   STC 98
   STC 98
   STC 105
   STC 70
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
   DRF 
   WRT  1
   STC 32
   STC 58
   STC 115
   STC 101
   STC 32
   STC 41
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   WRT  0
   SRF  0  4
   DRF 
   WRT  1
; Invocar CAMBIAR_DE_LINEA
   OSF  5  0 CAMBIAR_DE_LINEA
; Fin del programa FIBBONACI
L1:
   LVP 
