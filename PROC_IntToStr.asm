TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

String DB ?

.code

Comment /* Converts integer in EAX into String. Sets EDX to offset String. */
IntToStr PROC USES eax ebx ecx edi
	mov esi, offset String		;address of String
	mov edi, 0					;iterator
	mov ebx, 10					;10 for division
	mov cl, '-'					;minus sign

	cmp eax, 0
		jge DoNotNeg
	neg eax
	mov [esi], cl
	inc edi
	
	DoNotNeg:
	push eax
		GetLength:				;getting length of eax
			cdq
			div ebx
			inc edi
		cmp eax, 0
			jne GetLength
		dec edi					;length of eax
	pop eax

	Convert:					;converting int to string
		cdq
		div ebx
		add dl, '0'				;dl = reminder after division eax by 10 + '0'
		mov [esi + edi], dl		;writes reminder
		dec edi
	cmp eax, 0
		jne Convert

	mov edx, esi
	ret
IntToStr ENDP


main PROC

	mov eax, -123456789
	call IntToStr

	call WriteString
	call Crlf
	
	exit
main ENDP

END main