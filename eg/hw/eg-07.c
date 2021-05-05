/* Boot, say hello and halt. 
   Improved code using linker script.
*/

extern const char msg[];


void __attribute__((naked)) _start()
{

  /* Force variables to be allocated in registers rather
     than in RAM, as usual. */
  
  register short ax __asm__("ax"); /* Variable ax is register ax. */
  register short bx __asm__("bx"); /* Variable bx is register bx. */

  ax = 0x0e00;	       /* Store 0xe in ah, we don't care about al.*/

  bx = 0x0;	       /* Zero-initilize bx. */

  do
    {

      /* Gimmick to put msg[bx] in al. */
      
      ax = (ax & 0xff00) | (msg[bx] & 0x00ff);

      /* This is output as is in the assembly. */

      __asm__ ("int $0x10");	/* Call BIOS. */

      bx = bx + 1;
      
    }
  while ( (ax & 0x00ff) != 0  ); /* Do while al != 0. */

    while (1)
      __asm__("hlt");		/* Halt with safeguard. */
}

/*  The string. */

const char msg[]  = "Hello world";



