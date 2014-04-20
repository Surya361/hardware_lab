section .data

message1: db "enter the size of arrar",10
message2: db "enter the second array",10
message3: db "enter the first array",10
new: db 10
section .bss

num: resw 1
temp: resb 1
count: resw 1
array: resw 100
array1: resw 100
array2: resw 100
length: resw 1
num1: resd 1
cnt: resb 1

section .text

global _start:
_start:
	mov eax,4
	mov ebx,1
	mov ecx,message1
	mov edx,24
	int 80h
	call read
	mov ax,word[num]
	mov word[length],ax
	mov eax,4
	mov ebx,1
	mov ecx,message3
	mov edx,22
	int 80h
	call read_array
	mov eax,4
	mov ebx,1
	mov ecx,message2
	mov edx,23
	int 80h
	call read_array1
	call fun
	mov word[count],0

lo2:
	mov ax,word[length]
	cmp ax,word[count]
	je out
	mov eax,4
	mov ebx,1
	mov ecx,new
	mov edx,1
	int 80h
	mov esi,array2
	movzx eax,word[count]
	mov bx, word[esi + 2*eax]
	movzx ecx,bx
	mov dword[num1],ecx
	call pri
	inc word[count]
	jmp lo2	
	
	
out:
	mov eax,1
	mov ebx,0
	int 80h
fun:
	
	mov word[count],0
	lo1:
		mov esi,array
		mov eax,array1
		mov ebx,array2
		movzx edx,word[count]
		cmp dx,word[length]
		je r
		mov cx,word[esi+2*edx]
		cmp cx,word[eax+2*edx]
		jg write1
		mov cx,word[eax+2*edx]
		mov word[ebx+2*edx],cx
		inc word[count]
		jmp lo1
	write1:
		mov cx,word[esi+2*edx]
		mov word[ebx+2*edx],cx
		inc word[count]
		jmp lo1
	r:
		ret
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
read_array1:
	mov word[count],0
	mov ebp,array1
	l3:
		mov ax,word[length]		
		cmp word[count],ax
		je return2
		call read
		mov ax,word[num]
		movzx ebx,word[count]
		mov word[ebp+2*ebx],ax
		inc word[count]
		jmp l3
	return2:
	ret	
pri:
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
	jmp pri
	
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
	ret
	
