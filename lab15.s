// Style Sheet
// Programmer   : Jacob Campbell
// Lab #        : 15
// Purpose      : IO Write
// Date         : 4/4/2023
// Leading 0 indicates that a number is Octal (Base 8 notation)

	.EQU	R,		00		// READ ONLY
	.EQU	W,		01		// WRITE ONLY
	.EQU	RW, 	02		// READ/WRITE
	.EQU	T_RW,	01002	// Truncate READ/WRITE
	.EQU	C_W,	0101	// Create file if it dne
	.EQU	WRITE, 	64		// write
	.EQU	CLOSE,	57		// Close the file
// FILE PERMISSIONS
// OWNER	GROUP	OTHER
// RWE		RWE		RWE
			.EQU	RW_______, 0600

			.EQU	AT_FDCWD, -100		// local directory
	.data
szFile:		.asciz	"lab15.txt"
fileBuf:	.skip	512
iStrLen:	.byte	16
iFD:		.quad	0
szEOF:		.asciz	"Reached the End of File"
szErr:		.asciz	"FILE READ ERROR\n"
szMsg:		.asciz	"Assembly Rules\n"

	.global _start
	.text
_start:
// 1) Open the file
	MOV		X0, #AT_FDCWD	// *X0 = local directory, File Descriptor will be returned
	MOV		X8, #56			// OPENAT
	LDR		X1,=szFile		// Pointer to C-String: Use File Name

	MOV		X2, #C_W		// MODE: Create if dne
	MOV		X3, #RW_______	// Permission
	SVC 	0				// Service Call 0 (iosetup)

// Load program input into file
	MOV		X8, #WRITE		// *X8 = WRITE (64)
	LDR		X1,=szMsg		// *X1 = szMsg (Assembly Rules)
	LDR		X2,=iStrLen		// Load address pointing to string length buffer
	LDR		X2, [X2]		// Dereference for length
	SVC		0				// Service Call 0 (iosetup)

	MOV		X8, #CLOSE		// Close the file
	SVC		0				// Service call 0 (iosetup)

// Initialize registers
	MOV		X0, #0			// Use return code 0 (iosetup)
	MOV		X8, #93			// Service command 93 (exit)
	SVC		0				// Service code 0 (iosetup)
	.end

