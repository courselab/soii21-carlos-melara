	/* Auxiliary example:

	   Write a character onto video display memory using the
	   real-mode segemented memory model.
	
	*/

	
	.code16
	
_start:

     /* Initialize segement registers. */ 

        xorw %ax, %ax                 
        movw %ax, %ds                 /* Zero data segment.    */
        movw %ax, %es                 /* Zero extra segment.   */
        movw %ax, %fs                 /* Zero extra segment 2. */
        movw %ax, %gs                 /* Zero extra segment 3. */
        movw %ax, %ss                 /* Zero stack segment.   */

     /* Initialize the stack pointer. */
	
        mov $__END_STACK__, %sp      /* Setup stack */

	
	movw $0xb800, %ax
	movw %ax, %es            /* Load video ram address into %es */
	movb $'A',   %es:(%di)   /* Write character into %es:%di    */
	movb $0x20,  %es:1(%di)

halt:
	hlt
	jmp halt
