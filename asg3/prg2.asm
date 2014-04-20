section .data
message: db "enter string",10

section .bss
array: resb 100
temp: resb 1
count: resb 1
section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,message
mov edx,13
int 80h

call read
call strr

mov eax,1
mov ebx,0
int 80h
strr:
	mov edi,array
	lo1:
	cmp word[count],0
	je ex
	mov al,byte[edi]
	mov byte[temp],al
	mov eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h
	add edi,1
	dec word[count]
	jmp lo1
ex:
	ret

	
read:
	mov byte[count],0
	mov edi,array
	l1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		mov al,byte[temp]
		cmp byte[temp],32
		je l1
		cmp byte[temp],10
		je exit
		;push ecx
		stosb
		inc byte[count]
		jmp l1
	exit:
		ret
