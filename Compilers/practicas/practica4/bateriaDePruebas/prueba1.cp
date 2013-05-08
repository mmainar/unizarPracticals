; Programa prueba1
; Trunca las constantes de STC fuera de rango
; Da un MATH Overflow por el PLUS
   ENP L0

L0:
  
   ; STC de constantes en el limite, MIN_SHORT y MAX_SHORT	
   
   STC -32768
   
   STC 32767
   
   ; stc de constantes fuera del rango permitido, se truncan
   
   STC -32769
   
   STC -40000 
   
  
   STC 32768   

   STC 40000  
   
   PLUS   
   
L1:   
   LVP
         
