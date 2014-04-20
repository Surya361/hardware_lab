section .text
global _start
_start:

call read
call print
mov eax,1
mov ebx,0
int 80h
read:
	mov edi,array
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
		ret
print:
	mov esi,array
	l2:
		cmp edi,esi
		je r
		lodsb
		mov byte[temp],al
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h
		jmp l2
	r:
		ret
section .bss
array resb 100
temp resb 1		
