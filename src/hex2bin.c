/* hex2bin.c - Convert a file from hexadecima ascii to binary.
 
   Copyright (c) 2015, Monaco F. J. <monaco@usp.br>

   This file is part of Praxyss.

   Praxyss is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <stdlib.h>
#include "debug.h"

#define PROGRAM "hex2bin"
#define VERSION "1.0.0"

void usage()
{
#define msg(s)   fprintf (stderr, s "\n");
  msg("");
  msg("Usage   " PROGRAM " [option] | <input-file> [<output-file>]");
  msg("");
  msg("          <input-file>             if not given, reads from stdin");
  msg("          <output-file>            if not given, writes to stdout (in ascii)");
  msg("");
  msg("          options:   --help        this help");
  msg("                     --version     software version");
  msg("");
}

int main (int argc, char **argv)
{
  FILE *fpin, *fpout;
  int val;
  
  fpin = stdin;
  fpout = stdout;
  
  if (argc > 1)
    {
      if (!strcmp (argv[1], "--help"))
	{
	  usage();
	  exit(EXIT_SUCCESS);
	}
      if (!strcmp (argv[1], "--version"))
	{
	  printf ("Version: %s %s\n", PROGRAM, VERSION);
	  exit(EXIT_SUCCESS);
	}


      if (argc > 1)
	{
	  fpin = fopen(argv[1], "r");
	  sysfatal(!fpin);
	}
      
      if (argc > 2)
	{
	  fpout = fopen(argv[2], "w");
	  sysfatal(!fpout);
	}
    }
  

  if (fpout == stdout)
    while ( fscanf (fpin, "%2x", &val) >= 0)
      printf ("%d ", val);
  else
    while ( fscanf (fpin, "%2x", &val) >= 0)
      fputc (val, fpout);
  
  if(fpin != stdin)
    fclose (stdin);
  if(fpout != stdout)
    fclose (stdin);

  return EXIT_SUCCESS;
}
