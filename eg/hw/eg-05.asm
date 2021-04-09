	;; Boot, say hello, and loop forever
	;; NASM assembly, neater version wit loop

	bits 16			; Set 16-bit mode
	
	org 0x7c00		; Our load address (alternative way)

	mov ah, 0xe		; BIOS tty mode

	mov bx, 0		; May be 0 because org directive.
loop:				
	mov al, [msg + bx]	; Ofsset to the message
	int 0x10		; Call BIOS video interrupt
	cmp al, 0x0
	je end
	add bx, 0x1		; Point to the next character
	jmp loop		; Repeat until we find a 0x0

end:				
	jmp end			; Jump forver (alt to end, or 0x0)

msg:				; C-like NULL terminated string

	db 'Hello World', 0x0
	
	times 510 - ($-$$) db 0	; Pad with zeros
	dw 0xaa55		; Boot signature

		
	;; Notes
	;;
	;; In worship to the seven hacker gods and for the honor of
	;; source code realm, we hereby humbly offer our sacred 
	;; "Hello World" sacrifice. May our code remain bugless.
