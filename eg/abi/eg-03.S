
	global _start:

	section .text

_start:
	mov $43, %ebx
	mov $1, %eax
	int 0x80

	
