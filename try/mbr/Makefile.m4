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


#
# Main examples and auxiliary examples
#

bin = mbr.bin

objs = main.o mbr.o

AUXDIR =../../tools#

all : $(bin) 

UPDATE_MAKEFILE

## C source code.
## We build the program using gcc, as and ld.

mbr.bin : $(objs) mbr.ld rt0.o
	ld -melf_i386 --orphan-handling=discard  -T mbr.ld $(objs) -o $@

main.o mbr.o rt0.o :%.o: %.s 
	as --32 $< -o $@

main.s mbr.s rt0.s :%.s: %.c
	gcc -m16 -O0 -I. -Wall -Wextra -fno-pic -fcf-protection=none  --freestanding -S $< -o $@

main.s mbr.s : mbr.h

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
TARNAME=mbr-$(VERSION)

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
	for i in main.c mbr.c rt0.c mbr.h mbr.ld; do\
	  cp $(AUXDIR)/c-head-pack.c $(TARNAME)/$$i ;\
	  $(AUXDIR)/stripcomment -c $$i>> $(TARNAME)/$$i;\
	done
	for i in Makefile; do\
	  cp $(AUXDIR)/Makefile-head-pack $(TARNAME)/$$i ;\
	  $(AUXDIR)/stripcomment -h $$i>> $(TARNAME)/$$i;\
	done
	cp README $(AUXDIR)/COPYING $(TARNAME)
	tar zcvf $(TARNAME).tar.gz $(TARNAME)


# Include Make Bintools

DOCM4_MAKE_BINTOOLS

