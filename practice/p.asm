section .data
mesg: db "enter the array",10
section .bss
readnum: resb 1
temp: resb 1
printnum: resb 1
cnt: resb 1

section .text
global _start:
_start:
	mov eax,4
	mov ebx,1
	mov ecx,mesg
	mov edx,16
	int 80h

	call read
	mov al,byte[readnum]
	mov byte[printnum],al
	mov byte[temp],0
	mov byte[cnt],0
	call print	
	mov eax,4
	mov ebx,1
	mov ecx,readnum
	mov edx,1
	int 80h

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
	je returnread
	sub byte[temp],30h
	mov al,byte[readnum]
	mov bl,10
	mul bl
	mov byte[readnum],al
	mov bl,byte[temp]
	add byte[readnum],bl
	jmp read
returnread:
	ret
print:
		cmp byte[printnum],0
		je pri
		movzx ax,byte[printnum]
		mov bl,10
		div bl
;		cmp al,0
;		je pri
		mov byte[printnum],al
		movzx bx,ah		
		push bx
;		cmp al,0
;		je pri
		inc byte[cnt]
		jmp print
	pri:
		cmp byte[cnt],0
		je returnprint
		pop ax
		mov byte[temp],al
		add byte[temp],30h
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h
		dec byte[cnt]
		jmp pri
	returnprint:
		ret
