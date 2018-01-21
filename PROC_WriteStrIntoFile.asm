TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

String DB "Hello, World!!!",0Dh,0Ah
FilePath DB "File.txt",0

FileHandle DD ?
CountOfBytes DD ?

.code

Comment /* Writes String into FilePath. */
WriteStrIntoFile PROC USES eax
	INVOKE CreateFileA, offset FilePath, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
	mov FileHandle, eax

	INVOKE WriteFile, FileHandle, offset String, sizeOf String, offset CountOfBytes, NULL

	INVOKE CloseHandle, FileHandle
	ret
WriteStrIntoFile ENDP


main PROC

	call WriteStrIntoFile
	
	exit
main ENDP

END main