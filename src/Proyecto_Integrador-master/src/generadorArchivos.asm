
.globl randomGenerator
SECTION .data

nom1 db './sensorPulso.txt', 00h
nom2 db './sensorRitmo.txt', 00h
nom3 db './sensorPresion.txt', 00h
nom4 db './sensorTasaRespiratoria.txt', 00h
nom5 db './sensorSaturacionOxigeno.txt', 00h


SECTION .text

global generadorArchivos
global _start
_start:
generadorArchivos:
	
    ;prologo
    push ebp
    mov ebp,esp
    sub esp, 8

    ;crear archivo
    mov edx, [ebp+8] ;parametro tipoArchivo
    mov ecx, 0o777   ;Permisos de lectura, escritura y ejecucion
    cmp edx, 1
    je _sensorPulso
    cmp edx, 2
    je _sensorTemperatura
    cmp edx, 3
    je _sensorElectro
    cmp edx, 4
    je _sensorTasaRespiratoria
    cmp edx, 5
    je _sensorSaturacionOxigeno

    _sensorPulso:
    mov ebx, nom1    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    call generadorRandoms
    int 80h          ;interrupcion del sistema
    jmp _posArchivo
	
    _sensorTemperatura:
    mov ebx, nom2    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema
    jmp _posArchivo

    _sensorElectro:
    mov ebx, nom3    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema
    jmp _posArchivo

    _sensorTasaRespiratoria:
    mov ebx, nom4    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema
    jmp _posArchivo

    _sensorSaturacionOxigeno:
    mov ebx, nom5    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema

    _posArchivo:
    mov ebx, 0       ;codigo de salida
    mov eax, 1       ;SYS_EXIT es el system call 1
    int 80h          ;interrupcion del sistema

    ;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret
