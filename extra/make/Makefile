#   Makefike - Template for building multiple binaries 
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

# This template uses GNU make's second expansion feature to build
# multiple binaries out of their C source code files. It's meant as an
# example of Make features.
#
# 
#
# Note:   This Makefile is meant as an example to illustrate
# some features of the 'make' build automation tool.  The script is based
# on GNU make and makes use of some non-posix extensions.
#
# Bear in mind that this example is in no way nearly as capable as Atutootls,
# which one is strongly encourage to use for more flexible, portable and
# feature rich build automation. You may learn more about Autootls by
# checking http://gitlab.com/monaco/syseg
#
# If you happen to use this Makefile in your project, as a quick provisional
# step, please change the copyright notice above with your data, and add
# comment-line with attribution to SYSeg author. He would apreciate.

## Usage
## make [targets] [flags] [prefix]
##
##    targets	all	  builds all (default)
##              <goals>   build project-specific goals
##    		install   install sofware
##		uninstall uninstall project
##		dist	  create distribution tarball
##		clean	  clean up all that was built
##
##    flags
## 		CPPFLAGS  preprocessor flags
##  		CFLAGS	  compiler flags
##		LD_FLAGS  linker flags
##
##	        PREFIX	  installation path prefix (e.g. $(PREFIX)/bin etc.)
##			  if not specified, last (stored in .prefix) is used
##			  if none was specified before, defaults to '/'


## Name your project

PROJECT = foobar


## List your binaries
##
## E.g.
##
## bin = foo bar

bin = main1 main2

## For each binary $(bin), list its objects
##
## E.g.
##
## foo_obj = main.o foo.o
## bar_obj = main.o bar.o

main1_obj = main.o foo1.o bar1.o

main2_obj = main.o foo2.o bar2.o

## List your libraries
##
## lib = libfoobar1 libfoobar2

lib = libfoobar1.a libfoobar2.a libfoobar1.so

## For each library in $(lib), list its objects
##
## E.g.
##
## libfoobar1_obj = foo1.o bar1.o
## libfoobar2_obj = foo2.o bar2.o

libfoobar1_obj = foo1.o bar1.o

libfoobar2_obj = foo2.o bar2.o

## List the headers you want to get installed
##
## E.g.
##
## headers = foobar.h

headers = foobar.h

## User flags
##
## CPP_FLAGS : preprocessor flags
## C_FLAGS   : compiler flags
## LD_FLAGS  : linker flags
## PREFIX    : installation prefix
## CC        : compiler

CPP_FLAGS = 
C_FLAGS =   
LD_FLAGS =  
#PREFIX = ./
CC = gcc

## That's all.
##
## You probably don't need to change anything below this line.

CPP_FLAGS += -I. $(CFLAGS)
C_FLAGS   += $(CFLAGS)
LD_FLAGS  += $(LDFLAGS)


.SECONDEXPANSION:

all: $(bin) $(lib)

# Binaires

$(bin) : % : $$($$*_obj) 
	$(CC) $^ $(LD_FLAGS) -o $@

# Libs

lib_static  = $(filter %.a, $(lib))
lib_dynamic = $(filter %.so, $(lib))

$(lib_static) : %.a : $$($$*_obj)
	ar rcs $@ $^

$(lib_dynamic) : %.so : $$($$*_obj)
	gcc --shared $^ -Wl,-rpath='$$ORIGIN:$$ORIGIN/../' -o $@


#Objects

%.o : %.c
	$(CC)  $(CPP_FLAGS) $(C_FLAGS) -c $< -o $@

# Dependencies

objs = $(foreach i, $(bin) $(lib), $($(i:%=%_obj)))

deps = $(objs:%.o=%.d)

ifeq (,$(filterout clean install uninstall, $(MAKECMDGOAL)))
include $(deps)
endif

%.d : %.c
	$(CC) -MM -MT '$(<:%.c=%.o) $@' $< -o $@

# Install

.PHONY: clean install uninstall

# Do not remove trailing hash mark (#)

prefix = $(shell if [ -f .prefix ]; then cat .prefix; fi )
ifeq (,$(prefix))
ifeq (,$(PREFIX))
PREFIX=""
endif
$(shell echo $(PREFIX) > .prefix)
endif


ifneq (,$(filter install uninstall dist, $(MAKECMDGOALS)))
bindir=$(strip $(prefix))/bin#
libdir=$(strip $(prefix))/lib#
includedir=$(strip $(prefix))/include#
project=$(strip $(PROJECT))#
endif

install : $(bin) $(lib_static) $(lib_dynamic)
	mkdir -p $(bindir) && cp $(bin) $(bindir)
	mkdir -p $(libdir) && cp $(lib_static) $(lib_dynamic) $(libdir)
	mkdir -p $(includedir) && cp $(headers) $(includedir)

uninstall :
	for i in $(bin) ; do \
	  rm -f $(bindir)/$$i; done
	for i in $(lib_static) $(lib_dynamic) ; do\
	  rm -f $(libdir)/$$i; done
	for i in $(headers) $(lib_dynamic) ; do\
	  rm -f $(includedir)/$$i; done


# Distribution

dist : $(objs:%.o=%.c) $(headers) Makefile README COPYING
	rm -rf $(project)
	mkdir -p $(project)
	cp $^ $(project)
	tar zcvf $(project).tgz $(project)

# Housekeeping

clean:
	rm -f *.o $(bin) $(lib) $(objs) $(deps)
	rm -f *~

