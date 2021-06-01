/* main.c - Main program of MbrCmd
 
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



#include <mbr.h>


int main()
{
  char b[10];
  
  clear();

  while (1)
    {
  
      print (PROMPT);

      read (b);
      
      if (compare(b, "help"))
	help();
      else if (compare(b, "quit"))
	quit();
      else
	{
	  print (b);
	  printnl (": command not found.");
	}
    }
  
  return 0;

}
