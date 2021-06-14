/* Call write (works with x86 and x86_64. */

#include <unistd.h>

int main ()
{
  write (1, "Hello world!\n", 13);
  
  return 0;
}
