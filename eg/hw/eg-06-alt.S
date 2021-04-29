	## Boot, say hello, and loop forever
	## AT&T assembly, using 16-bit registers
	
	.code16               # Set 16-bit code

	.global _start         # So that symbol may be found by the linker

_start:		              # Default entry label
	
	movw  $0x0e00, %ax     # BIOS tty mode
	
	movw  $0x0, %bx       # Using linker's org flag	      

loop:			      
	andw  $0xff00, %ax
	movw  msg(%bx), %dx
	andw  $0x00ff, %dx
	orw   %dx, %ax
	int   $0x10	       # Call bios 
	cmp   $0x0, %dx	       # Loop while char is not 0x0
	je    halt             # Jump to halt
	add   $0x1, %bx	       # Point to the next character
	jmp   loop	       # Repeat until we find a 0x0
	
halt:
	hlt                    # Halt
	jmp   halt	       # Safeguard

msg:			       # C-like NULL terminated string

	.string    "Hello World"
	
	.fill 510 - (. - _start), 1, 0       # Pad with zeros
	.word 0xaa55			     # Boot signature


	# Notes
	#
	# We use the standard name for the entry point so we
	# don't need to pass it to the linker.


	
