#   Makefike - Handcrafted make script for eg/hw.
#
#   Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
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

#
# Main examples and auxiliary examples
#

bin = eg-00.bin eg-01.bin eg-02.bin

binx =  egx-01.bin egx-02.bin

AUXDIR =../../tools#


all : $(bin) $(binx)


## GAS assembly.
## We build with as and ld, using a linker script.

eg-00.o eg-01_alpha.o eg-01.o foo.o: %.o : %.S
	as --32 $< -o $@

eg-00.bin eg-01_alpha.bin eg-01.bin foo.bin: %.bin : %.o mbr-nort0.ld
	ld -melf_i386 --orphan-handling=discard  -T mbr-nort0.ld $(filter %.o, $^) -o $@

## C source code.
## We build the program using gcc, as and ld.

binc = eg-02 eg-03

$(binc:%=%.bin) : %.bin : %.o %_utils.o mbr.ld rt0.o
	ld -melf_i386 --orphan-handling=discard -T mbr.ld $*.o $*_utils.o -o $@

$(binc:%=%.o) $(binc:%=%_utils.o) rt0.o :%.o: %.s
	as --32 $< -o $@

$(binc:%=%.s) $(binc:%=%_utils.s) rt0.s :%.s: %.c
	gcc -m16 -O0 -I. -Wall -fno-pic -fcf-protection=none  --freestanding -S $< -o $@




#
# Test and inspect
#

include $(AUXDIR)/bintools.makefile

.PHONY: clean clean-extra intel att 16 32 diss /diss /i16 /i32 /a16 /a32

#
# Extra auxiliary examples
#

egx-01.o egx-02.o : %.o : %.S
	as --32 $< -o $@

egx-01.bin egx-02.bin : %.bin : %.o mbr-nort0.ld
	ld -melf_i386 -T mbr-nort0.ld --orphan-handling=discard $(filter %.o, $^) -o $@

#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img *.i
	make clean-extra

clean-extra:
	rm -f *~ \#*

# ##
# ## Create bootable USP stick if BIOS needs it
# ##

# %.iso : %.img
# 	xorriso -as mkisofs -b $< -o $@ -isohybrid-mbr $< -no-emul-boot -boot-load-size 4 ./

# %.img : %.bin
# 	dd if=/dev/zero of=$@ bs=1024 count=1440
# 	dd if=$< of=$@ seek=0 conv=notrunc

# run-iso: $(IMG)
# 	qemu-system-i386 -drive format=raw,file=$(IMG) -net none

# stick: $(IMG)
# 	@if test -z "$(STICK)"; then \
# 	echo "*** ATTENTION: make IMG=foo.bin SITCK=/dev/X"; exit 1; fi 
# 	dd if=$< of=$(STICK)

