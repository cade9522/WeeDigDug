    AREA	library, CODE, READWRITE	
    EXPORT read_character
    EXPORT output_character
    EXPORT read_string
    EXPORT output_string
    EXPORT display_digit_on_7_seg
    EXPORT read_from_push_btns
    EXPORT illuminateLEDS
    EXPORT Illuminate_RGB_LED
    EXPORT divide
        
U0LSR EQU 0x14			;UART0 Line Status Register

string = 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	;32 byte memory allocation

    ALIGN

    
    
read_character
        STMFD SP!, {lr}			;store register lr on stack
        LDR r1, =0xE000C000		;load recieve/transmit register into r1
RCHR	LDRB r2, [r1, #U0LSR]	        ;load value from LSR
        AND r3, r2, #1			;"and"ing LSR value with 00000001 to check if the RDR bit is 1
        CMP r3, #1			;compare if value equals 0
        BNE RCHR			;loopback if not equal
        LDRB r0, [r1]			;load character byte from recieve register into r0
        LDMFD SP!, {lr}			;load lr from the stack
        BX lr


output_character
        STMFD SP!, {lr}			;store register lr on stack
        LDR r1, =0xE000C000		;load recieve/transmit register into r1
OCHR	LDRB r2, [r1, #U0LSR]	        ;load value from LSR
        AND r3, r2, #&20		;"and"ing LSR value with 00100000 to check if the THRE bit is 1
        CMP r3, #&20			;compare if values are equal
        BNE OCHR			;loopback if not equal
        STRB r0, [r1]			;store byte into transmit value register
        LDMFD SP!, {lr}			;load lr from the stack
        BX lr


    
read_string
        LDR r4, =string			;load memory location of the string into r4
        MOV r5, #0			;initlaize r5 to 0 to act as an offset
        CMP r0, #13			;check to see if ENTER key was pressed
        BEQ OUTS			;if so, branch to output the string
RSTR	LDRB r3, [r4, r5]		;check if byte is already written to location
        CMP r3, #0			;check if value is NULL
        BEQ WRTE			;branch to store the character
        ADD r5, r5, #1			;increment the offest
        B RSTR				;check the next byte from the address
WRTE	STRB r0, [r4]			;store the characer
        B RCHR				;branch back to read the next character



output_string
        STMFD SP!, {lr}			;store register lr on stack
        MOV r5, #0			;initlaize r5 to 0 to act as an offset
        LDR r1, =0xE000C000		;load recieve/transmit register into r1
OUTS	LDRB r0, [r4, r5]		;load a byte from the string to be transmitted
        CMP r0, #0			;check if end of string has been reached
        BEQ OUTP			;branch to transmit the character if not
TCHK	LDRB r2, [r1, #U0LSR]	        ;load value from LSR
        AND r3, r2, #&20		;"and"ing LSR value with 00100000 to check if the THRE bit is 1
        CMP r3, #&20			;compare if values are equal
        BNE TCHK			;loopback if not equal
        STRB r0, [r1]			;store byte into transmit value register
        ADD r5, r5, #1			;increment the offset
        CMP r5, #0			;check if last byte was transmitted
        BGE OUTS			;output the next character if not
OUTP	LDMFD SP!, {lr}			;load lr from the stack
        BX lr
        


display_digit_on_7_seg
        STMFD SP!, {lr}			;store register lr on stack
        LDR r1, =0xE0028000		;load base address of IO0PIN
        LDR r3, [r1, #12]		;load current IO0CLR configuration
        LDR r2, =0x00003F80
        ORR r3, r3, r2			;set all pins to 1
        STR r3, [r1, #12]		;store in offset address of IO0CLR
        STR r0, [r1, #4]		;store digit pattern in offset address of IO0SET
        LDMFD SP!, {lr}			;load lr from the stack
        BX lr



read_from_push_btns
        STMFD SP!, {lr}			;store register lr on stack
        LDR r1, =0xE0028010		;load base address of IO1PIN
        LDR r3, =0x0000000		;set P1.20 - P1.23 as inputs
        STR r3, [r1, #8]		;store in offset address of IO1DIR
        BL read_character		;continue once ENTER pressed
        LDR r0, [r1]			;load value of IO1PIN into r0
        MOV r0, r0, LSR #8		;isolate the input by shifting off values before and after
        MOV r0, r0, LSL #28
        LDMFD SP!, {lr}			;load lr from the stack
        BX lr
        


illuminateLEDS
        STMFD SP!, {lr}			;store register lr on stack
        LDR r1, =0xE0028010		;load base address of IO1PIN
        LDR r3, [r1, #4]		;load current IO1SET configuration
        LDR r2, =0x000F0000		;write all 1's to clear any value
        ORR r3, r3, r2
        STR r3, [r1, #4]		;store in offset address of IO1SET
        STR r0, [r1, #12]		;store binary pattern in the IO1CLR address
        LDMFD SP!, {lr}			;load lr from the stack
        BX lr
        


Illuminate_RGB_LED
        STMFD SP!, {lr}			;store register lr on stack
        LDR r1, =0xE0028000		;load base address of IO0PIN
        LDR r3, [r1, #4]		;load current configuration of IO0SET
        LDR r2, =0x00260000		;write all 1's to clear any value
        ORR r3, r3, r2
        STR r3, [r1, #4]		;store in offset address of IO0SET
        STR r0, [r1, #12]		;store digit pattern in offset address of IO0CLR
        LDMFD SP!, {lr}			;load lr from the stack
        BX lr
        




divide
        STMFD SP!,{lr}		
DVND	CMP r0, #0			;check to see if dividend is positive
        BGE	DVSR			;if so, branch to check the same for the divisor
        NEG r0, r0			;else, negate the value
        MOV r6, #1			;record a value of 1 in r6 for a later check
DVSR	CMP r1, #0			;check to see if divisor is positive
        BGE	main			;if so, branch to check the same for the divisor
        NEG r1, r1			;else, negate the value
        MOV r7, #1			;record a value of 1 in r7 for a later check
main	MOV r2, #15			;intialize counter for 15-bit integer
        MOV	r3, #0			;intialize quotient to 0
        MOV r1, r1, LSL #15	        ;Logical Left Shift divisor by 15 places
        MOV r4, r0			;set remainder = dividend
        B	LOOP			;Unconditionally Branch to the start of the loop
                                        ;passing over the labels in between
NEGv	MOV r4, r5			;restore remainder to backup value
        MOV r3, r3, LSL #1	        ;Logical Left Shift in a value of 0
        MOV r1, r1, LSR #1	        ;Right Shift in a value of 0
        B	CNTR			;Unconditionally Branch to the Counter label
DCNT	SUB r2, r2, #1		        ;decrement counter
LOOP	MOV r5, r4			;initialize r5 as a backup of r4
        SUB	r4, r4, r1		;set remainder = remainder - divisor
        CMP	r4, #0			;compare the remainder to 0
        BLT	NEGv			;if remainder is negative, branch to Negative Value label
                                        ;else, continue onto the Positive Value label
POSv	MOV r3, r3, LSL #1	        ;Logical Left Shift in a value of 1
        ADD r3, r3, #1
        MOV r1, r1, LSR #1	        ;Right Shift in a value of 0
CNTR	CMP r2, #0			;is the counter greater than 0?
        BGT DCNT			;if so, loop back to the start
                                        ;if not, continue on to the final checks
CHK1	CMP r6, #1			;check if initial dividend was negative
        BNE	CHK2			;if not, branch to check the divisor
        NEG r3, r3			;if so, negate the value
CHK2	CMP r7, #1			;check if initial dividend was negative
        BNE	STOR			;if not, branch to the end
        NEG r3, r3			;if so, negate the value
STOR	MOV r0, r3			;store the quotient in r0
        MOV r1, r4			;store the remainder in r1
        LDMFD sp!, {lr}		
        BX lr

    END