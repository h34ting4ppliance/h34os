;; Sysfetch

os_programs_sysfetch:
	call 	printnl

	call	os_programs_sysfetch_space
	mov 	bx, 	OS_PROGRAMS_SYSFETCH_LOGO_A
	mov 	cl, 	0x3
	call 	printf
	call	os_programs_sysfetch_space
	mov 	bx, 	OS_PROGRAMS_SYSFETCH_INFO_A
	mov 	cl, 	0xb
	call 	printf
	call 	printnl

	call 	os_programs_sysfetch_space
	mov 	bx, 	OS_PROGRAMS_SYSFETCH_LOGO_B
	mov 	cl, 	0x3
	call 	printf
	call	os_programs_sysfetch_space
	mov 	bx, 	OS_PROGRAMS_SYSFETCH_INFO_B
	mov 	cl, 	0xb
	call 	printf
	mov 	bx, 	OS_VERSION
	call 	printf
	call 	printnl

	call 	os_programs_sysfetch_space
	mov 	bx, 	OS_PROGRAMS_SYSFETCH_LOGO_C
	mov 	cl, 	0x3
	call 	printf
	call	os_programs_sysfetch_space
	mov 	bx, 	OS_PROGRAMS_SYSFETCH_INFO_C
	mov 	cl, 	0xb
	call 	printf
	call 	printnl

	call	os_programs_sysfetch_space
	mov 	bx, 	OS_PROGRAMS_SYSFETCH_LOGO_D
	mov 	cl, 	0x3
	call 	printf
	call 	printnl

	call 	printnl

jmp 	os_main_cmdline_loop

os_programs_sysfetch_space:
	pusha
	mov 	ah, 	0xe
	mov 	al, 	' '
	int 	10h
	int 	10h
	int 	10h
	int 	10h
	popa
	ret

OS_PROGRAMS_SYSFETCH_LOGO_A:
	db " _     ", 0
OS_PROGRAMS_SYSFETCH_LOGO_B:
	db "| |__  ", 0
OS_PROGRAMS_SYSFETCH_LOGO_C:
	db "|  _ \ ", 0
OS_PROGRAMS_SYSFETCH_LOGO_D:
	db "| | | |", 0xa, 0xd
	db "    |_| |_|", 0
OS_PROGRAMS_SYSFETCH_INFO_A:
	db	"OS: h34OS", 0
OS_PROGRAMS_SYSFETCH_INFO_B:
	db	"Version: ", 0
OS_PROGRAMS_SYSFETCH_INFO_C:
	db 	"Shell: 34TTY", 0