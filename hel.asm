section .data
message: db "enter the length of the array",10
new: db 10
section .bss
num1: resd 1
cnt: resb 1
num: resw 1
temp: resb 1
array: resw 100
length: resw 1
count: resw 1
count1: resw 1
;num1: resw 1
num2: resw 1
second: resw 1
section .text
global _start:
_start:
	mov eax,4
	mov ebx,1
	mov ecx,message
	mov edx,30
	int 80h
	call read
	mov ax,word[num]
	mov word[length],ax
	call read_array
	call divisible
	mov eax,1
	mov ebx,0
	int 80h
divisible:
	mov ebp,array
	mov word[count],0
	l3:
		mov ax,word[length]
		cmp word[count],ax
		je return2
		movzx edx,word[count] 
		mov ax, word[ebp+2*edx]
		mov bl,7
		div bl
		inc word[count]
		cmp ah,0		
		je pr		
		jmp l3
	pr:
		mov ax,word[ebp+2*edx]
		movzx ebx,ax
		mov dword[num1],ebx
		mov eax,4
		mov ebx,1
		mov ecx,new
		mov edx,1
		int 80h
		call pri
		jmp l3
	return2:
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

		
