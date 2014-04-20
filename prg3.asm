section .data
message: db "enter string", 0Ah

section .bss
data: resb 10

section .text
global _start:
_start:
mov eax, 03
mov ebx, 00
mov ecx, data
mov edx, 10
int 80h

mov eax, 04
mov ebx, 1
mov ecx, data
mov edx, 10
int 80h

mov eax, 01
mov ebx, 00
int 80h
 
