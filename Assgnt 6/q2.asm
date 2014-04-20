section .data
msg1: db "Enter the radius  : ",0Ah
len1: equ $-msg1
msg2: db 0Ah
len2: equ $-msg2
format1 db "%lf",0
format4 db 10,"The circle area is : %lf",10


section .bss

temp1: resb 1
temp2: resb 1
temp3: resb 1
num: resb 1
ctr: resb 1
num2: resw 1

section .text
global main
extern scanf
extern printf

main:

 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

fldz
fldpi

reading:
call read
fst ST3
fst ST4

fmul ST4
fmul ST1
call print

exit:
mov eax, 1
mov ebx, 0
int 80h

print:

 push ebp
 mov ebp, esp
 sub esp, 8
 fst qword[ebp-8]
 push format4
 call printf
 mov esp, ebp
 pop ebp
 ret

read:
 push ebp
 mov ebp, esp
 sub esp, 8
 lea eax, [esp]
 push eax
 push format1
 call scanf
 fld qword[ebp-8]
 mov esp, ebp
 pop ebp
 ret

