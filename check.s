warship				EQU	0x20000400
civilship			EQU	0x20000500
shipcounter			EQU	0x20000600
cursor				EQU	0x20000650
clear_counter		EQU	0x20000498
mine				EQU	0x20000480
systick_counter		EQU	0x20000470
lose_flag			EQU	0x20000630
hit_number			EQU 0x20000540

;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		text,READONLY,CODE
			THUMB
			EXTERN		PRINT
			EXPORT		check_warship
			EXPORT		check_civilship
			IMPORT		victory
			IMPORT		lost


;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
check_warship 	PROC
			PUSH	{LR,R0,R1,R5,R6}			
			
			; parameters
			; R5 = mine X
			; R6 = mine effective Y
			
			LDR	R0,=warship
			LDR	R1,[R0]
lpl			CMP	R1,#0
			BEQ	end2
			LDR	R8, [R0,#4]		; R8 = warship X
			BIC	R8, #0x80
			LDR	R9,	[R0,#8]	
			BIC	R9, #0x40
			LDR	R10, [R0,#12]!	
			MOV	R12,#0
loope		LSR	R10, #1	; convert eff. bit
			ADD	R12, #1
			CMP	R10,#0
			BNE	loope	
			MOV	R10,R12	; finish eff. bit
			MOV	R7, #8
			MUL	R9, R7
			ADD	R9, R12			; R9 = warship effective Y

			CMP	R5,R8
			BLT	int_end
			ADD R8,#4			; width = 4
			CMP	R5,R8
			BGT	int_end
			
			CMP	R6,R9
			BLT	int_end
			ADD R9,#4			; height = 4
			CMP	R6,R9
			BGT	int_end
			
			LDR	R7,=hit_number
			LDR	R8,[R7]
			ADD	R8,#1
			STR	R8,[R7]

int_end		SUB	R1,#1
			B	lpl
			
end2		POP		{LR,R0,R1,R5,R6}
			BX		LR
			ENDP

check_civilship	PROC
			PUSH	{LR,R0,R1}			
			
			; parameters
			; R5 = mine X
			; R6 = mine effective Y
			
			LDR	R0,=civilship
			LDR	R1,[R0]
lpl2		CMP	R1,#0
			BEQ	end3
			LDR	R8, [R0,#4]		; R8 = civilship X
			BIC	R8, #0x80
			LDR	R9,	[R0,#8]		
			BIC	R9, #0x40
			LDR	R10, [R0,#12]!	
			MOV	R12,#0
loope2		LSR	R10, #1	; convert eff. bit
			ADD	R12, #1
			CMP	R10,#0
			BNE	loope2	
			MOV	R7, #8
			MUL	R9, R7
			ADD	R9, R12			; R9 = civilship effective Y

			CMP	R5,R8
			BLT	END31
			ADD R8,#8			; width = 8
			CMP	R5,R8
			BGT	END31
			
			CMP	R6,R9
			BLT	END31
			ADD R9,#2			; height = 2
			CMP	R6,R9
			BGT	END31

			LDR	R0,=lose_flag
			MOV	R1,#1
			STR	R1,[R0]
			B	end3

END31		SUB	R1,#1
			B	lpl2
			

			
end3		POP		{LR,R0,R1}
			BX		LR
			ENDP

			ALIGN
			END