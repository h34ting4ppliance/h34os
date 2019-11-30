os_commands_hello:
	mov 	bx, 	OS_MSG_HELLOWORLD
	mov 	cl, 	0xb
	call 	printf
	call 	printnl
jmp 	os_main_cmdline_loop

os_commands_about:
	mov 	bx, 	helloWorld
	mov 	cl, 	0x3
	call 	printf
	call 	printnl
	call 	printnl
	mov 	bx, 	OS_MSG_ABOUT
	mov 	cl, 	0xb
	call 	printf
	call 	printnl
jmp 	os_main_cmdline_loop

os_commands_cat:
	mov 	bx, 	OS_FILE_BUFFER
	mov 	cl, 	0xf
	call 	printf_addr
	call 	printnl
jmp 	os_main_cmdline_loop

os_commands_clear:
	mov 	bx, 	OS_MSG_CMDLINE
	call 	titlebar
jmp 	os_main_cmdline_loop

%include 	"programs/textedit.asm"
%include 	"programs/sysfetch.asm"