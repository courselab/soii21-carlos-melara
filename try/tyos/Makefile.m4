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

bin = stage1.bin tyos2.bin

stage1_obj = stage1.o tyos.o

tyos2_obj = tyos2.o tyos.o

AUXDIR =../../tools#

all : $(bin) 

UPDATE_MAKEFILE

DOCM4_RELEVANT_RULES

## C source code.
## We build the program using gcc, as and ld.

stage1.bin : $(stage1_obj) tyos.ld rt0.o
	ld -melf_i386 --orphan-handling=discard  -T tyos.ld $(stage1_obj) -o $@

tyos2.bin : $(tyos2_obj) tyos.ld
	ld -melf_i386 --orphan-handling=discard  -T tyos2.ld $(tyos2_obj) -o $@

$(stage1_obj) $(tyos2_obj) rt0.o :%.o: %.s 
	as --32 $< -o $@

$(stage1_obj:%.o=%.s) $(tyos2_obj:%.o=%.s) rt0.s :%.s: %.c
	gcc -m16 -O0 -I. -Wall -Wextra -fno-pic -fcf-protection=none  --freestanding -S $< -o $@

$(stage1_obj:%.o=%.s) $(tyos2_obj:%.o=%.s) : tyos.h


floppy.img: stage1.bin tyos2.bin
	rm -f $@
	dd              bs=1440 count=1024               if=/dev/zero of=$@
	dd conv=notrunc bs=512  count=1 obs=512 seek=0 if=stage1.bin of=$@
	dd conv=notrunc bs=512  count=1 obs=512 seek=1 if=tyos2.bin of=$@

test : floppy.img
	qemu-system-i386 -drive if=floppy,format=raw,file=$<

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
	for i in utils.c; do\
	  cp $(AUXDIR)/c-head-pack.c $(TARNAME)/$$i ;\
	  $(AUXDIR)/stripcomment -c $$i>> $(TARNAME)/$$i;\
	done
	for i in Makefile; do\
	  cp $(AUXDIR)/Makefile-head-pack $(TARNAME)/$$i ;\
	  $(AUXDIR)/stripcomment -h $$i>> $(TARNAME)/$$i;\
	done
	cp README $(AUXDIR)/COPYING $(TARNAME)
	touch $(TARNAME)/.dist
	tar zcvf $(TARNAME).tar.gz $(TARNAME)


# Include Make Bintools

DOCM4_MAKE_BINTOOLS

