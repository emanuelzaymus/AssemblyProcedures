TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Sequence DD 132, 159, -16, 137, 6, 14, 67, -3, 0, 98, 45, 842, -12, -63, 48, 1180, -1500, 9999

.code

Comment /* Sorts Sequence to ascending sequence. */
Sort PROC USES eax ebx edi esi
	mov esi, lengthOf Sequence - 1
	MainSortLoop:
		mov edi, 0
		mov bl, 0			;bool wasSwap 
		Sorting:
			mov eax, Sequence[edi * 4]
			inc edi
			cmp eax, Sequence[edi * 4]
				jle IsSmaller
			xchg eax, Sequence[edi * 4]
			dec edi
			mov Sequence[edi * 4], eax
			inc edi
			mov bl, 1

			IsSmaller:
		cmp edi, esi
			jb Sorting
	cmp bl, 1
		je MainSortLoop
	ret
Sort ENDP


Comment /* Writes Sequence separated with white space. */
WriteSequence PROC USES eax edx edi
	mov edi, 0

	WriteDown:
		mov eax, Sequence[edi * 4]
		call WriteInt
		mov al, ' '
		call WriteChar
		inc edi
	cmp edi, lengthOf Sequence
		jb WriteDown

	call Crlf
	ret
WriteSequence ENDP


main PROC
	
	call WriteSequence
	call Sort
	call WriteSequence

	exit
main ENDP

END main