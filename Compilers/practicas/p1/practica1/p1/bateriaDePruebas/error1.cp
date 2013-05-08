; Programa error1
   ENP L1
LINICIAR:
   SRF 0 3
   ASGI
   
   JMP L2  
; Etiqueta duplicada -> Error
L1:
L1:
   STC 10
   SRF 0 44   
   
L2:
   OSF 126 0 LINICIAR
   
L2:
   LVP
         
