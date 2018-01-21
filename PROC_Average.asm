TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Sequence DD 132, 159, 367, -16, 137, 6, 14, 67, 48, -3, 0, 98, -6549, 37, 842, -12, -63, 48, 1180, -1500, 9999
SequenceLength DD lengthOf Sequence
SequenceSum DD ?

.code

Comment /* Returns average value from Sequence in St(0). */
Average PROC USES eax ecx edi
	mov edi, 0					;iter for Sequence
	mov eax, 0					;sum of Sequence
	mov ecx, SequenceLength
	
	Count:								;counting SequenceSum
		add eax, Sequence[edi * 4]
		inc edi
	loop Count
	mov SequenceSum, eax

	fild SequenceSum
	fild SequenceLength
	fdiv
	ret
Average ENDP


main PROC

	call Average

	call WriteFloat
	call Crlf

	exit
main ENDP

END main