/* Like eg-02.c but with functions implemented after main(). */

#include <eg-04.h>

int main ()
{
   int a,b;
   a = foo(1);
   b = bar(2);
   return a+b;
}

int foo(int x)
{
   return x+1;
}

int bar(int x)
{
   return x+2;
}
