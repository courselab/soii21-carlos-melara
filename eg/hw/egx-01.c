/* egx-04.c - Auxiliary example source. */

void __attribute__((naked)) foo()
{
  register char bar __asm__("eax");

  bar = 42;

  __asm__("hlt");
  
}
