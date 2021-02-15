NVIC_EN0              EQU   0xE000E100
NVIC_PRI7             EQU   0xE000E41C

SYSCTL_RCGCGPIO 	  EQU 0x400FE608

GPIO_PORTF_DATA       EQU   0x400253FC
GPIO_PORTF_DIR        EQU   0x40025400
GPIO_PORTF_AFSEL      EQU   0x40025420
GPIO_PORTF_DEN        EQU   0x4002551C
GPIO_PORTF_LOCK       EQU   0x40025520
GPIO_PORTF_CR	      EQU   0x40025524
GPIO_PORTF_PUR	      EQU   0x40025510		
		
GPIO_PORTF_IS         EQU   0x40025404
GPIO_PORTF_IBE        EQU   0x40025408
GPIO_PORTF_IEV        EQU   0x4002540C
GPIO_PORTF_IM         EQU   0x40025410
GPIO_PORTF_RIS        EQU   0x40025414
GPIO_PORTF_MIS        EQU   0x40025418
GPIO_PORTF_ICR        EQU   0x4002541C

GPIO_PORTA_DATA       EQU   0x400043FC

debounce_count		  EQU	0x00180000

warship				EQU	0x20000400
civilship			EQU	0x20000500
shipcounter			EQU	0x20000600
cursor				EQU	0x20000650
clear_counter		EQU	0x20000498
mine				EQU	0x20000480
systick_counter		EQU	0x20000470

		; Initialization area
		AREA initisr , CODE, READONLY, ALIGN=2
		THUMB
		EXPORT	InitGPIO_F
		EXPORT	InitGPIO_Interrupt
		EXPORT	GPIOPortF_Handler
		IMPORT	clear_screen
		IMPORT	write_warship
		IMPORT	write_civilship
		IMPORT	first_player
		IMPORT	mine_f
			

; ****************************************************
; Configure GPIO
; ****************************************************
InitGPIO_F	PROC	
			LDR 		R1,=SYSCTL_RCGCGPIO
			LDR 		R0 , [R1 ]
			ORR 		R0 , R0 , #0x20	
			STR 		R0 , [R1 ]
			NOP
			NOP
			NOP 									; let GPIO clock stabilize
			
			LDR			R1, =GPIO_PORTF_LOCK
			MOV32		R0, #0x4C4F434B
			STR			R0, [R1]
			
			LDR			R1, =GPIO_PORTF_CR
			MOV			R0, #0xff
			STR			R0, [R1]
			
			LDR 		R1 , =GPIO_PORTF_DIR 		; config.of port B starts
			LDR 		R0 , [R1 ]
			BIC 		R0 , #0xFF		
			STR 		R0 , [R1 ]
			
			LDR 		R1 , =GPIO_PORTF_AFSEL		
			LDR 		R0 , [R1 ]
			BIC 		R0 , #0xFF					; AFSEL deactivated
			STR 		R0 , [R1 ]
			
			LDR 		R1 , =GPIO_PORTF_DEN
			MOV 		R0 , #0x11
			STR 		R0 , [R1 ] 					
			
			LDR 		R1 , =GPIO_PORTF_PUR		; Set pull up resistors
			MOV 		R0 , #0x11				
			STR 		R0 , [R1 ]		
	
			BX			LR
			ENDP

; ****************************************************
; Configure and initialize GPIO Interrupt
; ****************************************************
InitGPIO_Interrupt PROC
			LDR	R1, =GPIO_PORTF_IS
			LDR R2, =GPIO_PORTF_IBE
			LDR R3, =GPIO_PORTF_IEV
			LDR R4, =GPIO_PORTF_IM
			LDR R5, =GPIO_PORTF_ICR
			MOV R0, #0x00
			STR R0, [R1]
			STR R0, [R2]
			STR	R0, [R3]
			MOV	R0, #0x11
			STR R0, [R4]
			STR R0, [R5]

			LDR R1, =NVIC_PRI7
			LDR R2, [R1]
			AND R2, R2, #0xFF00FFFF ;
			ORR R2, R2, #0x00800000 ;
			STR R2, [R1]
			LDR R1, =NVIC_EN0
			MOV R2, #0x40000000 ; set bit 19 to enable interrupt 19
			STR R2, [R1]

			BX	LR
			ENDP

