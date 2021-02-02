				PRESERVE8
                THUMB

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
__Vectors
				DCD  0x20001000     ; stack pointer value when stack is empty
				DCD  Reset_Handler  ; reset vector
					
				

				AREA	myCode, CODE, READONLY
;**********************************************************************************
GPIOC_CRL   	EQU     0x40011000
GPIOC_CRH   	EQU     0x40011004
GPIOC_IDR   	EQU     0x40011008
GPIOC_ODR   	EQU     0x4001100C
GPIOC_BSRR  	EQU     0x40011010
GPIOC_BRR   	EQU     0x40011014
GPIOC_LCKR  	EQU     0x40011018

Image	dcd  row0,row1,row2,row3,row4,row5,row6,row7,row8,row9,row10,row11,row12,row13,row14,row15,row16
row0	dcd	 129,129,109,153,143,118,158,144,42,102,175,157,133,114,177,72,72
row1	dcd  129,129,109,153,143,118,158,144,42,102,175,157,133,114,177,72,72
row2 	dcd  102,102,110,157,109,97,111,114,6,102,99,86,122,122,183,151,151
row3 	dcd  83,83,107,103,133,137,39,130,2,103,110,75,93,94,135,121,121
row4    dcd  105,105,99,144,81,116,80,125,48,102,107,108,77,95,100,108,108
row5  	dcd  95,95,100,66,85,108,66,126,22,71,53,98,88,147,137,100,100
row6	dcd	 192,192,73,79,119,119,136,113,7,112,85,80,141,132,36,87,87
row7	dcd	 144,144,144,135,122,172,122,118,0,137,101,140,85,102,127,118,118
row8	dcd	 32,32,28,27,0,25,0,29,42,38,14,0,34,0,0,59,59
row9	dcd	 114,114,130,100,184,113,124,97,8,104,151,58,62,65,120,140,140
row10   dcd	 122,122,44,116,78,82,141,93,0,111,57,63,99,61,110,139,139
row11	dcd	 116,116,107,169,45,159,106,123,0,112,121,97,116,133,101,102,102
row12   dcd	 68,68,40,158,88,100,143,115,57,141,153,114,48,62,117,81,81
row13	dcd	 137,137,69,78,117,106,85,126,19,91,87,82,100,82,83,112,112
row14   dcd	 145,145,144,132,95,121,148,85,67,72,166,153,87,80,77,127,127
row15	dcd	 131,131,141,166,134,171,129,128,9,112,116,74,113,73,64,122,122
row16	dcd	 131,131,141,166,134,171,129,128,9,112,116,74,113,73,64,122,122

NewImage dcd  Nrow0,Nrow1,Nrow2,Nrow3,Nrow4,Nrow5,Nrow6,Nrow7,Nrow8,Nrow9,Nrow10,Nrow11,Nrow12,Nrow13,Nrow14

	

;**********************************************************************************	
				ENTRY
Reset_Handler

;**********************************************************************************
	        
			MOV32   r3, #5  
			MOV32   r4, #6
			BL      GaussianKernel
			
			MOV32   r6,#NewImage
			LDR     r6,[r6,#16]
			LDR     r6,[r6,#20]
			
	
			
			
			
loop
            B       loop
			
			
;FUNCTION DEFINITIONS

;r0(row) and r1(column) are inputs , r2(output) is the corresponding value of r0 and r1 indices of the original image(Image)
GetIndex    MOV32   r2, #4
            MUL     r0, r0,r2
			MUL     r1, r1,r2
            MOV32   r2, #Image
			LDR     r2, [r2,r0]
			LDR     r2, [r2,r1]
			MOV     pc, lr
			
;r0(row) and r1(column) and r2(value) are inputs, set the value of the corresponding index of r0 and r1 to the r2 value in the output image(NewImage)	
SetIndex    MOV32   r6, #4
            MUL     r0, r0,r6
			MUL     r1, r1,r6
			MOV32   r6, #NewImage
			LDR     r6, [r6,r0]
			STR     r2, [r6,r1]
			MOV     pc, lr
			
;r3(row) and r4(column) are inputs of the original image, the function calculates the guasssionkernel of the corresponding pixel
;and then stores the result in the appropriate place of the output image(NewImage)
GaussianKernel  MOV  r7, lr      
                SUB  r0, r3, #1
                SUB  r1, r4, #1
				BL   GetIndex
				MOV  r5, r2
				SUB  r0, r3, #1
				MOV  r1, r4
				BL   GetIndex
				MOV  r2, r2, LSL #1 ;r2 = r2*2
				ADCS r5, r5, r2
				SUB  r0, r3, #1
				ADD  r1, r4, #1
				BL   GetIndex
				ADCS r5, r5, r2
				MOV  r0, r3
				SUB  r1, r4, #1
				BL   GetIndex
				MOV  r2, r2, LSL #1 ;r2 = r2*2
				ADCS r5, r5, r2
				MOV  r0, r3
				MOV  r1, r4
				BL   GetIndex
				MOV  r2, r2, LSL #2 ;r2 = r2*4
				ADCS r5, r5, r2
				MOV  r0, r3
				ADD  r1, r4, #1
				BL   GetIndex
				MOV  r2, r2, LSL #1 ;r2 = r2*2
				ADCS r5, r5, r2
				ADD  r0, r3, #1
				SUB  r1, r4, #1
				BL   GetIndex
				ADCS r5, r5, r2
				ADD  r0, r3, #1
				MOV  r1, r4
				BL   GetIndex
				MOV  r2, r2, LSL #1 ;r2 = r2*2
				ADCS r5, r5, r2
				ADD  r0, r3, #1
				ADD  r1, r4, #1
				BL   GetIndex
				ADCS r5, r5, r2
		        SUB  r0, r3, #1
				SUB  r1, r4, #1
				MOV  r2, r5
				BL   SetIndex
				MOV  pc, r7
				
				
				
				
				
				
				
				
				
				
				
				
				
;**********************************************************************************					
			AREA myData, DATA, READWRITE		
				
Nrow0	dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow1	dcd  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow2 	dcd  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow3 	dcd  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow4   dcd  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow5  	dcd  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow6	dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow7	dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow8	dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow9	dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow10  dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow11	dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow12  dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow13	dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Nrow14  dcd	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0			
				
				
			
;**********************************************************************************
			END
