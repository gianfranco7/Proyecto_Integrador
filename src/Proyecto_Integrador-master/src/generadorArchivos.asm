SECTION .data
;nombres de archivos generados por el sensor, nombre del sensor, y unidades usadas en sus respectivas lecturas
nom1 db './sensorPulso.txt', 00h
head1 db 'Sensor de pulso', 0ah, 00h
unid1 db 'bpm', 0ah, 00h

nom2 db  './sensorPresionDiastolica.txt', 00h
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

delimitador db '\0', 00h

divisor db 1.02	    		    ;variable auxiliar para la division para generar floats

limiteSuperior1	db 150		    ;limite superior de rango para valores random
limiteInferior1 db 40		    ;limite inferior de rango para valores random

limiteSuperior2 db 120          ;limite superior de rango para valores random
limiteInferior2 db 80           ;limite inferior de rango para valores random

limiteSuperior3 db 180          ;limite superior de rango para valores random
limiteInferior3 db 120          ;limite inferior de rango para valores random

limiteSuperior4 db 20           ;limite superior de rango para valores random
limiteInferior4 db 120          ;limite inferior de rango para valores random

limiteSuperior5 db 100          ;limite superior de rango para valores random
limiteInferior5 db 90           ;limite inferior de rango para valores random

hora db 1			            ;hora 
contador dw 300			        ;contador para la cantidad de lecturas a crear

SECTION .bss

fd RESB 4    	                ;file descriptor
valor RESB 4                    ;float(4bytes)
minuto RESB 1
segundo RESB 1
limiteTiempoS RESB 1
limiteTiempoI RESB 1

SECTION .text

global generadorArchivos
generadorArchivos:
	
    ;prologo
    push ebp
    mov ebp,esp
    sub esp, 8
    push eax
    push ebx
    push ecx
    push edx
    push esi

    ;crear archivo
    mov edx, [ebp+8]            ;parametro tipoArchivo
    cmp edx, 1
    je _sensorPulso
    cmp edx, 2
    je _sensorPresionD
    cmp edx, 3
    je _sensorPresionS
    cmp edx, 4
    je _sensorPresionR
    cmp edx, 5
    je _sensorSaturacion

    _sensorPulso:           
    mov eax, 8
    mov ebx, nom1               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd], eax               ;eax tiene el file descriptor
    
    mov edx, 16                 ;tamano a escribir
    mov ecx, head1              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 4                  ;tamano a escribir
    mov ecx, unid1              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    xor eax, eax
    mov [minuto], eax
    mov [segundo], eax

    _ciclo:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80
    
    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    mov eax, [segundo]
    inc eax
    cmp eax, [limiteTiempoS]
    je _cambiar1
    jmp _cicloInterno1

    _cambiar1:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    inc ebx
    mov [minuto], ebx
    
    ;imprima floats
    _cicloInterno1:
    rdrand eax			        ;genera un random en eax
    cmp eax, [limiteSuperior1]	;compara con limite sup
    jle	_etiqueta1	            ;si es menor al limite sup
    jmp _cicloInterno1          ;si no es menor, repita 
    _etiqueta1:
    cmp eax, [limiteInferior1]  ;compara con limite inf
    jge _continuar1             ;si es mayor al limite inf, continue
    jmp _cicloInterno1          ;si no es mayor, repita
    
    _continuar1:

    CVTSI2SS xmm0, eax		    ;castea el int a float
    movsd xmm1, [divisor]	    ;mover el divisor a xmm1
    divsd xmm0, xmm1		    ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0		    ;resultado queda en valor
    mov eax, 4		       	    ;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    dec esi			            ;decremente el contador
    cmp esi, 0	        		;si no es igual a 0
    jne _ciclo			        ;continue con el ciclo hasta que sea 0
		
    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd]               ;le da el file descriptor para que sepa que file cerrar
	    
    jmp _final                  ;termina la funcion

    _sensorPresionD:           
    mov eax, 8
    mov ebx, nom2               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd], eax               ;eax tiene el file descriptor
    
    mov edx, 29                 ;tamano a escribir
    mov ecx, head2              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                  ;tamano a escribir
    mov ecx, unid2              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    xor eax, eax
    mov [minuto], eax
    mov [segundo], eax

    _ciclo2:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80
    
    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    mov eax, [segundo]
    inc eax
    cmp eax, [limiteTiempoS]
    je _cambiar2
    jmp _cicloInterno2

    _cambiar2:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    inc ebx
    mov [minuto], ebx
    
    ;imprima floats
    _cicloInterno2:
    rdrand eax			        ;genera un random en eax
    cmp eax, [limiteSuperior2]	;compara con limite sup
    jle	_etiqueta2	            ;si es menor al limite sup
    jmp _cicloInterno2          ;si no es menor, repita 
    _etiqueta2:
    cmp eax, [limiteInferior2]  ;compara con limite inf
    jge _continuar2             ;si es mayor al limite inf, continue
    jmp _cicloInterno2          ;si no es mayor, repita
    
    _continuar2:

    CVTSI2SS xmm0, eax		    ;castea el int a float
    movsd xmm1, [divisor]	    ;mover el divisor a xmm1
    divsd xmm0, xmm1		    ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0		    ;resultado queda en valor
    mov eax, 4			        ;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    dec esi			            ;decremente el contador
    cmp esi, 0			        ;si no es igual a 0
    jne _ciclo			        ;continue con el ciclo hasta que sea 0
		
    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd]               ;le da el file descriptor para que sepa que file cerrar
	    
    jmp _final                  ;termina la funcion

    _sensorPresionS:           
    mov eax, 8
    mov ebx, nom3               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd], eax               ;eax tiene el file descriptor
    
    mov edx, 28                 ;tamano a escribir
    mov ecx, head3              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                  ;tamano a escribir
    mov ecx, unid3              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    xor eax, eax
    mov [minuto], eax
    mov [segundo], eax

    _ciclo3:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80
    
    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    mov eax, [segundo]
    inc eax
    cmp eax, [limiteTiempoS]
    je _cambiar3
    jmp _cicloInterno3

    _cambiar3:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    inc ebx
    mov [minuto], ebx
    
    ;imprima floats
    _cicloInterno3:
    rdrand eax			        ;genera un random en eax
    cmp eax, [limiteSuperior3]	;compara con limite sup
    jle	_etiqueta3	            ;si es menor al limite sup
    jmp _cicloInterno3          ;si no es menor, repita 
    _etiqueta3:
    cmp eax, [limiteInferior3]  ;compara con limite inf
    jge _continuar3             ;si es mayor al limite inf, continue
    jmp _cicloInterno3          ;si no es mayor, repita
    
    _continuar3:

    CVTSI2SS xmm0, eax		    ;castea el int a float
    movsd xmm1, [divisor]	    ;mover el divisor a xmm1
    divsd xmm0, xmm1		    ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0		    ;resultado queda en valor
    mov eax, 4			        ;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    dec esi			            ;decremente el contador
    cmp esi, 0			        ;si no es igual a 0
    jne _ciclo3			        ;continue con el ciclo hasta que sea 0
		
    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd]               ;le da el file descriptor para que sepa que file cerrar
	    
    jmp _final                  ;termina la funcion
	
    _sensorPresionR:           
    mov eax, 8
    mov ebx, nom4               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd], eax               ;eax tiene el file descriptor
    
    mov edx, 28                 ;tamano a escribir
    mov ecx, head4              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 4                  ;tamano a escribir
    mov ecx, unid4              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    xor eax, eax
    mov [minuto], eax
    mov [segundo], eax

    _ciclo4:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80
    
    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    mov eax, [segundo]
    inc eax
    cmp eax, [limiteTiempoS]
    je _cambiar4
    jmp _cicloInterno4

    _cambiar4:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    inc ebx
    mov [minuto], ebx
    
    ;imprima floats
    _cicloInterno4:
    rdrand eax			        ;genera un random en eax
    cmp eax, [limiteSuperior4]	;compara con limite sup
    jle	_etiqueta4	            ;si es menor al limite sup
    jmp _cicloInterno4          ;si no es menor, repita 
    _etiqueta4:
    cmp eax, [limiteInferior4]  ;compara con limite inf
    jge _continuar4             ;si es mayor al limite inf, continue
    jmp _cicloInterno4          ;si no es mayor, repita
    
    _continuar4:

    CVTSI2SS xmm0, eax		    ;castea el int a float
    movsd xmm1, [divisor]	    ;mover el divisor a xmm1
    divsd xmm0, xmm1		    ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0		    ;resultado queda en valor
    mov eax, 4			        ;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    dec esi			            ;decremente el contador
    cmp esi, 0			        ;si no es igual a 0
    jne _ciclo4			        ;continue con el ciclo hasta que sea 0
		
    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd]               ;le da el file descriptor para que sepa que file cerrar
	    
    jmp _final                  ;termina la funcion

    _sensorSaturacion:          
    mov eax, 8
    mov ebx, nom5               ;darle nombre al archivo
    mov ecx, 0o777              ;permisos para escribir/leer en archivo
    int 0x80

    mov esi, [contador]
    mov [fd], eax               ;eax tiene el file descriptor
    
    mov edx, 32                 ;tamano a escribir
    mov ecx, head5              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                 ;tamano a escribir
    mov ecx, unid5              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80

    xor eax, eax
    mov [minuto], eax
    mov [segundo], eax

    _ciclo5:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80
    
    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    mov eax, [segundo]
    inc eax
    cmp eax, [limiteTiempoS]
    je _cambiar5
    jmp _cicloInterno5

    _cambiar5:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    inc ebx
    mov [minuto], ebx
    
    ;imprima floats
    _cicloInterno5:
    rdrand eax			        ;genera un random en eax
    cmp eax, [limiteSuperior5]	;compara con limite sup
    jle	_etiqueta5	            ;si es menor al limite sup
    jmp _cicloInterno5          ;si no es menor, repita 
    _etiqueta5:
    cmp eax, [limiteInferior5]  ;compara con limite inf
    jge _continuar5             ;si es mayor al limite inf, continue
    jmp _cicloInterno5          ;si no es mayor, repita
    
    _continuar5:

    CVTSI2SS xmm0, eax		    ;castea el int a float
    movsd xmm1, [divisor]	    ;mover el divisor a xmm1
    divsd xmm0, xmm1		    ;divide para generar un float con decimales diferentes de 0
    movsd [valor], xmm0	    	;resultado queda en valor
    mov eax, 4			        ;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura

    ;imprima delimitador
    mov eax, 4
    mov ebx, [fd]
    mov ecx, delimitador
    mov edx, 1
    int 0x80
    
    dec esi			            ;decremente el contador
    cmp esi, 0			        ;si no es igual a 0
    jne _ciclo5			        ;continue con el ciclo hasta que sea 0
		
    mov eax, 6                  ;SYS_CLOSE
    mov ebx, [fd]               ;le da el file descriptor para que sepa que file cerrar
	    
    jmp _final                  ;termina la funcion

    _final:
    mov ebx, 0                  ;codigo de salida
    mov eax, 1                  ;SYS_EXIT es el system call 1
    int 80h                     ;interrupcion del sistema

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
