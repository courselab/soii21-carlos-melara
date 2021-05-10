	;; Boot, say hello, and halt
	;; NASM assembly, neater version wit a loop

	bits 16			; Set 16-bit mode
	


	mov ah, 0xe		; BIOS tty mode

	mov bx, 0x7c00		; Absolute load address of msg
loop:				
	mov al, [msg + bx]	; Ofsset to the message
	int 0x10		; Call BIOS video interrupt
	cmp al, 0x0		; Loop while char is not 0x0 
	je halt			; Jump to halt
	add bx, 0x1		; Point to the next character
	jmp loop		; Repeat until we find a 0x0

halt:
	hlt			; Halt
	jmp halt		; Safeguard

msg:				; C-like NULL terminated string

	db 'Hello World', 0x0
	
	times 510 - ($-$$) db 0	; Pad with zeros
	dw 0xaa55		; Boot signature


	;; Notes
	;;
	;;  Directive db outputs a sequence of bytes.
	;;
	;;  This code uses instructions access memory positions.
	;;  We need to take into account that the program will be loaded
	;;  at some position in RAM, so that msg+bx points to the
	;;  right place.
