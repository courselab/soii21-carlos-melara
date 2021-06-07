dnl  doc.m4 - Macros for document source files
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
dnl
divert(-1)

changequote(`[',`]')

define([DOCM4_PROJECT],[SYSeg])
define([DOCM4_REPOSITORY],[http://gitlab.com/monaco/syseg])
define([DOCM4_YEAR],[2001])
define([DOCM4_AUTHOR],[Monaco F. J.])
define([DOCM4_EMAIL]),[<monaco@usp.br>])

dnl A short head notice that can be used in the README file
dnl describing the contents of a directory.

define(DOCM4_DIR_NOTICE,
[
 The contents of this directory are part of DOCM4_PROJECT,
 copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR
 DOCM4_PROJECT is Free Software distributed under GNU GPL vr3.
 Further information: DOCM4_REPOSITORY
])

dnl Copyright notice for Makefiles
dnl
dnl Arguments:
dnl
dnl  $1  file name
dnl  $2  one-line brief description

define(DOCM4_HASH_HEAD_NOTICE,
[changecom(,)dnl
#   $1 - $2
#
#   Copyright (c) DOCM4_YEAR - DOCM4_AUTHOR DOCM4_EMAIL
#
#   This file is part of DOCM4_PROJECT.
#
#   DOCM4_PROJECT is free software: you can redistribute it and/or modify
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
changecom([#],[])
])

dnl Copyright notice for shell scripts that use # as comment mark.
dnl
dnl Arguments:
dnl
dnl  $1  full path to the shell
dnl  $2  file name
dnl  $3  one-line brief description

define(DOCM4_SHELL_HEAD_NOTICE,
#!$1
#
[DOCM4_HASH_HEAD_NOTICE($2,$3)]
)

define(DOCM4_FILE_NOTICE,
[
 This file is a derivative part of DOCM4_PROJECT,
 copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR
 DOCM4_PROJECT is Free Software distributed under GNU GPL vr3.
 Further information: DOCM4_REPOSITORY
])

define(DOCM4_HASH_FILE_NOTICE,
[changecom(,)dnl
## This file is a derivative worl of DOCM4_PROJECT,
## copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR.
## DOCM4_PROJECT is Free Software distributed under GNU GPL vr3.
## Further information: DOCM4_REPOSITORY
changecom([#],)
])

define([DOCM4_MAKE_BINTOOLS],
[changecom(,)dnl
# ------------------------------------------------------------
# The following excerpt of code was copied from Make Bintools,
# part of DOCM4_PROJECT. Make-bintools is a collection of handy
# 'make' rules for disassembling object files, inspecting and
# comparing source and binary files.

include(bintools.makefile)
changecom([#],)dnl

# End of Make Bintools.
# -------------------------------------------------------------
])


divert(0)dnl
