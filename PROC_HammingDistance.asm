TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
.code

Comment /* Returns count of bits at which A and B are different in EAX. */
HammingDistance PROC USES ebx ecx  A, B
	mov eax, 0				;result
	mov ecx, 32				;loop

	mov ebx, A
	xor ebx, B
	Cyklus:
		shr ebx, 1
			jnc DoNotInc
		inc eax
		DoNotInc:
	loop Cyklus
	ret
HammingDistance ENDP


main PROC

	invoke HammingDistance, 11001000b, 10001111b

	call WriteInt
	call Crlf

	exit
main ENDP

END main