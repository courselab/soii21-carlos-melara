
#include <eg-03.h>

void __attribute__((naked, fastcall)) print (const char *str)
{

  short *video = (short *) VIDEO_MEMORY;
  int i = 0;
  
  while (str[i])
    {
      video[i] = (VIDEO_ATTRIBUTE << 8) + str[i];
      i++;
    }


}
