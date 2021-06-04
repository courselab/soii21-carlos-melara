include(top_dir/tools/m4/Makefile-head-notice.m4)
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
# Test and inspect
#


include(top_dir/tools/makefile.utils)

.PHONY: clean clean-extra intel att 16 32 diss /diss /i16 /i32 /a16 /a32

#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img *.i
	make clean-extra

clean-extra:
	rm -f *~ \#*

##
## Create bootable USP stick if BIOS needs it
##

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

#
# Programming exercise
#

VERSION=0.1.0
TARNAME=mbr-$(VERSION)

pack: 
	rm -rf $(TARNAME)
	mkdir $(TARNAME)
	cp README $(TARNAME)
	for i in main.c mbr.c rt0.c mbr.h ; do \
	  cp $(AUXDIR)/c-head-pack.c $(TARNAME)/$$i ;\
	  $(AUXDIR)/stripcomment -c $$i>> $(TARNAME)/$$i;\
	done
	tar zcvf $(TARNAME).tar.gz $(TARNAME)
