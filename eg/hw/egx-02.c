


void __attribute__ ((naked)) foo ()
{

  register int al __asm__  ("al");
  register int ah __asm__  ("ah");

  al = 0x42;
  ah = 0x43;
  
}











