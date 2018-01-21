TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Set DB 32 dup (?)

.code

Comment /* Returns effective set in EAX where each 1 represents one element with value of its order <0-31>. */
GenerateEffectiveSet PROC USES ebx ecx edx
	mov edx, 0			;result
	mov ecx, 10			;count for loop Generate

	call Randomize
	Generate:
		mov eax, 32
		call RandomRange
		push ecx

		mov ebx, 1
		mov cl, al
		shl ebx, cl		;shift '1' in ebx left by cl
		or edx, ebx

		pop ecx
	loop Generate
	mov eax, edx
	ret
GenerateEffectiveSet ENDP


Comment /* Writes effective set in EAX where each 1 represents one element with value of its order <0-31>. */
WriteEffectiveSet PROC USES eax edx edi
	mov edi, 0			;iter for edx (set)
	mov edx, eax		;set

	CheckBit:
		mov eax, edx
		and eax, 1			;if last bit is 1 it will write its position
			jz DoNotWrite
		mov eax, edi
		call WriteDec
		call Crlf

	DoNotWrite:
		shr edx, 1			;shift right whole set
		inc edi
	cmp edi, 32
		jne CheckBit
	ret
WriteEffectiveSet ENDP


Comment /* Convetrs effective set in EAX into Set. */
ConvertEffectiveSet PROC USES eax ebx edx edi
	mov bl, 0				;iter for edx (Set)
	mov edi, 0				;iter for Set
	mov edx, eax			;Set

	CheckBit:
		mov eax, edx
		and eax, 1
			jz DoNotConvert
		mov Set[edi], bl
		inc edi

	DoNotConvert:
		shr edx, 1
		inc bl
	cmp bl, 32
		jne CheckBit
	ret
ConvertEffectiveSet ENDP


main PROC

	call GenerateEffectiveSet
	call WriteEffectiveSet
	call ConvertEffectiveSet

	exit
main ENDP

END main