
 dnl Makefile bintools

 BUILD INSTRUCTIONS
 

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

   make stick IMG=foo STICK=/dev/sdX         make a bootable USB stick

   make iso IMG=foo	             	     build an iso9660 image with foo

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
