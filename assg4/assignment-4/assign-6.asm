section .data
string_len: db 0
msg1: db "Enter the string: ", 10
msglen1: equ $-msg1
msg2: db "Largest word: ", 10
msglen2: equ $-msg2
msg3: db "smallest word: ", 10
msglen3: equ $-msg3
newline: db 10
smallest_len: db 0
lenlargest: db 0
index_largest: db 0
zeroarray: TIMES 100 db 0
smallestindex: db 0
index: db 0
dum_len: db 0
index2: db 0

section .bss
string1: resb 100
string2: resb 100
smallest: resb 100
largest: resb 100
dum: resb 100
temp: resb 2
temp4: resb 1

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
; find the largest 	
mov al, 0
mov al, byte[string_len]
mov byte[temp4], al
mov eax, 0
mov edx, 0
first_round:
   mov ebx, string1
   movzx eax, byte[index]
   cmp byte[ebx + eax], 0
   je just_print
cmp byte[ebx + eax], 32
je firstrou_i
mov cl, byte[ebx + eax]
mov ebx, dum
mov byte[ebx + edx], cl 
inc byte[dum_len]
inc eax
inc edx
inc byte[index]
jmp first_round
just_print:
mov al, 0
mov al, byte[string_len]
mov byte[temp4], al
mov ebx, 0
mov ebx, string1
print_char4:
cmp byte[temp4], 0
je exit
   dec byte[temp4]
mov byte[temp], 0
mov al, byte[ebx]
mov byte[temp], al
push ebx
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
pop ebx
inc ebx
jmp print_char4
firstrou_i:
mov cl, byte[dum_len]
mov byte[lenlargest], cl
mov cl, byte[dum_len]
mov byte[smallest_len], cl
mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index]

L1:
   mov ebx, string1
   movzx eax, byte[index]
   cmp byte[ebx + eax], 0
   je finalch

cmp byte[ebx + eax], 32
je L2
mov cl, byte[ebx + eax]
mov ebx, dum
movzx edx, byte[dum_len]
mov byte[ebx + edx], cl 
inc byte[dum_len]
inc eax
inc byte[index]
inc edx

jmp L1
finalch:
mov cl, byte[dum_len]
cmp cl, byte[lenlargest]
ja Lfinal
    cmp cl, byte[smallest_len]
    jb Lfinal2
   mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   jmp Ld

Lfinal:
mov cl, byte[dum_len]
mov byte[lenlargest], cl

mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   jmp Ld

Lfinal2:
mov cl, byte[dum_len]
mov byte[smallest_len], cl

mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
jmp Ld
Ld:
CLD
mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
mov al, 0
mov al, byte[string_len]
mov byte[temp4], al
mov eax, 0
mov edx, 0

for1:

   mov ebx, string1
   movzx eax, byte[index2]
   cmp byte[ebx + eax], 0
   je fincheck

cmp byte[ebx + eax], 32
je Ls2
mov cl, byte[ebx + eax]
mov ebx, dum
mov byte[ebx + edx], cl 
inc byte[dum_len]
inc eax
inc byte[index2]
inc edx
jmp for1
fincheck:
mov cl, byte[dum_len]
cmp byte[lenlargest], cl
je insert_largest1
   cmp byte[smallest_len], cl
   je insertsm1
      jmp printing_string
insertsm1:
call put_word_smallest
jmp printing_string
insert_largest1:
call put_word_largest
jmp printing_string
Ls2:
push eax
mov cl, byte[dum_len]
cmp byte[lenlargest], cl
je insert_largest
   cmp byte[smallest_len], cl
   je insertsm
   mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index2]
   jmp for1

insertsm:
call put_word_smallest
mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index2]
   jmp for1
insert_largest:
call put_word_largest
mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index2]
   jmp for1

L2:
push eax
mov cl, byte[dum_len]
cmp cl, byte[lenlargest]
ja L3
    cmp cl, byte[smallest_len]
    jb L4
   mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index]
   jmp L1
L3:
mov cl, byte[dum_len]
mov byte[lenlargest], cl
mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index]
   jmp L1
L4:
mov cl, byte[dum_len]
mov byte[smallest_len], cl

mov esi, zeroarray
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index]
   jmp L1

put_word_largest:
pusha
mov ebx, largest
mov al, byte[dum_len]
mov byte[temp4], al
mov eax, 0
movzx edx, byte[index_largest]

put_char1:
cmp byte[temp4], 0
je end_char1
dec byte[temp4]
mov ebx, dum
mov cl, byte[ebx + eax]
mov ebx, largest
mov byte[ebx + edx], cl
inc edx
inc eax
inc byte[index_largest]
jmp put_char1 

end_char1:

mov al, 0
mov al, 32
mov ebx, largest
mov byte[ebx + edx], al
inc byte[index_largest]

popa
ret
put_word_smallest:
pusha
mov ebx, smallest
mov al, byte[dum_len]
mov byte[temp4], al
mov eax, 0
movzx edx, byte[smallestindex]

put_char2:
cmp byte[temp4], 0
je end_char2
dec byte[temp4]
mov ebx, dum
mov cl, byte[ebx + eax]
mov ebx, smallest
mov byte[ebx + edx], cl
inc edx
inc eax
inc byte[smallestindex]
jmp put_char2 

end_char2:
mov al, 0
mov al, 32
mov ebx, smallest
mov byte[ebx + edx], al
inc byte[smallestindex]
popa
ret
printing_string:

 pusha

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msglen2
    int 80h
popa
mov al, 0
mov al, byte[index_largest]
mov byte[temp4], al
mov ebx, 0
mov ebx, largest

print_char:
cmp byte[temp4], 0
je print_string2
   dec byte[temp4]
mov byte[temp], 0
mov al, byte[ebx]
mov byte[temp], al

push ebx

    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h

pop ebx
inc ebx
jmp print_char
print_string2:
pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, msglen3
    int 80h
popa
mov al, 0
mov al, byte[smallestindex]
mov byte[temp4], al
mov ebx, 0
mov ebx, smallest

print_char1:
cmp byte[temp4], 0
je exit
   dec byte[temp4]
mov byte[temp], 0
mov al, byte[ebx]
mov byte[temp], al

push ebx
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
pop ebx
inc ebx
jmp print_char1
exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

mov eax, 1
mov ebx, 0
int 80h
