
  .code16

__start:	
        mov $0xb800, %ax           /* Color display memory. */
        mov  %ax, %ds              /* Set data segement.    */
        movb $'A', (%di)           /* Write a character.    */
        movb $0x20, 1(%di)	   /* Apply attribute.      */

msg:
	.byte 'A'
	
halt:
	hlt
	jmp halt
