
/* A function-which prints pointed by str using BIOS' int 0x10 service. 

   We use fascall calling convention, which receives the argument in ecx.

   This function clobbers eax, ebx, ecx and esi.
*/


void __attribute__((fastcall, naked))  write(const char* s)
{
__asm__
(
"       movw  %cx, %bx             ;" /* Fascall receives arguments in ecx. */
"	movw  $0x0e00, %ax         ;" /* ah = 0xe, don't care about al. */
"	movw  $0x0, %si            ;" /* We have to use esi as the index. */
"loop:			           ;"
"	andw  $0xff00, %ax         ;" /* Zero al. */
"	movw  (%bx, %si), %dx    ;" /*  */
"	andw  $0x00ff, %dx         ;"
"	orw   %dx, %ax             ;"
"	int   $0x10	           ;"
"	cmp   $0x0, %dx	           ;"
"	je    go                   ;"
"	add   $0x1, %si	           ;"
"	jmp   loop	           ;"
"    go:                           "
 );
}

/* Notes.

   We used semicolon to split lines in this multi-line assembly code.
   Not all assemblers would work with that. Usual \n\t is likely more 
   portable, but since GAS allow it, this form may be more readable.

   We also use C comments freely, since cpp will get rid of them.

 */
