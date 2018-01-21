TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Sequence DD 132, 159, 367, -16, 137, 6, 14, 67, 48, -3, 0, 98, 45, 37, 842, -12, -63, 48, 1180, -1500, 9999, 8989898

.code

Comment /* Returns the first greatest element in Sequence in EAX and its position in EBX. */
MAX PROC USES edi
	mov eax, [Sequence]		;max element
	mov ebx, 0				;position of max element
	mov edi, 1

	Search:
		cmp eax, Sequence[edi * 4]
			jge IsNotGreater
		mov eax, Sequence[edi * 4]
		mov ebx, edi

		IsNotGreater:
		inc edi
		cmp edi, lengthOf Sequence
			jb Search
	ret
MAX ENDP


main PROC

	call MAX

	call WriteInt
	call Crlf
	
	mov eax, ebx
	call WriteInt
	call Crlf

	exit
main ENDP

END main