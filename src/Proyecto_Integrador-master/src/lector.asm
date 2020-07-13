SECTION .data

nombreArchivo db 'sensorPulso.txt', 00h

SECTION .bss

fileDescriptor RESB 4		;para guardar el file descriptor de eax


SECTION .text

global lector
lector:

    ;prologo
    push ebp
    mov ebp,esp
    sub esp, 8
    push eax
    push ebx
    push ecx
    push edx
    push esi

    ;cuerpo
	
    ;1.abrir el archivo
    mov eax, 5			;SYS_OPEN
    mov ebx, nombreArchivo	;abrir el archivo con ese nombre
    mov ecx, 0			;read only access
    mov edx, 0o777		;darle permisos
    int 0x80

    mov [fileDescriptor], eax	;sacar el file descriptor de eax porque este registro sera utilizado despues
	
    

    ;epilogo
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    add esp, 8
    mov esp,ebp
    pop ebp
    ret
