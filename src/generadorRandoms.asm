SECTION .bss


SECTION .data


SECTION .text

global _start
_start:


mov ebx, 0       ;codigo de salida
mov eax, 1       ; SYS_EXIT es el system call 1
int 80h     
