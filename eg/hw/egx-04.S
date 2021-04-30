	# A code excerpt to illustrate NASM vs GAS
	# GAS version
	
	.code16
	
	movb $0x1, %al
	movw $0x2, %ax
	movl $0x3, %eax
