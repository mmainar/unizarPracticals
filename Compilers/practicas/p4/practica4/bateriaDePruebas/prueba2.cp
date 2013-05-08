; Programa prueba2
; Da un MATH Overflow porque el NGI intenta negar -32768.
; Este error no lo comprobaba el interprete suministrado.
   ENP L0

L0:
   
   STC -32768
   
   NGI
             
L1:   
   LVP
         
