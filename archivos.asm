%include 'funciones.asm'

SECTION .data

saludo db 'Hola mundo!', 0ah, 00h
nomArch db './hola.txt', 00h

sobreescribir db 'gente', 00h

error1 db 'Error inespereado al abrir el archivo', 00h

SECTION .text

global _start

_start:
    mov ecx, 0o777    ;Permisos de lectura, escritura y ejecucion
    mov ebx, nomArch ;nombre del archivo
    mov eax, 8       ;SYS_CREAT es el system call 8
    int 80h
    
    mov ecx, 1       ;O_WRONLY
    mov ebx, nomArch ;puntero al nombre del archivo
    mov eax, 5       ; SYS_OPEN es el system call 5
    int 80h
                     ; En EAX queda el descriptor
    cmp eax, 0
    jl fatal         ;Si el descriptor es negativo, algo esta MUY mal

    push eax         ;Meto el descriptor a la pila

    push saludo      ;Calculo la longitud de la hilera de saludo
    call strlen

    mov edx, eax     ;longitud de la hilera o buffer que voy a escribir
    pop ecx          ;saco el puntero de la hilera de la pila
    pop ebx          ;saco el descriptor del archivo de la pila
    mov eax, 4       ;SYS_WRITE
    int 80h

    mov edx, 2       ;whence: SEEK_END
    mov ecx, -7
    mov ebx, ebx     ;en ebx queda el descriptor del archivo que voy a cerrar
    mov eax, 19
    int 80h

    mov edx, 5     ;longitud de la hilera o buffer que voy a escribir
    mov ecx, sobreescribir           ;saco el puntero de la hilera de la pila
    mov ebx, ebx     ;saco el descriptor del archivo de la pila
    mov eax, 4       ;SYS_WRITE
    int 80h

    mov ebx, ebx     ;en ebx queda el descriptor del archivo que voy a cerrar
    mov eax, 6       ;SYS_CLOSE
    int 80h

    mov ebx, 0 ;codigo de salida
    mov eax, 1       ; SYS_EXIT es el system call 1
    int 80h



fatal:
    push error1
    call strlen
    pop ebx

    push eax
    push error1
    call imprimehilera

    mov ebx, -1 ;codigo de salida
    mov eax, 1       ; SYS_EXIT es el system call 1
    int 80h
