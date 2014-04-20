 
section .text 
global _start:
read_num :
    push eax
	push ebx
	push ecx
	push edx
	mov al, 0	
  lo1 :
      push eax
	  mov eax, 3
	  mov ebx, 0
	  mov ecx, digit
	  mov edx, 1
	  int 80h	  
	  cmp byte[digit], 10
	  je stop_read
	  cmp byte[digit], ' '
	  je stop_read
	  sub byte[digit], 30h
	  pop eax
	  mov bl, 10
	  mul bl
	  add al, byte[digit] 
	  jmp lo1	  
  stop_read :
       pop eax
       mov byte[no], al
	   pop edx
	   pop ecx
	   pop ebx
	   pop eax
	   ret    
  read_matrix :        ; read matrix to ebp (base) , n size 
   push eax
   push ebx
   push ecx
   push edx
   mov al, byte[m]
   mov bl, byte[n]
   mul bl
   read_loop :
    cmp al, 0
    je end_read
    call read_num
    mov bl, byte[no]
    mov byte[ebp], bl
    add ebp, 1
    sub al, 1
    jmp read_loop
   end_read :
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret   
 print_no :          
  push eax
  push ebx
  push ecx
  push edx
  push 10
  
  mov bl, 10
  
  pushing :
   movzx ax, byte[temp] 
   div bl
   movzx ebx, ah
   push ebx
   mov byte[temp], al
   cmp al, 0
   jne pushing

  popping :
   pop ebx
   mov byte[temp], bl
   cmp bl, 10
   je end_printing_no
   add byte[temp], 30h
   
   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h
   jmp popping
  
  end_printing_no :
   
   pop edx
   pop ecx
   pop ebx
   pop eax
   ret
     
print_matrix :        
 push eax
 push ebx
 push ecx
 push edx
 mov byte[count1], 0
 mov byte[count2], 0
 
 print_loop :
  mov al, byte[m]
  cmp byte[count2], al
  je end_printing_matrix
  mov al, byte[n]
  cmp byte[count1], al
  je next_row_print
  mov al, byte[esi]
  mov byte[temp], al
  call print_no
  mov eax, 4
  mov ebx, 1
  mov ecx, spc
  mov edx, 1
  int 80h
  inc esi
  inc byte[count1]
  jmp print_loop
  
 next_row_print : 
  mov byte[count1], 0
  add byte[count2], 1
  mov eax, 4
  mov ebx, 1
  mov ecx, nl
  mov edx, 1
  int 80h
  jmp print_loop
  
 end_printing_matrix :
  pop edx
  pop ecx
  pop ebx
  pop eax
  ret
  
matrix_mul :              
 push eax 
 push ebx
 push ecx
 push edx
 mov ebp, matrix1
 mov esi, matrix2
 mov edx, res
 mov byte[sum], 0
 mov byte[count1], 0
 mov byte[count2], 0
 mov byte[count3], 0
 push esi
 push esi
 push ebp
 while :
   mov al, byte[m1]
   cmp al, byte[count1]
   je end_mul
   mov al, byte[n2]
   cmp al, byte[count2]
   je next_row
   mov al, byte[m2]
   cmp al, byte[count3]
   je next_col
   add byte[count3], 1
   mov al, byte[ebp]
   mov bl, byte[esi]                           
   mul bl
   add byte[sum], al
   inc ebp
   mov eax, 0
   movzx eax, byte[n2]
   add esi, eax
   jmp while
   
 end_mul :
   pop ebp
   pop esi
   pop esi
   pop edx
   pop ecx
   pop ebx
   pop eax
   ret
   
 next_col :
   mov al, byte[sum]
   mov byte[edx], al
   inc edx
   mov byte[sum], 0
   pop ebp
   pop esi
   inc esi
   push esi
   push ebp
   add byte[count2], 1
   mov byte[count3], 0
   jmp while
   
 next_row :
   pop ebp
   pop esi
   pop esi
   add byte[count1], 1
   mov byte[count2], 0
   mov eax, 0
   movzx eax, byte[n1]
   add ebp, eax
   push esi
   push esi
   push ebp
   jmp while
          
_start :
    mov eax, 4
    mov ebx, 1
    mov ecx, message1
    mov edx, msg_len
    int 80h
    
    call read_num
    mov al, byte[no]
    mov byte[m1], al
    
    mov eax, 4
    mov ebx, 1
    mov ecx, message3
    mov edx, msg_len
    int 80h
    
    call read_num
    mov al, byte[no]
    mov byte[n1], al
    
    mov eax, 4
    mov ebx, 1
    mov ecx, message2
    mov edx, msg_len
    int 80h
    
    call read_num
    mov al, byte[no]
    mov byte[m2], al
    
    mov eax, 4
    mov ebx, 1
    mov ecx, message4
    mov edx, msg_len
    int 80h
    
    call read_num
    mov al, byte[no]
    mov byte[n2], al

    mov al, byte[m2]
    cmp byte[n1], al
    jne print_notpossible
    
    mov eax, 4
    mov ebx, 1
    mov ecx, message6
    mov edx, 15
    int 80h
    
    mov al, byte[m1]
    mov bl, byte[n1]
    mov byte[m], al
    mov byte[n], bl
    mov ebp, matrix1
    call read_matrix
    
    mov eax, 4
    mov ebx, 1
    mov ecx, message7
    mov edx, 15
    int 80h
    
    mov al, byte[m2]
    mov bl, byte[n2]
    mov byte[m], al
    mov byte[n], bl
    mov ebp, matrix2
    call read_matrix  
    
    mov eax, 4
    mov ebx, 1
    mov ecx, message5
    mov edx, msg_len3
    int 80h 
        
    call matrix_mul
    mov esi, res
    mov al, byte[m1]
    mov byte[m], al
    mov al, byte[n2]
    mov byte[n], al
    call print_matrix
    jmp exit
   
   print_notpossible :
    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, error_len
    int 80h
      
   exit : 
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 80h
     
    mov eax, 1
    mov ebx, 0
    int 80h
section .data
 message1 : db "no of rows in first matrix "
 msg_len : equ $-message1
 message2 : db "no of rows in secnd matrix "
 message3 : db "no of clms in first matrix "
 message4 : db "no of clms in secnd matrix "
 error : db "Matrix multiplication not possible "
 error_len : equ $-error
 message5 : db "Resultant Matrix : ", 0Ah
 msg_len3 : equ $-message5
 nl : db 0Ah
 spc : db ' '
 message6 : db "Enter matrix1 ", 0Ah
 message7 : db "Enter matrix2 ", 0Ah
 
section .bss 
 matrix1 : resb 100
 matrix2 : resb 100
 res : resb 100
 pdt : resb 1
 sum : resb 1
 m1 : resb 1
 n1 : resb 1
 m2 : resb 1
 n2 : resb 1
 m : resb 1
 n : resb  1
 no : resb 1
 digit : resb 1
 temp : resb 1
 count1 : resb 1
 count2 : resb 1
 count3 : resb 1
