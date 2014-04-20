section .data
msg1: db "Enter any two numbers : ",0Ah
len1: equ $-msg1
msg2: db 0Ah
len2: equ $-msg2
format1 db "%lf",0
format4 db 10,"The product of the two numbers is : %lf",10
format3 db 10,"The difference of the two numbers is : %lf",0
format2 db 10,"The sum of the two numbers is : %lf",0


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

mov al,2
mov byte[num], al
mov byte[ctr], al
mov ah, 0
mov word[num2], ax

fldz

reading:
call read
fst ST1
fst ST3
dec byte[ctr]
cmp byte[ctr], 0
jne reading

fadd ST4
call print1

fldz
fadd st3
fsub st2
call print2

fldz
fadd ST3
fmul ST4
call print3

exit:
mov eax, 1
mov ebx, 0
int 80h

print1:

 push rbp
 mov ebp, esp
 sub esp, 8
 fst qword[ebp-8]
 push format2
 call printf
 mov esp, ebp
 pop rbp
 ret

print2:

 push rbp
 mov ebp, esp
 sub esp, 8
 fst qword[ebp-8]
 push format3
 call printf
 mov esp, ebp
 pop rbp
 ret

print3:

 push rbp
 mov ebp, esp
 sub esp, 8
 fst qword[ebp-8]
 push format4
 call printf
 mov esp, ebp
 pop rbp
 ret

read:
 push rbp
 mov ebp, esp
 sub esp, 8
 lea eax, [esp] ;load effective adress
 push rax
 push format1
 call scanf
 fld qword[ebp-8]
 mov esp, ebp
 pop rbp
 ret

