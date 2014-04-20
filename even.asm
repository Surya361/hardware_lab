section .data
str: db "enter n"

section .bss
val: resb 1
temp: resb 1

section .text
global _start:
_start:
;get the number
mov eax,3
mov ebx,0
mov ecx,val
mov edx,1
int 80h

sub byte[val],30h

;loop to print the even numb
mov byte[temp],2
lp:
mov al,byte[val]
cmp al,byte[temp]
jl exit
add byte[temp],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
add byte[temp],2
sub byte[temp],30h
jmp lp

exit:
mov eax,1
mov ebx,0
int 80h  
