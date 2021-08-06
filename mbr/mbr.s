	.file	"mbr.c"
	.code16gcc
	.text
	.globl	nl
	.data
	.type	nl, @object
	.size	nl, 3
nl:
	.string	"\r\n"
	.text
	.globl	print
	.type	print, @function
print:
.LFB0:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 33 "mbr.c" 1
	        mov   $0x0e, %ah           ;        mov   $0x0, %si            ;loop7:                             ;        mov   (%bx, %si), %al    ;        cmp   $0x0, %al            ;        je    end7                 ;        int   $0x10                 ;        add   $0x1, %si            ;        jmp   loop7                ;end7:                              ;        ret                         ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	print, .-print
	.globl	clear
	.type	clear, @function
clear:
.LFB1:
	.cfi_startproc
#APP
# 58 "mbr.c" 1
	 mov $0x0600, %ax                 ; mov $0x07, %bh                   ; mov $0x0, %cx                    ; mov $0x184f, %dx                 ; int $0x10                         ; ret                                
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE1:
	.size	clear, .-clear
	.globl	read
	.type	read, @function
read:
.LFB2:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 83 "mbr.c" 1
	   mov $0x0, %si               ;loop27:                         ;   movw $0X0, %ax              ;   int $0x16                    ;   movb %al, %es:(%bx, %si) ;   inc %si                     ;   cmp $0xd, %al               ;   mov   $0x0e, %ah            ;   int $0x10                    ;   jne loop27                   ; mov $0x0e, %ah                ; mov $0x0a, %al                ;   int $0x10                    ;   movb $0x0, -1(%bx, %si)    ;   ret                           
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE2:
	.size	read, .-read
	.globl	date
	.type	date, @function
date:
.LFB3:
	.cfi_startproc
#APP
# 118 "mbr.c" 1
			mov	$0x04, %ah                 ;		int 	$0x1a                       ;		mov	$0x0e, %ah                 ;		mov	%ch, %al                  ;		shr	$4, %al                    ;		add	$48, %al                   ;		int	$0x10                       ;		mov	%ch, %al                  ;		and	$15, %al                   ;		add	$48, %al                   ;		int	$0x10                       ;		mov	%cl, %al                  ;		shr	$4, %al                    ;		add	$48, %al                   ;		int	$0x10                       ;		mov	%cl, %al                  ;		and	$15, %al                   ;		add	$48, %al                   ;		int	$0x10                       ;		mov	$45, %al                   ;		int	$0x10                       ;		mov	%dh, %al                  ;		shr	$4, %al                    ;		add	$48, %al                   ;		int	$0x10                       ;		mov	%dh, %al                  ;		and	$15, %al                   ;		add	$48, %al                   ;		int	$0x10                       ;		mov	$45, %al                   ;		int	$0x10                       ;		mov	%dl, %al                  ;		shr	$4, %al                    ;		add	$48, %al                   ;		int	$0x10                       ;		mov	%dl, %al                  ;		and	$15, %al                   ;		add	$48, %al                   ;		int	$0x10                       ;
# 0 "" 2
#NO_APP
	movl	$nl, %ecx
	call	print
#APP
# 165 "mbr.c" 1
	ret
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE3:
	.size	date, .-date
	.globl	compare
	.type	compare, @function
compare:
.LFB4:
	.cfi_startproc
	movl	%ecx, %ebx
	movl	%edx, %edi
	movl	%ebx, %esi
#APP
# 173 "mbr.c" 1
	    mov $4, %cx   ;    mov $0x1, %ax     ;    cld                ;    repe  cmpsb        ;    jecxz  equal       ;    mov $0x0, %ax     ;equal:                 ;    ret                ;
# 0 "" 2
#NO_APP
	movl	$0, %eax
	ud2
	.cfi_endproc
.LFE4:
	.size	compare, .-compare
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
