SECTION .bss
fd RESB 4			;filedescriptor

SECTION .text

global abrir
abrir:

 	;prologo
    	push ebp
    	mov ebp,esp
    	sub esp, 8
        mov ebx, [ebp+8]	;recibe el filename
        mov esi, [ebp+12]	;recibe el offset

        ;abrir	
	mov eax, 5		;SYS OPEN
        ;filename ya esta en ebx
        mov ecx, 0		;modo
        mov edx, 0o777		;permisos
	int 0x80

 	mov [fd], eax

        ;mover el puntero 20 bytes
        mov eax, esi		;SYS LSEEK (offset)
        mov ebx, [fd]		;fd
	mov ecx, 20		;OFFSET
        mov edx, 1		;SEEK CUR
        int 0x80

        add esp, 8
        mov esp,ebp
        pop ebp
        ret
