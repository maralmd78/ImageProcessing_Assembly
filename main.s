				PRESERVE8
                THUMB

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
__Vectors
				DCD  0x20001000     ; stack pointer value when stack is empty
				DCD  Reset_Handler  ; reset vector
					
				

				AREA	myCode, CODE, READONLY
;**********************************************************************************
RCC_AHB1ENR		EQU		0x40023830
GPIOA_MODER		EQU		0x40020000
GPIOB_MODER		EQU		0x40020400
GPIOB_OTYPER	EQU		0x40020404
GPIOA_OSPEEDR	EQU		0x40020008
GPIOB_OSPEEDR	EQU		0x40020408
GPIOA_PUPDR		EQU		0x4002000C
GPIOB_PUPDR		EQU		0x4002040C
GPIOA_IDR		EQU		0x40020010
GPIOB_ODR		EQU		0x40020414

ImageN	dcd		rowN0,rowN1,rowN2,rowN3,rowN4,rowN5,rowN6,rowN7,rowN8,rowN9,rowN10,rowN11,rowN12,rowN13,rowN14,rowN15,rowN16
rowN0	dcb		129,129,109,153,143,118,158,144,42,102,175,157,133,114,177,72,72
rowN1	dcb		129,129,109,153,143,118,158,144,42,102,175,157,133,114,177,72,72
rowN2	dcb		102,102,110,157,109,97,111,114,6,102,99,86,122,122,183,151,151
rowN3	dcb		83,83,107,103,133,137,39,130,2,103,110,75,93,94,135,121,121
rowN4	dcb		105,105,99,144,81,116,80,125,48,102,107,108,77,95,100,108,108
rowN5	dcb		95,95,100,66,85,108,66,126,22,71,53,98,88,147,137,100,100
rowN6	dcb		192,192,73,79,119,119,136,113,7,112,85,80,141,132,36,87,87
rowN7	dcb		144,144,144,135,122,172,122,118,0,137,101,140,85,102,127,118,118
rowN8	dcb		32,32,28,27,0,25,0,29,42,38,14,0,34,0,0,59,59
rowN9	dcb		114,114,130,100,184,113,124,97,8,104,151,58,62,65,120,140,140
rowN10	dcb		122,122,44,116,78,82,141,93,0,111,57,63,99,61,110,139,139
rowN11	dcb		116,116,107,169,45,159,106,123,0,112,121,97,116,133,101,102,102
rowN12	dcb		68,68,40,158,88,100,143,115,57,141,153,114,48,62,117,81,81
rowN13	dcb		137,137,69,78,117,106,85,126,19,91,87,82,100,82,83,112,112
rowN14	dcb		145,145,144,132,95,121,148,85,67,72,166,153,87,80,77,127,127
rowN15	dcb		131,131,141,166,134,171,129,128,9,112,116,74,113,73,64,122,122
rowN16	dcb		131,131,141,166,134,171,129,128,9,112,116,74,113,73,64,122,122

Image	dcd		row0,row1,row2,row3,row4,row5,row6,row7,row8,row9,row10,row11,row12,row13,row14,row15,row16
row0	dcb		129,129,124,130,126,127,122,129,14,128,118,125,128,130,138,125,125
row1	dcb 	129,129,124,130,126,127,122,129,14,128,118,125,128,130,138,125,125
row2	dcb		112,112,99,145,131,99,117,128,29,118,93,111,119,133,158,145,145
row3	dcb		105,105,97,104,111,134,96,127,11,125,114,98,109,129,114,129,129
row4	dcb		107,107,109,117,92,81,105,129,6,126,111,93,78,121,105,118,118
row5	dcb		101,101,99,75,101,100,108,122,0,125,76,79,90,94,122,118,118
row6	dcb		120,120,71,68,112,116,125,114,1,125,90,75,115,103,79,99,99
row7	dcb		129,129,126,127,126,130,128,118,2,115,115,111,119,129,127,128,128
row8	dcb		16,16,25,15,18,4,1,4,35,6,7,7,18,20,14,21,21
row9	dcb		128,128,126,128,128,127,115,118,8,125,120,87,90,108,96,122,122
row10	dcb		129,129,93,91,104,76,97,129,6,121,96,80,89,109,116,113,113
row11	dcb		129,129,117,102,91,108,90,128,14,115,108,111,105,90,109,100,100
row12	dcb		125,125,94,117,78,124,124,124,29,113,117,115,106,80,100,100,100
row13	dcb		120,120,95,81,119,87,103,127,31,109,111,111,87,86,86,114,114
row14	dcb		120,120,103,113,125,109,124,121,9,101,86,118,104,100,78,117,117
row15	dcb		128,128,128,130,145,127,123,123,0,114,95,93,112,84,105,122,122
row16	dcb		128,128,128,130,145,127,123,123,0,114,95,93,112,84,105,122,122

