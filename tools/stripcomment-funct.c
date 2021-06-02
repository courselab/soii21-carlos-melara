/* stripcommen.c - Replace copyright note.
 
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

#include <stdio.h>
#include <stdlib.h>
#include "../config.h"
#include "debug.h"

enum state_t
  {
      body,	     /* Body of the program. */
      state_1,	     /* Start of comment. */
      state_2,
      state_3,
      state_4,	     /* End of comment. */
      done	     /* Finished. */
  };


void strip_c (FILE *fpin, FILE *fpout, int global)
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
	      state = state_1;
	      buffer[i++] = c;
	      break;
	    default:
	      fputc (c, fpout);
	      break;
	    }
	  break;

	case state_1:
	  switch (c)
	    {
	    case '*':
	      state = state_2;
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

	case state_2:
	  switch (c)
	    {
	    case '*':
	      state = state_3;
	      break;
	    default:
	      break;
	    }
	  break;

	case state_3:
	  switch (c)
	    {
	    case '/':
	      state = global ? body : done;
	      break;
	    default:
	      state = state_2;
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

void strip_Makefile (FILE *fpin, FILE *fpout, int global)
{
  int c;
  enum state_t state = body;
  
  while ( ((c = fgetc (fpin)) != EOF ) )
    {
      
      switch (state)
	{

	case body:
	  switch (c)
	    {
	    case '#':
		state = state_1;
	      break;
	    default:
		fputc (c, fpout);
	      break;
	    }
	  break;

	case state_1:
	  switch (c)
	    {
	    case '\n':
	      state = state_2 ;
	      break;
	    default:
	      break;
	    }
	  break;

	case state_2:
	  switch (c)
	    {
	    case '\n':
	    case '\r':
	    case '\t':
	      state = global ? body : done;
	      break;
	    case '#':
	      state = state_1;
	    default:
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
