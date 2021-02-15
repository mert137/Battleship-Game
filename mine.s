warship				EQU	0x20000400
civilship			EQU	0x20000500
shipcounter			EQU	0x20000600
cursor				EQU	0x20000650
clear_counter		EQU	0x20000498
mine				EQU	0x20000480
systick_counter		EQU	0x20000470

;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		text,READONLY,CODE
			THUMB
			EXTERN		PRINT
			EXPORT		mine_f


;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
mine_f		PROC
			PUSH	{LR,R1}			
			LDR	R0,=cursor
			LDR	R5,[R0]		; inst. x
			LDR	R6,[R0,#4]	; inst. y
			LDR	R7,[R0,#8]	; inst. bit
			LDR R0, =mine
			LDR	R1,[R0]		; R1 = mine
			MOV	R3,#12	
			MUL	R2,R3,R1	; R2 = 12*counter
			ADD	R0,R2
			STR	R5, [R0,#4]	
			STR	R6,	[R0,#8]
			STR	R7, [R0,#12]
			LDR R0, =mine
			LDR	R1,[R0]	; R1 = mine counter
			ADD	R1,#1
			STR	R1,[R0]

			POP		{LR,R1}
			BX		LR
			ENDP
			ALIGN
			END