TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

String DB "This is short sentence. :D",0Dh,0Ah,0
NewStr DB ?

.code

Comment /* Retrns offset of new substring in EDX. */
SubString PROC USES eax ebx ecx edi esi paOffSourceStr, paOffNewStr, paStartPos, paLength
	mov eax, paOffSourceStr
	mov edx, paOffNewStr
	mov esi, paStartPos			;starting position of new substring
	mov ecx, paLength			;length of new substring
	mov edi, 0

	Cycle:
		mov bl, [eax + esi]
		mov [edx + edi], bl

		inc esi
		inc edi
	loop Cycle
	ret
SubString ENDP


main PROC

	mov edx, offset String
	call WriteString

	invoke SubString, offset String, offset NewStr, 8, 14

	call WriteString
	call Crlf
	
	exit
main ENDP

END main