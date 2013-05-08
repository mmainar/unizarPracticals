; Programa error3
   ENP L1
LINICIAR:
   SRF 0 3
   ASGI

L1:
   STC 10
   SRF 0 44
   OSF 126 0 LINICIAR
   
   ; Store Constant de constantes fuera del rango permitido!!
   
   STC -32768
   ;STC -1
   ;PLUS 
  
   STC 32767
   ;STC 1
   ;PLUS
    
   
L2:   
   LVP
         
