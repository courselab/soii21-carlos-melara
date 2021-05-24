
#include <eg-02.h>

void __attribute__((naked, fastcall)) print (const char *str)
{

  __asm__ volatile
    (
     "           mov %[vid] , %%ax             ;"
     "           mov %%ax, %%es                ;"
     "           mov  $0x0, %%ax               ;"
     "           mov  $0x0, %%di               ;"
     "           mov  $0x0, %%bx               ;"
     " loop%=:                                 ;"
     "           movb msg%=(%%di), %%al   ;"
     "           cmp $0x0, %%al                ;"
     "           je halt%=                     ;"
     "           movb %%al,  %%es:(%%bx,%%di)  ;"
     "           inc %%bx                      ;"
     "           movb %[attr], %%es:(%%bx,%%di);"
     "           inc %%di                      ;"
     "           mov %%bx, %%di                ;"
     "           jmp loop%=                    ;"
     " halt%=:                                 ;"
     "           hlt                           ;"
     "           jmp halt%=                    ;"
     " msg%=:                                  ;"
     "           .string \"Hello World\"       ;"
     :
     :  [vid]  "n"  (VIDEO_MEMORY >> 4),
	[attr] "n"  (VIDEO_ATTRIBUTE)
     );




}

/* Notes

   Here we use %%es to acess video memory, while keeping in %ds the
   value set by rt0 startup code.

 */
