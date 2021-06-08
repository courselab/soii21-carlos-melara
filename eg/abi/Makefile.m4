include(docm4.m4)dnl
DOCM4_HASH_HEAD_NOTICE([Makefile],[Makefile script.])


targets = eg-01.o

all : $(targets) 

ifndef UPDATE
$(MAKECMDGOALS) : Makefile

Makefile : Makefile.m4
	cd .. && make
	make -f Makefile UPDATE=1 $(MAKECMDGOAL)
endif


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

eg-01.o : eg-01.c
	gcc -m32 -Qn -Wall -O0 -fno-pic -fcf-protection=none -fno-asynchronous-unwind-tables $< -c -o $@

eg-01 : eg-01.o
	gcc -m32 -Wall $< -o $@

.PHONY: clean
clean:
	rm -f $(targets)


DOCM4_MAKE_BINTOOLS
