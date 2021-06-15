	# A minimal syscall example
	
	.text		# Our program has only section .text

	.global _start		# Make _start visible to the linker

_start:
	mov $1, %eax		# Prepare to request syscall 1 (exit)
	mov $42, %ebx		# Exit's argument is expected in ebx
	
	int $0x80		# Perform syscall


	
	# Notes
	# 
	# When the following C program is compiled
	#
	# int main()
	# {
	#    return 42;
	# }
	#
	# the resulting assembly code perform exactly this operation:
	# loads the return status into ebx and trigger syscall exit.
