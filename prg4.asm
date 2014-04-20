section .data

section .bss
var: resb 1

section .text
global _start:
_start:

mov eax, 03
mov ebx, 00
mov ecx, var
mov edx, 1
int 80h

sub byte[var],30h
mov al,byte[var]
mov bl,10
mul bl
mov byte[var],al
add byte[var],30h

mov eax, 04
mov ebx, 01
mov ecx, var
mov edx, 1
int 80h

mov eax, 1
mov ebx, 0
int 80h

