os_programs_editor:
	pusha
	mov 	bx, 	OS_PROGRAMS_EDITOR_TITLE
	call 	titlebar
	mov 	bx, 	OS_PROGRAMS_EDITOR_WELCOME
	mov 	cl, 	0xe
	call 	printf
	call 	printnl
	xor 	ax, 	ax
	mov 	bx, 	ax
	mov 	cx, 	ax

	os_programs_editor_cloop:
		mov 	ah, 	0x0e
		mov 	al, 	"|"
		mov 	bl, 	0x1
		int 	10h

		mov 	bx, 	OS_CMD_INPUT
		mov 	cx, 	250
		call 	getline

		mov 	es, 	bx
		mov 	al,		[es:0x0000]
		cmp 	al, 	":"
		je 		os_programs_editor_append

		cmp 	al, 	"c"
		je 		os_programs_editor_clear

		cmp 	al, 	"l"
		je 		os_programs_editor_cat

		cmp 	al, 	"q"
		je 		os_programs_editor_end

	jmp 	os_programs_editor_cloop
	
	os_programs_editor_append:
		pusha
		xor 	ax, 	ax
		mov 	bx, 	OS_FILE_BUFFER
		mov 	es, 	bx
		xor 	bx,	 	bx
		os_programs_editor_append_loop1:
			mov 	al,	 	[es:bx]
			cmp 	al, 	0
			je 		os_programs_editor_append2
			add 	bx, 	1
			jmp 	os_programs_editor_append_loop1
		os_programs_editor_append2:
			mov 	dx, 	bx
			xor 	cx, 	cx
			mov 	ax, 	cx
			mov 	ah, 	0xe
		os_programs_editor_append2_loop:
			mov 	bx, 	OS_CMD_INPUT
			mov 	es, 	bx
			mov 	bx,	 	cx
			add 	bx,		1
			mov 	al, 	[es:bx]

			cmp 	al, 	0
			je 		os_programs_editor_append_end

			mov 	bx,		OS_FILE_BUFFER
			mov 	es, 	bx
			mov 	bx, 	dx
			add 	bx, 	cx

			mov 	[es:bx], 	al
			add 	cx, 		1
		jmp 	os_programs_editor_append2_loop

	os_programs_editor_append_end:
		mov 	bx, 	OS_FILE_BUFFER
		mov 	es, 	bx
		mov 	bx, 	dx
		add 	bx, 	cx
		mov 	[es:bx],	byte 0xa

		add 	bx, 	1
		mov 	[es:bx],	byte 0xd

		mov 	bx, 	OS_PROGRAMS_EDITOR_WRITING
		mov 	cl, 	0xe
		call 	printf
		call 	printnl
		popa
		jmp 	os_programs_editor_cloop

os_programs_editor_end:
	popa
jmp 	os_commands_clear

os_programs_editor_clear:
	mov 	bx, 	OS_PROGRAMS_EDITOR_CLEAR
	mov 	cl, 	0xe
	call 	printf
	call 	printnl
	mov 	bx, 	OS_FILE_BUFFER
	mov 	es, 	bx

	xor 	bx, 	bx

	os_programs_editor_clear_loop:
		mov 	al, 	[es:bx]
		cmp 	al, 	0
		je		os_programs_editor_cloop
		mov 	[es:bx], 	BYTE 0
		add 	bx, 	1
	jmp 	os_programs_editor_clear_loop

os_programs_editor_cat:
	mov 	bx, 	OS_FILE_BUFFER
	mov 	cl, 	0xf
	call 	printf_addr
	call 	printnl
jmp 	os_programs_editor_cloop

OS_PROGRAMS_EDITOR_WRITING:
	db 	"Wrote stuff.", 0
OS_PROGRAMS_EDITOR_CLEAR:
	db 	"Cleared buffer.", 0
OS_PROGRAMS_EDITOR_WELCOME:
	db 	"Welcome to the h34OS TextEdit!", 0xa, 0xd
	db 	"This program sort of works like Unix EX Text editor", 0
OS_PROGRAMS_EDITOR_TITLE:
	db 	"h34OS - TextEdit", 0