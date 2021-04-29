	## Boot, say hello, and loop forever
	## AT&T assembly, using 32-bit registers
       
	.code16                 # Set 16-bit code

	.global _start
	
_start:		                # Entry point

	movb
	
	movl  $0x0, %ebx        # Using linker's org flag
loop:			      
	movl  msg(%ebx),  %edx  # This is equivalent to
	andl  $0xff, %edx       #
	movl  $0xe00, %eax      # movb msg(%bx), %al
	xorl  %edx, %eax        #
	
	int   $0x10
	
	andl  $0xff, %eax       # Equivalent to
	cmp   $0x0, %eax        # cmp $0x0, $al
	
	je    halt
	add   $0x1, %ebx       # Point to the next character

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
	# The same program, but using 32-bit registers.

