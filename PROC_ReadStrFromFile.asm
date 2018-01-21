TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

String DB 100 dup (?)
FilePath DB "File.txt",0

FileHandle DD ?
CountOfBytes DD ?

.code

Comment /* Returns offset of read string from FilePath. */
ReadStrFromFile PROC USES eax
	INVOKE CreateFileA, offset FilePath, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
	mov FileHandle, eax

	INVOKE ReadFile, FileHandle, offset String, sizeOf String, offset CountOfBytes, NULL

	INVOKE CloseHandle, FileHandle
	mov edx, offset String
	ret
ReadStrFromFile ENDP


main PROC

	call ReadStrFromFile

	call WriteString
	Call Crlf

	exit
main ENDP

END main