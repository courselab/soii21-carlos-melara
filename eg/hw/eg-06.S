       # Our first "Hello World!" in AT&T syntax, gas dialect
       
	
	.code16               # Set 16-bit code
	.text

_start:		              # Needed (GAS has no equivalent to NASM $$)

	movb  $0xe, %ah	      # BIOS tty mode
	
	movw  $0x0, %bx	      
loop:			      # Write the string
	movb  here(%bx), %al
	int   $0x10	
	cmp   $0x0, %al	
	je    end
	add   $0x1, %bx	       # Point to the next character
	jmp   loop	       # Repeat until we find a 0x0
	
end:				
	jmp   end	       # Jump forever (alt to 0x0, or .)

here:			       # C-like NULL terminated string

	.string    "Hello World"
	
	.fill 510 - (. - _start), 1, 0       # Pad with zeros
	.word 0xaa55			     # Boot signature


	# Notes
	#
	# This intentionally a literal translation of mbr-05.asm
	# into AT&T GASM assembly. This may not be the neater approach
	# to it. In the next example we taks advantages of GASM features.

	
