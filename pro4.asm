section .text
    global _start:

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx ,entermsg
	mov edx ,23
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, digit1
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, digit2
	mov edx, 2
	int 80h

	sub byte[digit1], 30h
	sub byte[digit2], 30h

	mov al, byte[digit1] 
	mov bl, 10
	mul bl

	movzx bx, byte[digit2] 
	add ax, bx
	mov word[num1],ax
	
	mov eax, 4
	mov ebx, 1
	mov ecx ,entermsg2
	mov edx ,24
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, digit3
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, digit4
	mov edx, 2
	int 80h

	sub byte[digit3], 30h
	sub byte[digit4], 30h

	mov al, byte[digit3] 
	mov bl, 10
	mul bl

	movzx bx, byte[digit4] 
	add ax, bx
	add ax,word[num1]
	mov bl,100
	div bl
	mov byte[digit1],al
	mov byte[num2],ah
	mov ax,word[num2]
	mov bl,10
	div bl
	mov byte[digit2],al
	mov byte[digit3],ah
	add byte[digit1],30h
	add byte[digit2],30h
	add byte[digit3],30h
	mov eax, 4
	mov ebx, 1
	mov ecx ,digit1
	mov edx ,1
	int 80h
	mov eax, 4
	mov ebx, 1
	mov ecx ,digit2
	mov edx ,1
	int 80h
	mov eax, 4
	mov ebx, 1
	mov ecx ,digit3
	mov edx ,1
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
section .data
	entermsg: db 'Enter the first number',0Ah
	entermsg2: db 'Enter the second number',0Ah
section .bss
	num1: resb 1
	num2: resb 2
	digit1: resb 1
	digit2: resb 1
	digit3: resb 1
	digit4: resb 1
