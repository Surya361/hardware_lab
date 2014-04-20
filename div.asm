section .text
global _start:
_start:

mov ax,230
mov bx,10
div bx
mov byte[num],ah
mov byte[num1],al
add byte[num],30h
mov al,byte[num1]
mov bx,10
div bx
mov byte[num1],ah
mov byte[num2],al
add byte[num2],30h
add byte[num1],30h
mov eax,4
mov ebx,1
mov ecx,num
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h

section .bss
num: resb 1
num1: resb 1
num2: resb 1
