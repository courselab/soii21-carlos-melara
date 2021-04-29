/*  A simple example to illustrate how GCC treats both
    32 and 16-bit codes. */

int __attribute__ ((naked)) foo ()
{
  return 42;
}

/* To improve readability, the attribute 'naked' is used to 
   prevent GCC from cluttering the object code with elements
   that are not necessary in a flat binary like ours. */

