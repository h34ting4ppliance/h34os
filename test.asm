[BITS 16]
org 0x7C00
start:
        ; This section of code is added based on Michael Petch's bootloader tips
        xor ax,ax      ; We want a segment of 0 for DS for this question
        mov ds,ax   
        mov bx,0x8000  ; Stack segment can be any usable memory
        mov ss,bx      ; Top of the stack @ 0x80000.
        mov sp,ax      ; Set SP=0 so the bottom of stack will be just below 0x90000
        cld            ; Set the direction flag to be positive direction
        mov ah, 0x02
        mov al, 1   
        mov ch, 0    
        mov cl, 2    
        mov dh, 0   
        mov bx, new 
        mov es, bx  
        xor bx, bx
        int 0x13
        jmp new:0
data:
        new equ 0x0500
times   510-($-$$) db 0 
dw      0xaa55             
sect2:
        mov ax, cs
        mov ds, ax    ; Set CS=DS. CS=0x0500, therefore DS=0x500
                      ; If variables are added to this code then this
                      ; will be required to properly reference them
                      ; in memory
        mov ax, 0xB800
        mov es, ax
        mov byte [es:420], 'H'
        mov byte [es:421], 0x48
        mov byte [es:422], 'E'
        mov byte [es:423], 0x68
        mov byte [es:424], 'L'
        mov byte [es:425], 0x28
        mov byte [es:426], 'L'
        mov byte [es:427], 0x38
        mov byte [es:428], 'O'
        mov byte [es:429], 0x18
        mov byte [es:430], '!'
        mov byte [es:431], 0x58
        hlt
