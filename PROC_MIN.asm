TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Sequence DD 132, 159, 367, -16, 137, 6, 14, 67, 48, -3, 0, 98, -6549, 37, 842, -12, -63, 48, 1180, -1500, 9999, 8989898

.code

Comment /* Returns the first smallest element in Sequence in EAX and its position in EBX. */
MIN PROC USES edi
	mov eax, [Sequence]		;min element
	mov ebx, 0				;position of max element
	mov edi, 1				;iterator

	Search:
		cmp eax, Sequence[edi * 4]
			jle IsNotSmaller
		mov eax, Sequence[edi * 4]		;set the smallest num
		mov ebx, edi					;set the position

		IsNotSmaller:
		inc edi
		cmp edi, lengthOf Sequence
			jb Search
	ret
MIN ENDP


main PROC

	call MIN

	call WriteInt
	call Crlf
	
	mov eax, ebx
	call WriteInt
	call Crlf

	exit
main ENDP

END main