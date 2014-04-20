section .text
global _start:
_start:
mov al,byte[num]
mov byte[num1],al
add byte[num1],30h

mov eax,4
mov ebx,1
mov ecx,num
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h

section .data
num: dw 1
section .bss
num1: resb 1
