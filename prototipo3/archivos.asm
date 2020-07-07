
SECTION .data

;nom1 db '/home/jose/Escritorio/sensores/sensorPulso.txt', 00h
nom1 db './sensorPulso.txt', 00h
head1 db 'Sensor de pulso', 0ah, 00h
unid1 db 'bpm', 0ah, 00h

nom2 db './sensorPresionDisatolica.txt', 00h
head2 db 'Sensor de presion disatolica', 0ah, 00h
unid2 db 'mmHg', 0ah, 00h

nom3 db './sensorPresionSistolica.txt', 00h
head3 db 'Sensor de presion sistolica', 0ah, 00h
unid3 db 'mmHg', 0ah, 00h

nom4 db './sensorTasaRespiratoria.txt', 00h
head4 db 'Sensor de tasa respiratoria', 0ah, 00h
unid4 db 'BPM', 0ah, 00h

nom5 db './sensorSaturacionOxigeno.txt', 00h
head5 db 'Sensor de saturacion de oxigeno', 0ah, 00h
unid5 db 'SaO2', 0ah, 00h

contador dw 300

SECTION .bss

fd_out RESB 8                   ;nuevo
valor RESB 8                    ;nuevo

SECTION .text

global generadorArchivos
extern generadorRandoms
generadorArchivos:
	
    ;prologo
    push ebp
    mov ebp,esp
    sub esp, 8

    ;crear archivo
    mov edx, [ebp+8]            ;parametro tipoArchivo
    cmp edx, 1
    je _sensorPulso
    cmp edx, 2
    je _sensorDiastolica
    cmp edx, 3
    je _sensorSistolica
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
    mov [fd_out], eax           ;eax tiene el file descriptor
    
    mov edx, 16                 ;tamanio a escribir
    mov ecx, head1              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 4                  ;tamanio a escribir
    mov ecx, unid1              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    _ciclo:
    push edx			        ;le da parametro a funcion generadorRandoms
    call generadorRandoms 	    ;procesa el parametro con generadorRandoms
    fst qword[valor]		    ;llama el resultado del coprocesador a valor
    mov edx, 8                  ;tamanio a escribir
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    dec esi
    cmp esi, 0
    jne _ciclo

    mov eax, 6                  ;
    mov ebx, [fd_out]           ;
	    
    jmp _final                  ;termina la funcion


    _sensorDiastolica:
    mov eax, 8
    mov ebx, nom2               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd_out], eax           ;eax tiene el file descriptor

    mov edx, 29                 ;tamanio a escribir
    mov ecx, head2              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                  ;tamanio a escribir
    mov ecx, unid2              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    _ciclo2:
    push edx			        ;le da parametro a funcion generadorRandoms
    call generadorRandoms 	    ;procesa el parametro con generadorRandoms
    fst qword[valor]		    ;llama el resultado del coprocesador a valor
    mov edx, 8                  ;tamanio a escribir
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    dec esi
    cmp esi, 0
    jne _ciclo2

    mov eax, 6                  ;
    mov ebx, [fd_out]           ;
    jmp _final                  ;termina la funcion


    _sensorSistolica:
    mov eax, 8
    mov ebx, nom3               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd_out], eax           ;eax tiene el file descriptor

    mov edx, 28                 ;tamanio a escribir
    mov ecx, head3              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                  ;tamanio a escribir
    mov ecx, unid3              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    _ciclo3:
    push edx			        ;le da parametro a funcion generadorRandoms
    call generadorRandoms 	    ;procesa el parametro con generadorRandoms
    fst qword[valor]		    ;llama el resultado del coprocesador a valor
    mov edx, 8                  ;tamanio a escribir
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    dec esi
    cmp esi, 0
    jne _ciclo3

    mov eax, 6                  ;
    mov ebx, [fd_out]           ;
    jmp _final                  ;termina la funcion


    _sensorTasaRespiratoria:
    mov eax, 8
    mov ebx, nom4               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd_out], eax           ;eax tiene el file descriptor

    mov edx, 28                 ;tamanio a escribir
    mov ecx, head4              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 4                  ;tamanio a escribir
    mov ecx, unid4              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    _ciclo4:
    push edx			        ;le da parametro a funcion generadorRandoms
    call generadorRandoms 	    ;procesa el parametro con generadorRandoms
    fst qword[valor]		    ;llama el resultado del coprocesador a valor
    mov edx, 8                  ;tamanio a escribir
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    dec esi
    cmp esi, 0
    jne _ciclo4

    mov eax, 6                  ;
    mov ebx, [fd_out]           ;          
    jmp _final                  ;termina la funcion


    _sensorSaturacionOxigeno:
    mov eax, 8
    mov ebx, nom5               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd_out], eax           ;eax tiene el file descriptor

    mov edx, 32                 ;tamanio a escribir
    mov ecx, head5              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                  ;tamanio a escribir
    mov ecx, unid5              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    _ciclo5:
    push edx			        ;le da parametro a funcion generadorRandoms
    call generadorRandoms 	    ;procesa el parametro con generadorRandoms
    fst qword[valor]		    ;llama el resultado del coprocesador a valor
    mov edx, 8                  ;tamanio a escribir
    mov ecx, valor              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    dec esi
    cmp esi, 0
    jne _ciclo5

    mov eax, 6                  ;
    mov ebx, [fd_out]           ;           

	
    _final:
    mov ebx, 0                  ;codigo de salida
    mov eax, 1                  ;SYS_EXIT es el system call 1
    int 80h                     ;interrupcion del sistema

    ;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret