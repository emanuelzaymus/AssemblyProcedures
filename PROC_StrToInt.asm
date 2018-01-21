TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

String DB "-123456789",0

.code

Comment /* Returns converted string into integer in EAX. */
StrToInt PROC USES ebx ecx edx edi OffString
	mov edi, 0			;iterator
	mov edx, OffString	;address of string
	mov eax, 0			;result
	mov ebx, 0			;char
	mov cl, '-'			;minus sign

	cmp [edx], cl			;checking minus sign
		jne Convert
	inc edi

	Convert:	
		mov bl, [edx + edi]		;take one char
		cmp bl, 0
			je ConvertEnd
		imul eax, 10			;eax = eax * 10
		sub bl, '0'				;make int from char
		add eax, ebx			;eax = eax + ebx

		inc edi
		jmp Convert
	ConvertEnd:

	cmp [edx], cl			;if String has minus sign make negative number
		jne DoNotNeg
	neg eax

	DoNotNeg:
	ret
StrToInt ENDP


main PROC

	invoke StrToInt, offset String

	call WriteInt
	call Crlf
	
	exit
main ENDP

END main