TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
.code

Comment /* Returns count of bits at which A and B are different in EAX. */
HammingDistance PROC USES ebx edi  A, B
	mov eax, 0
	mov edi, 0

	mov ebx, A
	xor ebx, B
	Cyklus:
		shr ebx, 1
			jnc DoNotInc
		inc eax
		DoNotInc:

		inc edi
		cmp edi, 32
			jl Cyklus
	ret
HammingDistance ENDP


main PROC

	invoke HammingDistance, 11001000b, 10001111b

	call WriteInt
	call Crlf

	exit
main ENDP

END main