section .data
string: dw "my address is",10,"neekavasarama", 0Ah
length: equ $- string

section .text
global _start:
_start:
mov eax, 04
mov ebx, 01
mov ecx, string
mov edx, length
int 80h

mov eax, 01
mov ebx, 00
int 80h



