
 BARE-METAL HELLO WORLD
 ==============================

 This directory and its contents are part of SYSeg.
 Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
 SYSeg is Free Software distributed under GNU GPL vr3.
 Further information see http://gitlab.com/monaco/syseg
 
 Overview
 ------------------------------

 This directory contains a series of examplis comprising a step-by step
 bare-metal implementation of a traditional Hello World program,
 indented to book and execute in a conventional x86 platform.

 The sequence starts with as simple as a source code written directly
 in machine code, wich is then rewriten in assembly and incrementally
 improved until we transform it in a familiar C source code.

 Source code examples include explanatory inline comments and are
 accompanied with corresponding technical discussions laid in this
 file, which one should be able to go through in the suggested order.
 For convenience, a build script (Makefile) is provided which contain
 rules to build, test, inspect and disassembly the content files.
 It may be useful to refer to this script to understand how the
 build tools (compiler, assembler, linker) are used.

 Directions
 ------------------------------

 In order to experiment with the examples in this section, the following
 pieces of software are required. The version indication lists those with
 which the project was tested. Using a more recent version should be
 ok, but it is not absolutely guaranteed that results may exhibit minor
 variations. Feedback is always appreciated.

 - GCC 	     	 9.3.0
 - binutils 	 2.34
 - nasm		 2.14.02
 - qemu		 4.2.1		(qemu-system-i386)
 - gcc-multilib  9.3.0		(to compile 32-bit code in a 64-bit platform)

 If you may also need

 - xorriso	1.5.2-1		(depending on your computer's BIOS)


 include(DOCM4/make-bintools.m4)

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

    

 Contents
 ------------------------------


 Take a look at the following examples, preferably in the suggested order.
 


 * eg-00.hex	    Bare-metal hardcore Hello World in machine code.
 
   		    This is a tough old-school version of the classical
		    Hello World program. It writes the string directly to the
		    BIOS video memory, character by character, one at a time.
		    A Hello World as you may have never made before, with
		    neither an OS, nor a programming language, not even
		    assembly; just bare machine code.

		    The source code is an ASCII file containing the opcodes of
		    the program in hexadecimal representation.

		    Build with it with a simple hex-to-binary converter. 


 * eg-01.asm        The same as eg-00.hex, but now in assembly code.

   		    This program implements literally the same algorithm as
		    eg-01.hex, but written in assembly code, using Intel
		    syntax. This is the assembly understood by NASM assembler,
		    used here to build the binary.

		    Compare eg-01.bin and eg-02-beta.1.bin, by disassembling
		    them with

		      make eg-00.bin/16i
		      make eg-01.bin/16i

                    or, alternatively, with the graphical tool

		      make diff eg-00.bin eg-01.bin BIT=16 ASM=intel

		    and see that the resulting object codes match.

		    We are forcing the disassembler to interpret the object
		    as code for a i8086 (16-bit) CPU, using intel asm syntax.


 * eg-02-beta.asm   A variation of eg-01.asm, using a loop.

  		    Notice that now that we are dealing with offsets, we must
		    beware of the RAM load address. In this example, we handle
		    this by directly adding the offset into the code where
		    needed.
		    
 * eg-02.asm	    Same as eg-02-beta.2.asm, but using the 'org' directive.

   		    The directive 'org' causes all labels to be offset
		    to match the position where BIOS loads the program.

		    
		    Compare eg-02-beta.bin and eg-02.bin with

		      make eg-02-beta.bin/i16 
		      make eg-02.bin/i16 
  		    
		    and see that the resulting object codes match.

		    Now it's opportune to observe that NASM is performing
		    both the assembling (object code generation) and
		    linking (build-time address relocation) steps.



* eg-03-beta.S      Like eg-02.asm, but translated into AT&T assembly syntax.

  		    One motivation to convert the assembly source code from
		    Intel to AT&T dialect is because we intend to rewrite
		    the running example in C language.  To that end, we will
		    use the powerful and flexible GNU compiler collection.
		    The thing is, GCC's toolchain speaks AT&T asm and does not
		    understand NASM's intel asm.

		    See note (2) for further detailing.

   		    The translation was made as literal as possible so as to
		    facilitate the comparison with eg-04.asm.

		    A noteworthy observation is that the build procedure of
		    this example involves two steps: assembling and linking.
		    The former translates assembly to object (machine) code,
		    and the latter remaps offsets to match the load address.
		    Those are the normal duties of the assembler and the linker.
		    With NASM, which we had been using previously, those
		    two functions are performed by the same program. In the
		    GNU development toolchain, differently, those duties are
		    performed by two distinct programs: the assembler (GAS,
		    whose executable program name is 'as') converts assembly
		    to object code (machine code), and then the linker (ld)
		    is used to remap the addresses offset to match the RAM
		    load address. GAS does not have an equivalent for the
		    .org directive that we used with NASM for this purpose;
		    we inform the linker directly via a command line option.

		    Moreover, whilst we had instructed NASM to produce a flat
		    binary, the version of GAS installed in our x86 / x86_64
		    platform outputs binaries in ELF format --- a structured
		    executable format that has much more than the executable
		    code section (e.g. header, relocation information and
		    other metadata). It is the liker who is responsible to
		    strip all extra sections and output a flat binary.
		    We tell ld to do that using another command-line option.

		    Finally, ld let us specify which will be the entry point
		    of the executable. This would be important for structured
		    file formats such as ELF (Linux) or PE (windows). For
		    us, it's the first byte. However, since ld dos expect it,
		    we pass this information in yet another command-line option.


 * eg-03.S	    Same as before, but with standard entry point name.

   		    This example is to illustrate that the default symbol name
		    for the entry point is _start. If we stick to it, we do
		    not need to pass it as an option for to the linker. 

		    Alternative:

		    Issuing the build rule with the command-line variable
		    ALT=1 selects an alternative recipe using a single GCC 
		    invocation (GCC then invokes the assembler and the linker
		    with appropriate arguments).

		    Disassemble with 

		      make eg-02.bin/i16 
		      make eg-03.bin/i16

		      or

  		      make diff eg-02.bin eg-03.bin ASM=intel BIT=16
		      
		    and see that they all binaries match, i.e. the output of
		    both assemblers (NASM and GAS) are the same.


 * eg-04-beta.c	    Like eg-03.S but rewritten in C and inline assembly.

   		    We use basic inline assembly. GCC should copy the asm code
                    as is to the output asm.  The two function-like macros
		    are expaned by the preprocessor in build time.

		    Caveats:

                    We declared the function with attribute 'naked' to prevent
                    GCC from generating extra asm code which is not relevant
                    here and may be omitted for readability. See comments
                    in the source file.

                    Observe that the string is now allocated in the read-only
                    section of the object code --- and also the ad hoc
                    workaround (aka dirty hack) we used (see comments in
                    the source file).


 * eg-04.c	    Like eg-07-beta.c, but using a script

   		    We use a linker script to handle several issues:

   		    - merge .rodata into .text section

		    as well as

   		    - add the the boot signature        
   		    - covert from elf to binary         
   		    - set load address                  
   		    - entry point                       


		    The first feature frees our code from the hack on msg,
		    and the latter four simplify ld command-line options.


		    Compare eg-03.bin and eg-04.bin with

		    	make eg-06.bin/16i
			make eg-07.bin/16i


                    Both object code are amost a perfect match.

		    Bearing in mind that, since there is possibly more than
		    one way to implement the behavior specified by the C
		    source code into assembly form, it is not guaranteed
		    that both the handwritten eg-03.S and the GCC-produced
		    eg-03.S will match.
		    
		    Indeed if we inspect the disassembled objects, we may see
		    that GCC added a few extra instructions after the code.
		    Those are no-operation (NOP) and undefined (UD2)
		    instructions that are inserted by the compiler as a
		    security measure to assert that code is not executed
		    past the end of the legit code.  The appended
		    instructions however cause the string to be moved some
		    positions away from its original place in eg-03.S.
		    This is reflected in some other parts of the code.
		    

 * eg-05.c	    A rewrite of 08.c replacing macros with functions.

   		    The limitations of eg-08.c's macro usage are overcome, yet with
		    simple inline assembly.

		    One thing to be noticed is that we had to change the
		    assembly to use register si where we had been using bx.

		    See note (3).

		    We alse had to set the location where the call instruction
		    should leave the return address for the callee.


 * eg-06.c	    Like eg-09 but using GCC extended assembly.

   		    Extended assembly allow us to

		      reference C variable within asm code;
		      generate unique labels across the compilation unit;
		      notify GCC about clobbered registers.

		    Build eg-09.bin and compare

   		       make diff eg-05_utils.s eg-06_utils.s

		       make diff eg-05_utils.bin eg-06_utils.bin

		    In extended asm GCC is allowed to optmize to modify the
		    output. We used volatile with extended asm to prevent
		    optimization. Even though, there are slight differences.

		    We handled the stack pointer in a better way.

 * eg-07.c	    Finally our masterpiece C-looking program.

   		    We did some changes

		       replaced asm rt0 with a C version
		       used the linker to set the stack location
		       changed functions name to look like C
		       jump to main from rt0
		       fixed writing routine not to output 0x0

		    We now return from main, rather than calling exit.

		    This time we can't use attribute naked in main();
		    otherwise the compiler removes the 'ret' instruction.
		    The assembly for eg-11.s is added some extra code that
		    is not fundamental here, as explained in eg-07.c comments.


   		    See comments in the file.


 Troubleshooting
 ------------------------------

 You are encouraged to send boot reports and fixes to the software author.

 Some known issues and tentative workarounds are here listed.

 - Issue: my image boots ok with the emulator but not with the hardware.

   If you have prepared your stick with


      make stick IMG=foo.bin STICK=/dev/sdX

   try then, instead

      make stick IMG=foo.iso STICK=/dev/sdX

 - Issue: I used the regular cp command to transfer image.bin to my stick.

   No, it does not work. Utility cp relies on the OS to transfer data
   to a formatted media. It will choose where to store the data
   and it will certainly not be to the MBR area. You can either
   use cat, dd or, if your BIOS needs, xorriso.


 Notes
 ------------------------------

 (1)   Original PC's BIOS used to read the MBR from the first 512 bytes of
       either the floppy or hard disks. Later on, when CD-ROM technology
       came about, it brought a different specification for the boot
       information, described in the iso9960 (the conventional CD file system
       format). Vendors then updated the BIOSes to detect whether the storage
       is either a floppy (or HD) or a CD-ROM, and apply the appropriate boot
       procedure. More recently, when USB flash devices were introduced, the
       approach adopted by BIOS vendors was not to specify a new boot procedure,
       but to emulate  some of the former devices. The problem is that this
       choice is not very consistent: some BIOSes would detect a USB stick as
       a floppy, whereas other BIOSes would see it as a CD (welcome to the
       system layer!).

       If your BIOS mimics the original PC, to make a bootable USB stick
       all you need to do is to copy the MBR code to its first 512 bytes:


   	  make stick IMG=foo.bin STICK=/dev/sdX


       On the other hand, if your BIOS insists in detecting your USB stick
       as a CD-ROM, you'll need to prepare a bootable iso9660 image as
       described in El-Torito specification [2]. 

       As for that, the GNU xorriso utility may come in handy: it prepares a
       bootable USP stick which should work in both scenarios. Xorriso copies
       the MBR code to the first 512 bytes to the USB stick and, in addition,
       it also transfer a prepared iso9660 to the right location. If you can't
       get your BIOS to boot and execute the example with the above (floppy)
       method, then try

         make stick IMG=foo.iso STICK=/dev/sdX


       We wont cover iso9660 El-Torito boot for CD-ROM, as newer x86-based
       computers now offers the Unified Extensible Firmware Interface meant
       to replace the BIOS interface of the original PC.  EFI is capable
       of decoding a format device, allowing the MBR code to be read from a
       standard file system. Although EFI is gradually turning original PC
       boot obsolete, however, most present day BIOSes offer a so called
       "legacy mode BIOS" and its useful to understand more sophisticated
       technologies, as low-level boot is still often found in legacy
       hardware and embedded systems.



 (2)  One reason we had better switch from nasm (Intel) to gas (AT&T)
      assembly here is because GCC (compiler) and NASM (assembler) do
      not go that well together. Actually, although GCC outputs AT&T syntax
      by default, it is true that GCC is capable of outputing Intel
      assembly if asked by means of the 'masm' option.  The problem is that
      the latter comes in specific Intel assembly dialect meant for GAS
      (GNU Assembler), which is not the same as that understood by NASM
      --- for instance, some directives (such as 'bit 16' vs .code16,
      times vs .fill etc.), data types ('dw' vs 'word'), and mnemonics
      (mov vs moveb, movel etc.) differ.

      A glimpse of those differences may be seen in egx-03.S.

      It's therefore not practical to ask GCC to generate intel assembly
      from C, and have the latter assembled by nasm; we would need to
      use GAS, instead anyway.

      As a side note, that is why we do not refer to assembly as a
      "programming language", in the same way we refer to the C language
      but, as the name implies, as an "assembling language". Diverse
      assembly standards vary in syntax and thereby constitute different 
      specifications. Moreover, the assembly code is dependent on the
      processor architecture e.g. i386 vs ARM etc.

      If we want to read the assembly generated by GCC, even if we ask
      for Intel syntax, we would need to learn a new dialect --- whose
      differences are not only a matter of syntax, but also of semantics.
      For instance, the way NASM compiler works with directive 'org'
      is very different from how GAS works in association to the linker
      (ld) to relocate code.  It so happens that it may be arguably more
      interesting learn the native GCC toolchain assembly dialect and
      proceed therefrom.


 (3)  Previously, we would do
		    
      		    AT&T syntax			Intel syntax

      		    msg(%bx)			[msg + bx]


      to iterate through the characters of the string located at msg, using bx
      as the index of the array.

      Now, rather than constant labeled position, our string may be anywhere
      and we pass it to the function as an address stored in %cx. The thing
      is, we can't do

		    AT&T syntax			Intel syntax

		    %cx(%bx)			[cx + bx]
		    
      Why not? Because the i8086 (16-bit precursos of x86) does not allows to.
      The way to traverse an array here is by using the base-index-scale

		  base address + index array * scale

      E.g.

		   (%bx, %si, 1)

      is the memory position starting from the base address %bx, advancing
      %si * 1 positions.  The scale may be e.g. 4 if we want to advance
      %si 32-bit integers.

      So, in our example, can we do

		  (%cx, %bx)

       No.

       In 16-bit real mode x86 allow us We limited choices

	     	   (%bx), (%bp), (%si), (%di),

	           (%bx,%si), (%bx,%di), (%bp,%si) and (%bp,%di)


        We than had to modify our code to use %si for iteration and %bx for
	the base. (Do the respective names "base register" and "source  index 
	register" for bx and si ring you a bell?)

	Do I really need to know all of this??? 

	Hump... know this you must, for intricate and deceptive the hardware
	may be... and fighting the darkness you shall, to bring consistency
	and balance where there would be only chaos and fear.


 References
 ------------------------------
 
 [1] Auxiliary program: syseg/src/hex2bin

 [2] El-Torito: https://wiki.osdev.org/El-Torito
