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
	mov cl, '-'			;minus

	cmp [edx], cl
		jne Convert
	inc edi

	Convert:	
		mov bl, [edx + edi]
		cmp bl, 0
			je ConvertEnd
		imul eax, 10
		sub bl, '0'
		add eax, ebx

		inc edi
		jmp Convert
	ConvertEnd:

	cmp [edx], cl
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