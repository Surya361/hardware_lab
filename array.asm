section .data

message: db "enter the length of the array",10

section .bss

array: resw 10
num: resw 1
temp: resb 1
length: resw 1
count: resw 1

section .text

global_start:
_start:
	mov eax,4
	mov ebx,1
	mov ecx,message
	mov edx,30
	int 80h
	call read
	mov ax,word[num]
	mov word[length],ax
	cal read_array
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
		int 80x
		cmp byte[temp],10
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
	l2:
		call read
		

