; Programa todas
   ENP L1
   
LINICIAR:     
   CSF     
L1:
   ; Almacenamos constantes 10, 20, 30 y 40.
   STC 10
   STC 20
   STC 30
   STC 40
   ; Sumamos 30 + 40 = 70 en Stack
   PLUS
   ; Duplicamos el 70 en Stack
   DUP
   ; Comprobamos si 70 /= 70, se pondra 0 en Stack por ser falso
   NEQ
   ; Duplicamos el 0 en Stack
   DUP
   ; Comprobamos si 0 = 0, se pondra 1 en Stack por ser cierto
   EQ
   ; Dividimos 20/1 = 20
   DIV
   ; Hacemos 10 MOD 20 = 10
   MOD   
   ; Almacenamos 4 en Stack
   STC 4   
   ; Restamos 10 - 4 = 6
   SBT
   ; Almacenamos 15 en Stack
   STC 15
   ; Almacenamos 16 en Stack
   STC 16
   ; Desapilamos 16 de Stack
   POP 
   ; Comprobamos si 6 < 15, se pondra 1 en Stack por ser cierto
   LT
   ; Almacenamos constantes 20 y 40.
   STC 20
   STC 40
   ; Comprobamos si 20 > 40, se pondra 0 en Stack por ser falso
   GT
   ; Almacenamos constantes 20 y 40.
   STC 20 
   STC 40
   ; Comprobamos si 20 <= 40, se pondra 1 en Stack por ser verdadero
   LTE
   ; Almacenamos constantes 20 y 40.
   STC 20
   STC 40
   ; Comprobamos si 20 >= 40, se pondra 0 en Stack por ser falso
   GTE
   ; Negamos el booleano anterior
   NGB
   ; Almacenamos un 8
   STC 8
   ; Negamos el 8 anterior
   NGI
   ; No operacion
   NOP
   ; Acceso a parametro
   SRF 0 44
   AND
   OR
   ; Almacenamos constante 5
   STC 5
   ; Intercambio
   SWP
   ; Multiplicamos
   TMS
   ; Assign
   ASG
   ; Assign inverse
   ASGI
   ; Escribiremos aqui en el read
   SRF 0 1 
   DRF
   ; Leemos dato entero --> SE QUEDA ESPERANDO
   RD 1
   ; Guardamos 65
   STC 65
   ; Escribimos el ASCII 98
   WRT 0
   ; Almacenamos ASCII LF
   STC 10 
   ; Escribimos nueva linea
   WRT 0
   ; Almacenamos un 2
   STC 2
   ; Escribimos un 2
   WRT 1
   ; Almacenamos un 1   
   STC 1
   ; No salta
   JMF L3
   ; Almacenamos un 0
   STC 0
   ; Salta
   JMP L3
L4:
   ; Almacenamos un 0
   STC 0
   ; No salta
   JMT L2
 
L3: NOP
    STC 8
    ; Invocacion a funcion LINICIAR
    OSF 126 0 LINICIAR
   
L2:   
   LVP
   
      
