warship				EQU	0x20000400
civilship			EQU	0x20000500
shipcounter			EQU	0x20000600
cursor				EQU	0x20000650
clear_counter		EQU	0x20000498
mine				EQU	0x20000480
systick_counter		EQU	0x20000470
lose_flag			EQU	0x20000630
GPIO_PORTA_DATA        EQU         0x400043FC

;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		text,READONLY,CODE
			THUMB
			EXTERN		PRINT
			EXPORT		victory
			EXPORT		lost
			IMPORT		clear_screen

;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
victory 	PROC
			PUSH	{LR}
			
			BL	clear_screen
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared (control mode)
			STR	R0,[R1]	
			
			MOV	R2,#0x43
			BL	PRINT
			MOV	R2,#0xA4
			BL	PRINT
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			
			MOV	R2,#0xFF
			BL	PRINT
			MOV	R2,#0x40
			BL	PRINT
			MOV	R2,#0x20
			BL	PRINT
			MOV	R2,#0x40
			BL	PRINT
			MOV	R2,#0xFF
			BL	PRINT
			
			POP		{LR}
			BX		LR
			ENDP
				
				
lost	 	PROC
			PUSH	{LR}
			
			BL	clear_screen
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared(control mode)
			STR	R0,[R1]	
			
			MOV	R2,#0x43
			BL	PRINT
			MOV	R2,#0xA4
			BL	PRINT
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			
			MOV	R2,#0xFF
			BL	PRINT
			MOV	R2,#0x80
			BL	PRINT
			MOV	R2,#0x80
			BL	PRINT
			MOV	R2,#0x80
			BL	PRINT
			MOV	R2,#0x80
			BL	PRINT
			
			POP		{LR}
			BX		LR
			ENDP
			ALIGN
			END