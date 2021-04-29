/*  Linker script file. */

OUTPUT_FORMAT(binary)		/* Output flat binary (no structure) */
SECTIONS
{
        . = 0x7C00;		/* Line counter is now 0x7c00. */
        .text : { *(.text) }	/* Copy input section .txt to the oputput. */
        . = 0x7c00 + 510;	/* Advance 510 bytes. */
}
