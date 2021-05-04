
#include <eg-10.h>

void __attribute__((naked)) _start()
{
  
  write_str ("Hello World");

  halt();
}


