/* A program made of a single compilation unity. */

int foo(int x)
{
   return x+1;
}

int bar(int x)
{
   return x+2;
}

int main ()
{
   int a,b;
   a = foo(10);
   b = bar(20);
   return a+b;
}
