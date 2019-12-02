@@Complete Assembly Program
@.equ SWI_Exit, 0x11
@.text

@mov r7, #10 	@to multiply by 10
@ldr   r1, =AA	@ getting address of arrary ## universal
@mov r0, #0 	@Final Answer maybe
@mov r6, #0	@To store the multiplication
@mov r8, #48 	@To store a constant '0'

.global	program, expression, expTail, term, constant, consTail

program:
	mov r10,lr	@saving return address
	ldrb r2, [r1, #0]	   @load first character in r2
	cmp r2,#0 	@exit
        beq exit
	bl expression
	cmp r2,#0 	@exit
        beq exit

expression:	@Returns R3 since if only a constant in term then it becomes R4 = R3 assignment and if not then expTail returns R3 and thus, the final Answer is in R3
	ldrb r2, [r1, #0]	   @load first character in r2
	cmp r2,#0 	@exit
        beq exit
	
	str lr,[sp,#-4]!
	bl expTail

	bl term

	cmp r2, #46
	bllt expTail
	ldr lr , [sp],#4
	mov pc,lr


expTail:	@Takes R3 and returns the answer in R3
	ldrb r2, [r1, #0]	   @load first character in r2
	cmp r2,#0 	@exit
        beq exit
	@cmp r2,#40	@check if Parenthesis OPEN
	@moveq r2,r8	@CONVERTING ( to ZERO ASCII
	str lr,[sp,#-4]!


	ldrb r2, [r1, #0]	   @load first character in r2

	cmp r2,#43 	@add
	beq add
	cmp r2,#42	@mult
	beq mult
	cmp r2,#45	@sub
	beq sub
	b end

        add:
		 add   r1, r1, #1	@INCREMENting the ptr
		 mov r5,r3		@Saving R3 since I feel that it would be changed in Term()
		 str r5 , [sp,#-4]! @need to save in stack so doesn't get lost
		 bl term		@We get R4
		 ldr r5 ,[sp],#4
		 add r3, r5,r3		@Adding initial Value of R3 to the obatined R4 from the term() as assumed
		 bl expTail
 		 b end

	mult:
		 add   r1, r1, #1	@INCREMENting the ptr
		 mov r5,r3		@Saving R3 since I feel that it would be changed in Term()
		 str r5 , [sp,#-4]! @need to save in stack so doesn't get lost
		 bl term		@We get R4
		 ldr r5 ,[sp],#4
		 mov r9, r3
		 mul r3, r5,r9		@Adding initial Value of R3 to the obatined R4 from the term() as assumed
		 bl expTail
 		 b end

	sub:
		 add   r1, r1, #1	@INCREMENting the ptr
		 mov r5,r3		@Saving R3 since I feel that it would be changed in Term()
		 str r5 , [sp,#-4]! @need to save in stack so doesn't get lost
		 bl term		@We get R4
		 ldr r5 ,[sp],#4
		 sub r3, r5,r3		@Adding initial Value of R3 to the obatined R4 from the term() as assumed
		 bl expTail
 		 b end


	end:
		ldr lr , [sp],#4
	        mov pc,lr

term:  		@Returns r4
	ldrb r2, [r1, #0]	   @load first character in r2
	cmp r2,#0 	@exit
        beq exit

	str lr,[sp,#-4]!
	mov  r4, #0	@inititalizing int X to 0
      ldrb r2, [r1, #0]	   @load first character in r2
      cmp r2,#40 	@ '(' obtained
      bne constantPointer
	add r1,r1,#1	@check if next is a -
	ldrb r2,[r1,#0]
	cmp r2,#45
	bne NotMinus
	sub r1,r1,#1		@go back to (
	strb r8,[r1,#0]		@ ADDING A ZERO instead of (
   NotMinus:
      	@add   r1, r1, #1	@INCREMENTING
      	bl expression
      	add r1, r1, #1 	@Incrementing the ptr
	b endTerm

	constantPointer:
			bl constant
			mov r4,r3
			b endTerm

	endTerm:
	      ldr lr , [sp],#4
	      mov pc,lr

constant: 	@Return R3
	ldrb r2, [r1, #0]	   @load first character in r2
	cmp r2,#0 	@exit
        beq exit

	str lr,[sp,#-4]!

   	sub r2,r2,#48	@ read next digit storing in r1
	mov r3, r2 	@Storing the value in R3 since R2 is meant for *P
	add r1, r1, #1 	@Incrementing the ptr

 	bl consTail

	ldr lr , [sp],#4
      	mov pc,lr

consTail:	@Takes R3 as X input and returns R3
	@ldrb r2, [r1, #0]	   @load first character in r2
	@cmp r2,#0 	@exit
        @beq exit

	str lr,[sp,#-4]!

	ldrb r2, [r1, #0]	   @load first character in r2

	cmp r2, #48
        bge consTailPointer

        b exitConsTail

	consTailPointer:
			mul r6,r3,r7
			mov r3, r6
			add r3, r3, r2
			add r1, r1, #1
			sub r3, r3, #48
                        bl consTail


	exitConsTail:
		ldr lr , [sp],#4
	      	mov pc,lr


exit:
	mov r0, r3
	mov pc,r10



.end
