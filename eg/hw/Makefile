#   Makefike - Handcrafted makefile script for eg/hw
#
#   Copyright (c) 2014 - Monaco F. J. <monaco@usp.br>
#
#   This file is part of SYSeg.
#
#   SYSeg is free software: you can redistribute it and/or modify
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

AUXDIR = ../../tools#

bin = eg-01.bin eg-02.bin eg-03-beta.bin eg-03.bin eg-04.bin eg-05-beta.1.bin eg-05-beta.2.bin eg-05.bin eg-06.bin eg-07.bin eg-07-beta.bin eg-08.bin eg-09.bin

binx =  egx-01.bin egx-02-32bit-gas.bin egx-02-16bit-gas.bin egx-02-32bit-nasm.bin egx-02-16bit-nasm.bin egx-03.bin egx-04.bin egx-04-16bit.s egx-04-32bit.s egx-04-16bit.bin egx-04-32bit.bin 


all : $(bin) $(binx)

# Machine code in hex

eg-01.bin : %.bin : %.hex
	@if ! test -f $(AUXDIR)/hex2bin; then \
	echo "Have you read syseg/README?" ; exit 1; fi
	$(AUXDIR)/hex2bin $< $@ 


# NASM assembly

eg-02.bin eg-03-beta.bin eg-03.bin eg-04.bin: %.bin : %.asm
	nasm $< -f bin -o $@




##
## GAS assembly
##

# Assembler as outputs an elf_32.
# Linker ld reads it and outputs a flat binary.
# We need to tell the linker where to locate the .text section with -T
# and inform which is our entry point with -e

eg-05-beta.1.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00 -e 0x7c00  $*.o -o $@

# We can identify the entry point through a label

eg-05-beta.2.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00 -e begin  $*.o -o $@


ifndef ALT

eg-05.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00  $*.o -o $@
endif


# Doing everything at one with gcc
# 
ifeq ($(ALT), 1)
eg-05.bin : %.bin : %.S
	gcc -m16 -Wl,--oformat=binary -march=i386 -nostdlib -Ttext=0x7c00 $< -o $@
endif

ifndef ALT
eg-06.bin: %.bin : %.S
#	gcc -m32 -Wl,--oformat=binary -march=i386 -nostdlib -ffreestanding -Wl,-Ttext=0x7c00 -Wl,--entry=0x7c00 $< -o $@
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext 0x7c00 $*.o -o $@
endif

ifeq ($(ALT),1)
eg-06.bin : %.bin : %.S
	gcc -m16 -Wl,--oformat=binary -march=i386 -nostdlib -Wl,-Ttext=0x7c00 $< -o $@
endif


ifndef ALT
eg-07-beta.bin : %.bin : %.c %.ld
	gcc -m16 -O0 -Wall -fno-pic -fno-asynchronous-unwind-tables -fcf-protection=none -S $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -Ttext=0x7c00 $*.o --oformat=binary --orphan-handling=discard  -o $@
endif

ifeq ($(ALT),1)
eg-07-beta.bin : %.bin : %.c %.ld
	gcc -m16 -O0 -Wall -fno-pic -fno-asynchronous-unwind-tables  -fcf-protection=none -S $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T $*.ld $*.o --orphan-handling=discard  -o $@
endif

# One-line gcc command

ifeq ($(ALT),2)
eg-07-beta.bin : %.bin : %.c %.ld
	gcc -m16 -O0 -Wall -fno-pic -fcf-protection=none -nostdlib -T $*.ld -Wl,--orphan-handling=discard   $< -o $@
endif

# Using linker script to define entry, flat binary and boot signature,
# and to place the string in the .text section.


eg-07.s : %.s : %.c 
	gcc -m16 -O0 -Wall -fno-pic  -fcf-protection=none -S $< -o $@

eg-07-O1.s : %-O1.s : %.c
	gcc -m16 -O1 -Wall -fno-pic  -fcf-protection=none -S $< -o $@


eg-07.bin eg-07-O1.bin : %.bin : %.s eg-07.ld
	as --32 $< -o $*.o
	ld -melf_i386 -T eg-07.ld $*.o --orphan-handling=discard  -o $@





.precious: *.o

eg-08.bin : %.bin : %.c %.ld %.h
	gcc -m16 -O0 -I. -Wall -fno-pic  -fcf-protection=none -S $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T $*.ld $*.o --orphan-handling=discard  -o $@

# eg-09


eg-09.o : %.o : %.c %.h 
	gcc -m16 -O0 -I. -Wall -fno-pic  -fcf-protection=none -S $< -o $*.s
	as --32 $*.s -o $@

eg-09_utils.o : %.o : %.c 
	gcc -m16 -O0 -I. -Wall -fno-pic  -fcf-protection=none -S $< -o $*.s
	as --32 $*.s -o $@

eg-09.bin: %.bin : %.o %_utils.o %.ld
	ld -melf_i386 -T $*.ld $(filter %.o, $^) --orphan-handling=discard  -o $@



# Auxiliary extra examples

egx-01.bin : %.bin : %.c
	gcc -m32 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T egx-01.ld $*.o -o $@

egx-02-32bit-gas.bin egx-02-16bit-gas.bin : %-gas.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 -T egx-02.ld $*.o -o $@

egx-02-32bit-nasm.bin egx-02-16bit-nasm.bin : %-nasm.bin : %.asm
	nasm -f bin $< -o $@


# Program eg-04.asm in GAS's intel dialict

egx-03.bin : %.bin : %.S
	as -32 -msyntax=intel -mnaked-reg $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00 -e 0x7c00  $*.o -o $@

# Illustration of GCC limitations in handling 8-bit registers

egx-04.bin egx-06.bin : %.bin : %.c
	gcc -m16 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none -Wno-unused-but-set-variable $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T $*.ld $*.o -o $@


egx-04-16bit.s: %-16bit.s : %.c
	gcc -m16 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none -Wno-unused-but-set-variable $< -o $@

egx-04-32bit.s: %-32bit.s : %.c
	gcc -m32 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none -Wno-unused-but-set-variable $< -o $@

egx-04-16bit.bin egx-04-32bit.bin : %.bin : %.s
	as --32 $< -o $*.o
	ld -melf_i386 -T egx-04.ld $*.o -o $@

egx-05.bin : %.bin : %.c %.ld
	gcc -m32 -O0 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none -Wno-unused-but-set-variable $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T $*.ld $*.o -o $@

#
# Test and inspect
#

include $(AUXDIR)/makefile.utils

.PHONY: clean clean-extra intel att 16 32 diss /diss /i16 /i32 /a16 /a32

#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img
	make clean-extra

clean-extra:
	rm -f *~ \#*

#
# Create bootable USP stick if BIOS needs it
#

%.iso : %.img
	xorriso -as mkisofs -b $< -o $@ -isohybrid-mbr $< -no-emul-boot -boot-load-size 4 ./

%.img : %.bin
	dd if=/dev/zero of=$@ bs=1024 count=1440
	dd if=$< of=$@ seek=0 conv=notrunc

run-iso: $(IMG)
	qemu-system-i386 -drive format=raw,file=$(IMG) -net none

stick: $(IMG)
	@if test -z "$(STICK)"; then \
	echo "*** ATTENTION: make IMG=foo.bin SITCK=/dev/X"; exit 1; fi 
	dd if=$< of=$(STICK)

