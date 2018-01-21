TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Sequence DD -6, -2, 0, 2, 4, 6, 8, 10, 16, 19, 20, 21, 45, 98, 100

.code

Comment /* Reverses Sequence. */
Reverse PROC USES eax ebx edi esi
	mov esi, 0							;front iter
	mov edi, lengthOf Sequence - 1		;back iter
	mov eax, lengthOf Sequence
	mov bl, 2
	div bl
	mov ah, 0
	mov ecx, eax			;esi = (lengthOf Sequence) div 2

	Swap:
		mov eax, Sequence[esi * 4]
		xchg Sequence[edi * 4], eax	
		mov Sequence[esi * 4], eax

		inc esi
		dec edi
	cmp edi, ecx
		jb Swap
	ret
Reverse ENDP


Comment /* Writes Sequence separated with white space. */
WriteSequence PROC USES eax edx edi
	mov esi, 0		;iter

	WriteDown:
		mov eax, Sequence[esi * 4]
		call WriteInt
		mov al, ' '
		call WriteChar
		inc esi
	cmp esi, lengthOf Sequence
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