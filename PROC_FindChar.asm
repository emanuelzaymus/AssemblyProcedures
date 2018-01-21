TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

String DB "This is short sentence. :D",0Dh,0Ah,0

.code

Comment /* Returns position of the first found char in string in EAX else returns -1. */
FindChar PROC USES ecx esi paOffSourceStr, paChar
	mov eax, paOffSourceStr
	mov ch, BYTE ptr paChar
	mov esi, 0					;iter for eax (paOffSourceStr)

	Search:
		mov cl, [eax + esi]		;cl - compared char
		cmp ch, cl
			je Found
		inc esi
	cmp cl, 0
		jne Search
	
	mov eax, -1
	ret

	Found:                  
		mov eax, esi
		ret
FindChar ENDP


main PROC

	invoke FindChar, offset String, 's'

	call WriteInt
	call Crlf
	
	exit
main ENDP

END main