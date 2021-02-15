GPIO_PORTA_DATA        EQU         0x400043FC

;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		main,READONLY,CODE
			THUMB
			EXTERN		PRINT
			EXPORT		write_civilship


;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
write_civilship		

			PUSH	{R0,R1,LR}
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			
			; R2 = x adresi ayarlandi
			BL 		PRINT
			
			MOV		R2,R3 ; y adresi ayarlandi
			BL 		PRINT

			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			
			; Bit = R4
		
			MOV	R8,#0
		
lll			ADD	R8,#1
			LSR	R4,#1
			CMP	R4,#0
			BNE	lll

if1			CMP	R8,#7
			BLT	else1
			
			MOV	R5,#1
			LSL	R7,R5,R8
			MOV	R6,#0x100
			SUB	R6,R7
			MOV	R2,R6
			MOV	R0,#8		; R0 counter 
loop1		BL	PRINT
			SUBS R0,#1
			BNE	loop1
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			
			ADD	R3,#1					; Y = Y + 1
			MOV	R2,R3
			BL	PRINT
			
			MOV	R2,R10					; R2 = initial X
			BL	PRINT
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			
			MOV	R5,#1
			SUB	R8,#3
			LSL	R5,R8
			SUB	R5,#1
			MOV	R2,R5
			MOV	R0,#8		; R0 counter 
loo2p		BL	PRINT
			SUBS R0,#1
			BNE	loo2p		
			
			B	end3
			
		
else1		MOV	R5,#1
			ADD	R6,R8,#2	; height of warship is 2
			LSL	R7,R5,R6	; R7 = LSL (bit+2)
			LSL	R5,R5,R8	; R5 = LSL (bit)
			SUB	R7,R5		; R7 = LSL (bit+2) - LSL (bit) -> write this 
			MOV	R2,R7
			MOV	R0,#8		; R0 counter 
loop		BL	PRINT
			SUBS R0,#1
			BNE	loop
			
			
end3		POP {R0,R1,LR}

			BX	LR
			ALIGN
			END