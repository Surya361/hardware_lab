section .text

global _start:
  _start:


pusha

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msglen1
    int 80h
popa
mov ebx, string1

reading_string:

push ebx

    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h

pop ebx
cmp byte[temp], 10
je end_reading
   inc byte[string_len]
   mov al, byte[temp]
   mov byte[ebx], al
   inc ebx
   jmp reading_string

end_reading:

mov byte[ebx], 0

; READING SECOND STRING


pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msglen2
    int 80h
popa

mov ebx, 0
mov ebx, string2

reading_string1:

push ebx

    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h

pop ebx
cmp byte[temp], 10
je end_reading1
   inc byte[string_len1]
   mov al, byte[temp]
   mov byte[ebx], al
   inc ebx
   jmp reading_string1

end_reading1:

mov byte[ebx], 0

mov eax, 0
mov al, byte[string_len]
cmp byte[string_len1], al
jne print_none

; MAIN PROCESS OF FINDING WHETHER IT IS A CIRCULAR PERM OR NOT

mov ebx, string1
mov al, byte[ebx]
mov byte[startchar], al
mov eax, 0
mov edx, 0

L1:
   
   mov ebx, string1
   
   cmp byte[ebx + edx], 0
   je print_none_final
   mov cl, byte[ebx + edx]
   mov byte[startchar], cl
   mov ebx, string2
   cmp byte[ebx + eax], 0
   je print_none

mov cl, byte[startchar]
cmp byte[ebx + eax], cl
je L2
inc eax

jmp L1

L2:

mov byte[index], al
mov edx, 0
mov ebx, dum
mov al, byte[startchar]
mov byte[ebx + edx], al
inc byte[dum_len]
mov eax, 0
mov al, byte[index]
mov byte[currentindex], al
inc byte[currentindex]
mov ah, 0
mov al, byte[currentindex]
mov bl, byte[string_len]
div bl
mov byte[currentindex], ah
mov edx, 0
mov edx, 1

L3:

mov cl, byte[index]
cmp byte[currentindex], cl
je check_char

mov eax, 0

mov ebx, string2
movzx eax, byte[currentindex]
mov cl, byte[ebx + eax]
mov ebx, dum
mov byte[ebx + edx], cl
inc byte[dum_len]
inc byte[currentindex]

mov ah, 0
mov al, byte[currentindex]
mov ebx, 0
mov bl, byte[string_len]
div bl
mov byte[currentindex], ah

inc edx

jmp L3

check_char:

mov edx, 0
mov eax, 0
mov ebx, 0

L4:

cmp byte[string_len], 0
je found
dec byte[string_len]
mov ebx, string1
mov cl, byte[ebx + edx]
mov byte[dummy1], cl
mov ebx, dum
mov cl, byte[ebx + edx]
mov byte[dummy2], cl
cmp byte[dummy1], cl
je L5
   jmp print_none


L5:

inc edx
jmp L4

found:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, msglen3
    int 80h

jmp exit

print_none:

mov cl, byte[first_index]
inc cl
mov edx, 0
movzx edx, cl
jmp L1

print_none_final:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, msglen4
    int 80h

exit:

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

mov eax, 1
mov ebx, 0
int 80h


section .data

string_len: db 0
string_len1: db 0
msg1: db "Enter the string: ", 10
msglen1: equ $-msg1
msg2: db "Enter the second string: ", 10
msglen2: equ $-msg2
msg3: db "The two string are circular Permuations of each other", 10
msglen3: equ $-msg3
msg4: db "The two string are NOT circular Permuations of each other", 10
msglen4: equ $-msg4
newline: db 10
index: db 0
dum_len: db 0
first_index: db 0
currentindex: db 0
arrayindex: db 0

section .bss

string1: resb 100
string2: resb 100
temp: resb 2
temp4: resb 1
dum: resb 100
startchar: resb 1
dummy1: resb 1
dummy2: resb 1
