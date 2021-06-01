/* syseg.c - Replace copyright note.
 
   Copyright (c) 2021, Monaco F. J. <monaco@usp.br>

   This file is part of SYSeg.

   SYSeg is free software: you can redistribute it and/or modify
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


/* This program reads a source file and replace the heading comments
   with a given copyrigth notice. */

#include <stdio.h>
#include <stdlib.h>
#include "../config.h"
#include "debug.h"

#define PROGRAM "stripcomment"
#define PROGRAM_VERSION "0.1.0"

/* Program usage information. */

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


void multiline (FILE *fpin, FILE *fpout, int global);

/* Main program. */

  
int main (int argc, char **argv)
{
  
  FILE *fpin, *fpout;
  
  fpin = stdin;
  fpout = stdout;

  /* Process options. */
  
  if (argc > 1)
    {
      if (!strcmp (argv[1], "--help"))
	{
	  usage();
	  exit(EXIT_SUCCESS);
	}
      if (!strcmp (argv[1], "--version"))
	{
	  printf ("Version: %s %s\n", PROGRAM, PROGRAM_VERSION);
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
  

  /* Do the actual job. */

  multiline (fpin, fpout, 1);
  
  return EXIT_SUCCESS;

}

enum state_t
  {
      body,	     /* Body of the program. */
      start_1,	     /* Start of comment. */
      start_2,
      end,	     /* End of comment. */
      done	     /* Finished. */
  };

/* enum {open_1, open_2, open_3, close_3, close_2, close_1}; */
/* int marks[][6] = */
/*   { */
/*    {'/', '*', 0 , 0 , '*','/'} */
/*   }; */


void multiline (FILE *fpin, FILE *fpout, int global)
{
  int c, i=0;
  enum state_t state = body;
  char buffer[2048];
  
  while ( ((c = fgetc (fpin)) != EOF ) )
    {
      
      switch (state)
	{

	case body:
	  switch (c)
	    {
	    case '/':
	      state = start_1;
	      buffer[i++] = c;
	      break;
	    default:
	      fputc (c, fpout);
	      break;
	    }
	  break;

	case start_1:
	  switch (c)
	    {
	    case '*':
	      state = start_2;
	      i=0;
	      break;
	    default:
	      buffer[i]=c;
	      fputs (buffer, fpout);
	      i=0;
	      state = body;
	      break;
	    }
	  break;

	case start_2:
	  switch (c)
	    {
	    case '*':
	      state = end;
	      break;
	    default:
	      break;
	    }
	  break;

	case end:
	  switch (c)
	    {
	    case '/':
	      state = global ? body : done;
	      break;
	    default:
	      state = start_2;
	      break;
	    }
	  break;

	case done:
	  fputc (c, fpout);
	  break;
	  

	default:
	  printf ("*** ops\n");
	  state = done;
	  break;
	}

    }

}
