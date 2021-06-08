dnl  doc.m4 - Macros for document source files
dnl    
dnl  Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
dnl
dnl  This file is part of SYSeg. 
dnl
dnl  SYSeg is free software: you can redistribute it and/or modify
dnl  it under the terms of the GNU General Public License as published by
dnl  the Free Software Foundation, either version 3 of the License, or
dnl  (at your option) any later version.
dnl
dnl  SYSeg is distributed in the hope that it will be useful,
dnl  but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl  GNU General Public License for more details.
dnl
dnl  You should have received a copy of the GNU General Public License
dnl  along with .  If not, see <http://www.gnu.org/licenses/>.
dnl
dnl
divert(-1)

changequote(`[',`]')

define([DOCM4_PROJECT],[SYSeg])
define([DOCM4_REPOSITORY],[http://gitlab.com/monaco/syseg])
define([DOCM4_YEAR],[2001])
define([DOCM4_AUTHOR],[Monaco F. J.])
define([DOCM4_EMAIL]),[<monaco@usp.br>])

dnl A short head notice that can be used in the README file
dnl describing the contents of a directory.

define(DOCM4_DIR_NOTICE,
[
 The contents of this directory are part of DOCM4_PROJECT,
 copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR
 DOCM4_PROJECT is Free Software distributed under GNU GPL vr3.
 Further information: DOCM4_REPOSITORY
])

dnl Copyright notice for Makefiles
dnl
dnl Arguments:
dnl
dnl  $1  file name
dnl  $2  one-line brief description

define(DOCM4_HASH_HEAD_NOTICE,
[changecom(,)dnl
#   $1 - $2
#
#   Copyright (c) DOCM4_YEAR - DOCM4_AUTHOR DOCM4_EMAIL
#
#   This file is part of DOCM4_PROJECT.
#
#   DOCM4_PROJECT is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
changecom([#],[])
])

dnl Copyright notice for shell scripts that use # as comment mark.
dnl
dnl Arguments:
dnl
dnl  $1  full path to the shell
dnl  $2  file name
dnl  $3  one-line brief description

define(DOCM4_SHELL_HEAD_NOTICE,
#!$1
#
[DOCM4_HASH_HEAD_NOTICE($2,$3)]
)

define(DOCM4_FILE_NOTICE,
[
 This file is a derivative part of DOCM4_PROJECT,
 copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR
 DOCM4_PROJECT is Free Software distributed under GNU GPL vr3.
 Further information: DOCM4_REPOSITORY
])

define(DOCM4_HASH_FILE_NOTICE,
[changecom(,)dnl
## This file is a derivative worl of DOCM4_PROJECT,
## copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR.
## DOCM4_PROJECT is Free Software distributed under GNU GPL vr3.
## Further information: DOCM4_REPOSITORY
changecom([#],)
])

define([DOCM4_MAKE_BINTOOLS],
[changecom(,)dnl
# ------------------------------------------------------------
# The following excerpt of code was copied from Make Bintools,
# part of DOCM4_PROJECT, Copyright DOCM4_YEAR DOCM4_AUTHOR.
# Make-bintools is a collection of handy 'make' rules for
# inspecting and comparing the contents of source and object files.
# Further information: DOCM4_REPOSITORY

include(bintools.m4)
changecom([#],)dnl

# End of Make Bintools.
# -------------------------------------------------------------
])

define([DOCM4_UPDATE_AUTHOR_INFO],
[
  Please, do not forget to

    - fill in file AUTHORS with the pertinent information
    - edit heading comments in all source files with your data
])



##
## Bintools documentation
##
define([DOCM4_MAKE_BINTOOLS_DOC],
[
 
 BUILD INSTRUCTIONS
 

 * For buiding and inspecting, use
 

   make foo				     Build foo.

   make diss IMG=foo 			     Disassemble foo.

   	     	     			     Optionally,

					        ASM  = intel | att  (default)
						BIT  =    16 | 32   (default)

   make dump IMG=foo			     Show the raw contents of foo.
   
   make      			             build everything (or make all)

   make clean			             undo make all

   make diff foo bar baz		     Show graphical diff between files

   	     	     			     ASM and BIT variables apply


  * If any example involves the manipulation of a bootable image, use
  

   make run IMG=foo	             	     Test foo with the emulator.

   make iso IMG=foo	             	     build an iso9660 image with foo

   make stick IMG=foo STICK=/dev/sdX         make a bootable USB stick


   SHORTCUTS

   make foo/diss			     disassemble .text as 32-bit AT&T
   make foo/d				     same as foo/diss  (also bellow)

   make foo/diss intel|att		     disassemble as 32-bit Intel or AT&T
   make foo/diss 16|32			     disassemble as 16-bit or 32-bit
   make foo/diss intel|att 16|32	     disassemble as Intel|AT&T 16|32 bit
   make foo/diss 16|32 intel|att	     disassemble as Intel|AT&T 16|32 bit

   make foo/i16	       			     disassemble as Intel 16-bit
   make foo/i32	       			     disassemble as Intel 32-bit
   make foo/a16 or foo/16 		     disassemble as AT&T  16-bit
   make foo/a32	of foo/32       	     disassemble as AT&T  32-bit

   		   			     In all disassembly rules, a
					     trailing '*' means disassemble all
					     sections, e.g. foo/d* foo/16* ...

   make foo/dump			     show raw contents in hexadecimal

   make foo/run				     test foo with the emulator


 FILE NAMES

 Some examples allow alternative build recipes which can be selected
 by passing the command-line variable ALT=<number> to 'make'. See bellow. 

 File names:

     eg-00.ext		contain the main examples;
     egx-00.ext		contain auxiliary extra examples.

 File extensions:

     hex		ASCII file containing values
     			in hexadecimal representation;

     asm		manually written assembly code in
     			Intel ASM format;

     S			manually written assembly code
     			in AT&T Gas format;

     s			assembly code in AT&T Gas format
     			generated by the compiler (GCC);

     o			object code produced by the assembler;

     bin		binary file generated by the
     			compiler /linker;

     ld			linker script.



 NOTE ON BOOTING THE REAL HARDWARE

    If any example involves booting from a USB stick, mind following note.

    Unfortunately, not all BIOSes  handle USB boot devices in the same
    way (welcome to system level). Some are likely to emulate it as a floppy
    disk and rely on the original IBM PC boot method we are exploring here.
    If so, you should be able to prepare your stick using 'make stick'
    with the command line variable IMG=foo.bin. Otherwise, if your computer's
    BIOS emulates your USP stick as a CD-ROM, you should be better served
    by passing it the variable IMG=foo.iso.  See note (1) by the end.


 WORDS OF WISDOM

    If you plan to boot the examples in the physical hardware, check which
    device represents your USB stick. You may use, for instance lsblk utility.
    Your devices should possibly list as /dev/sdX, with X being a, b, c etc.

    If you have only one storage device, say your HD, it may appear as
    /dev/sda, and when you plug your USB stick, it'll take the next
    available letter and appears as /dev/sdb.  You should be required
    administrative privileges (sudo) to write directly into your device.

    Be careful: you're entering system-level. 

    If you misspell your stick as /dev/hda, you may end up grieving in
    pitiful misery and hopeless regrets... do not lower your guard.

    Note: in some systems, storage device may also appear as /dev/mmcblk;
    e.g. /dev/mmcblk0p1 is the first partition of the device mmcklk0.
])

##
## Have a good coding
##
define([DOCM4_CLOSING_WORDS],
[
 Happy hacking! 
 
                                  
])

divert(0)dnl
