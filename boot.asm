; H34OS BY H34TING4PPLIANCE
; 16-BITS OPERATING SYSTEM

; This is my first operating system.
; The purpose of this operating system is to
; create a fully working OS (with program support, etc.)
; to learn how does a computer works

; It is tested on QEMU and assembled with NASM
; This is also practice for my next project.
; That project is gonna be a major update of h34OS
; because it's gonna work on 32-bits protected mode
; but will be written in C, however (aside from the bootloader)

; No lisences for now.

section boot
xor 	ax,		ax
mov 	ds,		ax   
cld 	   		        ; Set the direction flag to be positive direction
mov 	ah,		 0x02
mov 	al,		 BOOTLOAD_SECTORS
mov 	ch,		 0    
mov 	cl,		 2    
mov 	dh,		 0   
mov 	bx,		 BOOTLOAD_SECT_OS
mov 	es,		 bx  
xor 	bx,		 bx

int 	0x13
jc 		boot_disk_error

cmp 	al, 	BOOTLOAD_SECTORS
jne 	boot_disk_error_s

jmp 	BOOTLOAD_SECT_OS:0
; TO DO :
; - Read program and run it from other sectors
; - Make base OS with base shell
; - Making commands

jmp 	infloop

boot_disk_error:
	mov 	ah, 	0x0e
	mov 	al, 	"D"
	int 	0x10
	jmp 	infloop
boot_disk_error_s:
	mov 	ah, 	0x0e
	mov 	al, 	"S"
	int 	0x10
infloop:
	jmp 	$


BOOTSECT_DISKERR:
	db 		"Disk Error. (", 0
BOOTSECT_DISKERR_SECT:
	db 		"sector)", 0
BOOTSECT_DISKERR_DISK:
	db 		"disk)", 0
BOOTLOAD_SECT_OS 	equ 	0x7c00
BOOTLOAD_SECTORS 	equ 	0x03

TIMES 	510-($-$$) 	DB 	0
DW 		0xaa55

section os 	vstart=0

OS_STACK:		equ		0x7000
mov 	sp, 	OS_STACK
mov 	ax, 	cs
mov 	ax,		BOOTLOAD_SECT_OS
mov 	ds, 	ax

;mov 	bx, 	helloWorld
;mov 	cl, 	0xf
;call 	printf
call 	clear_screen
mov 	bx,		OS_MSG_CMDLINE
call 	titlebar

call 	printnl
mov 	bx, 	helloWorld
mov 	cl,	 	0xe
call 	printf
call 	printnl

jmp 	os_main
jmp 	$

endl:
	jmp 	endl

helloWorld:
	db		" _     _____ _  _    ___  ____", 0xa, 0xd
	db 		"| |__ |___ /| || |  / _ \/ ___|", 0xa, 0xd
	db 		"|  _ \  |_ \| || |_| | | \___ \", 0xa, 0xd
	db 		"| | | |___) |__   _| |_| |___) |", 0xa, 0xd
	db 		"|_| |_|____/   |_|  \___/|____/", 0
OS_MSG_CMDLINE:
	db 		"H34OS", 0
OS_VERSION:
	db		"v0.1 Alpha", 0

%include 	"io.asm"
%include 	"os.asm"
%include 	"commands.asm"
times 	1534-($-$$) 	db 0
dw 		0xaa55