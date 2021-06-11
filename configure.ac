dnl    configure.ac - Autoconf script 
dnl    
dnl    Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
dnl
dnl    This file is part of SYSeg. 
dnl
dnl    SYSeg is free software: you can redistribute it and/or modify
dnl    it under the terms of the GNU General Public License as published by
dnl    the Free Software Foundation, either version 3 of the License, or
dnl    (at your option) any later version.
dnl
dnl    SYSeg is distributed in the hope that it will be useful,
dnl    but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl    GNU General Public License for more details.
dnl
dnl    You should have received a copy of the GNU General Public License
dnl    along with .  If not, see <http://www.gnu.org/licenses/>.
dnl

dnl Initialize Autoconf, Automake and Libtool

AC_INIT([SYSeg], [0.1.1], [monaco@usp.br],[syseg]) 
AC_PREREQ([2.65])                              
AC_CONFIG_AUX_DIR([build-aux])                 
AC_CONFIG_MACRO_DIR([m4])                      
AC_CONFIG_HEADERS([config.h])                  

AM_INIT_AUTOMAKE([-Wall 1.14.1 subdir-objects -Werror])	dnl Init Automake options


dnl Define language and tools

AC_PROG_CC 		        dnl Defines CC
AM_PROG_AR                      dnl Archiver for static lib                     

dnl
dnl Check for programs and libraries
dnl

m4_define([build_notes],
[
 $1 not found in your system.

 As a consequence, examples which require this resource may be affected.
 Depending on which component of this project you are interested in, this may
 or may not limit the acess to the avilable functionality. If you know that
 the referred resource is relevant, or if you are unsure, please install $1
 and re-run this script.
 
 e.g. in Ubuntu GNU/Linux, run: apt install $2
 ])

rm -f syseg.log

dnl We currently required the compiler to support some specific functionality
dnl and cause build to fail if they are not present. Eventually, we should
dnl enhance portability and gracefully proceed the build with limited
dnl functionality.

AX_CHECK_COMPILE_FLAG(
	[-fcf-protection],,
	[AC_MSG_ERROR([*** -fcf-protection not supported by compiler (gcc too old?)])]
	)

AX_GCC_FUNC_ATTRIBUTE([naked])
if test $ax_cv_have_func_attribute_naked = "no"; then
AC_MSG_ERROR([*** function attribute 'naked' not supported (gcc too old?)])
fi

AC_CHECK_PROG([has_xorriso],[xorriso],[yes])
AS_IF([test x"$has_xorriso" != x"yes"],
AC_MSG_WARN([*** Program xorriso not found.])
echo "[build_notes([xorriso],[xorriso])]" >> syseg.log)

AC_CHECK_PROG([has_qemu],[qemu-system-i386],[yes])
AS_IF([test x"$has_qemu" != x"yes"],
AC_MSG_WARN([*** Program qemu not found.])
echo "[build_notes([qemu],[qemu-system-i386])]" >> syseg.log)

AC_CHECK_PROG([has_meld],[meld],[yes])
AS_IF([test x"$has_meld" != x"yes"],
AC_MSG_WARN([*** Program meld not found.])
echo "[build_notes([meld],[meld])]" >> syseg.log)

dnl Initialize libtool

LT_INIT                         

dnl Alternative short name used for install prefixes etc.

AC_DEFINE(SHORT_NAME, [syseg],[Define short name.])
AC_SUBST([short_name],[syseg])

dnl Replace missing functions (see also GNUlib)

dnl AC_CONFIG_LIBOBJ_DIR([replace])
dnl AC_SEARCH_LIBS([qux], [xpto], [], AC_MSG_WARN([*** Symbol xpto not found in libxpto]),[])
dnl AC_SEARCH_LIBS([baz], [xpto], [], [AC_LIBOBJ(mybaz)],[])

dnl Define variables to be used by Automake

AC_SUBST([CPP_FLAGS],"-ansi -D_POSIX_C_SOURCE=200809L -Wall -Wextra")
AC_SUBST([C_FLAGS])
AC_SUBST([LD_FLAGS])

dnl Canonical check for POSIX threads.

AX_PTHREAD([AC_DEFINE(HAVE_PTHREAD,1,
            [Define to 1 if POSIX threads libraries and headers are found.]) ], 
	    AC_MSG_ERROR([POSIX threads support not detected.]))

dnl Portable shell 

dnl AC_SUBST([echo_n], ECHO_N)
dnl AC_SUBST([echo],[echo])

dnl Output files

AC_CONFIG_FILES([Makefile
		tools/Makefile
		eg/Makefile
		extra/Makefile
		test/Makefile
		try/Makefile
		])	

dnl Do it

AC_OUTPUT

AS_IF([test -f syseg.log],
[echo "Build notes"; cat syseg.log])
