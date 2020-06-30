	.file	"randomGenerator.c"
	.text
	.globl	generadorRandoms
	.type	generadorRandoms, @function
generadorRandoms:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	cmpl	$5, -36(%rbp)
	ja	.L2
	movl	-36(%rbp), %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L4(%rip), %rax
	movl	(%rdx,%rax), %eax
	movslq	%eax, %rdx
	leaq	.L4(%rip), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L4:
	.long	.L2-.L4
	.long	.L3-.L4
	.long	.L5-.L4
	.long	.L6-.L4
	.long	.L7-.L4
	.long	.L8-.L4
	.text
.L3:
	movl	$100, -20(%rbp)
	movl	$2000, -16(%rbp)
	jmp	.L2
.L5:
	movl	$150, -20(%rbp)
	movl	$400, -16(%rbp)
	jmp	.L2
.L6:
	movl	$12, -20(%rbp)
	movl	$20, -16(%rbp)
	jmp	.L2
.L7:
	movl	$700, -20(%rbp)
	movl	$100, -16(%rbp)
	jmp	.L2
.L8:
	movl	$950, -16(%rbp)
	movl	$1000, -20(%rbp)
	nop
.L2:
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	movl	%eax, %edx
	movl	-16(%rbp), %eax
	subl	-20(%rbp), %eax
	leal	1(%rax), %ecx
	movl	%edx, %eax
	cltd
	idivl	%ecx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %ecx
	movl	$1717986919, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -8(%rbp)
	movsd	-8(%rbp), %xmm0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	generadorRandoms, .-generadorRandoms
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
