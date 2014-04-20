section .data
message: db "enter number of elements in a array",10
message1: db "enter the elements",10
section .bss

num: resw 1
temp: resb 1
length: resw 1
array: resw 100
count: resw 1
search: resw 1
fcy: resw 1

section .text
global _start:
_start:
	mov eax,4
	mov ebx,1
	mov ecx,message
	mov edx,36
	int 80h
	call read
	mov ax,word[num]
	mov word[length],ax
	mov eax,4
	mov ebx,1
	mov ecx,message1
	mov edx,19
	int 80h	
	call read_array
	mov eax,1
	mov ebx,0
	int 80h
read:
	mov word[num],0
	l1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		cmp byte[temp],10
		je return
		cmp byte[temp],32
		je return
		sub byte[temp],30h
		mov bl,10
		mov ax,word[num]
		mul bl
		mov word[num],ax
		movzx ax,byte[temp]
		add word[num],ax
		jmp l1
	return:
		ret
read_array:
	mov word[count],0
	mov ebp,array
	l2:
		mov ax,word[length]		
		cmp word[count],ax
		je return1
		call read
		mov ax,word[num]
		movzx ebx,word[count]
		mov word[ebp+2*ebx],ax
		inc word[count]
		jmp l2
	return1:
	ret	
fqcy:
	mov word[count],0
	mov word[fcy],0
	mov 
