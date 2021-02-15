systick_counter		EQU	0x20000470
NVIC_ST_CURRENT		EQU 0xE000E018
GPIO_PORTA_DATA     EQU 0x400043FC
mine				EQU	0x20000480
lose_flag			EQU	0x20000630
NVIC_ST_CTRL		EQU 0xE000E010
hit_number			EQU 0x20000540
civilship			EQU	0x20000500
game_over			equ	0x20000638
victor				EQU	0x20000634
	
			AREA		text,READONLY,CODE
			THUMB
			EXPORT		SysTick_Handler
			IMPORT		one
			IMPORT		two	
			IMPORT		three
			IMPORT		four
			IMPORT		five
			IMPORT		six
			IMPORT		seven
			IMPORT		eight
			IMPORT		nine
			IMPORT		ten
			IMPORT		eleven
			IMPORT		twelve
			IMPORT		thirteen
			IMPORT		fourteen
			IMPORT		fifteen
			IMPORT		sixteen
			IMPORT		seventeen
			IMPORT		eighteen
			IMPORT		nineteen
			IMPORT		twenty
			IMPORT		PRINT
			IMPORT		check_warship
			IMPORT		check_civilship
			IMPORT		victory
			IMPORT		lost
				

SysTick_Handler  PROC	
			PUSH {LR,R9}

			LDR	R0,=systick_counter
			LDR	R1,[R0]
			CMP	R1,#20
			BGT	else1
			
			ADD	R1,#1
			STR	R1,[R0]
			MOV	R8,R1
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared (control mode)
			STR	R0,[R1]		
			
			MOV	R2,#0xCD
			BL	PRINT
			
			MOV	R2,#0x40
			BL	PRINT
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]		
			
			MOV	R1,R8
			CMP	R1,#1
			BLEQ	one
			CMP	R1,#2
			BLEQ	two
			CMP	R1,#3
			BLEQ	three
			CMP	R1,#4
			BLEQ	four
			CMP	R1,#5
			BLEQ	five
			CMP	R1,#6
			BLEQ	six
			CMP	R1,#7
			BLEQ	seven
			CMP	R1,#8
			BLEQ	eight
			CMP	R1,#9
			BLEQ	nine
			CMP	R1,#10
			BLEQ	ten
			CMP	R1,#11
			BLEQ	eleven
			CMP	R1,#12
			BLEQ	twelve
			CMP	R1,#13
			BLEQ	thirteen
			CMP	R1,#14
			BLEQ	fourteen
			CMP	R1,#15
			BLEQ	fifteen
			CMP	R1,#16
			BLEQ	sixteen
			CMP	R1,#17
			BLEQ	seventeen
			CMP	R1,#18
			BLEQ	eighteen
			CMP	R1,#19
			BLEQ	nineteen
			CMP	R1,#20
			BLEQ	twenty

			LDR	R0,=NVIC_ST_CURRENT
			MOV	R1,#10
			STR	R1,[R0]

			B	end3	
			
else1		
			LDR R1 , =NVIC_ST_CTRL
			MOV	R0 , #0x0
			STR R0 , [R1]
			LDR	R0,=mine
			LDR	R1,[R0]
			
lpl			CMP	R1,#0			; BEGINNING OF THE END
			BEQ	result
			LDR	R5, [R0,#4]		; R5 = X
			BIC	R5, #0x80		
			LDR	R6,	[R0,#8]		; R6 = Y
			BIC	R6, #0x40
			LDR	R7, [R0,#12]!	; R7 = BIT
			MOV	R12,#0
loope		LSR	R7, #1	; convert eff. bit
			ADD	R12, #1
			CMP	R7,#0
			BNE	loope	
			MOV	R7,R12	; finish eff. bit
			MOV	R8, #8
			MUL	R6, R8
			ADD	R6, R7			; R6 = effective Y
			BL	check_warship
			BL	check_civilship
			SUB	R1,#1
			B	lpl

result		LDR	R0,=game_over
			MOV	R1,#1
			STR	R1,[R0]
			LDR	R0,=lose_flag
			LDR	R1,[R0]
			CMP	R1,#1
			BEQ	lst
			LDR	R0,=hit_number
			LDR	R1,[R0]
			LDR	R2,=civilship
			LDR	R3,[R2]
			ADD	R1,R3
			CMP	R1,#4
			BLT	lst
			LDR	R0,=victor
			MOV	R1,#1
			STR	R1,[R0]
			B	end3
			
lst			LDR	R0,=victor
			MOV	R1,#0
			STR	R1,[R0]

end3		POP	{LR,R9}
			BX	LR
			ENDP
			ALIGN
			END