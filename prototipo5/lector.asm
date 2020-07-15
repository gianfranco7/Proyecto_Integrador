SECTION .bss

bufferHora RESB 1
bufferMin RESB 1
bufferSeg RESB 1
bufferLect RESB 4

SECTION .text

global lector
lector:

    ;prologo
    push ebp
    mov ebp,esp
    sub esp, 8

    ;cuerpo 
    mov eax, 3			;SYS READ
    mov ecx, bufferHora		;output buffer
    mov edx, 1			;size
    int 0x80
   
    mov eax, 3                  ;SYS READ
    mov ecx, bufferMin          ;output buffer
    mov edx, 1                  ;size
    int 0x80

    mov eax, 3                  ;SYS READ
    mov ecx, bufferSeg          ;output buffer
    mov edx, 1                  ;size
    int 0x80

    mov eax, 3                  ;SYS READ
    mov ecx, bufferLect         ;output buffer
    mov edx, 4                  ;size
    int 0x80

    ;modificar el valor de los 4 punteros recibidos en parametros
    mov edx, [ebp+8]
    mov edx, [bufferHora]
    mov [ebp+8], edx

    mov edx, [ebp+12]
    mov edx, [bufferMin]
    mov [ebp+12], edx

    mov edx, [ebp+16]
    mov edx, [bufferSeg]
    mov [ebp+16], edx

    mov edx, [ebp+20]
    mov edx, [bufferLect]
    mov [ebp+20], edx

    ;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret
