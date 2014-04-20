section .data
varp: db 10
section .bss
var: resb 1
var1: resb 1
var2: resb 1
cnt: resb 1
var3: resb 1
section .text
global _start:
_start:

mov eax,03
mov ebx,00
mov ecx,var
mov edx,2
int 80h

sub byte[var],30h
mov al,byte[var]
mov byte[var3],al
mov byte[cnt],0
l1:
cmp byte[cnt],10
jnl exit
movzx ax,byte[var3]
mov bl,10
div bl
mov byte[var1],al
mov byte[var2],ah 
add byte[var1],30h
add byte[var2],30h
mov eax,04
mov ebx,01
mov ecx,var1
mov edx,1
int 80h
mov eax,04
mov ebx,01
mov ecx,var2
mov edx,1
int 80h
mov eax,04
mov ebx,01
mov ecx,varp
mov edx,1
int 80h
mov al,byte[var]
add byte[var3],al
inc byte[cnt]
jmp l1

exit:
mov eax,1
mov ebx,0
int 80h
