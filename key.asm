section .data
str: db "alphanumeric"
str1: dw "special_symbol"
str2: db "special_key"

section .bss
var1: resb 1

section .text
global _start:
_start:

;getting the char
mov eax,03
mov ebx,0
mov ecx,var1
mov edx,1
int 80h

;comparing with the ascii values
cmp byte[var1],32
jg else
mov eax,04
mov ebx,01
mov ecx,str2
mov edx,11
int 80h
jmp exit

else:
cmp byte[var1],47
jg else1
mov eax,04
mov ebx,01
mov ecx,str1
mov edx,14
int 80h
jmp exit

else1:
cmp byte[var1],57
jg else2
mov eax,04
mov ebx,01
mov ecx,str
mov edx,12
int 80h
jmp exit

else2:
cmp byte[var1],64
jg else3
mov eax,04
mov ebx,01
mov ecx,str1
mov edx,14
int 80h
jmp exit

else3:
cmp byte[var1],90
jg else4
mov eax,04
mov ebx,01
mov ecx,str
mov edx,12
int 80h
jmp exit

else4:
cmp byte[var1],96
jg else5
mov eax,04
mov ebx,01
mov ecx,str1
mov edx,14
int 80h
jmp exit

else5:
cmp byte[var1],122
jg else6
mov eax,04
mov ebx,01
mov ecx,str
mov edx,12
int 80h
jmp exit

else6:
cmp byte[var1],126
jg else7
mov eax,04
mov ebx,01
mov ecx,str1
mov edx,14
int 80h
jmp exit

else7:
mov eax,04
mov ebx,01
mov ecx,str2
mov edx,11
int 80h
jmp exit

exit:
mov eax,1
mov ebx,0
int 80h
