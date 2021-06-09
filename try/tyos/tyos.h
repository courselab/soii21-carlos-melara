/* mbr.h -  MbrCmd command
 
   Copyright (c) 2021, Monaco F. J. <monaco@usp.br>

   This file is part of SYSeg.

   SYSeg is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

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

/* Load stage 2 as a block. */

void load_stage2_block();


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
