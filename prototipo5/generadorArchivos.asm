SECTION .data
;nombres de archivos generados por el sensor, nombre del sensor, y unidades usadas en sus respectivas lecturas
nom1 db './sensorPulso.txt', 00h
head1 db 'Sensor de pulso', 0ah, 00h
unid1 db 'bpm', 0ah, 00h

nom2 db './sensorPresionDiastolica.txt', 00h
head2 db 'Sensor de presion diastolica', 0ah, 00h
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

divisor db 1.02			;variable auxiliar para la division para generar floats
limiteSuperior1	db 150		;limite superior de rango para valores random
limiteInferior1 db 40		;limite inferior de rango para valores random

limiteSuperior2 db 120          ;limite superior de rango para valores random
limiteInferior2 db 80           ;limite inferior de rango para valores random

limiteSuperior3 db 180          ;limite superior de rango para valores random
limiteInferior3 db 120          ;limite inferior de rango para valores random

limiteSuperior4 db 20           ;limite superior de rango para valores random
limiteInferior4 db 120          ;limite inferior de rango para valores random

limiteSuperior5 db 100          ;limite superior de rango para valores random
limiteInferior5 db 90           ;limite inferior de rango para valores random

limiteSuperiorHoras db 24       ;limite superior para rango de horas
limiteInferiorHoras db 0        ;limite inferior para rango de horas

limiteSuperiorMinSeg db 60	;limite superior para minutos y segundos
limiteInferiorMinSeg db 0	;limite inferior para minutos y segundos

contador dw 300			;contador para la cantidad de lecturas a crear

hora db 1.0		        ;la hora siempre va a ser 0

SECTION .bss

fd_out RESB 8                   ;file descriptor
valor RESB 8                    ;variable auxiliar para randoms float
minuto RESB 4
segundo RESB 4

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
    
    mov edx, 16                 ;tamano a escribir
    mov ecx, head1              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 4                  ;tamano a escribir
    mov ecx, unid1              ;mover puntero de valor
    mov ebx, [fd_out]           ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    _ciclo:
       
    _cicloInterno1:
    rdrand eax			;genera un random en eax
    cmp eax, [limiteSuperior1]	;compara con limite sup
    jle	_etiqueta1	        ;si es menor al limite sup
    jmp _cicloInterno1          ;si no es menor, repita 
    _etiqueta1:
    cmp eax, [limiteInferior1]  ;compara con limite inf
    jge _continuar1             ;si es mayor al limite inf, continue
    jmp _cicloInterno1          ;si no es mayor, repita
    
    _continuar1:

    CVTSI2SS xmm0, eax		;castea el int a float
    movsd xmm1, [divisor]	;mover el divisor a xmm1
    divsd xmm0, xmm1		;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0		;resultado queda en valor
    mov eax, 4			;SYS_WRITE
    mov ebx, [fd_out]		;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		;mover a ecx el puntero del valor a escribir
    mov edx, 4			;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			;SYS_INTERRUPT despues de cada escritura
    
    dec esi			;decremente el contador
    cmp esi, 0			;si no es igual a 0
    jne _ciclo			;continue con el ciclo hasta que sea 0
		
    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd_out]           ;le da el file descriptor para que sepa que file cerrar
	    
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
	
    _cicloInterno2:
    rdrand eax                  ;genera un random en eax
    cmp eax, [limiteSuperior2]  ;compara con limite sup
    jle _etiqueta2              ;si es menor al limite sup
    jmp _cicloInterno2          ;si no es menor, repita 
    _etiqueta2:
    cmp eax, [limiteInferior2]  ;compara con limite inf
    jge _continuar2             ;si es mayor al limite inf, continue
    jmp _cicloInterno2          ;si no es mayor, repita

    _continuar2:
  
    CVTSI2SS xmm0, eax          ;castea el int a float
    movsd xmm1, [divisor]       ;mover el divisor a xmm1
    divsd xmm0, xmm1            ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0         ;resultado queda en valor
    mov eax, 4                  ;SYS_WRITE
    mov ebx, [fd_out]           ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor              ;mover a ecx el puntero del valor a escribir
    mov edx, 8                  ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80                    ;SYS_INTERRUPT despues de cada escritura

    dec esi                     ;decremente el contador
    cmp esi, 0                  ;si no es igual a 0
    jne _ciclo2                  ;continue con el ciclo hasta que sea 0
	
    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd_out]           ;le da el file descriptor para que sepa que file cerrar

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
  
    _cicloInterno3:
    rdrand eax                  ;genera un random en eax
    cmp eax, [limiteSuperior3]  ;compara con limite sup
    jle _etiqueta3              ;si es menor al limite sup
    jmp _cicloInterno3          ;si no es menor, repita 
    _etiqueta3:
    cmp eax, [limiteInferior3]  ;compara con limite inf
    jge _continuar3             ;si es mayor al limite inf, continue
    jmp _cicloInterno3          ;si no es mayor, repita

    _continuar3:
    CVTSI2SS xmm0, eax          ;castea el int a float
    movsd xmm1, [divisor]       ;mover el divisor a xmm1
    divsd xmm0, xmm1            ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0         ;resultado queda en valor
    mov eax, 4                  ;SYS_WRITE
    mov ebx, [fd_out]           ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor              ;mover a ecx el puntero del valor a escribir
    mov edx, 8                  ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80                    ;SYS_INTERRUPT despues de cada escritura

    dec esi                     ;decremente el contador
    cmp esi, 0                  ;si no es igual a 0
    jne _ciclo3                  ;continue con el ciclo hasta que sea 0

    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd_out]           ;le da el file descriptor para que sepa que file cerrar
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

    _cicloInterno4:
    rdrand eax                  ;genera un random en eax
    cmp eax, [limiteSuperior4]  ;compara con limite sup
    jle _etiqueta4              ;si es menor al limite sup
    jmp _cicloInterno4          ;si no es menor, repita 
    _etiqueta4:
    cmp eax, [limiteInferior4]  ;compara con limite inf
    jge _continuar4             ;si es mayor al limite inf, continue
    jmp _cicloInterno4          ;si no es mayor, repita

    _continuar4:

    CVTSI2SS xmm0, eax          ;castea el int a float
    movsd xmm1, [divisor]       ;mover el divisor a xmm1
    divsd xmm0, xmm1            ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0         ;resultado queda en valor
    mov eax, 4                  ;SYS_WRITE
    mov ebx, [fd_out]           ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor              ;mover a ecx el puntero del valor a escribir
    mov edx, 8                  ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80                    ;SYS_INTERRUPT despues de cada escritura

    dec esi                     ;decremente el contador
    cmp esi, 0                  ;si no es igual a 0
    jne _ciclo4                  ;continue con el ciclo hasta que sea 0

    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd_out]           ;le da el file descriptor para que sepa que file cerrar
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

    _cicloInterno5:
    rdrand eax                  ;genera un random en eax
    cmp eax, [limiteSuperior5]  ;compara con limite sup
    jle _etiqueta5              ;si es menor al limite sup
    jmp _cicloInterno5          ;si no es menor, repita 
    _etiqueta5:
    cmp eax, [limiteInferior5]  ;compara con limite inf
    jge _continuar5             ;si es mayor al limite inf, continue
    jmp _cicloInterno5          ;si no es mayor, repita

    _continuar5:
    rdrand eax                  ;genera un random en eax
    CVTSI2SS xmm0, eax          ;castea el int a float
    movsd xmm1, [divisor]       ;mover el divisor a xmm1
    divsd xmm0, xmm1            ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0         ;resultado queda en valor
    mov eax, 4                  ;SYS_WRITE
    mov ebx, [fd_out]           ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor              ;mover a ecx el puntero del valor a escribir
    mov edx, 8                  ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80                    ;SYS_INTERRUPT despues de cada escritura

    dec esi                     ;decremente el contador
    cmp esi, 0                  ;si no es igual a 0
    jne _ciclo5                  ;continue con el ciclo hasta que sea 0

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
