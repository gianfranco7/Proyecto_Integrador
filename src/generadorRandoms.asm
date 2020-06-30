extern randomGenerator.c

SECTION .bss


SECTION .data
v1: db 20
v2: db 200 

SECTION .text

global _start
_start:


mov eax, [v1]
mov ebx, [v2]
push eax
push ebx
call random

mov ebx, 0       ;codigo de salida
mov eax, 1       ; SYS_EXIT es el system call 1
int 80h     
