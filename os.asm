OS_CMD_INPUT: 		equ 	0x7b00
OS_FILE_BUFFER:		equ		0x7800
os_main:
	mov 	bx, 	OS_MSG_WELCOME
	mov 	cl, 	0xe
	call 	printnl
	call 	printf
	call 	printnl
	call 	printnl

	os_main_cmdline_loop:
		mov 	bx,		OS_CMD_SHELL
		mov 	cl, 	0xe
		call 	printf

		mov 	bx, 	OS_CMD_INPUT
		mov 	cx, 	32
		call 	getline

		mov 	ax, 	OS_CMD_HI
		mov 	cx, 	OS_CMD_INPUT
		call 	cmpstr
		cmp 	ah, 	1
		je 		os_commands_hello

		mov 	ax, 	OS_CMD_ABOUT
		call 	cmpstr
		cmp 	ah, 	1
		je 		os_commands_about

		mov 	ax, 	OS_CMD_EDIT
		call 	cmpstr
		cmp 	ah, 	1
		je 		os_programs_editor

		mov 	ax, 	OS_CMD_CAT
		call 	cmpstr
		cmp 	ah, 	1
		je 		os_commands_cat

		mov 	ax, 	OS_CMD_SYSFETCH
		call 	cmpstr
		cmp 	ah, 	1
		je 		os_programs_sysfetch

		mov 	ax, 	OS_CMD_CLEAR
		call 	cmpstr
		cmp 	ah,	 	1
		je 		os_commands_clear

		mov 	cl, 	0xc
		call 	printf_addr
		call 	printnl

		jmp 	os_main_cmdline_loop
jmp 	os_main_cmdline_loop

jmp 	$

OS_MSG_WELCOME:
	db 	"Welcome to h34OS CLI!", 0

OS_CMD_SHELL:
	db "system-$ ", 0
OS_CMD_HI:
	db "hello", 0
OS_CMD_ABOUT:
	db "about", 0
OS_CMD_EDIT:
	db "edit", 0
OS_CMD_CAT:
	db "cat", 0
OS_CMD_SYSFETCH:
	db "sysfetch", 0
OS_CMD_CLEAR:
	db "clear", 0

OS_MSG_HELLOWORLD:
	db "Hello, World!", 0
OS_MSG_ABOUT:
	db "h34OS version 0.1 Alpha", 0xa, 0xd
	db "by h34ting4ppliance", 0