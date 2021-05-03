
#include <eg-08.h>

extern const char msg[];

 
void __attribute__((naked)) _start()
{
  
  write_str(msg);

  halt();
}

/*  The string, with a hack to allocate it in the same code section. */

const char msg[]  = "Hello world";





