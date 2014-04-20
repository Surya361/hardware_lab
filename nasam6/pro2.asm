section .text
	global main
	extern scanf
	extern printf
	
main:
	
	call read
mov bx,2
mov word[num],bx
FLDPI
FILD qword[num]
FMUL ST1
FMUL ST2
call print
exit:
	mov eax,1
	mov ebx,0
	int 80h


print:
	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[ebp-8]
	push pri
	call printf
	mov esp, ebp
	pop ebp
	ret


read:
	push ebp
	mov ebp, esp
	sub esp, 8
	lea eax, [esp] ;load effective adress
	push eax
	push red
	call scanf
	fld qword[ebp-8]
	mov esp, ebp
	pop ebp
	ret
section .data

red: db "%lf",0
pri: db 10,"%lf ",10
section .bss
num: resd 1

