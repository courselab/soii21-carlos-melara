
extern const char here[];


__asm__(".code16");         /* Set 16-bit code */


/* This will be our entry point */

void __attribute__ ((naked)) _start()           
{

  register int eax __asm__  ("eax");                                      
  register int ebx __asm__  ("ebx");                                      
                                                                                   
  eax = 0x0e00;                 /* Load 0xe into ah. */                            
                                                                                   
  ebx = 0x0;                    /* Offest to the string. */                        
                                                                                   
  do                            
    {                                                                              
      eax &= 0xffffff00;        /*     prepare for the next line   */              
      eax |= (char) here[ebx];  /*     mov al, BYTE [here + bx]    */              
      __asm__("int     $0x10"); /*     int 0x10                    */              
      ebx++;                    /*     add bx, 0x1                 */              
                                                                                   
    }                                                                              
  while ( (eax & 0x000000ff)   != 0x0);      /*  while(ah != 0x0)  */    
  
  while(1);

}

const char here[] __attribute__((section(".text#"))) = "Hello world";


__asm__(". = _start + 510");                /* Pad with zeros */
__asm__(".byte 0x55, 0xaa");                /* Boot signature  */



/*  Notes.

    The specification

       __attribute__((section(".text#")))

   for the array 'here' cause the compiler to place the string within
   the segment .text (code segment). 

   Hack clues: 

        Actually, __attribute__((section(.text))) causes gcc to output 

	.section .text,"a"

	Using .text# is a dirty workaround to comment out the trailing ",a".

 */
