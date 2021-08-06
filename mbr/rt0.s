	.file	"rt0.c"
	.code16gcc
	.text
	.globl	_start
	.type	_start, @function
_start:
.LFB0:
	.cfi_startproc
#APP
# 29 "rt0.c" 1
	        xorw %ax, %ax                ;        movw %ax, %ds                ;        movw %ax, %es                ;        movw %ax, %fs                ;        movw %ax, %gs                ;        movw %ax, %ss                ;        mov $__END_STACK__, %sp     ;        call main                     ; loop5:                              ;        hlt                           ;        jmp loop5                    
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	_start, .-_start
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
