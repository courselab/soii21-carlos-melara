
#include <eg-09.h>

void __attribute__((naked)) _start()
{
  
  write_str ("Hello World");

  halt();
}


