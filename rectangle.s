GPIO_PORTA_DATA        EQU         0x400043FC

;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		rect,READONLY,CODE
			THUMB
			EXTERN		PRINT
			EXPORT		rectangle

rectangle
;;;; HORIZONTAL 1	
			PUSH {LR}
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared(control mode)
			STR	R0,[R1]	
			
			MOV	R2,#0x5					; Set x address
			ORR	R2, #0x80
			BL 	PRINT
			
			MOV	R2, #0x40			; Base address for y			
			BL 	PRINT
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			
			MOV	R3,#5
			MOV	R2,#0x80
loop1		BL PRINT
			ADD R3,#1
			CMP	R3,#71
			BNE	loop1
			
			;;;; HORIZONTAL 2
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared(control mode)
			STR	R0,[R1]	
			

			MOV	R2,#0x5					; Set x address
			ORR	R2, #0x80
			BL 	PRINT
			
			MOV	R2, #0x45			; Base address for y: 0x40
			BL 	PRINT
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) cleared(data mode)
			STR	R0,[R1]	
			
			MOV	R3, #5
			MOV	R2,#0x01
loop2		BL PRINT
			ADD R3,#1
			CMP	R3,#71
			BNE	loop2
			
			;;; VERTICAL 1
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared (control mode)
			STR	R0,[R1]	
			

			MOV	R2,#0x4					; Set x address
			ORR	R2, #0x80
			BL 	PRINT
			
			MOV	R2, #0x41			; Base address for y: 0x40
			BL 	PRINT
			
			MOV	R2, #0x22
			BL	PRINT
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) cleared (data mode)
			STR	R0,[R1]	
			
			MOV	R2,#0xFF
			MOV	R3, #1
loop3		BL PRINT
			ADD R3,#1
			CMP	R3,#5
			BNE	loop3
			
			;;; VERTICAL 2
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared (control mode)
			STR	R0,[R1]	
			

			MOV	R2,#71				; Set x address
			ORR	R2, #0x80
			BL 	PRINT
			
			MOV	R2, #0x41			; Base address for y: 0x40
			BL 	PRINT
			
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	
			
			MOV	R2,#0xFF
			MOV	R3, #1
loop4		BL PRINT
			ADD R3,#1
			CMP	R3,#5
			BNE	loop4
			POP {LR}
			BX	LR
			END