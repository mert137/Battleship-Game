;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		main,READONLY,CODE
			THUMB
			EXTERN		PRINT
			EXPORT		write_ship


;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
write_ship		

			PUSH	{R0,R1,R2,R3,R4,LR}
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) set(data mode)
			STR	R0,[R1]	
			
			ORR		R2, #0x80			; Set x address
			BL 		PRINT
			
			MOV		R2,R3
			ORR		R2, #0x40			; Set y address
			BL 		PRINT

			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			


			POP {R0,R1,R2,R3,R4,LR}