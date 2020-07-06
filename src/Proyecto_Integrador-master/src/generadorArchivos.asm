SECTION .data

nom1 db './sensorPulso.txt', 00h
nom2 db './sensorRitmo.txt', 00h
nom3 db './sensorPresion.txt', 00h
nom4 db './sensorTasaRespiratoria.txt', 00h
nom5 db './sensorSaturacionOxigeno.txt', 00h
valor dq 'qwertyui'
len equ $-valor
msg db '01234567'

SECTION .bss

fd_out RESB 1

SECTION .text

global generadorArchivos
extern generadorRandoms
generadorArchivos:
	
    ;prologo
    push ebp
    mov ebp,esp
    sub esp, 8

    ;crear archivo
    mov edx, [ebp+8] ;parametro tipoArchivo
    cmp edx, 1
    je _sensorPulso
    cmp edx, 2
    je _sensorRitmo
    cmp edx, 3
    je _sensorPresion
    cmp edx, 4
    je _sensorTasaRespiratoria
    cmp edx, 5
    je _sensorSaturacionOxigeno

    _sensorPulso:
    ;genera el archivo
    mov eax, 8
    mov ebx, nom1
    mov ecx, 0o777
    int 0x80
    
    push esp			;le da parametro a funcion generadorRandoms
    call generadorRandoms 	;procesa el parametro con generadorRandoms
    fst qword[valor]		;llama el resultado del coprocesador a valor
    mov [fd_out], eax
    movsd [msg], xmm0
    mov edx, len
    mov ecx, msg
    mov ebx, [fd_out]
    mov eax,4
    int 0x80
    mov eax, 6
    mov ebx, [fd_out]
    jmp _final

	
    _sensorRitmo:
    mov ebx, nom2    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema
    jmp _final

    _sensorPresion:
    mov ebx, nom3    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema
    jmp _final

    _sensorTasaRespiratoria:
    mov ebx, nom4    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema
    jmp _final

    _sensorSaturacionOxigeno:
    mov ebx, nom5    ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h          ;interrupcion del sistema
	
    _final:
    mov ebx, 0       ;codigo de salida
    mov eax, 1       ;SYS_EXIT es el system call 1
    int 80h          ;interrupcion del sistema

    ;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret
