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

divisor dd 1.02	 	           ;variable auxiliar para la division para generar floats

limiteSuperior1	dd 150		    ;limite superior de rango para valores random
limiteInferior1 dd 40		    ;limite inferior de rango para valores random

limiteSuperior2 dd 120          ;limite superior de rango para valores random
limiteInferior2 dd 80           ;limite inferior de rango para valores random

limiteSuperior3 dd 180          ;limite superior de rango para valores random
limiteInferior3 dd 120          ;limite inferior de rango para valores random

limiteSuperior4 dd 20           ;limite superior de rango para valores random
limiteInferior4 dd 120          ;limite inferior de rango para valores random

limiteSuperior5 dd 100          ;limite superior de rango para valores random
limiteInferior5 dd 90           ;limite inferior de rango para valores random

limiteTiempoS dd 60

hora db 1			            ;hora 
contador dw 300			        ;contador para la cantidad de lecturas a crear

SECTION .bss

fd RESB 4    	                ;file descriptor
valor RESB 4                    ;float(4bytes)
minuto RESB 1
segundo RESB 1

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
 
    
    mov eax, 1
    mov [segundo], eax
    mov [minuto], eax
    
    _ciclo:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 
	        
    mov eax, [segundo]
    add eax, 1
    mov [segundo], eax
    cmp eax, [limiteTiempoS]
    je _cambiar1
    jmp _genereRandom

    _cambiar1:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    add ebx, 1
    mov [minuto], ebx
   
   _genereRandom:
    ;Genere el random en el rango
    rdrand eax			            ;genera un random en eax
    mov ebx, [limiteSuperior1]
    mov ecx, [limiteInferior1]
    sub ebx, ecx
    div ebx
    add eax, ecx
    ;Convertir y guardar
    CVTSI2SS xmm0, eax		    	;castea el int a float
    movss xmm1, [divisor]	    	;mover el divisor a xmm1
    divss xmm0, xmm1		    	;divide para generar un float con decimales diferentes de 0
    movss [valor], xmm0		    	;resultado queda en valor
    ;escritura
    mov eax, 4		       	    	;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura
    
    dec esi			        ;decremente el contador
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
    
    mov edx, 29                ;tamano a escribir
    mov ecx, head2              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                  ;tamano a escribir
    mov ecx, unid2              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
 
    
    mov eax, 1
    mov [segundo], eax
    mov [minuto], eax
    
    _ciclo2:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 
	        
    mov eax, [segundo]
    add eax, 1
    mov [segundo], eax
    cmp eax, [limiteTiempoS]
    je _cambiar2
    jmp _genereRandom2

    _cambiar2:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    add ebx, 1
    mov [minuto], ebx
   
   _genereRandom2:
    ;Genere el random en el rango
    rdrand eax			            ;genera un random en eax
    mov ebx, [limiteSuperior2]
    mov ecx, [limiteInferior2]
    sub ebx, ecx
    div ebx
    add eax, ecx
    ;Convertir y guardar
    CVTSI2SS xmm0, eax		    	;castea el int a float
    movss xmm1, [divisor]	    	;mover el divisor a xmm1
    divss xmm0, xmm1		    	;divide para generar un float con decimales diferentes de 0
    movss [valor], xmm0		    	;resultado queda en valor
    ;escritura
    mov eax, 4		       	    	;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura
    
    dec esi			        ;decremente el contador
    cmp esi, 0	        		;si no es igual a 0
    jne _ciclo2			        ;continue con el ciclo hasta que sea 0
		
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
    
    mov edx, 28                ;tamano a escribir
    mov ecx, head3              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                  ;tamano a escribir
    mov ecx, unid3              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
 
    
    mov eax, 1
    mov [segundo], eax
    mov [minuto], eax
    
    _ciclo3:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 
	        
    mov eax, [segundo]
    add eax, 1
    mov [segundo], eax
    cmp eax, [limiteTiempoS]
    je _cambiar3
    jmp _genereRandom3

    _cambiar3:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    add ebx, 1
    mov [minuto], ebx
   
   _genereRandom3:
    ;Genere el random en el rango
    rdrand eax			            ;genera un random en eax
    mov ebx, [limiteSuperior3]
    mov ecx, [limiteInferior3]
    sub ebx, ecx
    div ebx
    add eax, ecx
    ;Convertir y guardar
    CVTSI2SS xmm0, eax		    	;castea el int a float
    movss xmm1, [divisor]	    	;mover el divisor a xmm1
    divss xmm0, xmm1		    	;divide para generar un float con decimales diferentes de 0
    movss [valor], xmm0		    	;resultado queda en valor
    ;escritura
    mov eax, 4		       	    	;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura
    
    dec esi			        ;decremente el contador
    cmp esi, 0	        		;si no es igual a 0
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
    
    mov edx, 28                ;tamano a escribir
    mov ecx, head4              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 4                  ;tamano a escribir
    mov ecx, unid4              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
 
    
    mov eax, 1
    mov [segundo], eax
    mov [minuto], eax
    
    _ciclo4:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 
	        
    mov eax, [segundo]
    add eax, 1
    mov [segundo], eax
    cmp eax, [limiteTiempoS]
    je _cambiar4
    jmp _genereRandom4

    _cambiar4:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    add ebx, 1
    mov [minuto], ebx
   
   _genereRandom4:
    ;Genere el random en el rango
    rdrand eax			            ;genera un random en eax
    mov ebx, [limiteSuperior4]
    mov ecx, [limiteInferior4]
    sub ebx, ecx
    div ebx
    add eax, ecx
    ;Convertir y guardar
    CVTSI2SS xmm0, eax		    	;castea el int a float
    movss xmm1, [divisor]	    	;mover el divisor a xmm1
    divss xmm0, xmm1		    	;divide para generar un float con decimales diferentes de 0
    movss [valor], xmm0		    	;resultado queda en valor
    ;escritura
    mov eax, 4		       	    	;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura
    
    dec esi			        ;decremente el contador
    cmp esi, 0	        		;si no es igual a 0
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
    
    mov edx, 32               ;tamano a escribir
    mov ecx, head5              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
    
    mov edx, 5                  ;tamano a escribir
    mov ecx, unid5              ;mover puntero de valor
    mov ebx, [fd]               ;le dice donde escribir
    mov eax, 4                  ;SYS_WRITE
    int 0x80
 
    
    mov eax, 1
    mov [segundo], eax
    mov [minuto], eax
    
    _ciclo5:
    ;imprima hora
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, hora
    mov edx, 1
    int 0x80

    ;imprima minuto
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, minuto
    mov edx, 1
    int 0x80  

    ;imprima segundo 
    mov eax, 4			
    mov ebx, [fd]
    mov ecx, segundo
    mov edx, 1
    int 0x80 
	        
    mov eax, [segundo]
    add eax, 1
    mov [segundo], eax
    cmp eax, [limiteTiempoS]
    je _cambiar5
    jmp _genereRandom5

    _cambiar5:
    mov eax, 0
    mov [segundo], eax
    mov ebx, [minuto]
    add ebx, 1
    mov [minuto], ebx
   
   _genereRandom5:
    ;Genere el random en el rango
    rdrand eax			            ;genera un random en eax
    mov ebx, [limiteSuperior5]
    mov ecx, [limiteInferior5]
    sub ebx, ecx
    div ebx
    add eax, ecx
    ;Convertir y guardar
    CVTSI2SS xmm0, eax		    	;castea el int a float
    movss xmm1, [divisor]	    	;mover el divisor a xmm1
    divss xmm0, xmm1		    	;divide para generar un float con decimales diferentes de 0
    movss [valor], xmm0		    	;resultado queda en valor
    ;escritura
    mov eax, 4		       	    	;SYS_WRITE
    mov ebx, [fd]		        ;file descriptor en ebx para que sepa donde escribir
    mov ecx, valor		        ;mover a ecx el puntero del valor a escribir
    mov edx, 4			        ;mover a edx el buffer size a escribir (el tamano de valor)
    int 0x80			        ;SYS_INTERRUPT despues de cada escritura
    
    dec esi			        ;decremente el contador
    cmp esi, 0	        		;si no es igual a 0
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