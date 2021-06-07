##   Makefile.am - Main Automake script for autohello
##
##   Copyright (c) 2014 - Monaco F. J. <monaco@usp.br>
##
##   This file is part of SYSeg.
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

extra_subdirs = hw abi build make

EXTRA_DIST = $(extra_subdirs)

docm4_files = abi/README abi/Makefile

include $(top_srcdir)/tools/docm4.am

clean-local:
	for i in $(extra_subdirs); do\
	  (cd $$i && $(MAKE) clean;)\
	done
	rm -f $(docm4_files)

dist-hook: clean-local

