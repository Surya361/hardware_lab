section .data

array: dw 2,4,3,1,5
length: dw 5
section .bss

num: resw 1
temp: resb 1
count: resw 1
count1: resw 1
num1: resw 1
num2: resw 1
second: resw 1

section .text
global _start:
_start:
	call second_large
	add word[second],30h
	mov eax,4
	mov ebx,1
	mov ecx,second
	mov edx,1
	int 80h
	mov eax,1
	mov ebx,0
	int 80h
second_large:
	mov word[count],0
	sub word[length],1
	l3:
		cmp word[count],2
		je ident
		mov word[count1],0
		mov ebp,array
		inc word[count]
		l4:
			mov ax,word[length]
			cmp word[count1],ax
			je l3
			movzx edx,word[count1]
			mov ax, word[ebp+2*edx]
			cmp word[ebp+2*edx+2],ax
			jl swap
			inc word[count1]
			jmp l4
		swap:
			movzx edx,word[count1]
			mov bx,word[ebp+2*edx+2]
			mov word[ebp+2*edx+2],ax
			mov word[ebp+2*edx],bx
			inc word[count1]
			jmp l4		
	ident:
		movzx ebx,word[length]
		sub ebx,1
		mov ax, word[ebp+2*ebx]
		mov word[second],ax
ret

