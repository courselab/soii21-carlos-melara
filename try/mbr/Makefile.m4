include(docm4.m4)dnl
DOCM4_HASH_HEAD_NOTICE([Makefile],[Makefile script.])

#
# Main examples and auxiliary examples
#

bin = mbr.bin

objs = main.o mbr.o

AUXDIR =../../tools#

all : $(bin) 

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
	cp README $(TARNAME)
	tar zcvf $(TARNAME).tar.gz $(TARNAME)

# Include Make Bintools

DOCM4_MAKE_BINTOOLS

