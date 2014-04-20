section .text
global _start:
_start:
	call read
	mov eax,4
	mov ebx,1
	mov ecx,readnum
	mov edx,1
	int 80h
	mov cx,word[readnum]
	mov word[printnum],cx
	call print
	
	mov eax,1
	mov ebx,0
	int 80h
read:
	mov word[readnum],0
	lo1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		cmp word[temp],10
		je returnread
		sub word[temp],30h
		mov ax,word[readnum]
		mov bx,10
		mul bx
		add ax,word[temp]
		mov word[readnum],ax
		jmp lo1
	returnread:
		ret
print:
	mov word[count],0
	lp1:
		cmp word[printnum],0
		je zero
		mov ax,word[printnum]
		mov dx,0
		mov bx,10
		div bx
		push dx
		mov word[printnum],ax
		inc word[count]
		jmp lp1
	zero:
		mov ax,0
		push ax
		inc word[count]
		jmp pr
	pr:
		cmp word[count],0
		je returnprint
		pop ax
		mov word[temp],ax
		add word[temp],30h
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h
		dec word[count]
		jmp pr
	returnprint:
		ret
readarray:
	mov word[count1],0
	l1:
		cmp word[count1],word[length]		
section .bss
readnum: resw 1
temp: resw 1
count: resw 1
printnum: resw 1
