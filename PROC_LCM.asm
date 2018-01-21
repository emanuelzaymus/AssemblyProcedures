TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

.code

Comment /* Returns the least common multiple of A and B in EAX. */
LCM PROC USES ebx A, B
	mov eax, A
	mov ebx, B
	mov edi, 1				;for multiplying eax

	cmp eax, ebx
		jge DoNotSwap
	xchg eax, ebx			;swap if A < B
	DoNotSwap:

	MultiplyGreater:
		push eax
		imul eax, edi		;eax = multiple

		cdq
		div ebx
		cmp edx, 0			;if (eax mov ebx == 0) goto ClmFound
			je ClmFound
		pop eax
		inc edi
	jmp MultiplyGreater

	ClmFound:
		pop eax
		imul eax, edi
	ret
LCM ENDP


main PROC

	invoke LCM, 3659, 1599

	call WriteInt
	call Crlf

	exit
main ENDP

END main