section .data

section .bss

digit1: resb 1
digit2: resb 1
digit3: resb 1
digit4: resb 1
num1: resb 1
num2: resb 1
rdr: resb 1
nub1: resb 1
nub2: resb 1

section .text
global _start:
_start:
mov eax,3
mov ebx,0
mov ecx,num1
mov edx,2
int 80h

;mov eax,3
;mov ebx,0
;mov ecx,digit2
;mov edx,2
;int 80h

mov eax,3
mov ebx,0
mov ecx,num2
mov edx,2
int 80h

;mov eax,3
;mov ebx,0
;mov ecx,digit4
;mov edx,2
;int 80h

sub byte[num1],30h
sub byte[num2],30h
;sub byte[digit3],30h
;sub byte[digit4],30h

;mov al,byte[digit1]
;mov bl,10
;mul bl
;mov byte[digit1],al
;mov bl,byte[digit2]
;mov byte[num1],bl
;add byte[num1],al

;mov al,byte[digit3]
;mov bl,10
;mul bl
;mov byte[digit3],al
;mov bl,byte[digit4]
;mov byte[num2],bl
;add byte[num2],al 
mov al,byte[num1]
mov bl,byte[num2]
mul bl
mov byte[nub1],al

l1:
movzx ax,byte[num1]
mov bl,byte[num2]
div bl
mov byte[rdr],ah
;mov byte[que],al
cmp byte[rdr],0
je lcm
;mov byte[num2],ah
mov bl,byte[num2]
mov byte[num1],bl
mov byte[num2],ah
jmp l1

lcm:
movzx ax,byte[nub1]
mov bl,byte[num2]
div bl
mov byte[nub2],al

print:
movzx ax,byte[nub2]
mov bl,10
div bl
mov byte[digit1],ah
mov byte[digit2],al
add byte[digit1],30h
add byte[digit2],30h

mov eax,4
mov ebx,1
mov ecx,digit2
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,digit1
mov edx,1
int 80h

exit:
mov eax,1
mov ebx,0
int 80h

