
/* A function-which prints pointed by str using BIOS' int 0x10 service. 

   This function clobbers eax, ebx, ecx and esi.
*/


void __attribute__((fastcall, naked))  puts(const char* s)
{
__asm__ volatile
("\
        mov   %w[str], %%bx         \n\t\
	mov   $0x0e, %%ah           \n\t\
	mov   $0x0, %%si            \n\t\
loop%=:	          		    \n\t\
	mov   (%%bx, %%si), %%al    \n\t\
	int   $0x10	            \n\t\
	cmp   $0x0, %%al	    \n\t\
	je    end%=                 \n\t\
	add   $0x1, %%si	    \n\t\
	jmp   loop%=	            \n\t\
end%=:                              \n\t\
        ret                         \n\t\
"
:				      /* No ouptut parameters. */
: [str] "b" (s)	                      /* Var. s put in bx, referenced as str.*/
: "ax", "cx", "si"       	      /* Clobbred registers (bx is input).   */
 );
}



/* Notes.


 */
