// Style Sheet
// Programmer   : Jacob Campbell
// Lab #        : 15
// Purpose      : IO Write
// Date         : 4/4/2023

	.EQU	R,		00		// READ ONLY
	.EQU	W,		01		// WRITE ONLY
	.EQU	RW, 	02		// READ/WRITE
	.EQU	T_RW,	01002	// Truncate READ/WRITE
	.EQU	C_W,	0101	// Create file if it dne
// FILE PERMISSIONS
// OWNER	GROUP	OTHER
// RWE		RWE		RWE
			.EQU	RW_______, 0600

			.EQU	AT_FDCWD, -100		// local directory
	.data
szFile:		.asciz	"lab15.txt"
fileBuf:	.skip	512
iFD:		.quad	0
szEOF:		.asciz	"Reached the End of File"
szErr:		.asciz	"FILE READ ERROR\n"

	.global _start
	.text
_start:
// 1) Open the file
	MOV		X0, #AT_FDCWD	// *X0 = local directory, File Descriptor will be returned
	MOV		X8, #56			// OPENAT
	MOV		X1,=szFile		// Pointer to C-String: Use File Name

	MOV		X2, #RW			// Open with READ WRITE
	MOV		X3, #RW_______	// MODE: RW------
