
section .text
global _start:
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

call no_read
mov ax, word[no]
mov word[n], ax

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov ax, word[n]
mov bx, word[n]
mul bx
mov word[n1], ax
mov ax, word [n]
mov bl, 2
mul bl
movzx esi, ax

mov ebx, arr
matrix_reading:
pusha
call read_no
popa
mov ax, word[no]
mov word[ebx], ax
add ebx, 2
dec word[n1]
cmp word[n1], 0
jne matrix_reading

mov word[n1], 2
mov ebx, arr
checking:
mov word[temp1], 1
mov byte[flag], 0
add ebx, esi

push ebx
;to check whether the elements < the coloumn no in a particular row are equal to zero
while:
mov cx, word[ebx]
cmp cx, 0
jne l1
add ebx, 2
inc word[temp1]
mov ax, word[temp1]
cmp ax, word[n1]
jne while
jmp l2
l1:
mov word[flag], 1
l2:
pop ebx

cmp word[flag], 0
jne exit
inc word[n1]
mov ax, word[n1]
cmp ax, word[n]
jna checking
jmp l3
exit:
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h
jmp l4

l3:
mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, len4
int 80h

l4:
mov eax, 1
mov ebx, 0
int 80h

read_no:
mov word[no], 0
no_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_no_read
cmp byte[temp], ' '
je end_no_read

mov ax, word[no]
mov bl, 10
mul bl
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[no], ax
jmp no_read
end_no_read:
ret


section .data
msg1: db "Enter the size of matrix " 
len1: equ $-msg1
msg2: db "Enter the elemets", 10
len2: equ $-msg2
msg3: db "not an upper triangular matrix", 10
len3: equ $-msg3
msg4: db "it is an upper triangular matrix", 10
len4: equ $-msg4

section .bss
no: resw 1
temp: resb 1
n: resw 1
n1: resw 1
arr: resw 50
key: resw 1
temp1: resw 1
flag: resb 1

