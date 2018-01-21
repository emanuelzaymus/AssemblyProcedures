TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

.code

Comment /* Returns the greatest common divisor of A and B in EAX. */
GCD PROC USES edx A, B
	DivideNumbers:				;Euclidean algorithm
		cmp B, 0				;while (B != 0) {
			je StopDivision
		push B					;	C = B

		mov eax, A
		cdq
		idiv B
		mov B, edx				;	B = A mod B

		pop A					;	A = C
	jmp DivideNumbers			;}

	StopDivision:
		mov eax, A
	ret
GCD ENDP

main PROC

	invoke GCD, 68524, 683924

	call WriteInt
	call Crlf

	exit
main ENDP

END main