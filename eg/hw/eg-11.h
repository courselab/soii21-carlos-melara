#ifndef EG_08_H
#define EG_08_H

/* A function-which prints pointed by str using BIOS' int 0x10 service. 

   Differently from eg-09.h's macro version, this function accepts 
   either a pointer to labeled string or an anonimous pointer for 
   a quoted literal string.

   This function clobbers eax, ebx, ecx and esi.

 */

void __attribute__((fastcall, naked))  puts(const char* s);

/* An exit function. */

void __attribute__((fastcall, naked))  exit(const char* s);




#endif

/* Notes.

   Note the combination \n\t to split lines in a multi-line assembly 
   source code. This is because assemblers read LF-terminated lines
   and normally indent the next line with a tab character.
*/
