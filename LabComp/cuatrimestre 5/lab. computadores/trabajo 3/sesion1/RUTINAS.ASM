TITLE MIPROG
	.model small
	.data         ; Inicio del segmento de datos

	EXTRN _a:WORD,_b:WORD  ; Definidas en C
	PUBLIC _res3  ; Hace visible la variable desde C

_res3    dw    ?  ; Variable definida en ASM

	.code         ; Inicio del segmento de codigo

	mov ax, @data
	mov ds,ax


	PUBLIC _max      ; Hace visible la funci¢n desde C
_max    PROC near
	push bp
	mov bp, sp
	mov ax,4[bp]
	cmp ax,6[bp]
	jge exit
	mov ax,6[bp]
exit:	pop bp
	ret
_max    endp


	PUBLIC _min     ; Hace visible la funci¢n desde C
_min    PROC near
	push bp
	mov bp, sp
	mov bx,4[bp] ; bx <- @a
	mov ax,[bx]  ; ax <- a
	mov bx,6[bp] ; bx <- @b
	mov cx,[bx]  ; cx <- b
	cmp ax,cx
	jle exit2    ; Si a<=b
	mov bx,8[bp] ; bx <- @res
	mov [bx],cx  ; res <- b
	jmp fin
exit2:  mov bx,8[bp] ; bx <- @res
	mov [bx],ax  ; res <- a
fin:	pop bp
	ret
_min    endp


	PUBLIC _min2      ; Hace visible la funci¢n desde C
_min2   PROC near
	push bp
	mov bp, sp
	mov ax,_a
	cmp ax,_b
	jle exit3
	mov ax, _b
	mov _res3, ax
exit3:  mov _res3, ax
	pop bp
	ret
_min2   endp


	PUBLIC _max2         ; Hace visible la funci¢n desde C
_max2   PROC near
	push bp
	mov bp, sp
	mov cx,4[bp] ; cx <- n
	sub cx,1 ; Una iteracion menos porque ya cargamos el primer maximo
	mov ax,6[bp] ; ax <- a1. En AX siempre ira el maximo temporal
	mov bx,bp; ; bx apuntara al operando a comparar
	add bx,8   ; bx apuntara al operando a2
bucle:  cmp ax,[bx] ; Compara el maximo temporal y el nuevo operando
	jl menor_max2 ; Si AX < ai
	add bx,2      ; bx apunta al sig. parametro
	loop bucle
	jmp exit4
menor_max2:
	mov ax,[bx] ; maximo temporal <- ai
	add bx,2    ; bx apunta al sig. parametro
	loop bucle
exit4:	pop bp
	ret
_max2   endp

	end