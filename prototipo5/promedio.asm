global promedio

promedio:

;prologo
    push ebp
    mov ebp,esp
    sub esp, 8

 ;operaciones para sacar el promedio
    movsd xmm0, [ebp+8]  ;guarda el total actual (suma de todos los numeros leidos)
    movsd xmm1, [ebp+16] ;guarda el total de numeros leidos

    divsd xmm0, xmm1     ;divide el total entre la cantidad de numeros leidos (calcula promedio)

    _final:
    movsd [ebp-8], xmm0   ;retorna el promedio a la pila
    
    ;cargar en la pila del coprocesador el resultado
    fld qword [ebp-8] ;mover 64 bits

;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret