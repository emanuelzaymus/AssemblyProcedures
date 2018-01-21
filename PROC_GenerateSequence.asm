TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Sequence DD 20 dup (?)

.code

Comment /* Fills Sequence with random integers between paBottom and paTop. */
GenerateSequence PROC USES eax edi paBottom, paTop
	call Randomize
	mov edi, 0						;iter for Sequence
	mov eax, 0						;generated number
	mov ebx, paTop
	sub ebx, paBottom
	inc ebx							;ebx - range for generating <0, paTop - paBottom + 1>

	Generate:
		mov eax, ebx
		call RandomRange				;eax = number from <0, ebx>
		add eax, paBottom				;shift eax to <paBottom, paTop>
		mov Sequence[edi * 4], eax

		inc edi
		cmp edi, lengthOf Sequence
			jb Generate
	ret
GenerateSequence ENDP


main PROC

	invoke GenerateSequence, -1000, 1000

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