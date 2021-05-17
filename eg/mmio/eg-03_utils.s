	.file	"eg-03_utils.c"
	.code16gcc
	.text
	.globl	print
	.type	print, @function
print:
.LFB0:
	.cfi_startproc
	movl	%ecx, %eax
	movl	$753664, %esi
	movl	$0, %ebx
	jmp	.L2
.L3:
	movl	%ebx, %edx
	addl	%eax, %edx
	movzbl	(%edx), %edx
	movsbw	%dl, %dx
	leal	512(%edx), %ecx
	movl	%ebx, %edx
	addl	%edx, %edx
	addl	%esi, %edx
	movw	%cx, (%edx)
	addl	$1, %ebx
.L2:
	movl	%ebx, %edx
	addl	%eax, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	jne	.L3
	nop
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	print, .-print
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
