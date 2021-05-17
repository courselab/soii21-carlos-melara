/*  Linker script for MBR. */

OUTPUT_FORMAT(binary)		/* Output flat binary (no structure) */
SECTIONS
{
        . = 0x7C00;		/* Line counter is now 0x7c00. */
        .text :
	{
	  *(.text)              /* Copy input section .text to the oputput. */
	  *(.rodata)		/* Copy input section .rodata to the output. */
	}	
        . = 0x7c00 + 510;	/* Advance 510 bytes. */
        .signature : 		/* Add a signadure section with this content. */
	{
	    BYTE(0x55)
            BYTE(0xAA)
        }
	. = ALIGN(0x1000) + 0x10000; /* Move 64 KB above,  aligned.  */
	__END_STACK__ = 0x7e10;	 /* Stack end (used by _start). */
}




