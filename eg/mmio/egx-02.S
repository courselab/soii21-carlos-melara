	/* Auxiliary example:

	   Write a character onto video display memory using
	   lnear memory in x86-emulated real mode.
	
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

	mov  $0xb8000, %edi        /* Load video memory address into %edi. */
        movb $'A',  (%edi)         /* Write a character into %es:edi       */
        movb $0x20, 1(%edi)	   

halt:
	hlt
	jmp halt


/*
	Notes.

	Original i8086 architecture did not have 32-bit di (edi) register.
	The only way to reach b800:0000 begin at %ds=0 would be to load
	0xb800 into %ds or %es.

	Wen we boot a modern x86 nowadasy, it emulates an i8086 hardware
	but its still an i386 CPU. A 32-bit %edi register does exists
	and the emulation allow us to load 32-bit values into it. The
	segments %ds and %es wtill work, though.

	It is therefore one may take advantage of this to access memory
	beyond the scope of the current 64k segment. That said, this is
	not portable to original i8086 and, arguably, in a strict sense
	not plain 16-bit real-mode programming.

*/	
