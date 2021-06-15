include(docm4.m4)dnl
DOCM4_HASH_HEAD_NOTICE([Makefile],[Makefile script.])

bins_c32 = eg-00 eg-01 eg-02 eg-04
bins_c64 = eg-04_64_buggy eg-04_64
bins_nasm32 = eg-03
bins_as32 = eg-03_as

targets = $(bins_c32) $(bins_c64) $(bins_nasm32) $(bins_gas32)

all : $(targets) 

UPDATE_MAKEFILE



###########################################################
##
## These are the rules of interest in this set of examples.
##

# When applicable, we use some options to minimize clobbering of asm code
#
#  -fno-pic	disable position-independent code, a default gcc feature meant
#		for building shared libraries (DLL). This is not our case here.
#
#  -fno-assuncrhonous-unwind-tables      disables stack unwinding tables, a 
#					 default gcc feature meant for
#		clearing the stack upon the occurrence of asynchronous events
#		such as exception handling and garbage collection. This is
#		only meaningful if asynchronous execution flow deviations are
#		to be supported. None is the case of our programs here.
#  
#  -fcf-protection=none			  disables code for control-flow
#					  integrity enforcement, a default
#		gcc feature intended to enhance security against return
#		return/call/jump-oriented programming attacks. We can 
#		safely get along without it for benefit of readability.
#
#  -Qn		prevents gcc from outputing compiler metainformation e.g.
#		the section .comment, which is not relevant in this context.

CFLAGS_00 = -m32 -Qn -Wall -Wno-unused-but-set-variable -O0 -fno-pic -fno-pie -fcf-protection=none -fno-asynchronous-unwind-tables
LDFLAGS_00 = -m32 -Wall

# C, x86

$(bins_c32:%=%.o) : %.o : %.c
	gcc  $(CFLAGS_00) -c $< -o $@

$(bins_c32) : % : %.o
	gcc  $(LDFLAGS_00) $< -o $@

# C, x86_64

$(bins_c64:%=%.o) : %.o : %.c
	gcc  $(CFLAGS_00) -c $< -o $@

$(bins_c64) : % : %.o
	gcc  $(LDFLAGS_00) $< -o $@

# NASM, x86

$(bins_nasm32:%=%.o) : %.o : %.asm
	nasm -f elf32 $< -o $@

$(bins_nasm32) : % : %.o
	ld -m elf_i386 $< -o $@

$(bins_as32) : % : %.S
	gcc -m32 $< -nostartfiles -nostdlib -o $@



.PHONY: clean
clean:
	rm -f $(targets) *.o


DOCM4_MAKE_BINTOOLS
