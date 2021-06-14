	;; A minimal syscall example
	
	section .text		; Our program has only section .text

	global _start		; Make _start visible to the linker

_start:
	mov eax, 1		; Prepare to request syscall 1 (exit)
	mov ebx, 42		; Exit's argument is expected in ebx
	
	int 0x80		; Perform syscall


	
	;; Notes
	;; 
	;; When the following C program is compiled
	;;
	;; int main()
	;; {
	;;    return 42;
	;; }
	;;
	;; the resulting assembly code perform exactly this operation:
	;; loads the return status into ebx and trigger syscall exit.
