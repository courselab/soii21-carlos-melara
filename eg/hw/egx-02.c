


void __attribute__ ((naked)) foo ()
{

  register int ah __asm__  ("ah");
  register int bx __asm__  ("bx");

  ah = 0x42;
  bx = 0x43;
  
}











