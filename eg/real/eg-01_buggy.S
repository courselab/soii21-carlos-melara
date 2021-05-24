	/* Here we are taking steps to print a string.

	   This code won't work. Can you spot the bug?

	*/	
	
  .code16

__start:


	
        mov $0xb800, %ax           /* Color display memory. */
        mov  %ax, %ds              /* Set data segement.    */
	movb msg, %al              /* Read byte at msg.     */
        movb %al, (%di)            /* Write a character.    */
        movb $0x20, 1(%di)	   /* Apply attribute.      */

msg:
	.string "Hello World"
	
halt:
	hlt
	jmp halt


	/*

	Notes.

	Try to identify the problem before reading this note.

	Ok, here we go.

	We load 0xb800 into %ds so we can write the charcter to memory position

           DS:DI b800:DI

	and the line

	   movb %al, (%di)

	can correctly store the content of %al into the memory position given by
	0xb8000 + %di.  So far so good.

	The problem is that the line

	  mov msg, %al

	is also affected by the value we've stored in the data segment DS.
	Its result is actually


	  mov %cs:msg, %al


	We're therefore not reaching the string, but something else at position
	b8000 + msg.
	
	*/
