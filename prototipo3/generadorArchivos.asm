SECTION .data

nom1 db './sensorPulso.txt', 00h
nom2 db './sensorRitmo.txt', 00h
nom3 db './sensorPresion.txt', 00h
nom4 db './sensorTasaRespiratoria.txt', 00h
nom5 db './sensorSaturacionOxigeno.txt', 00h
contador dw 300, 00h

SECTION .bss

fd_out RESB 8  ;nuevo
valor RESB 8   ;nuevo

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
    mov eax, 8
    mov ebx, nom1               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    
    _ciclo:

    mov [fd_out], eax           ;eax tiene el file descriptor
    push edx			;le da parametro a funcion generadorRandoms
    call generadorRandoms 	;procesa el parametro con generadorRandoms
    fst qword[valor]		;llama el resultado del coprocesador a valor
    mov edx, 8                  ;
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           ;
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    dec esi
    cmp esi, 0
    jne _ciclo

    mov eax, 6                  ;
    mov ebx, [fd_out]           ;
	    
    jmp _final                  ;termina la funcion


    _sensorRitmo:
    mov eax, 8
    mov ebx, nom2               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov [fd_out], eax           ;eax tiene el file descriptor
    push edx                    ;le da parametro a funcion generadorRandoms
    call generadorRandoms       ;procesa el parametro con generadorRandoms
    fst qword[valor]            ;llama el resultado del coprocesador a valor
    mov edx, 8                  
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    mov eax, 6                  
    mov ebx, [fd_out]           
    jmp _final                  ;termina la funcion


    _sensorPresion:
    mov eax, 8
    mov ebx, nom3               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov [fd_out], eax           ;eax tiene el file descriptor
    push edx                    ;le da parametro a funcion generadorRandoms
    call generadorRandoms       ;procesa el parametro con generadorRandoms
    fst qword[valor]            ;llama el resultado del coprocesador a valor
    mov edx, 8                  
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    mov eax, 6                  
    mov ebx, [fd_out]           
    jmp _final                  ;termina la funcion


    _sensorTasaRespiratoria:
    mov eax, 8
    mov ebx, nom4               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov [fd_out], eax           ;eax tiene el file descriptor
    push edx                    ;le da parametro a funcion generadorRandoms
    call generadorRandoms       ;procesa el parametro con generadorRandoms
    fst qword[valor]            ;llama el resultado del coprocesador a valor
    mov edx, 8                  
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    mov eax, 6                  
    mov ebx, [fd_out]           
    jmp _final                  ;termina la funcion


    _sensorSaturacionOxigeno:
    mov eax, 8
    mov ebx, nom5               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov [fd_out], eax           ;eax tiene el file descriptor
    push edx                    ;le da parametro a funcion generadorRandoms
    call generadorRandoms       ;procesa el parametro con generadorRandoms
    fst qword[valor]            ;llama el resultado del coprocesador a valor
    mov edx, 8                  
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    mov eax, 6                  
    mov ebx, [fd_out]           

	
    _final:
    mov ebx, 0       ;codigo de salida
    mov eax, 1       ;SYS_EXIT es el system call 1
    int 80h          ;interrupcion del sistema

    ;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret
