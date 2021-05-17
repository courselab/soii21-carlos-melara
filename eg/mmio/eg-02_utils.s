	.file	"eg-02_utils.c"
	.code16gcc
	.text
	.globl	print
	.type	print, @function
print:
.LFB0:
	.cfi_startproc
#APP
# 7 "eg-02_utils.c" 1
	           mov $47104 , %ax             ;           mov %ax, %ds                ;           mov  $0x0, %ax               ;           mov  $0x0, %di               ;           mov  $0x0, %bx               ; movw %cx, %es; loop5:                                 ;           movb %es:(%di), %al   ; hlt;           cmp $0x0, %al                ;           je end5                      ;           movb %al,  (%bx,%di)       ;           movb $2, 1(%bx,%di)     ;           inc %bx                      ;           inc %di                      ;           jmp loop5                    ; end5:                                  ;           ret                           ; msg5:                                  ;           .string "Hello World"       ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	print, .-print
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
