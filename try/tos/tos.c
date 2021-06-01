
#include <tos.h>


int main()
{
  char b[10];
  
  clear();

  while (1)
    {
  
      print (PROMPT);

      read (b);
      
      if (compare(b, "help"))
	help();
      else if (compare(b, "quit"))
	quit();
      else
	{
	  print (b);
	  printnl (": command not found.");
	}
    }
  
  return 0;

}
