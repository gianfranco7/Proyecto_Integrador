SECTION .data

nombreArchivo db 'sensorPulso.txt', 00h

SECTION .bss

fileDescriptor RESB 4		;para guardar el file descriptor de eax

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

    ;cuerpo
	
    ;1.abrir el archivo
    mov eax, 5			;SYS_OPEN
    mov ebx, nombreArchivo	;abrir el archivo con ese nombre
    mov ecx, 0			;read only access
    mov edx, 0o777		;darle permisos
    ;lo anterior retorna un file descriptor en eax, que sera usado en la lectura

    mov fileDescriptor, [eax]	;sacar el file descriptor de eax porque este registro sera utilizado despues
	
    ;2.leer del archivo
    mov eax, 3			;SYS_READ
    mov ebx, [fileDescriptor] 	;file descriptor en ebx
    mov ecx, *lecturas   	;puntero al input buffer
    mov edx, 4			;para pruebas iniciales, 1200 bytes, para el producto finalizado, 2100 bytes

    ;3.cerrar el archivo
    mov eax, 6			;SYS_CLOSE
    mov ebx, [fileDescrpitor]	;mover file descriptor a ebx para que sepa que file cerrar

    ;epilogo
    pop edx
    pop ecx
    pop ebx
    pop eax
    add esp, 8
    mov esp,ebp
    pop ebp
    ret
