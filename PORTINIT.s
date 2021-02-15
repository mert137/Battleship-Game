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

; GPIO Registers
GPIO_PORTE_DATA		EQU 0x400243FC
GPIO_PORTE_DIR 		EQU 0x40024400 ; Port Direction
GPIO_PORTE_AFSEL	EQU 0x40024420 ; Alt Function enable
GPIO_PORTE_DEN 		EQU 0x4002451C ; Digital Enable
GPIO_PORTE_AMSEL 	EQU 0x40024528 ; Analog enable
GPIO_PORTE_PCTL 	EQU 0x4002452C ; Alternate Functions

ADC0_ACTSS          EQU 0x40038000
ADC0_EMUX           EQU 0x40038014
ADC0_SSMUX2         EQU 0x40038080
ADC0_SSCTL2         EQU 0x40038084
ADC0_PC             EQU 0x40038FC4
ADC0_RIS            EQU 0x40038004
ADC0_ISC            EQU 0x4003800C
ADC0_PSSI           EQU 0x40038028

; System Registers
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; GPIO Gate Control
SYSCTL_RCGCADC	    EQU	0x400FE638

SYSCTL_PRADC        EQU 0x400FEA38

NVIC_ST_CTRL			EQU 0xE000E010
NVIC_ST_RELOAD 			EQU 0xE000E014
NVIC_ST_CURRENT			EQU 0xE000E018
SHP_SYSPRI3 			EQU 0xE000ED20

; 250ns x 4e6 = 1 second -> 4e6 = 0x3D0900 
RELOAD_VALUE 			EQU 0x3D0900
	

;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		 routines, CODE, READONLY
			THUMB
			EXPORT		PORTINIT
			IMPORT		PRINT
			IMPORT		rectangle
			IMPORT		DELAY100
				


;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
PORTINIT	PROC
			PUSH	{LR}
			LDR 	R1,=RCGCGPIO ;Clock register
			LDR 	R0, [R1]
			ORR 	R0, #0x01 		;turn on clock 
			STR 	R0, [R1]
			NOP						;wait untill GPIO is ready
			NOP
			NOP
			
			LDR 	R1, =GPIO_PORTA_DEN
			MOV 	R0, #0xEC ; enable Port(2,3,5,6,7) as digital port
			STR 	R0, [R1]

			LDR		R1,=GPIO_PORTA_DIR
			LDR		R0,[R1]
			ORR		R0,R0,#0xEC			; THE 1'S ARE OUT
			STR		R0,[R1]

		
			
			LDR		R1, =GPIO_PORTA_DATA
			LDR		R0,[R1]
			ORR		R1,#0x80		;nokia reset
			STR		R1,[R0]
			
			LDR 	R1, =GPIO_PORTA_AFSEL ;disable affsel
			LDR		R0, [R1]
			ORR		R0, #0x2C			; configure clk, ce, tx
			STRB	R0,[R1]  
			
			LDR		R1,=GPIO_PORTA_PCTL
			LDR		R0,[R1]
			LDR		R2,=PCTL_DEFAULT
			ORR		R0,R2				; ptcl SSI0 config. (2,3,5)
			STR		R0,[R1]

;SPICONF
			LDR		R1, =RCGCSSI
			LDR		R0,[R1]
			ORR		R0,R0,#0x01		;enable SSI Module0 (datasheet 348)
			STR		R0,[R1]
			NOP						;wait for SSI peripheral to be ready
			NOP
			NOP
			NOP
			NOP
			NOP
			NOP
			
			
			LDR 	R1,=SSICR1		 
			LDR 	R0,[ R1 ]
			BIC		R0,#0x06				; SSI operaion disabled 
			STR		R0,[ R1 ] 	

			LDR		R1, =SSICPSR
			LDR		R0,[R1]
			ORR		R0, R0, #0x06				;prescale
			STR		R0,[R1]
			
			LDR		R1, =SSICR0
			LDR		R0,[R1]	
			MOV		R0, #0xC7		;clock/255 and 8bit  data
			STR		R0,[R1]
			
			LDR 		R1, =SSICR1		
			LDR			R0, [R1]
			ORR			R0, #0x02				; ssi enabled
			STR			R0, [R1]
			
				; Start PORT E clock
			LDR R1, =SYSCTL_RCGCGPIO
			LDR R2, [R1] 	
			ORR R2, R2, #0x10 	; gpio module = bit position (4)
			STR R2, [R1]
			NOP
			NOP
			NOP
			
			; set direction of PE3
			LDR R1, =GPIO_PORTE_DIR
			LDR R0, [R1]
			BIC R0, R0, #0x0C ; clear bit 3 and 2 for input
			STR R0, [R1]
			
			; enable alternate function
			LDR R1, =GPIO_PORTE_AFSEL
			LDR R0, [R1]
			ORR R0, R0, #0x0C ; set bit 3 for alternate fuction on PE3
			STR R0, [R1]
			
			; enable analog
			LDR R1, =GPIO_PORTE_AMSEL
			LDR R0, [R1]
			ORR R0, R0, #0x0C ; set bit 3
			STR R0, [R1]
			
			; disable digital
			LDR R1, =GPIO_PORTE_DEN
			LDR	R0, [R1]
			BIC R0, #0x0C ; clear bit 3
			STR R0, [R1]


			; ADC Configuration
			LDR R1, =SYSCTL_RCGCADC
			MOV	R2, #0x1
			STR R2, [R1]
			NOP
			NOP
			NOP
			
			; ADC Check
			LDR R1, =SYSCTL_PRADC
