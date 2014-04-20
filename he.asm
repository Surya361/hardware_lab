section .data

section .bss
num: resd 1 
num2: resd 1
num3: resd 1
num4: resd 1

section .text
global _start:
_start:

mov eax, 03
mov ebx, 00
mov ecx, num
mov edx, 1
int 80h

sub dword[num], 30h
mov eax,dword[num]
mov ebx, 10
mul ebx
mov dword[num],eax

mov eax, 03
mov ebx, 00
mov ecx, num2
mov edx, 2
int 80h

sub dword[num2], 30h
mov ebx,dword[num2]
add dword[num], ebx

mov eax, 03
mov ebx, 00
mov ecx, num3
mov edx, 1
int 80h

sub dword[num3], 30h
mov eax,dword[num3]
mov ebx, 10
mul ebx
mov dword[num3],eax

mov eax, 03
mov ebx, 00
mov ecx, num4
mov edx, 2
int 80h

sub dword[num4], 30h
mov ebx, dword[num4]
add dword[num3], ebx

mov ebx, dword[num3]
add dword[num], ebx

mov edx,0
mov eax,dword[num]
mov ebx,10
div ebx
mov dword[num],eax
mov dword[num2],edx
add dword[num],30h
;add word[num2],30h
;mov dx,0
;mov ax,word[num2]
;mov ebx,10
;div ebx
;mov dword[num3],eax
;mov dword[num2],edx
add dword[num2],30h
;add dword[num3],30h

mov eax, 04
mov ebx, 01
mov ecx, num
mov edx, 1
int 80h

;mov eax, 04
;mov ebx, 01
;mov ecx, num3
;mov edx, 1
;int 80h

mov eax, 04
mov ebx, 01
mov ecx, num2
mov edx, 1
int 80h

mov eax,01
mov ebx,00
int 80h
