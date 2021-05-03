#ifndef EG_08_H
#define EG_08_H

#define write_str(str) __asm__\
("\
	movw  $0x0e00, %ax     \n \
	movw  $0x0, %bx        \n \
loop:			       \n \
	andw  $0xff00, %ax     \n \
	movw  msg(%bx), %dx    \n \
	andw  $0x00ff, %dx     \n \
	orw   %dx, %ax         \n \
	int   $0x10	       \n \
	cmp   $0x0, %dx	       \n \
	je    go               \n \
	add   $0x1, %bx	       \n \
	jmp   loop	       \n \
    go:                        \n \
")

#define halt() __asm__\
  ("\
  halt:               \n\
	hlt           \n\
	jmp   halt    \n\
  ")


#endif
