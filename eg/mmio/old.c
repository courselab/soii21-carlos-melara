

/* Prints one character in video display memory. 

   C with inline assembly. */

void _start()
{

  __asm__  
    (
     ".code16                              ;"
     
     "           mov $0xb800, %ax          ;" /* Color display memory. */
     "           mov  %ax, %ds             ;" /* Set data segement.    */
     "           movb $'A', (%di)          ;" /* Write a character.    */
     "           movb $0x20, 1(%di)        ;"  /* Apply attribute.      */


     "halt:                                ;"
     "hlt                                  ;"
     "jmp halt                              "

     
     );


}

