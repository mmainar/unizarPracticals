; Programa prueba37
; Desborda la pila DISPLAY por abajo dando un DISPLAY Underflow.
   ENP L0

L0: STC 5
    ; Intento guardar en FRAMES mas componentes de las que hay en DISPLAY
    OSF 1 5 L0
   
   
L1:   
   LVP
         
