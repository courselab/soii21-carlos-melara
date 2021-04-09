	## Boot, say hello, and loop forever
	## AT&T assembly, using 32-bit registers
       
	
	.code16               # Set 16-bit code
	.text

_start:		              # Needed (GAS has no equivalent to NASM $$)


	
	movl  $0x0, %ebx	      
loop:			      # Write the string
	movl  msg(%ebx),  %edx
	andl  $0xff, %edx
	movl  $0xe00, %eax
	xorl  %edx, %eax
	
	int   $0x10
	
	andl  $0xff, %eax
	cmp   $0x0, %eax
	je    end
	add   $0x1, %ebx       # Point to the next character

	jmp   loop	       # Repeat until we find a 0x0
	
end:				
	jmp   end	       # Jump forever (alt to 0x0, or .)

msg:			       # C-like NULL terminated string

	.string    "Hello World"
	
	.fill 510 - (. - _start), 1, 0       # Pad with zeros
	.word 0xaa55			     # Boot signature
