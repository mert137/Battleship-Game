warship				EQU	0x20000400
civilship			EQU	0x20000500
shipcounter			EQU	0x20000600
cursor				EQU	0x20000650

;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		main,READONLY,CODE
			THUMB
			EXTERN		PRINT
			EXPORT		first_player
			IMPORT		write_civilship
			IMPORT		write_warship


;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
first_player PROC
			PUSH	{LR,R1}			
			LDR		R0, =warship
			LDR		R1, [R0]		; R1 = counter
count		CMP		R1, #0
			BEQ		civil
			LDR		R2, [R0,#4]!	; R2 = X
			LDR		R3, [R0,#4]!	; R3 = Y
			LDR		R4, [R0,#4]!	; R4 = bit
			BL		write_warship
			SUB		R1, #1
			B		count
			
civil		LDR		R0, =civilship
			LDR		R1, [R0]		; R1 = counter
count2		CMP		R1, #0
			BEQ		finish
			LDR		R2, [R0,#4]!	; R2 = X
			LDR		R3, [R0,#4]!	; R3 = Y
			LDR		R4, [R0,#4]!	; R4 = bit
			BL		write_civilship
			SUB		R1, #1
			B		count2

finish		POP		{LR,R1}
			BX		LR
			ENDP
			END