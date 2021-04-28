/* Like eg-02.c but with functions implemented after main(). */

int main ()
{
   int a,b;
   a = foo(10);
   b = bar(20);
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

