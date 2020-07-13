SECTION .data
;nombres de archivos generados por el sensor, nombre del sensor, y unidades usadas en sus respectivas lecturas
nom1 db './sensorPulso.txt', 00h
head1 db 'Sensor de pulso', 0ah, 00h
unid1 db 'bpm', 0ah, 00h

divisor db 1.02			;variable auxiliar para la division para generar floats
limiteSuperior1	db 150		;limite superior de rango para valores random
limiteInferior1 db 40		;limite inferior de rango para valores random

contador dw 300			;contador para la cantidad de lecturas a crear

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
	
    _final:
    mov ebx, 0                  ;codigo de salida
    mov eax, 1                  ;SYS_EXIT es el system call 1
    int 80h                     ;interrupcion del sistema

    ;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret