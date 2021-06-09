
#include <tyos.h>

void __attribute__((naked)) init()
{
  print ("Inited");


  /* Here we may call functions from tyos.c. */
  
  __asm__("hlt");
}

