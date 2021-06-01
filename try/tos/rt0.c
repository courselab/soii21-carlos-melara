
/* This symbol is defined in the linker script. */

extern void __END_STACK__;


#define _(...) # __VA_ARGS__ "\n\t"

/* This is our program's entry point. */

void __attribute__((naked)) _start()
{
  __asm__ volatile
    (

     /* BIOS is not guaranteed to initialize all segemnt registers.
	We therefore do it manually. */
     
     _(        xorw %%ax, %%ax                ) 
     _(        movw %%ax, %%ds                ) /* Zero data segment.    */
     _(        movw %%ax, %%es                ) /* Zero extra segment.   */
     _(        movw %%ax, %%fs                ) /* Zero extra segment 2. */
     _(        movw %%ax, %%gs                ) /* Zero extra segment 3. */
     _(        movw %%ax, %%ss                ) /* Zero stack segment.   */


     /* Configure the stack pointer. */
     
     _(        mov $__END_STACK__, %%sp     ) /* Setup stack */

     /* Call main. */

     _(        call main                     ) /* Call main */
     _( loop%=:                              ) /* Safeguard. */
     _(        hlt                           ) /* Halt. */
     _(        jmp loop%=                    )
     
     :::
     );
}

/* Notes.

   Our rt0 file is now C with inline asm.

 */
