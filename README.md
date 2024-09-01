# LATIN TO MORSE ALPHABET ENCODER/CONVERTER/TRANSLATOR IN ASSEMBLY X86 (PROTOTYPE)

This program is written in Netwide Assembler syntax for Intel x86 Architecture.
It utilizes the 32-bit [Linux System Calls](https://syscalls32.paolostivanin.com/).
The program can be used for converting Latin Alphabet to the Morse Alphabet.

## The Tools Used

- [Nano Text Editor](https://nano-editor.org/)
- [Netwide Assembler](https://www.nasm.us/)
- [GNU Debugger](https://www.sourceware.org/gdb/)

## How to Run It?

If you are using Windows, you can use WSL. [Click here to learn how to install WSL in your system](https://learn.microsoft.com/en-us/windows/wsl/install).
If you are using a Unix-Like system, you do not need much if system calls are matching. Otherwise, you should modify the system calls.

1. `nasm -f elf morse.asm`
2. `ld -m elf_i386 morse.o -o morse` or `ld -m elf_i386 morse.asm`<sub>(the output file will be a.out)</sub>

The program will work when you open the output file.

## Without an OS

If you'd like to use the program without an OS but BIOS, you can use [Ralf Brown's Interrupt List](https://www.cs.cmu.edu/~ralf/files.html)

## What it does

Simply it gets a string and manipulates it. From there, finds the corresponding character sequence in morse alphabet of the bytes in this string from mapped data.
Then starts to print the characters.

[In morse alphabet](https://en.wikipedia.org/wiki/Morse_code), there are 2 sounds dit and dah. We use dot (".") for dit and dash ("-") for dah.
Also, in morse alphabet, every letter becomes split by space. And every word becomes split by slash ("/").

**Hello World in Morse**: .... . .-.. .-.. --- / .-- --- .-. .-.. -.. 


Since the program is a prototype of advanced version of itself, it does not get input from the console but the text you want to convert is hardcoded.
Also, it only converts uppercase English letters.

If you want to feed the program via console, you can add somethings like these:

```
SECTION .bss
input	resb	255	; adjust the 255
```

```
mov	edx,	255
mov	ecx,	input
mov	ebx,	0
mov	eax,	3
int	0x80
```

```
mov	esi,	input
```

In that way, the source index will be set as the bytes which are input from console.	


***Sources***
- [Intel 64 and IA-32 Architectures Software Developer Manuals](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- [32-Bit Linux System Calls Reference](https://syscalls32.paolostivanin.com/)
- [GNU Manuals](https://www.gnu.org/manual/manual.en.html)
- [NASM Manual](https://www.nasm.us/xdoc/2.16.03/nasmdoc.pdf)
- [Digital Computer Electronics](https://www.amazon.com/Digital-computer-electronics-Albert-Malvino/dp/0070398615)
