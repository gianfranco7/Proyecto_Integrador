SECTION .data

nomArch db './sensorPulso.txt', 00h

SECTION .text

global _start

_start:

    ;crear archivo
    mov ecx, 0o777   ;Permisos de lectura, escritura y ejecucion
    mov ebx, nomArch ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema
    
    mov ebx, 0       ;codigo de salida
    mov eax, 1       ;SYS_EXIT es el system call 1
    int 80h          ;interrupcion del sistema