NewImage	dcd		Nrow0,Nrow1,Nrow2,Nrow3,Nrow4,Nrow5,Nrow6,Nrow7,Nrow8,Nrow9,Nrow10,Nrow11,Nrow12,Nrow13,Nrow14

IsGaussionKernel	dcd		0
;**********************************************************************************	
				ENTRY
Reset_Handler

;**********************************************************************************
			;initialize micro settings
			;connect GPIOA and GPIOB clocks
			MOV32	r10, #RCC_AHB1ENR
			LDR		r11, [r10]
			ORR		r11, r11, #3
			STR		r11, [r10]

			;define pinA0 as input
			MOV32	r10, #GPIOA_MODER
			LDR		r11, [r10]
			AND		r11, r11, #4294967292	;11111111111111111111111111111100
			STR		r11, [r10]

			;define pinB1 as output
			MOV32	r10, #GPIOB_MODER
			LDR		r11, [r10]                
			AND		r11, r11, #4294967287	;11111111111111111111111111110111
			ORR		r11, r11, #4			;00000000000000000000000000000100 
			STR		r11, [r10]			

			;set pinB1 as push pull
			MOV32	r10, #GPIOB_OTYPER
			LDR		r11, [r10]
			AND		r11, r11, #4294967293	;11111111111111111111111111111101
			STR		r11, [r10]			

			;set speed for pinA0	
			MOV32	r10, #GPIOA_OSPEEDR
			LDR		r11, [r10]
			AND		r11, r11, #4294967292	;11111111111111111111111111111100			
			STR		r11, [r10]

			;set speed for pinB1
			MOV32	r10, #GPIOB_OSPEEDR
			LDR		r11, [r10]
			AND		r11, r11, #4294967283	;11111111111111111111111111110011			
			STR		r11, [r10]

			;set pinA0 pull up/down setting
			MOV32	r10, #GPIOA_PUPDR
			LDR		r11, [r10]
			AND		r11, r11, #4294967292	;11111111111111111111111111111100
			STR		r11, [r10]

			;set pinB1 pull up/down setting
			MOV32	r10, #GPIOB_PUPDR
			LDR		r11, [r10]
			AND		r11, r11, #4294967283	;11111111111111111111111111110011			
			STR		r11, [r10]
			
			;decide to start or not
ReadPin		MOV32	r10, #GPIOA_IDR
			LDR		r11, [r10]
			ANDS	r11, r11, #1			;00000000000000000000000000000001
			;BEQ		ReadPin

			
			
			;decide between gaussion filter and edge detection filter          
			MOV32	r10, #IsGaussionKernel
			LDR		r10, [r10]
			CMP		r10, #0
			BNE		GaussionStart	;skip edge detection filter
			
			;edge detection filter algorithem
			MOV32	r8, #1
			MOV32	r9, #1
MyLoop1		MOV		r3, r8
			MOV		r4, r9
			BL		EdgeDetectKernel
			ADD		r9, r9, #1
			CMP		r9, #16
			BNE		MyLoop1
			ADD		r8, r8, #1
			MOV32	r9,#1
			CMP		r8, #16
			BNE		MyLoop1
			B		loop	;skip gaussion filter
			
			;gaussion filter algorithem
GaussionStart			
			MOV32	r8, #1
			MOV32	r9, #1
MyLoop2		MOV		r3, r8
			MOV		r4, r9
			BL		GaussianKernel
			ADD		r9, r9, #1
			CMP		r9, #16
			BNE		MyLoop2
			ADD		r8, r8, #1
			MOV32	r9,#1
			CMP		r8, #16
			BNE		MyLoop2
			
			
			;turn on output ready flag
			MOV32	r10, #GPIOB_ODR
			LDR		r11, [r10]
			ORR		r11, r11, #2	;00000000000000000000000000000010	
			STR		r11, [r10]	   

loop
            B       loop
			
			
;FUNCTION DEFINITIONS

;r0(row) and r1(column) are inputs , r2(output) is the corresponding value of r0 and r1 indices of the original image(Image)
GetIndex	MOV32	r2, #4
			MUL		r0, r0,r2
			;MUL	r1, r1,r2
			MOV32	r2, #Image
			LDR		r2, [r2,r0]
			LDRB	r2, [r2,r1]
			MOV		pc, lr
			
