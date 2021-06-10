dnl  Makefile.m4 - Makefile template.
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
dnl  ------------------------------------------------------------------
dnl
dnl  Note: this is a source file used to produce either a documentation, item,
dnl        item, script or another source file by m4 macro processor. If you've
dnl	   come across a file named, say foo.m4, while looking for one of the
dnl	   aforementioned items, changes are you've been looking for file foo,
dnl	   instead. If you can't find foo, perhaps it is because you've missed
dnl 	   missed the build steps described in the file README, found in the
dnl	   top source directory of this project.
dnl        
dnl
include(docm4.m4)dnl
DOCM4_HASH_HEAD_NOTICE([Makefile],[Makefile script.])

## 
## Stage 1: boot loader
## Stage 2: kernel
##

bin = stage1.bin stage2.bin

# Stage 1 uses some basic functions implemented in core.c

stage1_obj = stage1.o core.o

# Stage 2 also uses core.c, but includes a lot more implemented in tyos.c

stage2_obj = stage2.o core.o tyos.o

# Size of stage2 in 512-byte sectors

STAGE2_SIZE=1

# Auxiliary variables to simplify this Makefile

all_obj = $(sort $(stage1_obj) $(stage2_obj)) rt0.o

AUXDIR =../../tools#

all : $(bin) 

UPDATE_MAKEFILE

DOCM4_RELEVANT_RULES

## C source code.
## We build the program step by step so that we can inspect the intrmediate
## assembly, object and binaries if we want to.

stage1.bin : $(stage1_obj) stage1.ld rt0.o
	ld -melf_i386 --orphan-handling=discard  -T stage1.ld $(stage1_obj) -o $@

stage2.bin : $(stage2_obj) stage2.ld
	ld -melf_i386 --orphan-handling=discard  -T stage2.ld $(stage2_obj) -o $@

$(all_obj) :%.o: %.s 
	as --32 $< -o $@

$(all_obj:%.o=%.s) :%.s: %.c
	gcc -m16 -O0 -I. -Wall -Wextra -fno-pic -fcf-protection=none  --freestanding -S $< -DSTAGE2_SIZE=$(STAGE2_SIZE) -o $@

$(stage1_obj:%.o=%.s) $(stage2_obj:%.o=%.s) : tyos.h

## Here we create a 1.44M floppy disk image.
## We store stage1.bin at the MBR area (first 512 bytes), and
## stage1.bin right after it. 

tyos.img: stage1.bin stage2.bin
	rm -f $@
	dd              bs=1440 count=1024               if=/dev/zero of=$@
	dd conv=notrunc bs=512  count=1 obs=512 seek=0 if=stage1.bin of=$@
	dd conv=notrunc bs=512  count=$(STAGE2_SIZE) obs=512 seek=1 if=stage2.bin of=$@


#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img *.i
	make clean-extra

clean-extra:
	rm -f *~ \#*


#
# Programming exercise
#

VERSION=0.1.0
TARNAME=tyos-$(VERSION)

pack:
	@if ! test -f .dist; then\
	  make do_pack;\
	 else\
	  echo "This is a distribution pack already. Nothing to be done.";\
	fi

do_pack:
	rm -rf $(TARNAME)
	mkdir $(TARNAME)
	(cd .. && make clean && make)
	for i in core.c  rt0.c  stage1.c  stage2.c  tyos.c stage1.ld stage2.ld tyos.h; do\
	  cp TOOL_PATH/c-head-pack.c $(TARNAME)/$$i ;\
	  TOOL_PATH/stripcomment -c $$i >> $(TARNAME)/$$i;\
	done
	for i in Makefile; do\
	  cp $(TOOL_PATH)/Makefile-head-pack $(TARNAME)/$$i ;\
	  TOOL_PATH/stripcomment -h $$i >> $(TARNAME)/$$i;\
	done
	cp README TOOL_PATH/COPYING $(TARNAME)
	touch $(TARNAME)/.dist
	tar zcvf $(TARNAME).tar.gz $(TARNAME)


# Include Make Bintools

DOCM4_MAKE_BINTOOLS

