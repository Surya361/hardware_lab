section .data
mesg: db "enter the length of the array1 number",10
new: db 10
section .bss

readnum: resw 1
temp: resw 1
count: resb 1
printnum: resw 1
array: resw 100
length: resw 1
count1: resb 1
count2: resb 1
len: resw 1
start: resw 1
stop: resw 1
search: resw 1

section .text

global _start:
_start:

	mov eax,4
	mov ebx,1
	mov ecx,mesg
	mov edx,38
	int 80h
	
	call read

	

	
	mov ax,word[readnum]
	mov word[length],ax

	call readarray
	call read
	mov ax,word[readnum]
	mov word[search],ax
	call binser
;	call printarray
	mov eax,1
	mov ebx,0
	int 80h

read:
	mov word[readnum],0
	mov word[temp],0
	loo1:
	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h
	cmp word[temp],10
	je return_read
	sub word[temp],30h
	mov dx,0
	mov ax,word[readnum]
	mov bx,10
	mul bx
	mov word[readnum],ax
	mov bx,word[temp]
	add word[readnum],bx
	jmp loo1
return_read:
	ret
print:
	mov byte[count],0
	lo1:
	cmp word[printnum],0
	je zero
	mov dx,0
	mov ax,word[printnum]
	mov bx,10
	div bx
	mov word[printnum],ax
	push dx
	inc byte[count]
	jmp lo1
zero:
	mov ax,0
	push ax
	inc byte[count]
	jmp pri
pri:
	cmp byte[count],0
	je returnprint
	pop ax
	mov word[temp],ax
	add word[temp],30h
	mov eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h
	dec byte[count]
	jmp pri
returnprint:
	ret
	
readarray:

	mov esi,array
	mov byte[count1],0
	l1:
	movzx ax,byte[count1]
	cmp ax,word[length]
	je retu
	call read
	mov ax,word[readnum]

	movzx ebx,word[count1]
	mov word[esi + 2*ebx],ax
	mov ax,word[esi + 2*ebx]

	inc byte[count1]
	jmp l1
retu:
	ret

printarray:
	mov byte[count2],0
	mov esi,array
	l2:
	movzx ax,byte[count2]
	cmp ax,word[length]
	je re
	movzx ebx,byte[count2]
	mov ax,word[esi+2*ebx]
	mov word[printnum],ax
	call print
	mov eax,4
	mov ebx,1
	mov ecx,new
	mov edx,1
	int 80h
	inc byte[count2]
	jmp l2
re:
	ret
binser:
	mov word[start],0
	mov ax,word[length]
	sub ax,1
	mov word[stop],ax
	rec:
	mov word[len],0
	mov esi,array
	mov ax,word[start]
	mov bx,word[stop]
	add word[len],ax
	add word[len],bx
	mov dx,0
	mov ax,word[len]
	mov bx,2
	div bx
	movzx ebx,ax
	mov cx,word[search]
	cmp cx,word[esi + 2*ebx]
	je p
	cmp cx,word[esi + 2*ebx]
	jg g
	cmp cx,word[esi + 2*ebx]
	jl l
p:
	mov word[printnum],bx
	call print
	ret
g:
	mov ax,word[len]
	add ax,1
	mov word[start],ax
	jmp rec
l:
	mov ax,word[len]
	sub ax,1
	mov word[stop],ax 
	jmp rec
	
