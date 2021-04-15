	;; Boot, say hello, and loop forever
	;; NASM assembly, using a loop 
	
	bits 16			; Set 16-bit mode
	
	org 0x7c00		; Our load address (alternative way)

	mov ah, 0xe		; Configure BIOS tty mode

	mov bx, 0x0		; Load current RAM position
loop:	
	mov al, [msg + bx]	; Offset to 'msg' + RAM load address
	int 0x10		; Call BIOS video interrupt
	cmp al, 0x0		; Loop while char is not 0x0
	je end
	add bx, 0x1		; Point to the next character
	jmp loop		; Repeat until we find a 0x0

end:	
	jmp $			; Jump forever

msg:				; C-like NULL terminated string
	db 'H'
	db 'e'
	db 'l'
	db 'l'
	db 'o'
	db ' '
	db 'W'
	db 'o'
	db 'r'
	db 'l'
	db 'd'
	db 0x0
	
	times 510 - ($-$$) db 0	; Pad with zeros
	dw 0xaa55		; Boot signature

		
	;; Notes
	;;
	;; This should produce the same result than mbr-03.asm.
	;; This time, we use a loop to write 'Hello' string, which is naturally
	;; more efficient than manually writing character by character.
	;; On the other hand, we have to take into account the fact that BIOS
	;; will load the program at the specific address 0x7c00. We don't have
	;; and operating system taking care of translating relative memory
	;; address into physical RAM address. Welcome to real world.
