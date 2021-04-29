
extern const char msg[];


void __attribute__((naked)) _start()
{
  register short ax __asm__("ax");
  register short bx __asm__("bx");

  ax = 0x0e00;

  bx = 0x0;

  do
    {
      ax = (ax & 0xff00) | (msg[bx] & 0x00ff);

      __asm__ ("int $0x10");

      bx = bx + 1;
      
    }
  while ( (ax & 0x00ff) != 0  );

    while (1)
      __asm__("hlt");
}

const char msg[] = "Hello world";




