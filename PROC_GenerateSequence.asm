TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Sequence DD 20 dup (?)

.code

Comment /* Fills Sequence with random integers between -100 and 100. */
GenerateSequence PROC USES eax edi
	call Randomize
	mov edi, 0
	mov eax, 0
	Generate:
		mov eax, 201
		call RandomRange
		sub eax, 100
		mov Sequence[edi * 4], eax

		inc edi
		cmp edi, lengthOf Sequence
			jb Generate
	ret
GenerateSequence ENDP


main PROC

	call GenerateSequence

	mov edi, 0
	REPT lengthOf Sequence
		mov eax, Sequence[edi * 4]
		call WriteInt
		call Crlf
		inc edi
	ENDM

	exit
main ENDP

END main