; Programa error2 
L0:
   ENP L1
L1:
  JMF L3
  
  ; Saltos incondicionales a la propia instruccion
  
L2: JMP L2
L3: JMP 3

  ; Saltos a la instruccion 0

  JMF 0
  
  JMP L0
  
  ; Saltos a direcciones no existentes.
  
  JMT 9
  
  JMT -1
    
  LVP
