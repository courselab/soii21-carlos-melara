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

extra_subdirs = mbr 

EXTRA_DIST = $(extra_subdirs) 

doc_m4 = README mbr/README

makefile_m4 = mbr/Makefile

include $(top_srcdir)/tools/m4pp.makefile

clean-local: 
	for i in $(extra_subdirs); do\
	  (cd $$i && $(MAKE) clean;)\
	done
	rm -f $(files_m4)

dist-hook: clean-local
