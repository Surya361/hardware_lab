
section .data
	format2: db "%lf",10,0
	format1: db "%lf", 0
	msg1: db "enter the value of x: "
	l1: equ $-msg1
     msg2:db "using series: ",0Ah
     l2:equ $-msg2
     msg3:db "using formula: ",0Ah
      l3:equ $-msg3
	
section .bss
	x: resd 1
	cos: resd 1
	temp: resd 1
	temp1: resd 1
	temp2: resd 1
	temp3: resd 1
	one : resd 1
	pointf : resd 1

section .text
	global main
	extern scanf
	extern printf

print:

	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[ebp-8]
	push format2
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

main:
fldz

	mov dword[one],1
	mov eax,dword[one]
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	call read
	fst dword[x]
	fisub dword[one]
	fdiv dword[x]
	fst dword[x]
	
	
	mov eax,dword[x]
	mov dword[cos],eax
	mov byte[temp], 2
	movzx eax, byte[x]
	mov dword[cos], eax
	loopin:
		mov al, byte[temp]
		mov byte[temp1], al
		;mov byte[temp2], al
		
		fld dword[x]
		movzx ecx, byte[temp1]
		dec ecx
		multi: 	
			fmul dword[x]
			;dec dword[temp2]
			loop multi	
		fidiv dword[temp]	
		fstp dword[temp3]


		jmp itsadd
	continue:
		inc byte[temp]
		cmp byte[temp], 100
		jne loopin

	;fld dword[cos]
	fld dword[cos]
      ;mov byte[temp],1
     ; fiadd dword[temp]
      fadd dword[x]
     
      pusha
      mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h
      popa

	call print
      
exit:
	mov eax, 1
	mov ebx, 0
	int 80h


itsadd:
	fld dword[cos]
	fadd dword[temp3]
	fstp dword[cos]
	jmp continue

