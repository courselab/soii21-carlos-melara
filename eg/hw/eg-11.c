/* Boot, say hello and halt. 
   A source code with a familiar C look.
*/

#include <eg-11.h>

int __attribute__((naked)) main ()
{
  
  puts ("Hello World!\n\r");
  puts ("We're good ain't we?");

  exit (0);
}


/* Notes

   Cool, ain't it?

 */