;r0(row) and r1(column) are inputs , r2(output) is the corresponding value of r0 and r1 indices of the noisy image(ImageN)
GetIndexN	MOV32	r2, #4
			MUL		r0, r0,r2
			;MUL	r1, r1,r2
			MOV32	r2, #ImageN
			LDR		r2, [r2,r0]
			LDRB	r2, [r2,r1]
			MOV		pc, lr
			
;r0(row) and r1(column) and r2(value) are inputs, set the value of the corresponding index of r0 and r1 to the r2 value in the output image(NewImage)	
SetIndex	MOV32	r6, #4
			MUL		r0, r0,r6
			;MUL	r1, r1,r6
			MOV32	r6, #NewImage
			LDR		r6, [r6,r0]
			STRB	r2, [r6,r1]
			MOV		pc, lr
			
;r3(row) and r4(column) are inputs of the original image, the function calculates the guasssion kernel of the corresponding pixel
;and then stores the result in the appropriate place of the output image(NewImage)
GaussianKernel	MOV		r7, lr 
				ADDS	r3, r3, #0		;to clear carry bit
				SUB		r0, r3, #1
				SUB		r1, r4, #1
				BL		GetIndexN
				MOV		r5, r2
				SUB		r0, r3, #1
				MOV		r1, r4
				BL		GetIndexN
				MOV		r2, r2, LSL #1	;r2 = r2*2
				ADCS	r5, r5, r2
				SUB		r0, r3, #1
				ADD		r1, r4, #1
				BL		GetIndexN
				ADCS	r5, r5, r2
				MOV		r0, r3
				SUB		r1, r4, #1
				BL		GetIndexN
				MOV		r2, r2, LSL #1	;r2 = r2*2
				ADCS	r5, r5, r2
				MOV		r0, r3
				MOV		r1, r4
				BL		GetIndexN
				MOV		r2, r2, LSL #2	;r2 = r2*4
				ADCS	r5, r5, r2
				MOV		r0, r3
				ADD		r1, r4, #1
				BL		GetIndexN
				MOV		r2, r2, LSL #1	;r2 = r2*2
				ADCS	r5, r5, r2
				ADD		r0, r3, #1
				SUB		r1, r4, #1
				BL		GetIndexN
				ADCS	r5, r5, r2
				ADD		r0, r3, #1
				MOV		r1, r4
				BL		GetIndexN
				MOV		r2, r2, LSL #1	;r2 = r2*2
				ADCS	r5, r5, r2
				ADD		r0, r3, #1
				ADD		r1, r4, #1
				BL		GetIndexN
				ADCS	r5, r5, r2
				MOV		r5, r5, LSR #4	;r5=r5/16
				SUB		r0, r3, #1
				SUB		r1, r4, #1
				MOV		r2, r5
				BL		SetIndex
				MOV		pc, r7
				
;r3(row) and r4(column) are inputs of the original image, the function calculates the edge detect kernel of the corresponding pixel
;and then stores the result in the appropriate place of the output image(NewImage)
EdgeDetectKernel	MOV		r7, lr  
					ADDS	r3, r3, #0	;to clear carry bit
					SUB		r0, r3, #1
					MOV		r1, r4
					BL		GetIndex
					MOV		r5, r2

					MOV		r0, r3
					SUB		r1, r4, #1
					BL		GetIndex
					ADCS	r5, r5, r2

					MOV		r0, r3
					MOV		r1, r4
					BL		GetIndex
					MOV		r2, r2, LSL #2	;r2 = r2*4
					SBCS	r5, r5, r2		;r5 = r5-r2

					MOV		r0, r3
					ADD		r1, r4, #1
					BL		GetIndex
					ADCS	r5, r5, r2

					ADD		r0, r3, #1
					MOV		r1, r4
					BL		GetIndex
					ADCS	r5, r5, r2

					MOV		r5, r5, LSR #2	;r5=r5/4
					ADCS	r5, r5, #64
					SUB		r0, r3, #1
					SUB		r1, r4, #1
					MOV		r2, r5
					BL		SetIndex
					MOV		pc, r7
				
							
;**********************************************************************************					
			AREA myData, DATA, READWRITE		
				
Nrow0	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow1	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow2	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow3	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow4	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow5	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow6	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow7	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow8	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow9	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow10	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow11	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow12	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow13	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow14	dcb		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0			
				
				
			
;**********************************************************************************
			END
