GPIO_PORTA_DATA        EQU         0x400043FC
			AREA		text,READONLY,CODE
			THUMB
			EXPORT		one
			EXPORT		two	
			EXPORT		three
			EXPORT		four
			EXPORT		five
			EXPORT		six
			EXPORT		seven
			EXPORT		eight
			EXPORT		nine
			EXPORT		ten
			EXPORT		eleven
			EXPORT		twelve
			EXPORT		thirteen
			EXPORT		fourteen
			EXPORT		fifteen
			EXPORT		sixteen
			EXPORT		seventeen
			EXPORT		eighteen
			EXPORT		nineteen
			EXPORT		twenty
			IMPORT		PRINT
				
one			PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT	
			POP	{LR}
			BX	LR	
			
two			PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x74
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x5C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
three		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
four		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x3C
			BL PRINT
			MOV	R2,#0x20
			BL PRINT
			MOV	R2,#0x70
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
five		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x5C
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x74
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
six			PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x74
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
seven		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x4
			BL PRINT
			MOV	R2,#0x4
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
eight		PUSH {LR}
			MOV	R2,#0x0
			BL PRINT
			MOV	R2,#0x0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
nine		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x5C
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
ten			PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL	PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0x44
			BL PRINT
			MOV	R2,#0x7C
			BL	PRINT
			POP	{LR}
			BX	LR
			
eleven		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL	PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			POP	{LR}
			BX	LR
			
twelve		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL	PRINT
			MOV	R2,#0x74
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x5C
			BL PRINT
			POP	{LR}
			BX	LR
			
thirteen	PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL	PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			POP	{LR}
			BX	LR
			
fourteen	PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL	PRINT
			MOV	R2,#0x3C
			BL PRINT
			MOV	R2,#0x20
			BL PRINT
			MOV	R2,#0x70
			BL PRINT
			POP	{LR}
			BX	LR
			
fifteen		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL	PRINT
			MOV	R2,#0x5C
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x74
			BL PRINT
			POP	{LR}
			BX	LR
			
sixteen		PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x74
			BL PRINT
			POP	{LR}
			BX	LR
			
seventeen	PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x4
			BL PRINT
			MOV	R2,#0x4
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			POP	{LR}
			BX	LR
			
eighteen	PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			POP	{LR}
			BX	LR
			
nineteen	PUSH {LR}
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0
			BL PRINT
			MOV	R2,#0x5C
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			POP	{LR}
			BX	LR
			
twenty		PUSH {LR}			
			MOV	R2,#0x74
			BL PRINT
			MOV	R2,#0x54
			BL PRINT
			MOV	R2,#0x5C
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			MOV	R2,#0x44
			BL PRINT
			MOV	R2,#0x7C
			BL PRINT
			POP	{LR}
			BX	LR
			ALIGN
			END
			