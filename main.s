@Complete Assembly Program
.equ SWI_Open, 0x66 @open a file
.equ SWI_Close,0x68 @close a file
.equ SWI_PrChr,0x00 @ Write an ASCII char to Stdout
.equ SWI_PrStr, 0x69 @ Write a null-ending string 
.equ SWI_PrInt,0x6b @ Write an Integer
.equ SWI_RdInt,0x6c @ Read an Integer from a file
.equ Stdout, 1 @ Set output target to be Stdout
.equ SWI_Exit, 0x11 @ Stop execution
.equ SWI_RdStr, 0x6a @ Read string from file
.equ SWI_PrStg, 0x02 @print to Stdout
.global _start
.text

mov r7, #10 	@to multiply by 10
@ldr   r2, =AA	@ to store final ans
mov r0, #0 	@Final Answer maybe
mov r6, #0	@To store the multiplication

@Functions 
	.extern	program, expression, expTail,term,consTail,constant 

openFile:
	ldr r0,	=FN	@output filename
	swi SWI_Open
readString:
	swi SWI_RdStr	@line read and address stored in r1
	ldrb r10,[r1,#0]	@read first ASCII
	cmp r10,#0		@check if null or not
	beq done 
callProgram:
	b program	@calling calculating funciton
intToString:
	mov r1,r2	@ to give address of output file
	b itoa		@ gives ascii string in r0
printStr:
	swi SWI_PrStg
	b readString
done:
	swi SWI_Close	@close file
	swi SWI_Exit	@exit program
.data
AA:   .space 400

ReadParams:
	.word    0                @ the file handle
	.word    InputBuffer      @ address of input buffer
	.word    80               @ number of bytes to read
InputBuffer:
	.skip    80
OpenParams:
	.word   FileName
	.word   FileNameEnd-FileName   @ length of filename
	.word   0                 @ File mode = read
FileName:
FN:	.ascii  "MyData.txt"      @ name without final NUL byte
FileNameEnd:
	.byte   0                 @ the NUL byte


