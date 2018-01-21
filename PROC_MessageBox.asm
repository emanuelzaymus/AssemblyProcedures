TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

DialogBoxCaption DB "Hello, World!",0
DialogBoxText DB "Do you like this message box??",0

CaptionYES DB "NICE!",0
TextYES DB "I like it, too.",0Dh,0Ah,0

CaptionNO DB "Sadly...",0
TextNO DB "I am sorry about that.",0Dh,0Ah,0

.code

main PROC
	
	ShowMessage:
		INVOKE MessageBoxA, NULL, offset DialogBoxText, offset DialogBoxCaption, MB_YESNO or MB_ICONQUESTION

		cmp eax, 6
			je ShowOKText
		cmp eax, 7
			je ShowNOText
		Return:

	cmp eax, 4
		je ShowMessage

	exit

	ShowOKText:
		INVOKE MessageBoxA, NULL, offset TextYES, offset CaptionYES, MB_RETRYCANCEL or MB_ICONINFORMATION
	jmp Return

	ShowNOText:
		INVOKE MessageBoxA, NULL, offset TextNO, offset CaptionNO, MB_RETRYCANCEL or MB_ICONERROR
	jmp Return

main ENDP

END main