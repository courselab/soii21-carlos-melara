	## Boot, say hello, and loop forever
	## AT&T assembly, translated from NASM
	
	.code16               # Set 16-bit code


	
begin:		              # Needed (GAS has no equivalent to NASM $$)
	
	movb  $0xe, %ah	      # BIOS tty mode
	
	movw  $0x0, %bx	      
loop:			      # Write the string
	movb  msg(%bx), %al
	int   $0x10	
	cmp   $0x0, %al	
	je    halt
	add   $0x1, %bx	       # Point to the next character
	jmp   loop	       # Repeat until we find a 0x0
	
halt:
	hlt		       # Halt
	jmp   halt	       # Safeguard

msg:			       # C-like NULL terminated string

	.string    "Hello World"
	
	.fill 510 - (. - begin), 1, 0       # Pad with zeros
	.word 0xaa55			     # Boot signature


	# Notes
	#
	# This is a intentionally literal translation of mbr-04.asm
	# into AT&T Gas assembly. It may not be the neater approach ;
	# in the next examples we taks advantages of GASM features. 

	
