dnl   make-bintools.m3 - Source documentation file.
dnl
dnl   Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
dnl
dnl   This file is part of SYSeg
dnl
dnl   SYSeg is free software: you can redistribute it and/or modify
dnl   it under the terms of the GNU General Public License as published by
dnl   the Free Software Foundation, either version 3 of the License, or
dnl   (at your option) any later version.
dnl
dnl   This program is distributed in the hope that it will be useful,
dnl   but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl   GNU General Public License for more details.
dnl
dnl   You should have received a copy of the GNU General Public License
dnl   along with this program.  If not, see <http://www.gnu.org/licenses/>.



 Build Instructions
 ------------------------------
 

 Use

   make foo				     Build foo.

   make run IMG=foo	             	     Test foo with the emulator.

   make diss IMG=foo 			     Disassemble foo.

   	     	     			     Optionally,

					        ASM  = intel | att  (default)
						BIT  =    16 | 32   (default)

   make dump IMG=foo			     Show the raw contents of foo.
   
   make      			             build everything (or make all)

   make clean			             undo make all

   make iso IMG=foo	             	     build an iso9660 image with foo

   make stick IMG=foo STICK=/dev/sdX         make a bootable USB stick

   make diff foo bar baz		     Show graphical diff between files
   	     	     			     ASM and BIT variables apply


   SHORTCUTS

   make foo/diss			     disassembly as 32-bit AT&T
   make foo/diss intel|att		     disassembly as 32-bit Intel or AT&T
   make foo/diss 16|32			     disassembly as 16-bit or 32-bit
   make foo/diss intel\att 16|32	     disassembly as Intel|AT&T 16|32 bit
   make foo/diss 16|32 intel|att	     disassembly as Intel|AT&T 16|32 bit

   make foo/i16	       			     disassembly as Intel 16-bit
   make foo/i32	       			     disassembly as Intel 32-bit
   make foo/a16 or foo/16 		     disassembly as AT&T  16-bit
   make foo/a32	of foo/32       	     disassembly as AT&T  32-bit

   make foo/dump			     show raw contents in hexadecimal

   make foo/run				     test foo with the emulator


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

    Some notes.

    If you see /dev/hdb1, this is the first partition of your storage
    device /dev/hdb. You should transfer your bootable probram to
    /dev/hdb, not /dev/hdb1, or it will be written at the start of
    that partition --- and not at the start of the media itself as
    we need.

    In newer systems, your block device may also appear as /dev/mmcblk0,
    and your first partition as /dev/mmcblk0p1 and so on... 

