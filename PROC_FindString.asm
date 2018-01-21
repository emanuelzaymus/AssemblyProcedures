TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

String DB "This is sshort sentence. :D",0Dh,0Ah,0
Searched DB "short",0

.code

Comment /* Returns position of the first found substring in string in EAX. */
FindString PROC USES ebx ecx edx edi esi paOffSourceStr, paOffSearched
	mov eax, paOffSourceStr
	mov ebx, paOffSearched

	mov edi, 0			;iter of eax (paOffSourceStr)
	mov esi, 0			;iter of ebx (paOffSearched)
	mov edx, 0			;searched position

	Search:
		mov ch, [ebx + esi]			;set searched char
		cmp ch, 0
			je Found				;end - found

		mov cl, [eax + edi]			;set compared char
		cmp cl, 0
			je NotFound				;end - did not find

		cmp ch, cl					;compare searched and compared char
			je CharMatch			;inc esi
		cmp esi, 0
			je NoDecEdi
		dec edi						;return one loop
		NoDecEdi:
			mov esi, 0
			mov edx, edi			;set possibly found position
			inc edx					;it will by the next position
		RetCharMatch:
			inc edi
	jmp Search

	CharMatch:
		inc esi
	jmp RetCharMatch

	Found:
		mov eax, edx
		ret

	NotFound:
		mov eax, -1
		ret

FindString ENDP


main PROC

	invoke FindString, offset String, offset Searched

	call WriteInt
	call Crlf
	
	exit
main ENDP

END main