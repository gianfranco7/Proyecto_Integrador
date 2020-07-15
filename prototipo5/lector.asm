SECTION .data

nombreArchivo db 'sensorPulso.txt', 00h
delimitador db '\0', 00h

;Sensor de pulso       16bytes con el cambio de linea
;bpm                   4bytes con el cambio de linea


SECTION .bss

fileDescriptor RESB 4		;para guardar el file descriptor de eax
nombre RESB 50			
unit RESB 5

global bufferHora RESB 1
global bufferMin RESB 1
global bufferSeg RESB 1
global bufferLect RESB 4

SECTION .text

global lectorPulso
lectorPulso:

    ;prologo
    push ebp
    mov ebp,esp
    sub esp, 8
    push eax
    push ebx
    push ecx
    push edx
    push esi

    ;cuerpo
	
    ;1.abrir el archivo
    mov eax, 5			;SYS_OPEN
    mov ebx, nombreArchivo	;abrir el archivo con ese nombre
    mov ecx, 0			;read only access
    mov edx, 0o777		;darle permisos
    int 0x80

    mov [fileDescriptor], eax	;sacar el file descriptor de eax porque este registro sera utilizado despues
      
    mov eax, 19			;SYS_SEEK
    mov ebx, [fileDescriptor]	
    mov ecx, 20			;CANTIDAD DE BYTES A SKIP
    mov edx, 1			;APARTIR DE DONDE
    int 0x80
    
    mov eax, 3			;SYS READ
    mov ebx, [fileDescriptor]
    mov ecx, bufferHora		;output buffer
    mov edx, 1			;size
    int 0x80
   
    mov eax, 3                  ;SYS READ
    mov ebx, [fileDescriptor]
    mov ecx, bufferMin          ;output buffer
    mov edx, 1                  ;size
    int 0x80

    mov eax, 3                  ;SYS READ
    mov ebx, [fileDescriptor]
    mov ecx, bufferSeg          ;output buffer
    mov edx, 1                  ;size
    int 0x80

    mov eax, 3                  ;SYS READ
    mov ebx, [fileDescriptor]
    mov ecx, bufferLect         ;output buffer
    mov edx, 4                  ;size
    int 0x80

    ;IMPRIMIR
 
    mov eax, 4			;SYS OUT
    mov ebx, 1			;ni idea
    mov ecx, bufferHora		;output buffer
    mov edx, 1			;size
    int 0x80

    mov eax, 4                  ;SYS OUT
    mov ebx, 1                  ;ni idea
    mov ecx, bufferMin         ;output buffer
    mov edx, 1                  ;size
    int 0x80

    mov eax, 4                  ;SYS OUT
    mov ebx, 1                  ;ni idea
    mov ecx, bufferSeg         ;output buffer
    mov edx, 1                  ;size
    int 0x80

    mov eax, 4                  ;SYS OUT
    mov ebx, 1                  ;ni idea
    mov ecx, bufferLect         ;output buffer
    mov edx, 4                  ;size
    int 0x80




    ;mov [bufferHora], [ebp+8]
    ;mov eax, [bufferHora]
    ;ebp+12
    ;ebp+16
    ;ebp+20

;
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
