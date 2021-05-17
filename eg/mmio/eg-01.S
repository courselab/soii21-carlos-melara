	/* Prints one character in video display memory.

	   Bug fixed.
	*/

	
  .code16

__start:
	mov $0, %ax
	mov %ax, %es
	
        mov $0xb800, %ax           /* Color display memory. */
        mov  %ax, %ds              /* Set data segement.    */
	movb %es:msg, %al
        movb %al, (%di)           /* Write a character.    */
        movb $0x20, 1(%di)	   /* Apply attribute.      */

msg:
	.string "Hello World"
	
halt:
	hlt
	jmp halt


	/*

	Notes.

	Here we use the extra segment register to read from the correct
	memory position, and the data segement to write to video display
	memory.
	
	
	*/
