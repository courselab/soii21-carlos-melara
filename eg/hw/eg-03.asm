	;; Boot, say hello, and loop forever
	;; NASM assembly, naive char by char, manually
	
	bits 16			; Set 16-bit mode
	
	mov ah, 0xe		; set BIOS teletype mode

	mov al, 'H'		; Load 'H' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, 'e'		; Load 'H' ascii code; 
	int 0x10		; Issue BIOS interrupt

	mov al, 'l'		; Load 'H' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, 'l'		; Load 'H' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, 'o'		; Load 'H' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, ' '		; Load ' ' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, 'W'		; Load 'W' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, 'o'		; Load 'o' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, 'r'		; Load 'r' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, 'l'		; Load 'l' ascii code
	int 0x10		; Issue BIOS interrupt

	mov al, 'd'		; Load 'd' ascii code
	int 0x10		; Issue BIOS interrupt

	jmp $			; Loop forever (shorter version)

	times 510 - ($-$$) db 0	; Pad with zeros
	dw 0xaa55		; Boot signature



	;; Notes
	;;
	;; BIOS interruption 0x10 causes the process flow to jump to the
	;; interruption vector table area, where there is a pre-loaded BIOS
	;; routine capable of output characters at the video device.
	;;
	;; This interruption handler routine reads the byte at the 8-bit
	;; register and send to the video controller. The video operation
	;; mode (e.g. ascii character) is controlled by register ah.
	;; After completing the operation, execution flow is returned to
	;; the next line after 'int' instruction.
