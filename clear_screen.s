warship				EQU	0x20000400
civilship			EQU	0x20000500
shipcounter			EQU	0x20000600
cursor				EQU	0x20000650
clear_counter		EQU	0x20000498
mine				EQU	0x20000480
systick_counter		EQU	0x20000470

GPIO_PORTA_DATA        EQU         0x400043FC

			AREA		main,READONLY,CODE
			THUMB
			EXTERN		PRINT
			EXPORT		clear_screen
			IMPORT		rectangle


clear_screen PROC
			PUSH	{LR,R0}
			MOV	R0, #503
jump		MOV	R2,#0
			BL	PRINT
			SUBS R0,#1
			BNE jump
			
			BL	rectangle
						
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared (control mode)
			STR	R0,[R1]	
			
			MOV	R2, #0x20				; Set basic mode to be able to [x y] addressing
			BL	PRINT
			

			POP		{LR,R0}
			BX		LR
			ENDP
			ALIGN
			END