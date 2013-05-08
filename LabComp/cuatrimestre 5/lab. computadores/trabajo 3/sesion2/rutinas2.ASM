TITLE MIPROG
		     .model small
		     .data
PUBLIC _terminar

_terminar               db         0
escape                  equ        1
datoTeclado             equ        60h
strobe                  equ        61H
csIntOriginalTeclado    dw         ?
ipIntOriginalTeclado    dw         ?
IRQ1                    equ        4*9
		     .code

		     PUBLIC _inicializarLinea
_inicializarLinea    PROC near
		     mov al, 80H
		     mov dx, 3fbH
		     out dx, al          ; Acceso a DLLSB y DLMSB
		     mov al, 0CH         ; Definir velocidad de 9600 baudios
		     mov dx, 3F8H
		     out dx, al          ; Acceso al Divisor Latch register LSB
		     mov al, 0
		     inc dx
		     out dx, al          ; Acceso al Divisor Latch register MSB
		     mov al, 00000011B   ; No paridad, 1 bit stop y 8 bits de longitud
		     mov dx, 3FBH
		     out dx, al          ; Definir formato del paquete
		     ret
_inicializarLinea    endp


		     public _enviarDato
_enviarDato          proc near
		     push bp
		     mov bp, sp
		     mov dx, 3FDH        ; Registro de estado de la linea
enviar:              in al, dx
		     test _terminar,1
		     jnz fin_envio
		     test al, 20H        ; Test del bit de Transmission Ready
		     jz enviar
		     mov dx, 3F8H
		     mov al, 4[bp]       ; al <- caracter
		     out dx, al          ; Envio del caracter
fin_envio:	     pop bp
		     ret
_enviarDato	     endp


		     public _recibirDato
_recibirDato         proc near
		     mov dx, 3FDH        ; Registro de estado de la linea
recibir:             in al, dx
		     test _terminar,1
		     jnz fin_recepcion
		     test al, 1          ; Test del bit de Reception Ready
		     jz recibir
		     mov dx, 3F8H
		     xor ax, ax
		     in al, dx           ; Recepcion del caracter
		     ; Lo guarda en AX para escribirlo por pantalla
fin_recepcion:       ret
_recibirDato         endp


		     public _habilitarInt
_habilitarInt        proc near
		     mov dx, 3F9H        ; Interrupt enable register
		     mov al, 1           ; Permitir interrupciones de recepcion
		     out dx, al
		     mov dx, 3FCH        ; Modem control register
		     mov al, 8           ; Activar generacion de interrupciones
		     out dx, al
		     ; Inicializacion UART
		     ; Lecturas de los registros LSR, RBR, THR e IIR
		     ret
_habilitarInt        endp



		     public _deshabilitarInt
_deshabilitarInt     proc near
		     mov dx, 3FDH        ; Registro de estado de la linea
recibir_int:         in al, dx
		     test al, 1          ; Test del bit de Reception Ready
		     jz recibir_int
		     mov dx, 3F8H
		     xor ax, ax
		     in al, dx           ; Recepcion del caracter
		     ; Lo guarda en AX para escribirlo por pantalla
		     ret
_deshabilitarInt     endp


		     public _intRecepcion
_intRecepcion        proc far
		     push ax
		     push dx              ; Salvar registros
		     mov dx, 3FDH         ; Line status register
		     in al, dx
		     test al, 01H         ; Comprbar que existe un nuevo caracter
		     jz fin_interrupcion
		     mov dx, 3F8H         ; Receiver buffer register
		     in al, dx            ; Lectura del caracter

		     ; Almacenar AL en memoria

fin_interrupcion:     mov al, 20H
		      out 20H, al         ; Envio de EOI al i8259
		      pop dx
		      pop ax
		      iret                ; Retorno de interrupcion
_intRecepcion         endp



	       ; -------------------------------------
		  PUBLIC _cambiarTablaInt
		  _cambiarTablaInt proc near
	       ; -------------------------------------
	       ; algoritmo cambiarTablaInt

		    push ax  ; Guardamos los registros
		    push es  ; que vamos a usar
		    push si
		    ; Primero salvamos la direcci¢n
		    ; de la interrupci¢n original
		    ; del teclado
		    xor ax,ax
		    mov es,ax
		    mov si,IRQ1
		    mov ax,es:[si]
		    mov word ptr ipIntOriginalTeclado, ax
		    mov ax,es:2[si]
		    mov word ptr csIntOriginalTeclado, ax

		    ; Modificamos la rutina original
		    ; del teclado introduciendo la direcci¢n
		    ; de la nuestra

		    cli ; Deshabilitamos las interrupciones
		    mov si,IRQ1
		    mov word ptr es:[si], offset intTeclado
		    mov es:2[si],cs

		    ; Ahora hacemos lo mismo con la rutina
		    ; original de la interrupci¢n de linea serie


		    sti ; Volvemos a habilitar las interrupciones

		    pop si
		    pop es   ; Recuperamos los
		    pop ax   ; registros guardados
		    ret      ; Retorno
	       ; -----------------------------------------
		   _cambiarTablaInt endp
	       ; -----------------------------------------



	       ; -----------------------------------------
		    PUBLIC _restaurarTablaInt
		    _restaurarTablaInt proc near
	       ; -----------------------------------------
		    push ax   ; Guardamos los registros
		    push bx   ; que vamos a usar
		    push es
		    push si

		    ; Restauramos la interrupci¢n original del teclado
		    xor ax, ax
		    mov es,ax
		    mov si,IRQ1
		    mov ax,word ptr ipIntOriginalTeclado
		    mov bx, word ptr csIntOriginalTeclado
		    cli ; Deshabilitamos las interrupciones
		    mov es:[si],ax
		    mov es:2[si],bx
		    sti ; Volvemos a habilitar las interrupciones

		    pop si
		    pop es
		    pop bx  ; Recuperamos los
		    pop ax  ; registros guardados
		    ret     ; Retorno
	       ; -------------------------------------------
		    _restaurarTablaInt endp
	       ; -------------------------------------------



	       ; ---------------------------------------------
		  intTeclado proc far
	       ; ---------------------------------------------

		 ; Programamos nuestra propias rutina de
		 ; gestion de la interrupcion de teclado (far)


      principio:    push ax ; Guardamos los registros
		    push bx
		    push cx ; que vamos a usar

		    in al,datoTeclado  ; Leemos la tecla pulsada
		    cmp al,escape   ; ¨Se ha pulsado escape?

		    jne seguir3     ; Si no, comprobamos la siguiente tecla
		    mov _terminar,1 ; Si se ha pulsado escape, fin



       seguir3:     in al,strobe  ; Realizamos el strobe de teclado
		    or al,80h     ; Forzamos a 1
		    out strobe,al
		    and al,7Fh    ; Forzamos a 0
		    out strobe,al

	   fin:     cli          ; Deshabilitamos las interrupciones
		    mov al,20h   ; End of
		    out 20h, al  ; Interruption.
		    sti          ; Volvemos a habilitar las interrupciones
		    pop cx  ; Recuperamos los registros
		    pop bx
		    pop ax  ; guardados
		    iret
	       ; ---------------------------
		  intTeclado endp
	       ; ---------------------------






		     end