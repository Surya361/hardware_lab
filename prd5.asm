section .data
message: db "enter string",10

section .bss
array: resb 100
temp: resw 1
count: resw 1
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
	
	mov ax,word[edi-1]
	mov word[temp],ax
	mov eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h
	cmp edi,array
	je ex
	sub edi,1
	call strr

ex:
	ret

	
read:
	mov word[count],0
	mov edi,array
	l1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		mov ax,word[temp]
		cmp word[temp],10
		je exit
		;push ecx
		stosw
		inc word[count]
		jmp l1
	exit:
		ret
