/* Call syscall write in linux x86_64. */

#include <unistd.h>
#include <sys/syscall.h>

int main(void)
{
  syscall(1, 1, "hello, world!\n", 14);
  return 0;
}

