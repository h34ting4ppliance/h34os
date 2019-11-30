[bits 16]

clear_screen:
	pusha
	mov 	ah, 	0x00
	mov 	al, 	0x12
	int 	10h
	popa
	ret

printf:
	pusha
	mov 	ah, 	0x0e		; tty mode
	push 	cx
	mov 	cx,		bx
	mov 	bx,		0x7c00
	mov 	es,		bx
	mov 	bx, 	cx
	pop 	cx
	printf_loop:
		mov 	al, 	[es:bx]	; set the character as [bx]
		cmp 	al, 	0x00
		je 		printf_end
		push 	bx				; these lines of code are for color
		xor 	bx, 	bx		; the color will have to be defined on cx
		mov 	bl,		cl
		int 	10h
		pop 	bx

		inc 	bx
		jmp 	printf_loop
	printf_end:
		popa
		ret

printf_addr:
	pusha
	mov 	ah, 	0x0e
	mov 	es, 	bx
	xor 	bx, 	bx
	jmp 	printf_loop

printnl:
	pusha
	mov 	ah, 	0x0e
	mov 	al, 	0xa
	int 	10h
	mov 	al, 	0xd
	int 	10h
	popa
	ret

titlebar:
	pusha
	call 	clear_screen
	mov 	ah, 	0x0e
	push 	bx
	mov 	bl, 	0x05
	mov 	al, 	'/'
	int 	10h
	mov 	al, 	' '
	int 	10h
	pop 	bx

	mov 	cl, 	0x0d
	call 	printf

	xor 	cx, 	cx

	titlebar_lenloop:
		mov 	al, 	[bx]
		cmp 	al, 	0
		je 		titlebar_lenloop_end
		inc 	cx
		inc 	bx
		jmp 	titlebar_lenloop
	titlebar_lenloop_end:
		xor 	bx, 	bx

	mov 	bl,	 	0x05
	mov 	dx, 	cx
	mov 	cx, 	77
	sub 	cx, 	dx
	xor 	dx, 	dx
	mov 	al, 	' '
	int 	10h
	mov 	al, 	'\'
	int 	10h
	mov 	al, 	'_'
	titlebar_eqloop:
		dec 	cx
		cmp 	cx, 	0
		je 		titlebar_eqloop_end
		int 	10h
		jmp 	titlebar_eqloop
	titlebar_eqloop_end:
		popa
		ret

getline:
	pusha
	mov 	dx, 	cx
	mov 	es, 	bx
	xor 	bx, 	bx
	getline_loop:
		mov 	ah, 	0x00
		int 	16h

		cmp 	al, 	0x08
		je 		getline_backspace

		push 	bx
		mov 	bl, 	0x7
		mov 	ah, 	0x0e
		int 	10h
		pop 	bx

		dec 	cx
		cmp 	al, 	0x0d
		je 		getline_loop_end
		cmp 	cx, 	0
		je 		getline_loop_end


		mov 	[es:bx], 	al
		inc 	bx
		jmp 	getline_loop
	getline_loop_end:
		mov 	al, 	0x00
		mov 	[es:bx],	al
		call printnl
		popa
		ret
	getline_backspace:
		cmp 	cx, 	dx
		jge 	getline_loop

		mov 	ah, 	0x0e
		mov 	al, 	0x08
		int 	10h
		mov 	al, 	' '
		int 	10h
		mov 	al, 	0x08
		int 	10h

		inc 	cx
		dec 	bx
		jmp 	getline_loop


cmpstr:
	pusha
	mov 	bx, 	cx
	mov 	es, 	bx
	xor 	cx, 	cx
	cmpstr_loop:
		mov 	bx, 	ax
		mov 	dl,		[bx]
		mov 	bx, 	cx
		mov 	dh, 	[es:bx]

		cmp 	dl, 	dh
		jne 	cmpstr_endloop_false
		cmp 	dl, 	0
		je 		cmpstr_endloop_true

		inc 	ax
		inc 	cx
		jmp 	cmpstr_loop
	cmpstr_endloop_false:
		popa
		xor 	ax, 	ax
		mov 	ah, 	0
		ret
	cmpstr_endloop_true:
		popa
		xor 	ax, 	ax
		mov 	ah, 	1
		ret