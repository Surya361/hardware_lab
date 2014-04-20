section .data

array: dw 14,7,21,28,35
array2: dw 3,1,5,6,7,10
length: dw 5
length2: dw 6

section .bss
num1: resd 1
count: resw 1
count2: resw 1
section .text
global _start:
_start:

merge:
	mov ebp,array
	mov edx,array2
	cond: 
		cmp word[count],word[length]
		je write_array2
		cmp word[count2],word[length2]
		je write_array
		movzx eax word[count]
		movax ebx,word[count2]
		mov 
		cmp word[ebp + 2 * count]

pri:
	mov ax,word[ebp+2*edx]
	movzx ebx,ax
	mov dword[num1],ebx
	l2:
	mov eax,dword[num1]
	cmp eax,0
	je print
	mov edx,0
	mov eax,dword[num1]
	mov ebx,10
	div ebx
	push edx
	mov dword[num1],eax
	inc byte[cnt]
	jmp l2
	
print:
	mov bl,byte[cnt]
	cmp bl,0
	je exit
	pop eax
	mov dword[num1],eax
	add dword[num1],30h 
	mov eax,4
	mov ebx,1
	mov ecx,num1
	mov edx,1
	int 80h
	dec byte[cnt]
	jmp print
exit:
	mov eax,1
	mov ebx,0
	int 80h

