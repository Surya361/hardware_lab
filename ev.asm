section .data
str1: db "even",0Ah
str2: db "odd" ,0Ah
section .bss
var: resb 1
var1: resb 1
section .text
global _start:
_start:

;getting first digit
mov eax,3
mov ebx,0
mov ecx,var
mov edx,1
int 80h
sub byte[var],30h

;divide it by 2
mov bl,2
mov ax,[var]
div bl

;checking remainder
mov bl,0
mov bh,1
cmp ah,bl
je else
mov eax,4
mov ebx,1
mov ecx,str2
mov edx,3
int 80h
jmp exit

else:
mov eax,4
mov ebx,1
mov ecx,str1
mov edx,4
int 80h
jmp exit

exit:

mov eax,1
mov ebx,0
int 80h


