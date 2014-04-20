section .text
global _start
_start:
mov edi,array
call read
mov dword[adr],edi
call length
mov eax,1
mov ebx,0
int 80h
read:
	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h
	cmp byte[temp],10
	je return
	mov al,byte[temp]
	stosb
	jmp read
return:
	ret
length:
	mov esi,array
	sub dword[adr],esi
	add dword[adr],30h
	mov eax,4
	mov ebx,1
	mov ecx,adr
	mov edx,1
	int 80h
	ret
section .bss
array resb 100
temp resb 1
adr resd 1
