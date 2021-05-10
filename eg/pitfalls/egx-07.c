
void __attribute__((naked)) foo()
{
  __asm__("mov $0x42, %%al" :::);
}

