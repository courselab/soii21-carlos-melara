

/* Prints one character in video display memory. 

   This there is a problem here. */



void _start()
{

    __asm__ volatile
    (
     "           mov %[vid] , %%ax             ;"
     "           mov %%ax, %%ds                ;"
     "           mov  $0x0, %%ax               ;"
     "           mov  $0x0, %%di               ;"
     "           mov  $0x0, %%bx               ;"
     " loop%=:                                 ;"
     "           movb %%es:msg%=(%%di), %%al   ;"
     "           cmp $0x0, %%al                ;"
     "           je halt%=                     ;"
     "           movb %%al,  (%%bx,%%di)       ;"
     "           inc %%bx                      ;"
     "           movb %[attr], (%%bx,%%di)     ;"
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

