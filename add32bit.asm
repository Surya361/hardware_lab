section .text
global _start:
_start:
	mov dword[num1],0
	

read_num2:

	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h
	mov al,byte[temp]
	cmp al,10
	je add
	sub byte[temp],30h
	mov eax,dword[num2]
	mov ebx,10
	mul ebx
	mov dword[num2],eax
	movzx eax,byte[temp]
	add dword[num2],eax
	jmp read_num2
	
add:
	mov eax,4
	mov ebx,1
	mov ecx,num2
	mov edx,1
	int 80h
	mov eax,dword[num2]
	add dword[num1],eax
	jmp pri
	
	
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
	
exit:	mov eax,1
	mov ebx,0
	int 80h	
	
section .bss
temp: resb 1
num1: resd 1
num2: resd 1
cnt: resb 1	
