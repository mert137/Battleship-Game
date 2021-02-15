;PORTA BASE ADDRESS 0x40004000
GPIO_PORTA_DATA        EQU         0x400043FC
GPIO_PORTA_DIR         EQU         0x40004400
GPIO_PORTA_AFSEL       EQU         0x40004420
GPIO_PORTA_DEN         EQU         0x4000451C
GPIO_PORTA_PCTL        EQU     	   0x4000452C 
RCGCGPIO               EQU         0x400FE608
PCTL_DEFAULT           EQU         0x00202200 
SSICR0                 EQU         0x40008000
SSICR1                 EQU         0x40008004
SSICPSR                EQU         0x40008010
RCGCSSI                EQU         0x400FE61C
RCGCSSIWTF             EQU         0x400FE104
	
ADC0_SSFIFO2        EQU 0x40038088
ADC0_RIS            EQU 0x40038004
ADC0_ISC            EQU 0x4003800C
ADC0_PSSI           EQU 0x40038028

NVIC_ST_CTRL		EQU 0xE000E010

warship				EQU	0x20000400
civilship			EQU	0x20000500
shipcounter			EQU	0x20000600
cursor				EQU	0x20000650
clear_counter		EQU	0x20000498
mine				EQU	0x20000480
game_over			EQU	0x20000638
victor				EQU	0x20000634
lose_flag			EQU	0x20000630
hit_number			EQU 0x20000540
systick_counter		EQU	0x20000470


;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		main,READONLY,CODE
			THUMB
			EXTERN		PORTINIT
			EXTERN		PRINT
			EXTERN		DELAY100
			EXPORT		__main
			IMPORT		rectangle
			IMPORT		write_warship
			IMPORT		write_civilship
			IMPORT		first_player
			IMPORT		clear_screen
			IMPORT		InitGPIO_F	
			IMPORT		InitGPIO_Interrupt	
			IMPORT		victory
			IMPORT		lost


;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
__main		BL PORTINIT

			LDR		R0, =warship
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =civilship
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =shipcounter
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =victor
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =lose_flag
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =game_over
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =hit_number
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =clear_counter
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =systick_counter
			MOV		R1, #0
			STR		R1, [R0]
			
			LDR		R0, =mine
			MOV		R1, #0
			STR		R1,[R0],#4
			
			
			BL	InitGPIO_F							; initialize GPIO
			BL	InitGPIO_Interrupt					; initialize GPIO interrupt
			CPSIE I 								; enable interrupts		

start		MOV	R2, #0x04
			LDR R1, =ADC0_PSSI
			STR	R2, [R1]
			
			LDR R1, =ADC0_RIS
loop 		LDR R2, [R1]
			ANDS R2, #0x04 ; isolate bit 2 (sequencer 2)
			BEQ loop ; if no capture, then loop	
			
			MOV	R2, #0x04
			LDR R1, =ADC0_ISC
			STR	R2, [R1]
			
			; Await edge capture event

			LDR	R1, =ADC0_SSFIFO2
			LDR R2, [R1]				; R6 y i temsilen
			LDR	R6, [R1]				; R2 x i temsilen

			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) cleared (control mode)
			STR	R0,[R1]						
			
			MOV		R5, #0x40
			UDIV	R2, R5				; pottan x adresini elde ediyoruz
			ADD		R2,#5
			ORR		R2, #0x80
			BL 		PRINT
			LDR		R0, =cursor
			STR		R2, [R0]
			
			MOV		R5, #0x3ff
			MOV		R9, R6				; R9 ADC degeri		
			UDIV	R6, R5				
			MOV		R7, R6				; r7 y adresi	
			MUL		R6, R5
			SUB		R9, R6
			MOV		R0, #0x7f
			UDIV	R9, R0				; R9 BIT
			ADD		R7, #1
			MOV		R2, #0x40			; base address for y
			ORR		R2, R7				
			BL 		PRINT
			LDR		R0, =cursor
			STR		R2, [R0,#4]

			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set (data mode)
			STR	R0,[R1]	

			MOV		R3,#1				; This block converts 0x5 to 00010000
loop10		CMP		R9,#0
			BEQ		print2
			LSL		R3,#1
			SUBS	R9,#1
			BNE		loop10
			LDR		R0, =cursor
			STR		R3, [R0,#8]
			
print2		MOV		R2,#0
			BL		PRINT
			MOV		R2,R3
			BL		PRINT
			MOV		R2,#0
			BL		PRINT
			
			; buraya kadar cursor
			LDR		R0, =shipcounter
			LDR		R1, [R0]		; R1 = counter
			CMP		R1, #5
			BLT		first
			BEQ		clr
			CMP		R1,#6
			BEQ		systick
			BGT		MAIN_FINAL
			
first		BL		first_player
			B		start	
			
clr			LDR		R0,=clear_counter
			LDR		R1, [R0]
			CMP		R1,#1
			BLEQ	clear_screen
			MOV		R1,#0
			STR		R1,[R0]
			B		start
			
systick		; priority is set to 2
			; now enable system timer and the related interrupt
			LDR 	R1 , =NVIC_ST_CTRL
			MOV		R0 , #0x03
			STR 	R0 , [R1]	
			LDR		R0, =shipcounter
			LDR		R1, [R0]		; R1 = counter
			ADD		R1, #1
			STR		R1, [R0]
			B			start
			
MAIN_FINAL	LDR	R0,=game_over
			LDR	R1,[R0]
			CMP	R1,#0
			BEQ	start
			LDR	R0,=victor
			LDR	R1,[R0]
			CMP	R1,#0
			BEQ	losttt
			BL	victory
			B	DONE
			
losttt		BL	lost
	
DONE		B    DONE

			ALIGN
			END