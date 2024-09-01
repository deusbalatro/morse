SECTION .data

	morse_table	db	".-", 0, "-...", 0, "-.-.", 0, "-..", 0, ".", 0, "..-.", 0, "--.", 0, "....", 0
			db	"..", 0, ".---", 0, "-.-", 0, ".-..", 0, "--", 0, "-.", 0, "---", 0, ".--.", 0
			db	"--.-", 0, ".-.", 0, "...", 0, "-", 0, "..-", 0, "...-", 0, ".--", 0, "-..-", 0, "-.--", 0
			db	"--..", 0

	morse_index	db	0, 3, 8, 13, 17, 19, 24, 28, 33, 36, 41, 45, 50, 53, 56, 60, 65, 70
			db	74, 78, 80, 84, 89, 93, 98, 103

	string		db	'CHANGE THIS DATA. I am ADDING unKNOWN ÇHARS', 0h

	spaceChar	db	' / ', 0h

	unknownChar	db	'?', 0h

SECTION .text
	global	_start

_start:
	mov	esi,	string

starting:
	xor	eax,	eax
	lodsb
	cmp	eax,	0
	je	exit						; if it is null, it means no any char to encode and print
	cmp	eax,	20h
	je	wordSpace					; if the input char is space, print " / "
	cmp	eax,	5Ah
	jg	unknown
	cmp	eax,	41h
	jl	unknown
	mov	ecx,	40h
	idiv	ecx

	mov	eax,	edx					; move the remainder into the eax

	movzx	ebx,	byte [morse_index+edx-1]		; Find the index

	xor	ecx,	ecx

repeatChar:
	inc	ecx
	movzx	edx,	byte [morse_table+ebx+ecx-1]		; Find the morse letter according to index
	cmp	edx,	0
	je	printML
	push	edx						; push DX (holds a char in morse letter) onto the stack
	jmp	repeatChar					; repeat the process until we reach the 0 (so for example, for B, we will have ...- onto the stack)

printML:							; Morse letter print loop
	dec	ecx
	cmp	ecx,	0					; compare counter
	je	letterSpace					; if counter 0, print a space

	lea	eax,	[esp+ecx*4-4]				; The stack address is manipulated, otherwise it would print the chars in reverse order
	push	ecx

	mov	edx,	1					; printing process
	mov	ecx,	eax
	mov	ebx,	1
	mov	eax,	4
	int	0x80

	pop	ecx						; bring back the counter

	jmp	printML						; repeat the process until CX is 0

letterSpace:							; printing a space after every morse letter
	mov	eax,	20h
	push	eax

	mov	edx,	1
	mov	ecx,	esp
	mov	ebx,	1
	mov	eax,	4
	int	0x80

	jmp	starting

wordSpace:							; printing a slash between 2 space after every morse word
	mov	eax,	spaceChar
	push	eax

	mov	edx,	3
	mov	ecx,	spaceChar
	mov	ebx,	1
	mov	eax,	4
	int	0x80

	jmp	starting

unknown:
	mov	edx,	1
	mov	ecx,	unknownChar
	mov	ebx,	1
	mov	eax,	4
	int	0x80

	jmp	starting

exit:								; We simply feed a line just before exit

	mov	eax,	0Ah
	push	eax
	mov	edx,	1
	mov	ecx,	esp
	mov	ebx,	1
	mov	eax,	4
	int	0x80

	mov	eax,	1
	int	0x80
