section .bss
	digit0: resb 1   ;1st digit of a 2 digit number
	digit1: resb 1   ;2nd digit of a 2 digit number
	array: resb 50
	element: resb 1
	num: resb 1
	pos: resb 1
	temp: resb 1
	ele: resb 1

section .data
	msg1: db "enter the number of elements: "
	size1: equ $-msg1
	
	msg2: db "enter a number: "
	size2: equ $-msg2

	msg3: db "enter the number to be searched: "
	size3: equ $-msg3
        count: db 0

section .text
 global _start
_start:

;printing message to enter #of ele' in array
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h

;reading the 1st digit of number(2 digit number)
mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, 1
int 80h

;reading the 2nd digit of number
mov eax, 3
mov ebx, 0
mov ecx, digit0
mov edx, 2
int 80h

;computing the given 2 digit number into the variable 'num'
sub byte[digit1], 30h
sub byte[digit0], 30h
mov al, byte[digit1]
mov dl, 10
mul dl
mov byte[num], al
mov al, byte[digit0]
add byte[num], al          ;'num' contains array size

;copying array size from 'num' to 'temp'
mov al, byte[num]
mov byte[temp], al

;copying the base address of the array to ebx
mov esi, array



;;;process to take input the array elements...
reading:                   ;label name
;push ebx                   ;preserving the value of ebx in stack
   ;printing the message to enter each element
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, size2
int 80h
   ;Reading the 1st digit of element into 'digit1'
mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, 1
int 80h
   ;Reading the 2nd digit of element into 'digit0'
mov eax, 3
mov ebx, 0
mov ecx, digit0
mov edx, 2
int 80h
   ;computing the given 2 digit element into 'al'reg
sub byte[digit1], 30h
sub byte[digit0], 30h
mov al, byte[digit1]
mov dl, 10
mul dl
add al, byte[digit0]         ;al now contains the computed element

      ;popping out the address of array into ebx
;pop ebx
mov ebx, esi
   ;copying the element from al to the ;memory location whose address is present in ebx
mov byte[ebx], al
   
add ebx, 1   ;incrementing the 'pointer to the memory location' to the next location

dec byte[temp]       ;'temp' initially containing array size is decremented
cmp byte[temp], 0    ;check if #of elements i/p = array size

ja reading           ;looping using branch statements

;----------------------------------reading the array elements is over

;;;Reading the number to be searched...
 ;printing the message to i/p the number
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, size3
int 80h

 ;Reading the 1st digit of number
mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, 1
int 80h

 ;Reading the 2nd digit of number
mov eax, 3
mov ebx, 0
mov ecx, digit0
mov edx, 2
int 80h

 ;computation of the number to be searched into the variable 'ele'
sub byte[digit1], 30h
sub byte[digit0], 30h
mov al, byte[digit1]
mov dl, 10
mul dl
add al, byte[digit0]
mov byte[ele], al

movzx ecx, byte[num]
mov ebx, array
mov byte[pos], 1


searching:               ;label name

mov al , byte[ebx]
cmp al, byte[ele]
je found
add ebx, 1
dec ecx
cmp ecx, 0
je output

jmp searching

exit:
mov eax, 1
mov ebx, 0
int 80h

found:
add byte[count], 1
add ebx, 1
dec ecx
jmp searching

;getting the two digits of count
output:
movzx ax, byte[count]
mov bl, 10
div bl
mov byte[digit1], al
mov byte[digit0], ah
add byte[digit0], 30h
add byte[digit1], 30h

;print the #of occurances
mov eax, 4
mov ebx, 1
mov ecx, digit1
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, digit0
mov edx, 1
int 80h

jmp exit
















