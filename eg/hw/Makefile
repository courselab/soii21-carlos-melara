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

all : eg-01.bin eg-02.bin eg-03.bin eg-04-beta.bin eg-04.bin eg-05.bin eg-06-beta.1.bin eg-06-beta.2.bin eg-06.bin eg-06+1.bin eg-07.bin eg-08.bin


# Machine code in hex

eg-01.bin eg-02.bin : %.bin : %.hex
	$(AUXDIR)/hex2bin $< $@

# NASM assembly

eg-03.bin eg-04-beta.bin eg-04.bin eg-05.bin: %.bin : %.asm
	nasm $< -f bin -o $@
##
## GAS assembly
##

# Assembler as outputs an elf_32.
# Linker ld reads it and outputs a flat binary.
# We need to tell the linker where to locate the .text section with -T
# and inform which is our entry point with -e

eg-06-beta.1.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00 -e 0x7c00  $*.o -o $@

# We can identify the entry point through a label

eg-06-beta.2.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00 -e begin  $*.o -o $@

eg-06.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00  $*.o -o $@

# Doing everything at one with gcc
# Apparently, we don't need to pass -Ttext=org to the linker (does GCC do it?)

eg-06+1.bin : %+1.bin : %.S
#	gcc -m32 -Wl,--oformat=binary -march=i386 -nostdlib -ffreestanding -Wl,-Ttext=0x7c00  $< -o $@
	gcc -m32 -Wl,--oformat=binary -march=i386 -nostdlib -ffreestanding  $< -o $@



eg-07.bin : %.bin : %.S
#	gcc -m32 -Wl,--oformat=binary -march=i386 -nostdlib -ffreestanding -Wl,-Ttext=0x7c00 -Wl,--entry=0x7c00 $< -o $@
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext 0x7c00 $*.o -o $@
##
## GCC with inline
##

eg-08.bin : %.bin : %.c
#
# The following works
#
#	 gcc -Wall -O0 -ffreestanding -fno-pic -m16 -nostdlib -estart -Wl,-Ttext=0x7c00 $< -o $*.elf
#	 objcopy -j.text -Obinary  $*.elf $@
#
# The following does not work
#
#	gcc -m32 -Wl,--oformat=binary -fno-pic -fno-pie -march=i386 -nostdlib -ffreestanding -fno-pic -Wl,-Ttext=0x7c00 $< -o $@
	gcc -O0 -Wall -m32 -fno-pic -S $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -Ttext=0x7c00 $*.o -o $*.elf
	objcopy -j.text -Obinary $*.elf  $@

# Avoid objcopy

eg-08+1.bin : %+1.bin : %.c
	gcc -O0 -Wall -m32 -fno-pic -S $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -Ttext=0x7c00 $*.o -T script.ld -o $@



# Run on emulator

run: $(IMG)
	qemu-system-i386 -drive format=raw,file=$< -net none


diss: $(IMG)
	objdump -M intel -b binary -m i8086 -D $<

dump: $(IMG)
	hexdump -C $<


.PHONY: clean clean-extra

clean:
	rm -f *.bin *.elf *.o *.s
	make clean-extra

clean-extra:
	rm -f *~ \#*

# Create bootable USP stick if BIOS needs it

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

