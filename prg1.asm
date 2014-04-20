section .data
string: db "SuryaTeja",0Ah
length: equ 11

section .bss
var: resb 1

section .txt

global _start:
_start:
mov eax, 4
mov ebx, 1
mov ecx, string
mov edx, length
int 80h

mov eax, 1
mov ebx, 0
int 80h

