section .data
message1: db "Enter the string: "
len1: equ 18
message3: db "Enter the sub: "
len3: equ 15
message2: db "Number : "
len2: equ 9
new: db 10

section .bss
arry1: resb 50
arry2: resb 50
temp: resb 1
arrylen1: resb 1
arrylen2: resb 1
count: resb 1
temp1: resb 1

section .text
global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, message1
mov edx, len1
int 80h

mov byte[arrylen1], 0
mov ebx, arry1
reading1:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx

cmp byte[temp], 10
je end_reading1
mov al, byte[temp]
mov byte[ebx], al
inc ebx
inc byte[arrylen1]
jmp reading1
end_reading1:

mov eax, 4
mov ebx, 1
mov ecx, message3
mov edx, len3
int 80h

mov byte[arrylen2], 0
mov ebx, arry2
reading2:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx

cmp byte[temp], 10
je end_reading2
mov al, byte[temp]
mov byte[ebx], al
inc ebx
inc byte[arrylen2]
jmp reading2
end_reading2:

mov eax, 4
mov ebx, 1
mov ecx, message2
mov edx, len2
int 80h

mov al, byte[arrylen2]
mov byte[temp1], al
mov ebx, arry1
mov ecx, arry2
mov byte[count], 0
counting:
mov al, byte[ebx]
cmp al, byte[ecx]
jne l1

do:
mov al, byte[ebx]
cmp al, byte[ecx]
jne l1
dec byte[arrylen1]
dec byte[arrylen2]
inc ebx
inc ecx
cmp byte[arrylen1], 0
je exit
cmp byte[arrylen2], 0
je l1
jmp do

l1:
cmp byte[ebx + 1*esi], ' '
jne l2
cmp byte[arrylen2], 0
jne l2
inc byte[count]
l2:
mov al, byte[temp1]
mov byte[arrylen2], al
mov ecx, arry2
inc ebx
dec byte[arrylen1]
cmp byte[arrylen1], 0
jne counting
exit:
cmp byte[arrylen2], 0
jne l3
inc byte[count]

l3:
add byte[count], 30h
mov eax, 4
mov ebx, 1
mov ecx, count
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, new
mov edx, 1
int 80h

mov eax, 1
mov ebx, 0
int 80h
