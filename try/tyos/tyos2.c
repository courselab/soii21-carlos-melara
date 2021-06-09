
#include <tyos.h>

void __attribute__((naked)) init()
{
  print ("Inited");
  __asm__("hlt");
}

