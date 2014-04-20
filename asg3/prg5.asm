section .data
message1: db "Enter the string: "
length1: equ $-message1
message2: db "Updated string is: "
length2: equ $-message2
new: db 10


section .bss
arr: resb 50
temp: resb 1
arrlen: resb 1
comp: resb 1
yes: resb 1
count: resb 1
temp1: resb 1
no1: resb 1

section .text
global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, message1
mov edx, length1
int 80h

mov byte[arrlen], 0
mov ebx, arr
reading:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx

cmp byte[temp], 10
je end_reading
mov al, byte[temp]
mov byte[ebx], al
inc ebx
inc byte[arrlen]
jmp reading
end_reading:

mov eax, 4
mov ebx, 1
mov ecx, message2
mov edx, length2
int 80h

mov ecx, arr
mov al, byte[arrlen]
mov byte[no1], al
mov byte[count], 0

print:
mov al, byte[ecx]
mov byte[comp], al
mov byte[yes], 0

pusha
mov al, byte[count]
mov byte[temp1], al
mov ecx, arr
l1:
cmp byte[temp1], 0
je end_l1
mov al, byte[ecx]
cmp al, byte[comp]
je l2
dec byte[temp1]
add ecx, 1
jmp l1
l2:
mov byte[yes], 1
end_l1:
popa

inc byte[count]
cmp byte[yes], 0
jne l3

mov al, byte[comp]
mov byte[temp], al
pusha
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
popa

l3:
add ecx, 1
dec byte[no1]
cmp byte[no1], 0
jne print

mov eax, 4
mov ebx, 1
mov ecx, new
mov edx, 1
int 80h

mov eax, 1
mov ebx, 0
int 80h
