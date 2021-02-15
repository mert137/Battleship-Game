;********************************************************************
; PROGRAM SECTION					      
;********************************************************************	
;LABEL  	DIRECTIVE   VALUE       COMMENT	              
			AREA    	SUBROUTINES, READONLY, CODE, ALIGN=2  
			EXPORT      DELAY100  
			THUMB
				
DELAY100	PUSH		{R1}
			LDR			R1,=534000	; =16 Mhz clock / 3 clock cycles for each iteration 
LOOP		SUBS		R1,#1		; takes 1 clock cycle to execute
			BNE			LOOP		; takes 2 clock cycles to execute
			POP			{R1}
			BX			LR
			END

;********************************************************************
; END OF PROGRAM SECTION					      
;********************************************************************