; ****************************************************
; GPIO ISR area
; ****************************************************
GPIOPortF_Handler  PROC	
			PUSH		{LR}
			
			LDR			R0,=debounce_count		
LOOP		SUBS		R0,#1			
			BNE			LOOP

			LDR			R1, =GPIO_PORTF_RIS
			LDR			R0, [R1]
			
			CMP			R0, #0x1
			BEQ			BUTTON2

BUTTON1
			
			LDR	R0,=shipcounter
			LDR	R1,[R0]
			CMP	R1,#4
			BLT	add_ship
			BEQ	clear_1
			CMP	R1,#5
			BEQ	player2_start
			CMP	R1,#9
			BGT	end2
			
			BL mine_f
			B end2
			
add_ship
			LDR	R0,=cursor
			LDR	R5,[R0]		; inst. x
			LDR	R6,[R0,#4]	; inst. y
			LDR	R7,[R0,#8]	; inst. bit
			LDR R0, =warship
			LDR	R1,[R0]	; R1 = warship counter
			MOV	R3,#12	
			MUL	R2,R3,R1	; R2 = 12*counter
			ADD	R0,R2
			STR	R5, [R0,#4]	
			STR	R6,	[R0,#8]
			STR	R7, [R0,#12]
			LDR R0, =warship
			LDR	R1,[R0]	; R1 = warship counter
			ADD	R1,#1
			STR	R1,[R0]
			B	end2
			
clear_1
			BL	clear_screen
			LDR		R0,=clear_counter
			MOV		R1,#1
			STR		R1,[R0]
			B	end2
			
player2_start
			;show all ships
			BL	first_player
			;DELAY 0.5 seconds
			MOV32		R0,#0x4C4B40		
LOOP3		SUBS		R0,#1			
			BNE			LOOP3
			;clear
			BL	clear_screen
			B	end2
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
		
BUTTON2					
			
			LDR	R0,=shipcounter
			LDR	R1,[R0]
			CMP	R1,#4
			BLT	add_ship2
			BEQ	clear_12
			CMP	R1,#5
			BEQ	player2_start2
			
			BL mine_f
			B	end2
			
add_ship2
			LDR	R0,=cursor
			LDR	R5,[R0]		; inst. x
			LDR	R6,[R0,#4]	; inst. y
			LDR	R7,[R0,#8]	; inst. bit
			LDR R0, =civilship
			LDR	R1,[R0]	; R1 = civilship counter
			MOV	R3,#12	
			MUL	R2,R3,R1	; R2 = 12*counter
			ADD	R0,R2
			STR	R5, [R0,#4]	
			STR	R6,	[R0,#8]
			STR	R7, [R0,#12]
			LDR R0, =civilship
			LDR	R1,[R0]	; R1 = warship counter
			ADD	R1,#1
			STR	R1,[R0]
			B	end2
			
clear_12
			BL	clear_screen
			LDR		R0,=clear_counter
			MOV		R1,#1
			STR		R1,[R0]
			B	end2
			
player2_start2
			;show all ships
			BL	first_player
			;DELAY 0.5 seconds
			MOV32		R0,#0x4C4B40		
LOOP4		SUBS		R0,#1			
			BNE			LOOP4
			;clear
			BL	clear_screen
			B	end2
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
			
			
end2		LDR R0, =shipcounter
			LDR	R1,[R0]	; R1 = warship counter
			ADD	R1,#1
			STR	R1,[R0]	

			LDR 		R1, =GPIO_PORTF_ICR			; to prevent infinite interrupt cycle, clear RIS 
			MOV 		R0, #0x11
			STR 		R0, [R1]

			POP			{LR}
			BX			LR
			ENDP

			ALIGN
			END