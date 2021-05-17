
#include <eg-02.h>

void __attribute__((naked, fastcall)) print (const char *str)
{

    __asm__ volatile
    (
     "           mov %[vid] , %%ax             ;"
     "           mov %%ax, %%ds                ;"
     "           mov  $0x0, %%ax               ;"
     "           mov  $0x0, %%di               ;"
     "           mov  $0x0, %%bx               ;"
     " movw %%cx, %%es;"

     " loop%=:                                 ;"
     "           movb %%es:(%%di), %%al   ;"
          " hlt;"
     "           cmp $0x0, %%al                ;"
     "           je end%=                      ;"
     "           movb %%al,  (%%bx,%%di)       ;"
     "           movb %[attr], 1(%%bx,%%di)     ;"
     "           inc %%bx                      ;"
     "           nc %%di                      ;"
     //"           mov %%bx, %%di                ;"
     "           jmp loop%=                    ;"
     " end%=:                                  ;"
     "           ret                           ;"
     " msg%=:                                  ;"
     "           .string \"Hello World\"       ;"
     :
     :  [vid]  "n"  (VIDEO_MEMORY >> 4),
	[attr] "n"  (VIDEO_ATTRIBUTE)
     : "ax", "bx", "di"
     );




}
