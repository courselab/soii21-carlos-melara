
#ifndef TOS_H
#define TOS_H

#define VIDEO_MEMORY 0xb8000
#define VIDEO_ATTRIBUTE 0X02

/* Print string str on standard output. */

void __attribute((naked, fastcall)) print (const char *str);

/* Print string str on standard output, with a newline. */

extern char nl[];

#define printnl(str) do{print(str); print (nl);}while(0)

/* Clear the screen. */

void __attribute__((naked, fastcall)) clear (void);

/* Read standard input into buffer. */

void __attribute__((naked, fastcall)) read (char *buffer);

/* Prints a help message. */

void __attribute__((naked)) help (void);

/* Compare to strings up to BUFFER_MAX_LENGTH-1. */

#define BUFFER_MAX_LENGTH 5

int __attribute__((fastcall, naked)) compare (char *s1, char *s2);

/* Quit. */

#define quit() printnl("Sorry...")

#define PROMPT ">"

/* Handy macros for (extended) inline assembly. */

#define PUSH_AX " push %%ax ;"
#define PUSH_BX " push %%bx ;"
#define PUSH_CX " push %%cx ;"
#define PUSH_DX " push %%dx ;"

#define PUSH_ES " push %%es ;"
#define PUSH_DS " push %%ds ;"

#define PUSH_DI " push %%di ;"
#define PUSH_SI " push %%si ;"

#define PUSH_REGS PUSH_AX PUSH_BX PUSH_CX PUSH_DX PUSH_DI PUSH_SI
#define PUSH_SEG_REGS PUSH_DI PUSH_SI 


#define POP_AX " pop %%ax ;"
#define POP_BX " pop %%bx ;"
#define POP_CX " pop %%cx ;"
#define POP_DX " pop %%dx ;"

#define POP_ES " pop %%es ;"
#define POP_DS " pop %%ds ;"

#define POP_DI " pop %%di ;"
#define POP_SI " pop %%si ;"

#define POP_REGS POP_SI POP_DI POP_DX POP_CX POP_BX POP_AX
#define POP_SEG_SEGS POP_SI POP_DI

#endif
