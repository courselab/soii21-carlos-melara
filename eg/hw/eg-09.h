#ifndef EG_08_H
#define EG_08_H

/* A function-which prints pointed by str using BIOS' int 0x10 service. 

   Differently from eg-09.h's macro version, this function accepts 
   either a pointer to labeled string or an anonimous pointer for 
   a quoted literal string.

   This function clobbers eax, ebx, ecx and esi.

 */

void __attribute__((fastcall, naked))  write_str(const char* s);


/* A function-like macro which halts the system. 
 
   This function takes no arguments and does not clobber registers.

*/

#define halt() __asm__\
("\
  halt:               \n\t\
	hlt           \n\t\
	jmp   halt    \n\t\
")


/* This register tells the CPU where the call instruction should
   leave the return address. More technically, this is the
   stack pointer but we'll go deeper into it opportunely. 

   LOAD_ADDRESS + 512 bytes + 16 bytes = 0x7e10

   Note:

   The header file is not necessarity the most appropriate place to add 
   code aimed at the assemlber (that will generate code). This should be 
   for preprocessor directives. We shall make a better job in the 
   examples which follow. */

__asm__("movl $0x7e10, %esp");


#endif

/* Notes.

   Note the combination \n\t to split lines in a multi-line assembly 
   source code. This is because assemblers read LF-terminated lines
   and normally indent the next line with a tab character.
*/
