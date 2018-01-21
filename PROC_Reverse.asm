TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Sequence DD -6, -2, 0, 2, 4, 6, 8, 10, 16, 19, 20, 21, 45, 98, 100

.code

Comment /* Reverses Sequence. */
Reverse PROC USES eax ebx edi esi
	mov edi, 0
	mov ecx, lengthOf Sequence - 1
	mov eax, lengthOf Sequence
	mov bl, 2
	div bl
	mov ah, 0
	mov esi, eax

	Swap:
		mov eax, Sequence[edi * 4]
		push edi

		imul edi, -1
		add edi, ecx
		xchg Sequence[edi * 4], eax

		pop edi
		mov Sequence[edi * 4], eax

		inc edi
	cmp edi, esi
		jb Swap
	ret
Reverse ENDP


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
	call Reverse
	call WriteSequence

	exit
main ENDP

END main