section .text
global _start
_start:

mov edi,array
call read
mov dword[adr],edi
mov edi,array1
call read
mov dword[adr1],edi
mov esi,array
mov edi,dword[adr]
call print
mov esi,array1
mov edi,dword[adr1]
call print
mov esi,array
mov eax,1
mov ebx,0
int 80h
read:
;	mov edi,array
	l1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		cmp byte[temp],10
		je return
		mov al,byte[temp]
		stosb
		jmp l1
	return:
		;mov dword[adr],edi
		ret

print:
;	mov esi,array
	l2:
		cmp esi,edi
		je re
		lodsb
		mov byte[temp],al
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h
		jmp l2
	re:
		ret
section .bss
array resb 100
array1 resb 100
temp resb 1
adr resd 1
adr1 resd 1
