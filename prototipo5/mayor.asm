global mayor

mayor:
;prologo
    push ebp
    mov ebp,esp
    sub esp, 8

 ;operaciones para sacar el mayor
    movsd xmm0, [ebp+8]  ;guarda el mayor actual
    movsd xmm1, [ebp+16] ;guarda el numero leido

    _comparar:
    comisd xmm1, xmm0      ;compara el numero actual con el leido actualmente
    ja _ret2               ;si el leido es mayor lo cambia
    jmp _ret1              ;si no es mayor no hace nada

    _ret2:
    movsd [ebp-8], xmm1    ;retorna el numero leido
    jmp _cargar

    _ret1:
    movsd [ebp-8], xmm0    ;retorna el mayor guardado
     
    ;cargar en la pila del coprocesador el resultado
    _cargar:
    fld qword [ebp-8]      ;mover 64 bits

;epilogo
    add esp, 8
    mov esp,ebp
    pop ebp
    ret