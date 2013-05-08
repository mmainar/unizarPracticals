TITLE MIPROG
		     .model small
		     .stack 100h
		     .data

PUBLIC _terminar,_caracter_recibido,_recibido,_leidoTeclado,_caracter_envio,_enviado,_sobrecarga, _formato

pant                    equ        0B800h ; @ de memoria de la pantalla
areaPantalla            equ        80*25  ; 25 filas x 80 columnas
color                   dw         04h      ; Color del escenario actual
escape                  equ        1
datoTeclado             equ        60h
strobe                  equ        61H
IRQ4                    equ        4*12
IRQ1                    equ        4*9
mayuscula               db         0
csIntOriginalSerie      dw         ?
ipIntOriginalSerie      dw         ?
csIntOriginalTeclado    dw         ?
ipIntOriginalTeclado    dw         ?
_terminar               db         0 ; Indica si se ha pulsado o no ESCAPE
_caracter_envio         db         ?
_enviado                db         0 ; Se activa cuando enviamos un caracter por linea serie
_caracter_recibido      db         ? ; Guarda el caracter recibido por linea serie
_leidoTeclado           db         0 ; Se activa cuando leemos un caracter de teclado
_recibido               db         0 ; Se activa cuando recibimos un caracter por linea serie
_sobrecarga             db         0 ; Error de Overrun en la linea serie
_formato                db         0 ; Error de Formato en la linea serie
tabla                   db '  ','1234567890',4 DUP(' ')
			db 'qwertyuiop',4 DUP(' ')
			db 'asdfghjkl',5 DUP(' ')
			db 'zxcvbnm,.',48 dup(' ')



pantalla                db '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
			db '²                                    Sistema local                            ²²'
			db '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²                                                                              ²'
                        db '²                                                                              ²'
			db '²                                                                              ²'
			db '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
			db '²²                                    Sistema remoto                           ²'
			db '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
			db '²²                                       Debug                                ²²'
			db '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²                                                                              ²'
			db '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'



		     .code

		     mov ax, @data
		     mov ds, ax



	       ; ------------------------------
		  PUBLIC _pintarPantalla
		  _pintarPantalla proc near
	       ; ------------------------------
	       ; algoritmo pintarPantalla(offset_pant punt: texto; color: nat)

		    push ax
		    push bx
		    push cx
		    push si
		    push dx
		    push ds
		    mov si, offset pantalla
		    mov dx,color
		    mov cx,areaPantalla
		    mov bx,pant
		    mov es,bx
		    mov bx,0

	  bucle:    mov ax,[si]
		    mov es:[bx],ax   ; Pintamos el car cter ASCII
		    mov es:1[bx],dl  ; Pintamos su atributo de color
		    inc si
		    add bx,2
		    loop bucle

		    pop ds
		    pop dx    ; Recuperamos
		    pop si    ; los registros
		    pop cx    ; guardados
		    pop bx
		    pop ax
		    ret      ; Retorno
	       ; -------------------------------------
		    _pintarPantalla endp
	       ; -------------------------------------



                 PUBLIC _ponerCaracter
			    _ponerCaracter PROC near
			    push bp
			    mov bp,sp
			    push es
			    push ax
			    push bx
			    xor ax,ax
			    mov ax,4[bp] ; AX contiene el caracter
			    mov bx,pant
			    mov es,bx
			    xor bx,bx
			    mov bx,6[bp] ; BX contiene la posicion a escribir
			    mov es:[bx],al
			    pop bx
			    pop ax
			    pop es
			    pop bp
			    ret
	       _ponerCaracter endp




		     PUBLIC _inicializarLinea
_inicializarLinea    PROC near
		     push ax
		     push dx
		     push ds
		     cli
		     ; Inicializacion UART
		     mov al, 80H
		     mov dx, 3FBH
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
		     ; Activamos interrupciones
		     MOV dx, 3F9h ; Interrupt enable register
		     MOV al,5     ; Permitir interrupciones de recepcion
		     OUT dx,al    ; y de envio y de cambio de estado en la linea
		     MOV dx,3FCh  ; Modem control register
		     MOV al,8     ; Activar generacion de interrupciones
		     OUT dx,al
		     ; Verificar que ambos COM's estan habilitados
		     in al, 21h
		     and al, 00000000b
		     out 21h, al
		     ; lecturas de los registros LSR, RBR, THR e IIR
		     ; para liberar posibles peticiones de interrupcion
		     ; pendientes
		     mov dx, 3FDh ; Leemos LSR
		     in al, dx
		     mov dx, 3F8h  ; Leemos RBR y THR
		     in al, dx
		     mov dx, 3FAh ; Leemos IIR
		     in al, dx
		     pop ds
		     pop dx
		     pop ax
		     sti
		     ret
_inicializarLinea    endp




	       ; -------------------------------------
		  PUBLIC _cambiarTablaInt
		  _cambiarTablaInt proc near
	       ; -------------------------------------
	       ; algoritmo cambiarTablaInt

		    push ax  ; Guardamos los registros
		    push es  ; que vamos a usar
		    push ds

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

		    ; Hacemos lo mismo con la interrupcion
		    ; de reloj
		    mov si, IRQ4
		    mov ax, es:[si]
		    mov word ptr ipIntOriginalSerie, ax
		    mov ax,es:2[si]
		    mov word ptr csIntOriginalSerie, ax

		    ; Modificamos la rutina original
		    ; del teclado introduciendo la direcci¢n
		    ; de la nuestra

		    cli ; Deshabilitamos las interrupciones
		    mov si,IRQ1
		    mov word ptr es:[si], offset intTeclado
		    mov es:2[si],cs

		    ; Ahora hacemos lo mismo con la rutina
		    ; original de la interrupci¢n de linea serie

		    mov si,IRQ4
		    mov word ptr es:[si], offset intSerie
		    mov es:2[si],cs
		    sti ; Volvemos a habilitar las interrupciones

		    pop ds
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
		    push ds

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

		    ; Restauramos la interrupcion original de linea serie (COM1)
		    mov si, IRQ4
		    mov ax, word ptr ipIntOriginalSerie
		    mov bx, word ptr csIntOriginalSerie
		    cli; Deshabilitamos las interrupciones
		    mov es:[si],ax
		    mov es:2[si],bx
		    sti; Volvemos a habilitar las interrupciones

		    pop ds
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
		    push cx ; que vamos a usar
		    push ds

		    in al,datoTeclado  ; Leemos la tecla pulsada
		    cmp al,escape   ; ¨Se ha pulsado escape?

		    jne seguir2     ; Si no, comprobamos la siguiente tecla
		    mov _terminar,1 ; Si se ha pulsado escape, fin
		    jmp seguir3
       seguir2:     test al,80h   ; Testeo de make (pulsar) o break (soltar)
		    jz comprobarletra   ; Si no es make, seguir
		    cmp al,0AAh
		    jne soltadoSD
		    mov mayuscula,0
		    jmp seguir3
      soltadoSD:    cmp al,0B6h
		    jne seguir3
		    mov mayuscula,0
		    jmp seguir3
  comprobarletra:    cmp al,42     ; miramos a ver si es shift
		    jne shiftd
		    jmp mayusculas
       shiftd:      cmp al,54
		    jne traduccion
       mayusculas:  mov mayuscula,1
		    jmp seguir3
       traduccion:  xor bx,bx
		    cmp al,28
		    jne esBorrar
		    mov al,0Ah
		    jmp guardar_caracter
     esBorrar:      cmp al,14
		    jne otroCaracter
		    mov al,8;
		    jmp  guardar_caracter
     otroCaracter:  mov bx,offset tabla ; Traduccion de los codigos de
		    xlat     ; rastreo a ASCII
		    cmp mayuscula,1
		    jne guardar_caracter
		    cmp al,57      ; Miramos a ver si es numero o caracter
		    ja letra
		    sub al,16
		    jmp guardar_caracter
	letra:	    sub al,32

 guardar_caracter:  mov _caracter_envio,al
		    ; Comprobamos si tenemos algun caracter listo
		    ; para enviar por la linea serie, si es asi lo
		    ; enviamos
		    mov _leidoTeclado, 1 ; Marcamos que hay un caracter para enviar
					 ; ya que se ha leido de teclado
		    ;mov dx, 3FDh
	enviar:	    ;in al, dx
		    ;test al, 20h
		    ;jz enviar
		    mov dx, 3F8h
		    ;mov al, _caracter_envio
		    out dx, al

       seguir3:     in al,strobe  ; Realizamos el strobe de teclado
		    or al,80h     ; Forzamos a 1
		    out strobe,al
		    and al,7Fh    ; Forzamos a 0
		    out strobe,al

	   fin:     cli          ; Deshabilitamos las interrupciones
		    mov al,20h   ; End of
		    out 20h, al  ; Interruption.
		    sti          ; Volvemos a habilitar las interrupciones

		    pop ds
		    pop cx  ; Recuperamos los registros
		    pop ax  ; guardados
		    iret
	       ; ---------------------------
		  intTeclado endp
	       ; ---------------------------



	       ; ---------------------------------------------
		  intSerie proc far
	       ; ---------------------------------------------

		 ; Programamos nuestra propias rutina de
		 ; gesti¢n de la interrupci¢n de linea serie (far)

principio_serie:    push ax ; Guardamos los registros
		    push cx ; que vamos a usar
		    push dx
		    push ds

		    ; Comprobar si hay algun caracter recibido
		    ; por la linea serie, si es asi lo escribimos
		    ; por pantalla
     sig_int:	    mov dx, 3FAH        ; Consultamos el IIR
		    in al, dx           ; Leemos IIR
		    test al, 100b       ; Interrupcion RBR lleno?
		    jz errores

		    ; Recibimos caracter si RBR lleno
     recibir:	    mov dx, 3F8H      ; Accedemos RBR (Receive Buffer Register)
		    in al, dx         ; Leemos el caracter
		    mov _caracter_recibido,al ; Guardamos el caracter recibido
		    mov _recibido,1 ; Activamos marca de recibido
		    jmp fin_serie
		    ; Escribir el caracter por pantalla desde el programa C

     testeo:       mov dx, 3FAH       ; Consultamos LSR
		   in al, dx
		   test al, 110b      ; Cambio de estado de la linea?
		   jz fin_serie


     errores:	   ; Miramos el LSR para ver que tipo de error de
		   ; transmision se ha producido
		   mov dx, 3FDh
		   in al, dx
		   test al, 2 ; Error de sobrecarga?
		   jz test2
		   mov _sobrecarga, 1
		   jmp fin_serie

    test2:	   test al, 8 ; Error de formato?
		   jz fin_serie
		   mov _formato, 1

		   ; Antes de volver nos fijamos si hay algo pendiente
     otra:         ;mov dx, 3FAh
		   ;test al, 1
		   ;jz  sig_int

     fin_serie:     cli          ; Deshabilitamos las interrupciones
		    mov al,20h   ; End of
		    out 20h, al  ; Interruption.
		    sti          ; Volvemos a habilitar las interrupciones

		    pop ds
		    pop dx
		    pop cx  ; Recuperamos los registros
		    pop ax  ; guardados
		    iret
	       ; ---------------------------
		  intSerie endp
	       ; ---------------------------




 end