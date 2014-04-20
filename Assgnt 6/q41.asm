section .text
global main
	extern scanf
	extern printf
getfloat:
	push ebp
	mov ebp , esp
	sub esp , 8
	lea eax , [ ebp - 8]
	push eax 
	push fmt1
call scanf
	add esp , 8

	fld qword [ebp-8]
	mov esp , ebp
	pop ebp
	ret

putfloat:
	push ebp
	mov ebp , esp
	sub esp , 8
	fst qword[ebp-8]
	push fmt2
call printf
	mov esp , ebp
	pop ebp
	ret

main:
;=======================
	mov eax, 3
	mov ebx, 0
	mov ecx, temp1
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, temp2
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, temp3
	mov edx, 1
	int 80h
	
	sub byte[temp1], 30h
	sub byte[temp2], 30h
	mov al, byte[temp1]
	mov bl, 10
	mul bl
	add al, byte[temp2]
	mov byte[num], al
	mov byte[num1], al
	mov byte[num2], al
	mov byte[num3], al
	mov byte[num4], al

;========================
	
	mov eax,0
loop:	
	pusha
call getfloat
	popa	
	fstp dword[array+eax*4]
	inc eax
	dec byte[num]
	cmp byte[num],0
jg loop

dec byte[num4]
dec byte[num1]

loop2:
	mov eax,0
	mov cl,byte[num4]
	mov byte[num1],cl
loop1:

	fld dword[array+eax*4]

	inc eax
	fld dword[array+eax*4]
	fcomi st1
	ja noswap

	dec eax
	fstp dword[array+eax*4]
	inc eax
	fstp dword[array+eax*4]
	dec eax

	jmp nos
	noswap:

	fstp dword[array+eax*4]
	dec eax
	fstp dword[array+eax*4]

	nos:
	inc eax
	ffree st0
	ffree st1	
	dec byte[num1]
	cmp byte[num1],0
jg loop1	

dec byte[num2]
cmp byte[num2],0
jg loop2







mov eax,0
loop3:

fld dword[array+eax*4]

pusha
call putfloat
popa
ffree st0
inc eax

dec byte[num3]
cmp byte[num3],0
jg loop3


exit:
	mov ebx , 0
	mov eax, 1
 	int 80h

section .data
	fmt1 db "%lf",0
	fmt2 db 10,"%lf",10

section .bss
	ele : resd 1
	array: resd 1000
	max : resd 1
	num : resb 1
	num1 : resb 1
	num2 : resb 1
	num3 : resb 1
	num4 : resb 1
	temp1 : resb 1
	temp2 : resb 1
	temp3 : resb 1