not_ready	LDR	R2, [R1]
			AND R2, #0x01
			BEQ	not_ready
			
			LDR R1, =ADC0_PC
			LDR R0, [R1]
			ORR R0, R0, #0x01 ; set 125 kbps
			STR R0, [R1]
			
			LDR R1, =ADC0_ACTSS
			LDR	R0, [R1]
			BIC R0, #0x04 ; disable sequencer 2
			STR R0, [R1]
			
			LDR R1, =ADC0_EMUX
			LDR	R0, [R1]
			BIC R0, #0x0F00 ; clear bits [11:8]
			STR R0, [R1]
			
			LDR R1, =ADC0_SSMUX2
			MOV R0, #0x10	; to select AIN0,AIN1
			STR R0, [R1]
			
			LDR R1, =ADC0_SSCTL2
			LDR R0, [R1]
			ORR R0, R0, #0x64 ; set bits [2:1]
			STR R0, [R1]
			
			LDR R1, =ADC0_ACTSS
			LDR	R0, [R1]
			ORR R0, #0x04 ; enable sequencer 2
			STR R0, [R1]
			
			; SYSTICK ; SYSTICK ; SYSTICK ; SYSTICK ; SYSTICK ; SYSTICK
			; first disable system timer and the related interrupt
			; then configure it to use internal oscillator PIOSC/4
			LDR 		R1 , =NVIC_ST_CTRL
			MOV 		R0 , #0
			STR 		R0 , [R1 ]

			; now set the time out period
			LDR 		R1 , =NVIC_ST_RELOAD
			LDR 		R0 , =RELOAD_VALUE
			STR 		R0 , [R1 ]

			; time out period is set
			; now by writing to CURRENT register, it is cleared
			LDR 		R1 , =NVIC_ST_CURRENT
			STR 		R0 , [R1 ]


	
			
			; Configuration finished

			LDR R1,=GPIO_PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x80	; reset 0 landi
			STR	R0,[R1]
			
			BL DELAY100
			
			LDR R1,=GPIO_PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x80	; reset set edildi, D/C = 0 (control mode)
			STR	R0,[R1]
			
			; CHECK IF BUSY

			MOV		R2,#0x21			;H=1	
			BL		PRINT
			
			MOV		R2, #0xc0			;VOP
			BL 		PRINT
			
			MOV		R2, #0x07			;TEMPERATURE
			BL 		PRINT
			
			MOV		R2, #0x13			;BIAS 
			BL 		PRINT

			MOV		R2, #0x20			;H=0
			BL 		PRINT
			
			MOV		R2, #0x0C			;display normal
			BL 		PRINT
			
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			ORR	R0,#0x40				; A6 (D/C) set edildi (data mode)
			STR	R0,[R1]	
	
				
			MOV	R0, #504
jump		MOV	R2,#0
			BL	PRINT
			SUBS R0,#1
			BNE jump
			
			BL	rectangle
						
			LDR R1,=GPIO_PORTA_DATA		
			LDR	R0,[R1]
			BIC	R0,#0x40				; A6 (D/C) clear edildi (control mode)
			STR	R0,[R1]	
			
			MOV	R2, #0x20				; Basic modea aldik ki x y adreslemesini yapalim.
			BL	PRINT
			
			POP 	{LR}
			
			BX		LR
			ENDP
			ALIGN
			END