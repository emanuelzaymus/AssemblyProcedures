TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

String DB "String Analysis will count number of each char used in this string.",0

Chars DB 256 dup (?)
CountOfChars DD 256 dup (?)

.code

Comment /* Sorts String to ascending sequence. */
SortString PROC USES eax ebx edx edi esi paOffString, paStrLength
	mov edx, paOffString
	mov esi, paStrLength
	sub esi, 2					;last char is 0

	MainSortLoop:
		mov edi, 0					;iter for edx (paOffString)
		mov bl, 0					;bool wasSwap
		Sorting:					;chacks every two chars which are next to each other, if they are in wrong order it will swap them
			mov al, [edx + edi]
			inc edi
			cmp al, [edx + edi]
				jle IsSmaller
			xchg al, [edx + edi]
			dec edi
			mov [edx + edi], al
			inc edi
			mov bl, 1

			IsSmaller:
		cmp edi, esi
			jb Sorting
	cmp bl, 1						;if (wasSwap == 1) goto MainSortLoop
		je MainSortLoop
	ret
SortString ENDP


Comment /* Writes char analysis of string into Chars and CountOfChars. paOffString = sorted string */
StringAnalysis PROC USES eax ebx ecx edx edi esi ebp paOffString, paStrLength
	mov edx, paOffString
	mov esi, paStrLength	;length of string
	mov edi, 0				;iterator for edx (string)
	mov eax, 0				;al - actual char
	mov ebx, 0				;bl - previous char
	mov ecx, 0				;count for char
	mov ebp, 0				;iter for conteiners

	mov bl, [edx + edi]		;init previous char
	inc edi

	Analyse:
		mov al, [edx + edi]		;set actual char
		cmp al, bl
			je DoNotWrite

		mov Chars[ebp], bl
		mov CountOfChars[ebp * 4], ecx
		mov ecx, 0
		inc ebp
		mov bl, al			;set previous char

		DoNotWrite:
		inc ecx				;inc count of char
		inc edi
	cmp edi, esi
		jb Analyse

	ret
StringAnalysis  ENDP


Comment /* Prints string analysis from Chars and CountOfChars. */
PrintAnalysis PROC USES eax esi
	mov esi, 0
	mov eax, 0

	Print:
		cmp CountOfChars[esi * 4], 0
			je Stop
		mov al, Chars[esi]
		call WriteChar
		mov al, '='
		call WriteChar
		mov eax, CountOfChars[esi * 4]
		call WriteDec
		call Crlf

		inc esi
	jmp Print

	Stop:
	ret
PrintAnalysis ENDP


main PROC

	mov edx, offset String
	call WriteString
	call Crlf

	invoke SortString, offset String, lengthOf String
	invoke StringAnalysis, offset String, lengthOf String
	call PrintAnalysis

	exit
main ENDP

END main