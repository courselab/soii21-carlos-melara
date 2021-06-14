/* Call syscall write in linux x86. */

#include <unistd.h>
#include <sys/syscall.h>

int main(void)
{
  syscall(4, 1, "hello, world!\n", 14);
  return 0;
}

