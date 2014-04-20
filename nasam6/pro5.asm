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

mov dword[fact],1
mov dword[num],3
mov dword[count],2
fldz


call read
fld ST0	;st0 = num,st1= num
fcos;sto = cos(num) st1 = num
call print2

fld ST0;st0=num,st1= num
fmul ST0;sto = num2,st1 = num
fmul ST1;sto = num3,st1 = num

fld ST0;sto = num3, st1 = num3,st2=num
fchs;sto = -num3,st1=num3,st2 = num
fidiv dword[fact3];sto= -num3/6 st1 = num3,st2 = num 
fxch ST1;st0 = num3,st1=-num3/6,st2 = num

fmul ST2;st0 = num4,st1=-num3/6,st2 = num
fmul ST2;st0 = num5,st1=-num3/6,st2 = num
fld ST0;st0 = num5,st1= num5,st2 = -num3/6,st3 = num
fidiv dword[fact5];st0 = num5/120,st1= num5,st2 = -num3/6,st3 = num

fxch ST1;st1 = num5/120,st0= -num5,st2 = -num3/6,st3 = num

fmul ST3;st1 = num5/120,st0= -num6,st2 = -num3/6,st3 = num
fmul ST3;st1 = num5/120,st0= -num7,st2 = -num3/6,st3 = num
fchs ;st1=num5/120,st0= num7,st2 = -num3/6,st3 = num
fidiv dword[fact7];st0=num7/7!,st1=num5/120,st2 = -num3/6,st3 = num

fadd ST1
fadd ST2
fadd ST3
;st0=sinx
FMUL ST0
FCHS 
mov dword[num],1
FIADD dword[num]
FSQRT
call print3
;call print3 ;---for dummying purpose------
exit:
mov eax, 1
mov ebx, 0
int 80h

print2:

 push ebp
 mov ebp, esp
 sub esp, 8
 fstp qword[ebp-8]
 push format3
 call printf
 mov esp, ebp
 pop ebp
 ret

print3:

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

fact1:
  
  mov eax, dword[num]
  cmp ax, 1
  je terminate
  push word[num]

  dec dword[num]
  call fact1

  pop word[num]
  mov edx, dword[num]

  mov eax, dword[fact]
  mul dx
  mov dword[fact], eax
  jmp exit1
  
terminate:
  mov dword[fact], 1

exit1:
  ret
section .data
msg1: db "enter x in radians : ",0Ah
len1: equ $-msg1
msg2: db 0Ah
len2: equ $-msg2
err: db "error is here",0Ah
lene: equ $-err
format1:db "%lf",0
format3: db 10,"Cos(X) using processor instruction : %lf",0
format4: db 10,"Cos(X) using series expansion : %lf",10
fact3: dd 6
fact5: dd 120
fact7: dd 5040

section .bss

temp1: resb 1
temp2: resb 1
temp3: resb 1
ctr: resb 1
num2: resw 1
count: resd 1
num: resd 1
num1: resd 1
fact: resd 1
d4: resb 1
d3: resb 1
d2: resb 1
d1: resb 1
rad: resd 1


