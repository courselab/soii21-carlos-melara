	.file	"eg-01.c"
	.intel_syntax noprefix
	.text
	.globl	main
	.type	main, @function
main:
	push	ebp
	mov	ebp, esp
	and	esp, -16
	call	foo
	mov	eax, 10
	leave
	ret
	.size	main, .-main
	.globl	foo
	.type	foo, @function
foo:
	push	ebp
	mov	ebp, esp
	nop
	pop	ebp
	ret
	.size	foo, .-foo
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
