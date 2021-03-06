#   Makefike - Handcrafted make script for eg/build.
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

AUXDIR =../../tools#

#
# Main examples and auxiliary examples
#

bin = eg-01 eg-02 eg-03-alpha eg-03 eg-04 eg-06 eg-06 
ppi = eg-05.i
arc = eg-07.a
lib = libeg-08.a

all: $(bin) $(ppi) $(arc) $(lib)

BARE= -fno-pic -fno-pie -fno-asynchronous-unwind-tables -fcf-protection=none

# Very simple example to illustrate the build steps

eg-01 : % : %.o %.i
	gcc -m32 -Wall -O0 $< -fno-pic -o $@

eg-01.o : %.o : %.s
	as -32 $< -o $@

eg-01.s : %.s : %.i
	gcc -Wall -O0 -m32 $(BARE) -Wl,--static -S $< -o $@

eg-01.i : %.i : %.c
	cpp -Wall -P $< -o $@

# Compilation unities

eg-02 eg-03 : % : %.c
	gcc -Wall $< -o $@

eg-03-alpha : % : %.c
	gcc -Wall $< -o $@
	@echo "Note: it's ok, we were expeting this warning"
	@echo

eg-04 : % : %.i
	gcc -Wall $< -o $@

eg-04.i : %.i : %.c %.h
	gcc -E -I. -P $< -o $@

eg-05.i : %.i : %.c
	gcc -E -I. -P $< -o $@

eg-05:
	@echo "Not a target; see README."

ifndef ALT
eg-06 : % : %.o %_foo.o %_bar.o
	gcc -Wall $^ -o $@
else
eg-06 : % : %.o lib%.a
	gcc -Wall $< -fno-pie -o  $@ -L. -l$*
endif

eg-06.o eg-06_foo.o eg-06_bar.o eg-06_baz.o: %.o : %.s 
	gcc -Wall -c -fno-pie $< -o $@

eg-06.s eg-06_foo.s eg-06_bar.s eg-06_baz.s : %.s : %.i
	gcc -S $< -fno-pic -o $@

eg-06.i : %.i : %.c %.h
	gcc -E -I. -P $< -o $@

eg-06_foo.i  eg-06_bar.i eg-06_baz.i : %.i : %.c 
	gcc -E -I. -P $< -o $@

ifeq ($(ALT), 1)
libeg-06.a : eg-06_foo.o eg-06_bar.o
	ar rs $@ $^
endif

ifeq ($(ALT),2)
libeg-06.a : eg-06_foo.o eg-06_bar.o eg-06_baz.o
	ar rs $@ $^
endif

eg-07.a :
	echo AAAAAAAAAA > f1
	echo BBBBBBBBBB > f2
	ar r $@ f1 f2

# Static library

libeg-08.a : eg-08_foo.o eg-08_bar.o
	ar rs $@ $^

eg-08_foo.o eg-08_bar.o: %.o : %.c
	gcc -Wall -c -fno-pic -fcf-protection=none -fno-asynchronous-unwind-tables $< -o $@

# ifeq ($(ALT) ,1)
# eg-06 : % : %.o libeg-06.a
# 	gcc -Wall -L. $< -o $@ -leg-06
# endif


# Another build example with static library

# main : main.o foobar.h libfoobar.a
# 	gcc $< -o $@ -L. -lfoobar

# libfoobar.a : foo.o bar.o
# 	ar rcs $@ $^

# main.o foo.o bar.o : %.o : %.c 
# 	gcc -Wall -I. -c $< -o $@

# Disassemble

# diss:  $(IMG)
# 	objdump -M intel -m i386 -d $< ; \

include $(AUXDIR)/bintools.makefile
 


.PHONY: clean

clean:
	rm -f $(bin) *.o *.i *.a main *.s *~ f1 f2 f
