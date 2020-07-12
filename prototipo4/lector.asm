SECTION .data

;float lecturas[300]
lecturas TIMES 2100 db 0 ;crea un array de 2100 bytes (1/hr,1/min,1/sec, 4float) por 300 que es la cantidad de lecturas
formato db '"%f"', 00h

global lector
lector:

;prologo
    push ebp
    mov ebp,esp
    sub esp, 8
    
    extern fscanf
    extern printf
    mov eax, [ebp+8]	;recibimos el file descriptor como parametro
    mov esi, 300	;i = 0
    
    push lecturas	;push el buffer donde cae el texto
    push formato	;push el formato del texto a leer
    push eax 		;push el file descriptor del file a usar

    cmp esi, 0          ;i ? 0 
    jne _ciclo		
    jmp _fin

    _ciclo:     
    call fscanf
    push lecturas
    push formato
    call printf
    dec esi
	
    _fin:
    

;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret
