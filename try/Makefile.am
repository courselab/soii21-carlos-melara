##   Automake.am - Automake script.
##
##   Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
##
##   This file is part of SYSeg
##
##   SYSeg is free software: you can redistribute it and/or modify
##   it under the terms of the GNU General Public License as published by
##   the Free Software Foundation, either version 3 of the License, or
##   (at your option) any later version.
##
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
##   You should have received a copy of the GNU General Public License
##   along with this program.  If not, see <http://www.gnu.org/licenses/>.

##### Change to docm4, makefilem4 etc.

doc_m4 = README mbr/README

makefile_m4 = mbr/Makefile

filesm4 = $(doc_m4) $(makefile_m4) 

extra_subdirs = mbr 

EXTRA_DIST = $(extra_subdirs) $(filesm4)

all: $(filesm4)

# Build source and documentation files from m4 sources.

SUFFIXES = .m4

.m4: 
	m4 --include=$(top_srcdir)/tools $< > $@

$(doc_m4) : $(top_srcdir)/tools/doc.m4

$(makefile_m4) : $(top_srcdir)/tools/makefile.m4

##
## Housekeeping
##

# Invoking clean from this directory will clean up m4-generated files.

clean-local:
	for i in $(extra_subdirs); do\
	  (cd $$i && $(MAKE) clean;)\
	done
	rm -f $(filesm4)
# 

dist-hook: 
	for i in $(EXTRA_DIST); do\
	  $(MAKE) clean;\
	done
