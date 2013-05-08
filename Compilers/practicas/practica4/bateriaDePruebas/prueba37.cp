; Programa prueba37
; Desborda la pila DISPLAY por arriba dando un DISPLAY Overflow.
   ENP L0

L0: STC 5
    ; Desbordara la pila DISPLAY en 100 invocaciones recursivas ya que
    ; TOPE_DISPLAY = 100
    ; Al ser l = 0 no despilamos de DISPLAY
    OSF 1 0 L0
   
   
L1:   
   LVP
         
