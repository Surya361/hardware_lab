section .text
	global main
	extern scanf
	extern printf	
main:
	mov ecx, msg1
	mov edx, len_msg1
	call pri
	
	call getnum
	mov eax,dword[number]	
	mov dword[n],eax
	mov dword[temp],eax

	cmp eax,0
	je exit
	
	push eax
	mov ecx, msg1
	mov edx, len_msg1
	call pri
	pop eax

	mov ebx,array
	mov dword[temp],eax
	call getarry
		
bub:
	mov ebx,array  ;main pointer
	mov ecx,array  ;sub pointer
	
	mov eax,dword[n]
	mov dword[cnt1],eax
	mov dword[cnt2],eax
bubble:
	mov eax,dword[ebx]
	cmp eax,dword[ecx]
	jna skip
	call swap
	
	skip:
		add ecx,4
		dec dword[cnt2]
		cmp dword[cnt2],0
		je setsecpointer
		jmp bubble
	
		setsecpointer:
			add ebx,4
			dec dword[cnt1]
			cmp dword[cnt1],0
			je bubble_sort_done
			mov eax,dword[cnt1],
			mov dword[cnt2],eax
			mov ecx,ebx
			jmp bubble
	
bubble_sort_done:
	mov ecx,msg1
	mov edx,len_msg1
	call pri

	mov ebx,array
	mov eax,dword[n]
	mov dword[temp],eax
	call pri_arry

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
getarry:
readelement:
	push ebx
	call read 
	pop ebx
	
	fstp dword[ebx]
	add ebx,4

	dec dword[temp]
	cmp dword[temp],0
	ja readelement
	ret
 
pri_arry:
	cmp dword[temp],0
	je printing_done

	fld dword[ebx]
	call print
	fstp dword[waste]	
	
	add ebx,4
	dec dword[temp]
	jmp pri_arry
printing_done:
	ret	
	
getnum:
	mov dword[number],0
  getnumber:
	mov ecx,digit
	mov edx,1
	call READ

	cmp BYTE[digit],10                 
	jne carryon
	ret			   	   
  carryon:				   
	sub byte[digit],30h
	mov eax,dword[number]
	mov ebx,10
	mul ebx
	
	movzx ebx,byte[digit]
	add eax,ebx
	mov dword[number],eax
	jmp getnumber
	
pri:
	mov eax,4
	mov ebx,1
	int 80h
	ret
READ:
	mov eax,3
	mov ebx,0
	int 80h
	ret		
print:
	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push formatp
	 call printf
	 
	 mov esp, ebp
	 pop ebp
	 ret
read:
	 push ebp
	 mov ebp, esp
	 sub esp, 8 
	 lea eax, [esp] 
	 push eax
	 push format1
	 call scanf
	 fld qword[ebp-8]
	 
	 mov esp, ebp
	 pop ebp
	 ret
	mov eax,3
	mov ebx,0
	int 80h
	ret	
swap:
	mov eax,dword[ebx]
	mov edx,dword[ecx]
	mov dword[ebx],edx
	mov dword[ecx],eax
	ret
section .data
	msg1: db "",10
	len_msg1: equ $-msg1
	blank: db 10
	format1 db "%lf",0
	formatp db "%lf",10
section .bss
	waste: resd 1
	cnt1: resd 1
	cnt2: resd 1
	number: resd 1
	digit: resb 1
	n: resd 1
	array: resd 100
	temp: resd 1
