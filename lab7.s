      AREA 		digdug, CODE, READWRITE
      EXPORT lab7
      EXPORT FIQ_Handler
      EXTERN random_number
      EXTERN output_character
      EXTERN read_character
      EXTERN output_string
      EXTERN interrupt_init
      EXTERN default_setup		
      EXTERN display_digit_on_7_seg
      EXTERN Illuminate_RGB_LED
      EXTERN illuminateLEDS
      EXTERN char_check
      EXTERN spawn_check
      EXTERN enemy_check
      EXTERN move_check
      EXTERN disable_interrupts


title = 0xC,"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",0xA,0xD
      = "x  __          __            _____               _____                x",0xA,0xD           
      = "x  ",0x5C," ",0x5C,"        ",0x2F," ",0x2F,"           |  __ ",0x5C,"             |  __ ",0x5C,"               x",0xA,0xD
      = "x 	 ",0x5C," ",0x5C,"  ",0x2F,"",0x5C,"  ",0x2F," ",0x2F,"__  ___     | |  | |_  __ _     | |  | |_   _  __ _   x",0xA,0xD
      = "x	   ",0x5C," ",0x5C,"",0x2F,"  ",0x5C,"",0x2F," ",0x2F," _ ",0x5C,"",0x2F," _ ",0x5C,"    | |  | | |",0x2F," _` |    | |  | | | | |",0x2F," _` |  x",0xA,0xD
      = "x	    ",0x5C,"  ",0x2F,"",0x5C,"  ",0x2F,"  __",0x2F,"  __",0x2F,"    | |__| | | (_| |    | |__| | |_| | (_| |  x",0xA,0xD
      = "x	     ",0x5C,"",0x2F,"  ",0x5C,"",0x2F," ",0x5C,"___|",0x5C,"___|    |_____",0x2F,"|_|",0x5C,"__, |    |_____/",0x2F,"",0x5C,"__,_|",0x5C,"__, |  x",0xA,0xD
      = "x	                                     __",0x2F," |                   __",0x2F," |  x",0xA,0xD
      = "x	                                    |___",0x2F,"                   |___",0x2F,"   x",0xA,0xD
      = "x                                                                     x",0xA,0xD
      = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",0xA,0xD,0xA,0xD
      = "                    --------- Press Enter ---------",0xA,0xD,0
      
prompt = 0xC,"How To Play: ",0xA,0xD,0xA,0xD
       = "Your character '>' will spawn in the middle of the board",0xA,0xD
       = "Your goal is to score as many points as possible before the time runs or you use all your lives",0xA,0xD
       = "The four LEDs will indicate how many lives you have left (starting with 4)",0xA,0xD
       = "The RGB LED will indicate the game state:",0xA,0xD
       = " 		- Green = Game start, unpaused",0xA,0xD
       = " 		- Blue = Game paused ",0xA,0xD
       = " 		- Red = Game over",0xA,0xD
       = "Each level will spawn three enemies",0xA,0xD
       = "'&' are hard enemies. '*' are normal enemies",0xA,0xD
       = "To kill enemies, you need to inflate them with your air pump '+'",0xA,0xD
       = "If an enemy touches you, you will lose a life",0xA,0xD
       = "After you defeat all enemies, you will start a new level",0xA,0xD
       = "The seven segment display will display what level you are on",0xA,0xD,0xA,0xD
       = "Press [Enter] to continue...",0xA,0xD,0xA,0xD,0
       
prompt2 = 0xC,"Controls: ",0xA,0xD,0xA,0xD
        = "To change the direction of the character: ",0xA,0xD
        = " 	- type [w] for up ",0xA,0xD
        = " 	- type [s] for down ",0xA,0xD
        = " 	- type [a] for left ",0xA,0xD
        = " 	- type [d] for right ",0xA,0xD
        = "To use your air pump press the [SPACE BAR]",0xA,0xD
        = "To pause the game, press the button labeled P0.14",0xA,0xD,0xA,0xD
        = "Scoring: ",0xA,0xD,0xA,0xD
        = "Collect dirt '#' - 10 points",0xA,0xD
        = "Kill normal enemy '*' - 50 points",0xA,0xD
        = "Kill hard enemy '&' - 100 points",0xA,0xD
        = "Ending with extra lives - 50 points per life",0xA,0xD
        = "Advancing to the next level - 100 points",0xA,0xD,0xA,0xD
        = "You will have 120 seconds to play, good luck!",0xA,0xD,0xA,0xD
        = "Press [Enter] to begin...",0xA,0xD,0xA,0xD,0

board = "ZZZZZZZZZZZZZZZZZZZZZ",0xA,0xD
      = "Z                   Z",0xA,0xD
      = "Z                   Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z######## > ########Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "Z###################Z",0xA,0xD
      = "ZZZZZZZZZZZZZZZZZZZZZ",0xA,0xD,0

topboard = "ZZZZZZZZZZZZZZZZZZZZZ",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD,0

botboard = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "Z                   Z",0xA,0xD
         = "ZZZZZZZZZZZZZZZZZZZZZ",0xA,0xD,0
         
midboard = "Z                   Z",0xA,0xD,0
endgame	= "Z     Game Over     Z",0xA,0xD,0
pausegame = "Z      Paused       Z",0xA,0xD,0
timeleft = "Time Left: ",0
gamescore = "Score: ",0
restart = 0xA,0xD,"To play again, press [Enter]",0xA,0xD
        = "To quit the game, type [q]",0xA,0xD,0
closescreen = 0xC,"Close PuTTY and stop the program.",0xA,0xD,"Thank you for playing.",0	

clear = 0xC,0			;clear display
newline = 0xA,0xD,0

user = 0x08 			;set user coordinates to row 8, col 10
     = 0x0A 	
     = 0x3E			;character to '>'
     = 0x03			;and direction to the right
     
lives_left = 0x00		

enemy_row = 0x00
          = 0x00
          = 0x00
          = 0x00	        ;byte 1 (1 row), 2 (2 row), 3, (3 row)		   
enemy_size = 0x00		
           = 0x00
           = 0x00		;byte 1 (1 size), 2 (2 size), 3, (3 size)
enemy_col  = 0x00
           = 0x00
           = 0x00	        ;byte 1 (1 row), 2 (2 row), 3, (3 row)
enemy_direct = 0x02		;start enemy 1 -> left
             = 0x03		;2 -> right
             = 0x02		;3 -> left	 

prev_loca DCD 0x00000000	;previous enemy location
    
attack DCD 0x00000000           ;board address of air pump attack	
       
    ALIGN
           
time = 0x31			;set intial time to 120 seconds
     = 0x32
     = 0x30,0
     
random1 DCD 0x00000000		;bits 0-2 + bits 3-4 + bit 5 (1), 8-13 (2), 16-21 (3) <-row ... bits 6,14,22 (1,2,3) <-size
        
random2 DCD 0x00000000		;bits 0-3 + bit 4 (1), 8-12 (2), 16-20 (3)
        
    ALIGN
        
score = 0x30			;set initial score to ascii 0000
      = 0x30
      = 0x30
      = 0x30,0

timerphase = 0x04		;refresh rate (half second)
           = 0x00		;rate counter
           = 0x00		;timer counter
           = 0x00		;pause counter
           = 0x00		;enemy movement counter
           
movement = 0x00			;various flag bytes
airpump = 0x00
paused = 0x00
ended = 0x00

level = 0x01			;inital level 1
      = 0x00			;levelup flag

      ALIGN

digits_SET	
        DCD 0x00001F80  ; 0
        DCD 0x00000300  ; 1
        DCD 0x00002D80  ; 2
        DCD 0x00002780  ; 3
        DCD 0x00003300  ; 4
        DCD 0x00003680  ; 5
        DCD 0x00003E80  ; 6
        DCD 0x00000380  ; 7
        DCD 0x00003F80  ; 8
        DCD 0x00003380  ; 9
            
RGB_color
        DCD 0x00020000  ; red
        DCD 0x00040000  ; blue
        DCD 0x00200000  ; green
        DCD 0x00060000  ; purple
        DCD 0x00220000  ; yellow
        DCD 0x00260000  ; white

LED_pattern
        DCD 0x000F0000	;4
        DCD 0x000E0000	;3
        DCD 0x000C0000	;2
        DCD 0x00080000	;1
        DCD 0x00000000	;0

      ALIGN

lab7
        STMFD sp!, {lr}
        LDR r1, =0xE0008004		;enable Timer 1
        MOV r2, #1
        STR r2, [r1]
        BL default_setup		;setup initial GPIO
        LDR r4, =title			;load title sequence
        BL output_string		;output title via PuTTY
TITLE   BL read_character		
        CMP r0, #0xD			
        BNE TITLE
        LDR r4, =prompt			;load instruction sets
        BL output_string		;output instructions via PuTTY
HOWTO	BL read_character		
        CMP r0, #0xD			
        BNE HOWTO
        BL random_number
        LDR r1, =random1		;store first random number
        STR r0, [r1]
        LDR r1, [r1]
        LDR r4, =prompt2		
        BL output_string		
CNTRL	BL read_character		
        CMP r0, #0xD			
        BNE CNTRL
        BL random_number
        LDR r1, =random2		;second random number
        STR r0, [r1]
FIRST	LDR r4, =RGB_color		;set RGB color to green for gameplay			
        LDR r0, [r4, #8]
        BL Illuminate_RGB_LED	
        BL init_param			;set all initial parameters
        BL init_display
        BL display_board		;display the initial board
        BL interrupt_init		;enable interrupts
        LDR r4, =level			;load current level
        LDRB r1, [r4]
        MOV r1, r1, LSL #2		;use to set an offset for digits_SET
        LDR r4, =digits_SET
        LDR r0, [r4, r1]
        BL display_digit_on_7_seg	;display level on 7 seg
        LDR r4, =lives_left			;load number of lives left 
        LDRB r1, [r4]
        MOV r1, r1, LSL #2			
        LDR r4, =LED_pattern		;display on the LEDs
        LDR r0, [r4, r1]
        BL illuminateLEDS
LOOP	LDR r4, =ended			;enter loop, check if game has ended
        LDRB r0, [r4]
        CMP r0, #1
        BNE LVLup			;check for level up flag		
        BL disable_interrupts	        ;disable the interrupts
        BL random_number
        LDR r1, =random1		;store first random number
        STR r0, [r1]
        LDR r4, =lives_left		;for each of the lives left, add 50 points
        LDRB r5, [r4]
        RSB	r5, r5, #4			

SCOR50	CMP r5, #0			;check if all lives accounted for
        BLE SCRUPT4
        LDR r4, =score			;load score memory location
        LDRB r2, [r4]			;thousands place
        LDRB r1, [r4, #1]		;hundreds
        LDRB r0, [r4, #2]		;tens
        CMP r0, #0x35			;check if rollover to the hundreds place
        BGE upTEN4
        ADD r0, r0, #5			;increment by 5 x place
        B SCRUPT3
upTEN4	CMP r1, #0x39			;to the thousands
        BGE upHUN4
        SUB	r0, r0, #0x35 		;reset tens and add remaining places
        ADD r0, r0, #0x30
        ADD r1, r1, #1			;increment by 1 x place
        B SCRUPT3
upHUN4	MOV r1, #0x30			;reset hundreds to 0
        SUB	r0, r0, #0x35 		;reset tens and add remaining places
        ADD r0, r0, #0x30
        ADD r2, r2, #1			;increment by 1 x place
SCRUPT3	STRB r0, [r4, #2]		;update the score
        STRB r1, [r4, #1]
        STRB r2, [r4]
        SUB r5, r5, #1			;loopback for each life
        B SCOR50
        
SCRUPT4	LDR r4, =RGB_color
        LDR r0, [r4, #12]		;set RGB to purple
        BL Illuminate_RGB_LED
        LDR r4, =clear
        BL output_string
        LDR r4, =timeleft		;time string
        BL output_string
        LDR r4, =time			;time in ascii
        BL output_string
        LDR r4, =newline		
        BL output_string
        LDR r4, =gamescore		;score string
        BL output_string
        LDR r4, =score			;score in ascii
        BL output_string
        LDR r4, =newline
        BL output_string
        LDR r4, =newline
        BL output_string
        
        LDR r4, =topboard		;load top/middle/bottom of board
        BL output_string		;print each
        LDR r4, =endgame
        BL output_string
        LDR r4, =botboard
        BL output_string
        LDR r4, =restart		;display instructions
        BL output_string
                
LOOP2	BL read_character		;wait for user input
        CMP r0, #0x51			;check for 'q' or 'Q' to quit game
        BNE CUE
        B GMEXIT
CUE		CMP r0, #0x71
        BNE RESRT
        B GMEXIT
RESRT	CMP r0, #0xD			;check for ENTER key response
        BNE LOOP2
        BL random_number
        LDR r1, =random2		;store second random number
        STR r0, [r1]
        BL end_initialize		;reinitialize all stored values
        BL reinitialize			
        B FIRST				;restart the game

LVLup	LDR r4, =level			;check levelup flag
        LDRB r0, [r4, #1]
        CMP r0, #1
        BNE LOOP			;loopback
        BL reinitialize			;reinitialze new level
        B FIRST
        
GMEXIT	B GMEXIT			;infinte loop so cwrapper cannot jump to some random line :(
        LDMFD sp!,{lr}			;exit
        BX lr



init_param
        STMFD sp!, {lr}
        LDR r0, =enemy_row		;load enemy characteristics
        LDR r1, =enemy_col
        LDR r9, =enemy_size
        LDR r2, =random1
        LDR r10, =level			;load current level as a rotate offset
        LDRB r11, [r10]
        SUB r11, r11, #1
        MOV r7, #0
SETROW	LDRB r3, [r2, r7]		;isolate the specified bits of the random number and add them together
        ROR r3, r3, r11
        MOV r4, r3, LSL #29
        MOV r4, r4, LSR #29
        MOV r5, r3, LSL #27
        MOV r5, r5, LSR #30
        MOV r6, r3, LSL #26
        MOV r6, r6, LSR #31
        ADD r5, r4, r5
        ADD r6, r5, r6
        ADD r6, r6, #3
        STRB r6, [r0, r7]		;store in offset of enemy number
        MOV r4, r3, LSL #31		;isolate the specified bits for enemy size
        MOV r4, r4, LSR #31
        STRB r4, [r9, r7]		;store in offset of enemy number
        ADD r7, r7, #1
        CMP r7, #3
        BNE SETROW
        LDR r2, =random2		
        MOV r7, #0
SETCOL	LDRB r3, [r2, r7]		;isolate the specified bits of the random number and add them together
        ROR r3, r3, r11
        MOV r4, r3, LSL #28
        MOV r4, r4, LSR #28
        MOV r5, r3, LSL #27
        MOV r5, r5, LSR #31
        ADD r5, r4, r5
        ADD r5, r5, #2
        STRB r5, [r1, r7]		;store in offset of enemy number
        ADD r7, r7, #1
        CMP r7, #3
        BNE SETCOL
CHK1	LDRB r2, [r0]			;load row for each enemy
        LDRB r3, [r0, #1]
        LDRB r4, [r0, #2]
        LDRB r5, [r1]			;load col for each enemy
        LDRB r6, [r1, #1]
        LDRB r7, [r1, #2]
        BL spawn_check			;check against any character collision in initial spawn
        LDR r0, =enemy_row		;store new coordinates
        STRB r2, [r0]
        LDR r1, =enemy_col
        STRB r5, [r1]
        MOV r8, r3			;swap registers for branch and link
        MOV r3, r2
        MOV r2, r8
        MOV r8, r6
        MOV r6, r5
        MOV r5, r8
        BL spawn_check
        LDR r0, =enemy_row		;store new coordinates
        STRB r2, [r0, #1]
        LDR r1, =enemy_col
        STRB r5, [r1, #1]
        MOV r8, r4			;swap registers for branch and link
        MOV r4, r2
        MOV r2, r8
        MOV r8, r7
        MOV r7, r5
        MOV r5, r8
        BL spawn_check
        LDR r0, =enemy_row		;store new coordinates
        STRB r2, [r0, #2]
        LDR r1, =enemy_col
        STRB r5, [r1, #2]
        LDMFD sp!,{lr}
        BX lr


        LTORG
init_display
        STMFD SP!, {lr}
        MOV r8, #0
NXTen	LDR r5, =enemy_row		;load row in r1, size in r3
        LDR r6, =enemy_col		;load col in r2
        LDRB r1, [r5, r8]
        LDRB r2, [r6, r8]				
        LDR r4, =board
        ADD r1, r1, #1			;add 1 to row to account for sky
        MOV r5, r1, LSL #4		;incerment board address by row
        MOV r6, r1, LSL #3
        ADD r5, r5, r6
        SUB r1, r5, r1
        ADD r4, r4, r1
        ADD r4, r4, r2
        SUB r4, r4, #1
        MOV r10, #0x20			;store a space in the three corresponding spaces
        STRB r10, [r4]
        ADD r4, r4, #1
        STRB r10, [r4]
        ADD r4, r4, #1
        STRB r10, [r4]
        CMP r8, #2			;scheck if last enemy checked
        BGE SPCSTR 
        ADD r8, r8, #1			;incremet enemy offset
        B NXTen
SPCSTR	LDR r4, =clear
        BL output_string
        LDR r4, =board
        BL output_string
        LDMFD SP!, {lr}
        BX lr

        
display_board
        STMFD SP!, {lr}			;Store register lr on stack
        
        LDR r4, =clear			;clear display
        BL output_string
        LDR r4, =timeleft		;time string
        BL output_string
        LDR r4, =time			;time in ascii
        BL output_string
        LDR r4, =newline		
        BL output_string
        LDR r4, =gamescore		;score string
        BL output_string
        LDR r4, =score			;score in ascii
        BL output_string
        LDR r4, =newline
        BL output_string
        LDR r4, =newline
        BL output_string
        
        LDR r4, =user			;load row in r1
        LDRB r1, [r4]	
        LDRB r2, [r4, #1]		;column in r2
        LDRB r3, [r4, #2]		;char in r3
        
        LDR r4, =board
        ADD r1, r1, #1			;add 1 to row to account for sky
        MOV r5, r1, LSL #4		;incerment board address by row
        MOV r6, r1, LSL #3		;(16 x row) + (8 x row) - (row)
        ADD r5, r5, r6
        SUB r1, r5, r1
        ADD r4, r4, r1	
        
        ADD r4, r4, r2
        STRB r3, [r4]			;store char
        SUB r4, r4, #1
        
enCHK	LDR r10, =enemy_row		;load each enemy row and size
        LDRB r0, [r10]
        LDRB r1, [r10, #1]
        LDRB r2, [r10, #2]
        LDR r10, =enemy_col		;load each enemy column and life status
        LDRB r4, [r10]
        LDRB r5, [r10, #1]
        LDRB r6, [r10, #2]
        
        MOV r8, #0
STRTen	CMP r0, #0			;enemy alive if row =/= 0
        BEQ NXTen1
        LDR r10, =enemy_size
        LDRB r3, [r10, r8]
        CMP r3, #1			;big enmeny if 1, normal if 0
        BNE NORMIE
        MOV r3, #0x26
        B BIGGIE
NORMIE	MOV r3, #0x2A

BIGGIE	MOV r7, r0			;set r7 as a backup of the row
        LDR r9, =board
        ADD r0, r0, #1			;add 1 to row to account for sky
        MOV r10, r0, LSL #4		;incerment board address by row
        MOV r11, r0, LSL #3
        ADD r10, r10, r11
        SUB r0, r10, r0
        ADD r9, r9, r0
        ADD r9, r9, r4
    
        STRB r3, [r9]			;store char
        SUB r9, r9, #1
        MOV r11, #1
        LDRB r12, [r9]
        BL enemy_check			;check col - 1 and replace with ' ' if old enemy char exists
        CMP r12, #0
        BEQ NXT4
        MOV r11, #0x20
        STRB r11, [r9]
NXT4	ADD r9, r9, #24
        MOV r11, #4
        LDRB r12, [r9]
        BL enemy_check			;check row + 1 and replace with ' ' if old enemy char exists
        CMP r12, #0
        BEQ NXT5
        MOV r11, #0x20
        STRB r11, [r9]
NXT5	SUB r9, r9, #46
        MOV r11, #3
        LDRB r12, [r9]
        BL enemy_check			;check row - 1 and replace with ' ' if old enemy char exists
        CMP r12, #0
        BEQ NXT6
        MOV r11, #0x20
        STRB r11, [r9]
NXT6	ADD r9, r9, #24
        MOV r11, #2
        LDRB r12, [r9]
        BL enemy_check			;check col + 1 and replace with ' ' if old enemy char exists
        CMP r12, #0
        BEQ NXTen1
        MOV r11, #0x20
        STRB r11, [r9]
        
NXTen1	CMP r8, #0			;check which enemy already printed
        BNE NXTen2
        MOV r9, r7			;swap register values for row/col
        MOV r0, r1
        MOV r1, r9
        MOV r9, r4
        MOV r4, r5
        MOV r5, r9
        ADD r8, r8, #1
        B STRTen
NXTen2	CMP r8, #1
        BNE DISPLY
        MOV r9, r7
        MOV r0, r2
        MOV r2, r9
        MOV r9, r4
        MOV r4, r6
        MOV r6, r9
        ADD r8, r8, #1
        B STRTen
        
DISPLY	LDR r4, =board
        BL output_string
        LDMFD SP!, {lr}			;Restore register lr from stack
        BX lr
        
        
        LTORG
collision_adjust
        STMFD SP!, {r0-r4, lr}
        CMP r0, r1			;compare for overlap
        BNE KLSN1
        CMP r3, r2
        BNE KLSN1
        LDR r4, =user			;reset user coordinates to row 8, col 10
        MOV r0, #0x08			
        STRB r0, [r4]
        MOV r0, #0x0A
        STRB r0, [r4, #1]
        MOV r0, #0x3E			;reset user character to '>'
        STRB r0, [r4, #2]
        MOV r0, #0x03
        STRB r0, [r4, #3]		;reset direction to right
        
        LDR r4, =lives_left		;load number of lives used
        LDRB r5, [r4]
        CMP r5, #4
        BGE KLSN
        ADD r5, r5, #1			;increment the offset
        STRB r5, [r4]			;store back into the memory location
        MOV r1, r5, LSL #2		;create offset to get the associated LED pattern 
        LDR r3, =LED_pattern
        LDR	r0, [r3, r1]	
        BL illuminateLEDS		;illuminate the number of lives left
KLSN	MOV r5, #1
        B KLSN2
KLSN1	MOV r5, #0
KLSN2	LDMFD SP!, {r0-r4, lr}
        BX lr



reinitialize
        STMFD SP!, {lr}
        LDR r4, =user			;reset user coordinates to row 8, col 10
        MOV r0, #0x08
        STRB r0, [r4]
        MOV r0, #0x0A
        STRB r0, [r4, #1]
        MOV r0, #0x3E			;reset user character to '>'
        STRB r0, [r4, #2]
        MOV r0, #0x03			;reset direction to right
        STRB r0, [r4, #3]	
        MOV r0, #0
        LDR r4, =enemy_direct	        ;reset enemy directions
        MOV r0, #2
        STRB r0, [r4]
        STRB r0, [r4, #2]
        MOV r0, #1
        STRB r0, [r4, #1]
        MOV r0, #0
        LDR r4, =enemy_row		;reset all enemy characteristics to zero
        STRB r0, [r4]
        STRB r0, [r4, #1]
        STRB r0, [r4, #2]
        STRB r0, [r4, #3]
        LDR r4, =enemy_col
        STRB r0, [r4]
        STRB r0, [r4, #1]
        STRB r0, [r4, #2]
        LDR r4, =movement		;reset the movement byte
        STRB r0, [r4]
        LDR r4, =airpump		;attack byte and address
        STRB r0, [r4]
        LDR r4, =attack
        STR r0, [r4]
        LDR r4, =paused			;pause byte
        STRB r0, [r4]
        LDR r4, =ended			;endgame byte
        STRB r0, [r4]
        LDR r4, =level			;levelup byte
        STRB r0, [r4, #1]
        LDR r4, =timerphase		;timer phase bytes
        STRB r0, [r4, #1]
        STRB r0, [r4, #2]
        STRB r0, [r4, #3]
        STRB r0, [r4, #4]
        BL board_reset			;revert board to starting layout
        LDMFD SP!, {lr}
        BX lr



end_initialize
        STMFD SP!, {lr}		
        LDR r4, =time			;reset time left to ascii 120, null terminated
        MOV r0, #0x31
        STRB r0, [r4]
        MOV r0, #0x32
        STRB r0, [r4, #1]
        MOV r0, #0x30
        STRB r0, [r4, #2]
        MOV r0, #0x00
        STRB r0, [r4, #3]
        MOV r0, #0x30
        LDR r4, =score			;reset score to 0000
        STRB r0, [r4]
        STRB r0, [r4, #1]
        STRB r0, [r4, #2]
        STRB r0, [r4, #3]
        LDR r4, =timerphase		;reset refresh rate
        MOV r0, #4
        STRB r0, [r4]
        MOV r0, #0x00
        LDR r4, =lives_left		;lives offset back to zero
        STRB r0, [r4]
        LDR r4, =level			;set level back to 1
        MOV r0, #0x01
        STRB r0, [r4]
        LDMFD SP!, {lr}
        BX lr



board_reset
        STMFD SP!, {lr}
        LDR r4, =board		;load current board
        MOV r0, #0
        MOV r1, #0
        CMP r0, #0
        MOV r2, #0x5A
RST1	STRB r2, [r4]		;store the first line as all Z's
        ADD r4, r4, #1
        ADD r1, r1, #1
        CMP r1, #21
        BNE RST1
        BL end_chars		;followed by new line and carraige return
        MOV r1, #0
RST2	CMP r0, #2		;for rows 1 and 2
        BGE RST4
        MOV r2, #0x5A		;store the Z border
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        MOV r2, #0x20		;followed by all spaces
RST3	STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        CMP r1, #20
        BNE RST3
        MOV r2, #0x5A		;ending with another border
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        BL end_chars
        MOV r1, #0
        ADD r0, r0, #1
        B RST2
RST4	CMP r0, #8		;for up until row 9
        BGE RST6
        MOV r2, #0x5A		;store the border
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        MOV r2, #0x23		;followed by all #'s
RST5	STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        CMP r1, #20
        BNE RST5
        MOV r2, #0x5A		;ending with a border
        STRB r2, [r4]
        ADD r4, r4, #1
        BL end_chars
        ADD r0, r0, #1
        MOV r1, #0
        B RST4
RST6	MOV r2, #0x5A		;for row 9, store the border
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        MOV r2, #0x23		;followed by #'s unitl column 9
RST7	STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        CMP r1, #9
        BNE RST7
        MOV r2, #0x20		;store a space
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        MOV r2, #0x3E		;user character
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        MOV r2, #0x20		;another space
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        MOV r2, #0x23		;#'s unitl the last border
RST8	STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        CMP r1, #20
        BNE RST8
        MOV r2, #0x5A
        STRB r2, [r4]
        ADD r4, r4, #1
        BL end_chars
        ADD r0, r0, #1
        MOV r1, #0
RST9	CMP r0, #15		;repeat rows 3-8 for rows 10-15
        BGE RST11
        MOV r2, #0x5A
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        MOV r2, #0x23
RST10	STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        CMP r1, #20
        BNE RST10
        MOV r2, #0x5A
        STRB r2, [r4]
        ADD r4, r4, #1
        BL end_chars
        ADD r0, r0, #1
        MOV r1, #0
        B RST9
RST11	MOV r2, #0x5A		;ending with a full border character row
        STRB r2, [r4]
        ADD r4, r4, #1
        ADD r1, r1, #1
        CMP r1, #21
        BNE RST11
        BL end_chars
        MOV r2, #0x00		;null terminated
        STRB r2, [r4]
        LDMFD SP!, {lr}
        BX lr


end_chars
        STMFD SP!, {lr}
        MOV r2, #0xA		;store a new line character
        STRB r2, [r4]
        ADD r4, r4, #1
        MOV r2, #0xD		;line return character
        STRB r2, [r4]
        ADD r4, r4, #1
        LDMFD SP!, {lr}
        BX lr
        
        
        
FIQ_Handler
        STMFD SP!, {r0-r12, lr}   ; Save registers

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Check for EINT1 interrupt

EINT1		
        LDR r0, =0xE01FC140
        LDR r1, [r0]
        TST r1, #2
        BEQ TIMER
    
        STMFD SP!, {r0-r12, lr}   ; Save registers 
        
        LDR r4, =paused
        LDRB r0, [r4]
        LDR r2, =RGB_color	
        CMP r0, #0
        BNE PAUSE
        MOV r0, #1			;set 'pause' state to 1
        STRB r0, [r4]
        LDR r4, =timerphase		;set pause counter to zero
        MOV r0, #0
        STRB r0, [r4, #3]
        LDR r0, [r2, #4]		;load blue color
        BL Illuminate_RGB_LED
        B CLEAR
PAUSE	LDR r0, [r2, #8]		;load green color
        BL Illuminate_RGB_LED
        MOV r0, #0			;set 'pause' state to 0
        STRB r0, [r4]
CLEAR	LDMFD SP!, {r0-r12, lr}         ; Restore registers
        
        ORR r1, r1, #2		; Clear Interrupt
        STR r1, [r0]
        B FIQ_Exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Check for Timer interrupt

TIMER	LDR r0, =0xE0004000
        LDR r1, [r0]
        TST r1, #2
        BEQ UART0
    
        STMFD SP!, {r0-r12, lr}  	; Save registers	
        
        ;check for paused game
        LDR r4, =paused
        LDRB r0, [r4]
        CMP r0, #1
        BLT GMECLK
        
        LDR r4, =clear			;clear screen
        BL output_string
        LDR r4, =timeleft		;time string
        BL output_string
        LDR r4, =time			;time in ascii
        BL output_string
        LDR r4, =newline		
        BL output_string
        LDR r4, =gamescore		;score string
        BL output_string
        LDR r4, =score			;score in ascii
        BL output_string
        LDR r4, =newline
        BL output_string
        LDR r4, =newline
        BL output_string
        
        LDR r4, =timerphase
        LDRB r0, [r4, #3]
        CMP r0, #4			;check for which cycle pause screen is on
        BGT BLINK
        ADD r0, r0, #1			;increment the pause counter
        STRB r0, [r4, #3]
        
        LDR r4, =topboard		;load top/middle/bottom of board
        BL output_string		;print each
        LDR r4, =midboard
        BL output_string
        LDR r4, =botboard
        BL output_string
        B SKIP

BLINK	ADD r0, r0, #1			;increment the pause counter
        CMP r0, #9
        BLE BLINK2
        MOV r0, #0
BLINK2	STRB r0, [r4, #3]
        
        LDR r4, =topboard		;load top/middle/bottom of board
        BL output_string		;print each
        LDR r4, =pausegame
        BL output_string
        LDR r4, =botboard
        BL output_string
        B SKIP
        
;;;;;;;;;;;;;;;;; update game timer
GMECLK	LDR r4, =RGB_color		;illuminate green color
        LDR r0, [r4, #8]
        BL Illuminate_RGB_LED
        LDR r4, =timerphase		;load timerphase memory address
        LDRB r0, [r4, #2]		;load the timer counter
        CMP r0, #9			;check if one second has passed
        BGE TICK
        ADD r0, r0, #1			;increment counter
        STRB r0, [r4, #2]		;store new value
        B RFRSH					
TICK	MOV r0, #0			;reset counter
        STRB r0, [r4, #2]
        LDR r4, =time			;load each digit of the game clock
        LDRB r0, [r4]
        LDRB r1, [r4, #1]
        LDRB r2, [r4, #2]
        CMP r2, #0x30			;check if ones place is zero
        BEQ TENS
        SUB r2, r2, #1			;decrement
        STRB r2, [r4, #2]
        B RFRSH
TENS	CMP r1, #0x30			;check tens place
        BEQ HNDRDS
        SUB r1, r1, #1			;decrement
        STRB r1, [r4, #1]
        MOV r2, #0x39			;change remaing time to 9
        STRB r2, [r4, #2]
        B RFRSH
HNDRDS	CMP r0, #0x30			;check hundreds place
        BEQ TMEOUT
        MOV r0, #0x30			;if not, swap to zero
        STRB r0, [r4]
        MOV r1, #0x39			;change remaing time to 99
        STRB r1, [r4, #1]
        STRB r1, [r4, #2]
        B RFRSH
TMEOUT	LDR r4, =ended			;flag that the game has timed out
        MOV r0, #1
        STRB r0, [r4]
        B SKIP
        
;;;;;;;;;;;;;;;;;;;;; check refresh rate
RFRSH	LDR r4, =timerphase
        LDRB r0, [r4]			;load refresh rate and counter
        LDRB r1, [r4, #1]
        CMP r0, r1			;check if counter has reached refresh rate
        BNE TICK2
        MOV r1, #0			;reset coutner
        STRB r1, [r4, #1]
        B RUN				;continue with board update
TICK2	ADD r1, r1, #1			;increment counter
        STRB r1, [r4, #1]
        B SKIP
        
        ;;;game run checks;;;
        
;;;;;;;;;;;;;;;;; enemy/player collision
RUN 	MOV r9, #0			;initialzie counter
        LDR r4, =user			;load user location into r0, r3
        LDRB r0, [r4]			
        LDRB r3, [r4, #1]
COLSN	LDR r4, =enemy_row		;load enemy location into r1, r2
        LDRB r1, [r4, r9]
        LDR r4, =enemy_col
        LDRB r2, [r4, r9]
        BL collision_adjust
        CMP r5, #1
        BEQ COLSN3
COLSN2	CMP r9, #2			;have all enemies been checked against?
        BGT USER
        ADD r9, r9, #1			;check next enemy
        B COLSN
COLSN3	LDR r4, =lives_left			
        LDRB r5, [r4]			;load number of lives left into r1
        CMP r5, #4			;if all lives have been exhausted
        BLT USER
        LDR r4, =ended			;begin endgame process, store 1 in memory location
        MOV r0, #1
        STRB r0, [r4]
        B SKIP
        
;;;;;;;;;;;;;;;;;;; user movement
USER	LDR r4, =movement		;reset the timerupdate
        LDRB r0, [r4]
        LDR r4, =user			;load row in r1
        LDRB r1, [r4]	
        LDRB r2, [r4, #1]		;column in r2
        LDRB r3, [r4, #2]		;char in r3
        
        LDR r7, =board			;load board address in r7
        ADD r8, r1, #1			;add 1 to row to account for sky
        MOV r5, r8, LSL #4		;incerment board address by row
        MOV r6, r8, LSL #3
        ADD r5, r5, r6
        SUB r8, r5, r8
        ADD r7, r7, r8
        ADD r7, r7, r2
        
UP		CMP r0, #1		;check if 0 stored
        BNE DOWN
        CMP r3, #0x5E			;check if already facing the desired direction
        BEQ UPMVE
        MOV r3, #0x5E			;store new char
        STRB r3, [r4, #2]
        MOV r0, #0
        STRB r0, [r4, #3]
        B UPDATE
UPMVE	CMP r1, #1			;check row, update if applicable
        BEQ UPDATE
        MOV r0, #0x20			;replace old coordinates with a space
        STRB r0, [r7]
        SUB r1, r1, #1
        STRB r1, [r4]
        SUB r7, r7, #23			;check if char at new coordinates is a '#'
        LDRB r8, [r7]
        CMP r8, #0x23
        BEQ SCRETEN
        B UPDATE
DOWN	CMP r0, #2			;check if 1 stored
        BNE LEFT
        CMP r3, #0x76	
        BEQ DWNMVE
        MOV r3, #0x76			;store new char
        STRB r3, [r4, #2]
        MOV r0, #1
        STRB r0, [r4, #3]
        B UPDATE
DWNMVE	CMP r1, #14			;check row, update if applicable
        BEQ UPDATE
        MOV r0, #0x20			
        STRB r0, [r7]
        ADD r1, r1, #1
        STRB r1, [r4]
        ADD r7, r7, #23
        LDRB r8, [r7]
        CMP r8, #0x23
        BEQ SCRETEN
        B UPDATE
LEFT	CMP r0, #3			;check if 2 stored
        BNE RGHT
        CMP r3, #0x3C	
        BEQ LFTMVE
        MOV r3, #0x3C			;store new char
        STRB r3, [r4, #2]
        MOV r0, #2
        STRB r0, [r4, #3]
        B UPDATE
LFTMVE	CMP r2, #1			;check col, update if applicable
        BEQ UPDATE
        MOV r0, #0x20
        STRB r0, [r7]
        SUB r2, r2, #1
        STRB r2, [r4, #1]
        SUB r7, r7, #1
        LDRB r8, [r7]
        CMP r8, #0x23
        BEQ SCRETEN
        B UPDATE
RGHT	CMP r0, #4			;check if 3 stored
        BNE	UPDATE
        CMP r3, #0x3E
        BEQ RGTMVE
        MOV r3, #0x3E			;store new char
        STRB r3, [r4, #2]
        MOV r0, #3
        STRB r0, [r4, #3]
        B UPDATE
RGTMVE	CMP r2, #19			;check col, update if applicable
        BEQ UPDATE
        MOV r0, #0x20
        STRB r0, [r7]
        ADD r2, r2, #1
        STRB r2, [r4, #1]
        ADD r7, r7, #1
        LDRB r8, [r7]
        CMP r8, #0x23
        BEQ SCRETEN
        B UPDATE

SCRETEN	LDR r4, =score			;load score memory location
        LDRB r2, [r4]			;thousands
        LDRB r1, [r4, #1]		;hundreds
        LDRB r0, [r4, #2]		;tens place
        CMP r0, #0x39			;check if rollover to the hundreds place
        BGE upTEN
        ADD r0, r0, #1			;increment by 1 x place
        B SCRUPT
upTEN	CMP r1, #0x39			;to the thousands
        BGE upHUN
        MOV r0, #0x30			;reset tens to 0
        ADD r1, r1, #1			;increment by 1 x place
        B SCRUPT
upHUN	MOV r1, #0x30			;reset tens and hundreds to 0
        MOV r0, #0x30
        ADD r2, r2, #1			;increment by 1 x place

SCRUPT	STRB r0, [r4, #2]		;update the score
        STRB r1, [r4, #1]
        STRB r2, [r4]

UPDATE	MOV r0, #0
        LDR r4, =movement		;reset movment byte
        STRB r0, [r4]

;;;;;;;;;;;;;;;;;; check for attack
AIRPUMP	LDR r4, =airpump		;check if air pump used
        LDRB r0, [r4]
        CMP r0, #0x20
        BNE LEVEL
        MOV r0, #0			;clear flag
        STRB r0, [r4]
        LDR r4, =RGB_color		;illumiate red color
        LDR r0, [r4]
        BL Illuminate_RGB_LED
        LDR r4, =user			;load user coordinates/direction
        LDRB r1, [r4]
        LDRB r2, [r4, #1]
        LDRB r3, [r4, #3]
        
        LDR r7, =board			;load board address in r7
        ADD r8, r1, #1			;add 1 to row to account for sky
        MOV r5, r8, LSL #4		;incerment board address by row
        MOV r6, r8, LSL #3
        ADD r5, r5, r6
        SUB r8, r5, r8
        ADD r7, r7, r8
        ADD r7, r7, r2
        
        MOV r10, #0			;set r10 as a counter
        MOV r8, #0			;initialize enemy offset
ATKUP	CMP r3, #0			;check current facing user direction, up
        BNE ATKDWN
ATK1	ADD r10, r10, #1		;increment counter
        SUB r7, r7, #23			;move down (up) one row in the board
        SUB r1, r1, #1			;decrement row coordinate
        LDRB r9, [r7]
        MOV r11, r9
        CMP r9, #0x20			;check if char is a space
        BEQ ATK1	
        CMP r9, #0x5A			;'Z' border
        BEQ ATK2
        CMP r9, #0x23			;'#' character
        BNE ATKen
ATK2	CMP r10, #2			;check if more that 1 space away from player
        BLT LEVEL
        ADD r7, r7, #23			;move back one space on the board
        MOV r9, #0x2B			;display a '+' symbol
        STRB r9, [r7]
        B STRatk

ATKDWN	CMP r3, #1			;down
        BNE ATKLFT
ATK3	ADD r10, r10, #1		
        ADD r7, r7, #23			;move up (down) one row in the board
        ADD r1, r1, #1			;increment row coordinate	
        LDRB r9, [r7]
        MOV r11, r9
        CMP r9, #0x20
        BEQ ATK3
        CMP r9, #0x5A
        BEQ ATK4
        CMP r9, #0x23
        BNE ATKen
ATK4	CMP r10, #2
        BLT LEVEL
        SUB r7, r7, #23			;move back one row
        MOV r9, #0x2B
        STRB r9, [r7]
        B STRatk

ATKLFT	CMP r3, #2			;left
        BNE ATKRGHT
ATK5	ADD r10, r10, #1
        SUB r7, r7, #1			;move left one space on the board
        SUB r2, r2, #1			;decrement column counter
        LDRB r9, [r7]
        MOV r11, r9
        CMP r9, #0x20
        BEQ ATK5
        CMP r9, #0x5A
        BEQ ATK6
        CMP r9, #0x23
        BNE ATKen
ATK6	CMP r10, #2
        BLT LEVEL
        ADD r7, r7, #1			;move back one space
        MOV r9, #0x2B
        STRB r9, [r7]
        B STRatk
        
ATKRGHT	CMP r3, #3			;right
        BNE UPDTen
ATK7	ADD r10, r10, #1
        ADD r7, r7, #1			;move right one space on the baord
        ADD r2, r2, #1			;increment row counter
        LDRB r9, [r7]
        MOV r11, r9
        CMP r9, #0x20
        BEQ ATK7
        CMP r9, #0x5A
        BEQ ATK8
        CMP r9, #0x23
        BNE ATKen
ATK8	CMP r10, #2
        BLT LEVEL
        SUB r7, r7, #1			;move back one space
        MOV r9, #0x2B
        STRB r9, [r7]
        B STRatk

ATKen	MOV r9, #0x20
        STRB r9, [r7]
ATKen1	LDR r4, =enemy_row		;load enemy row and col
        LDRB r5, [r4, r8]
        LDR r6, =enemy_col	
        LDRB r10, [r6, r8]
        CMP r1, r5			;compare the row to the attack coordinates
        BEQ	ATKen2
        ADD r8, r8, #1			;check next enemy
        B ATKen1
ATKen2	CMP r2, r10			;compare the colomns
        BEQ ATKen3
        ADD r8, r8, #1			;check next enemy
ATKen3	MOV r9, #0x2B			;store a '+' at the coordinates
        STRB r9, [r7]	
        MOV r5, #0
        STRB r5, [r4, r8]		;move enemy coordinates to (0,0)
        STRB r5, [r6, r8]
        
SCOREx	LDR r4, =score			;load score memory location
        LDRB r2, [r4]			;thousands place
        LDRB r1, [r4, #1]		;hundreds
        LDRB r0, [r4, #2]		;tens
        CMP r11, #0x2A
        BEQ SCR50
        CMP r11, #0x26
        BEQ SCR100
SCR50	CMP r0, #0x35			;check if rollover to the hundreds place
        BGE upTEN2
        ADD r0, r0, #5			;increment by 5 x place
        B SCRUPT2
upTEN2	CMP r1, #0x39			;to the thousands
        BGE upHUN2
        SUB	r0, r0, #0x35 		;reset tens and add remaining places
        ADD r0, r0, #0x30
        ADD r1, r1, #1			;increment by 1 x place
        B SCRUPT2
upHUN2	MOV r1, #0x30			;reset hundreds to 0
        SUB	r0, r0, #0x35 		;reset tens and add remaining places
        ADD r0, r0, #0x30
        ADD r2, r2, #1			;increment by 1 x place
        B SCRUPT2
SCR100	CMP r1, #0x39			;check if rollover to the thousands
        BGE upHUN3
        ADD r1, r1, #1			;increment by 1 x place
        B SCRUPT2
upHUN3	MOV r1, #0x30			;reset hundreds to 0
        ADD r2, r2, #1			;increment by 1 x place

SCRUPT2	STRB r0, [r4, #2]		;update the score
        STRB r1, [r4, #1]
        STRB r2, [r4]
        
STRatk	MOV r0, #1			;store a flag in the airpump byte
        LDR r4, =airpump
        STRB r0, [r4]
        LDR r8, =attack			;store current board address
        STR r7, [r8]
                
;;;;;;;;;;;;;;;;; level up
LEVEL	MOV r8, #0		
        MOV r1, #0			;set counter = 0
LVL2	CMP r8, #2			;check enemy offset
        BGT LVL3
        LDR r4, =enemy_row	        ;load enemy coordinates
        LDRB r0, [r4, r8]
        ADD r1, r1, r0		        ;add row to counter
        ADD r8, r8, #1		        ;check next enemy
        B LVL2
LVL3	CMP r1, #0			;if counter = 0, advance to next level
        BNE UPDTen
        LDR r4, =level
        LDRB r0, [r4]
        CMP r0, #9			;if level equals 9, remain on level
        BEQ LVL4
        ADD r0, r0, #1		        ;else, add 1
        STRB r0, [r4]
        LDR r5, =timerphase
        LDRB r1, [r5]		        ;decrement refresh rate until caps at 0 (level 5)
        CMP r1, #0
        BEQ LVL4
        SUB r1, r1, #1	
        STRB r1, [r5]
LVL4	MOV r0, #1			;create flag	
        STRB r0, [r4, #1]
        LDR r4, =score		        ;load score memory location
        LDRB r2, [r4]		        ;thousands place
        LDRB r1, [r4, #1]	        ;hundreds
        LDRB r0, [r4, #2]	        ;tens
SCOR100	CMP r1, #0x39		        ;check if rollover to the thousands
        BGE upHUN5
        ADD r1, r1, #1		        ;increment by 1 x place
        B SCRUPT5
upHUN5	MOV r1, #0x30		        ;reset hundreds to 0
        ADD r2, r2, #1		        ;increment by 1 x place

SCRUPT5	STRB r0, [r4, #2]	        ;update the score
        STRB r1, [r4, #1]
        STRB r2, [r4]
        B SKIP

;;;;;;;;;;;;;;;;; enemy 1, 2, and/or 3
UPDTen	MOV r9, #0
UPDTen1	LDR r4, =user			;load user coordinates into r0, r3
        LDRB r0, [r4]
        LDRB r3, [r4, #1]
        LDR r4, =enemy_row		;load the row/col/direction of the enemy
        LDRB r1, [r4, r9]
        CMP r1, #0
        BEQ STRdir
        LDR r4, =enemy_col	
        LDRB r2, [r4, r9]
        BL collision_adjust		;check for user/enemy collsion before each movement
        LDR r4, =enemy_direct
        LDRB r3, [r4, r9]
        
        LDR r4, =board
        ADD r7, r1, #1			;add 1 to row to account for sky
        MOV r5, r7, LSL #4		;incerment board address by row/col
        MOV r6, r7, LSL #3
        ADD r5, r5, r6
        SUB r7, r5, r7
        ADD r4, r4, r7
        ADD r4, r4, r2			;add column
        LDR r5, =prev_loca		;store current enemy location before updating
        STR r4, [r5]
        
        LDR r5, =enemy_row		;load the coordinates of each other enemy for movement check
        LDR r6, =enemy_col
        CMP r9, #0
        BNE ENMY1
        LDRB r8, [r5, #1]		;enemies 2 and 3
        LDRB r10, [r5, #2]
        LDRB r11, [r6, #1]
        LDRB r12, [r6, #2]
        B ENMY3
ENMY1	CMP r9, #1
        BNE ENMY2
        LDRB r8, [r5]			;enemies 1 and 3
        LDRB r10, [r5, #2]
        LDRB r11, [r6]
        LDRB r12, [r6, #2]
        B ENMY3
ENMY2	LDRB r8, [r5, #1]		;enemies 1 and 2
        LDRB r10, [r5]
        LDRB r11, [r6, #1]
        LDRB r12, [r6]

ENMY3	SUB r4, r4, #1			;load the surrounding board characters
        LDRB r0, [r4]
        SUB r1, r1, #1			;decrement column for check
        BL move_check			;check each to see if applicable movement
        MOV r5, r0
        ADD r4, r4, #2			
        LDRB r0, [r4]
        ADD r1, r1, #2			;increment row
        BL move_check
        SUB r1, r1, #1			;restore original row
        MOV r6, r0
        SUB r4, r4, #24
        LDRB r0, [r4]
        SUB r2, r2, #1			;decrement column
        BL move_check
        MOV r7, r0
        ADD r4, r4, #46
        LDRB r0, [r4]
        ADD r2, r2, #2			;increment column	
        BL move_check
        SUB r2, r2, #1			;restore orignal column
        MOV r8, r0
        
        MOV r0, #0			;set r0 as the # of available directions
        MOV r4, #0			;set r4 as strictly horizontal
        MOV r10, #0			;set r10 as strictly vertical
        
        CMP r5, #1			;check if left is an applicable movemnt
        BNE SPCr
        ADD r0, r0, #1			;store bit 0 in r0
        MOV r4, #1			;set horizontal
SPCr	CMP r6, #1			;check right
        BNE SPCu
        ADD r0, r0, #2			;bit 1
        MOV r4, #1			;horizontal
SPCu	CMP r7, #1			;check up
        BNE SPCd
        CMP r1, #1			;check if current row is top of the board
        BEQ SPCd
        ADD r0, r0, #8			;bit 3
        MOV r10, #1			;set vertical
SPCd	CMP r8, #1			;check down
        BNE SAVED
        ADD r0, r0, #4			;bit 2
        MOV r10, #1			;vertical
        
SAVED	CMP r0, #3			;check left/right
        BGT FLOP
        CMP r4, r10			;if vertical/horizontal, change to random direction
        BEQ CHANGE
        CMP r4, r10			;if vertical, branch to its subsection
        BLT FLOP
FLIP	CMP r0, #3			;left/right check
        BNE CHGi
CONTl	CMP r3, #2			;continue in current direction
        BNE CONTr
        SUB r2, r2, #1
        B STRdir
CONTr	ADD r2, r2, #1
        B STRdir
CHGi	CMP r3, #2			;switch from left -> right or right -> left
        BNE CHGi2
        MOV r3, #3
        ADD r2, r2, #1
        B STRdir
CHGi2	MOV r3, #2
        SUB r2, r2, #1
        B STRdir
        
FLOP	CMP r0, #4			;up/down check
        BEQ CHGo
        CMP r0, #8
        BEQ CHGo
        CMP r0, #12
        BEQ CONTu
        B CHANGE
CONTu	CMP r3, #0			;continue in current direction
        BNE CONTd
        SUB r1, r1, #1
        B STRdir
CONTd	ADD r1, r1, #1		
        B STRdir
CHGo	CMP r3, #0			;swap up/down
        BNE CHGo2
        MOV r3, #1
        ADD r1, r1, #1
        B STRdir
CHGo2	MOV r3, #0
        SUB r1, r1, #1
        B STRdir
        
CHANGE	LDR r11, =0xE0008008		;load current value from Timer 1
        LDR r12, [r11]
        MOV r11, r12, LSL #31		;isolate bit 0
        MOV r11, r11, LSR #31
        MOV r12, r12, LSL #30		;isolate bits 0 and 1
        MOV r12, r12, LSR #30
        CMP r0, #5			;check for left/down scenario
        BNE CHNG1
        CMP r11, #0
        BNE C1L
        MOV r3, #1			;move down
        ADD r1, r1, #1
        B STRdir
C1L		MOV r3, #2		;move left
        SUB r2, r2, #1
        B STRdir
CHNG1	CMP r0, #6			;right/down
        BNE CHNG2
        CMP r11, #0
        BNE C2R
        MOV r3, #1
        ADD r1, r1, #1
        B STRdir
C2R		MOV r3, #3
        ADD r2, r2, #1
        B STRdir
CHNG2	CMP r0, #9			;left/up
        BNE CHNG3
        CMP r11, #0
        BNE C3L
        MOV r3, #0
        SUB r1, r1, #1
        B STRdir
C3L		MOV r3, #2
        SUB r2, r2, #1
        B STRdir
CHNG3	CMP r0, #10			;right/up
        BNE CHNG4
        CMP r11, #0
        BNE C3R
        MOV r3, #0
        SUB r1, r1, #1
        B STRdir
C3R		MOV r3, #3
        ADD r2, r2, #1
        B STRdir
CHNG4	CMP r0, #7			;left/right/down				
        BNE CHNG5
        CMP r12, #0
        BNE C4R
        MOV r3, #1
        ADD r1, r1, #1
        B STRdir
C4R		CMP r12, #1
        BNE C4L
        MOV r3, #3
        ADD r2, r2, #1
        B STRdir
C4L		MOV r3, #2
        SUB r2, r2, #1
        B STRdir
CHNG5	CMP r0, #11			;left/right/up
        BNE CHNG6
        CMP r12, #0
        BNE C5R
        MOV r3, #0
        SUB r1, r1, #1
        B STRdir
C5R		CMP r12, #1
        BNE C5L
        MOV r3, #3
        ADD r2, r2, #1
        B STRdir
C5L		MOV r3, #2
        SUB r2, r2, #1
        B STRdir
CHNG6	CMP r0, #13			;left/down/up
        BNE CHNG7
        CMP r12, #0
        BNE C6D
        MOV r3, #0
        SUB r1, r1, #1
        B STRdir
C6D		CMP r12, #1
        BNE C6L
        MOV r3, #1
        ADD r1, r1, #1
        B STRdir
C6L		MOV r3, #2
        SUB r2, r2, #1
        B STRdir
CHNG7	CMP r0, #14			;right/down/up
        BNE CHNG8
        CMP r12, #0
        BNE C7D
        MOV r3, #0
        SUB r1, r1, #1
        B STRdir
C7D		CMP r12, #1
        BNE C7R
        MOV r3, #1
        ADD r1, r1, #1
        B STRdir
C7R		MOV r3, #3
        ADD r2, r2, #1
        B STRdir
CHNG8	CMP r0, #15			;all directions available
        BNE STRdir
        CMP r12, #0
        BNE C8D
        MOV r3, #0
        SUB r1, r1, #1
        B STRdir
C8D		CMP r12, #1
        BNE C8R
        MOV r3, #1
        ADD r1, r1, #1
        B STRdir
C8R		CMP r12, #2
        BNE C8L
        MOV r3, #3
        ADD r2, r2, #1
        B STRdir
C8L		MOV r3, #2
        SUB r2, r2, #1
        B STRdir

STRdir	LDR r4, =prev_loca		;store previous location
        LDR r5, [r4]
        MOV r11, #0x20
        STRB r11, [r5]
        LDR r4, =enemy_direct	        ;store updated direction
        STRB r3, [r4, r9]
        LDR r4, =enemy_row		;updated row
        STRB r1, [r4, r9]
        LDR r4, =enemy_col		;updated column
        STRB r2, [r4, r9]
        CMP r9, #0
        BNE TMEup
        LDR r4, =timerphase
        LDRB r0, [r4, #4]
        CMP r0, #0
        BNE TMEup
        MOV r0, #1
        STRB r0, [r4, #4]
        B DONEen
TMEup	CMP r9, #2 			;branch back if all enemies not updated
        BEQ DONEup
        ADD r9, r9, #1
        B UPDTen1
DONEup	LDR r4, =timerphase
        MOV r9, #0
        STRB r9, [r4, #4]

DONEen	BL display_board
        
        LDR r4, =airpump		;check to reset airpump if used
        LDRB r0, [r4]
        CMP r0, #1
        BNE SKIP
        MOV r0, #0			;clear the flag
        STRB r0, [r4]
        LDR r4, =attack			;load address of air pump
        LDR r1, [r4]
        MOV r0, #0x20			;clear it with a space for next interrupt
        STRB r0, [r1]
        
SKIP	LDMFD SP!, {r0-r12, lr}   	; Restore registers
        
        ORR r1, r1, #2		        ; Clear Interrupt
        STR r1, [r0]
        B FIQ_Exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Check for UART0 interrupt
        
UART0	LDR r0, =0xE000C008		
        LDR r1, [r0]
        TST r1, #0
        BNE FIQ_Exit
    
        STMFD SP!, {r0-r12, lr}        ; Save registers	
        
        LDR r4, =movement
        BL read_character
        
UPup	CMP r0, #0x77			;check if 'w' pressed
        BNE DOWNup
        MOV r0, #1			;store 0 in movment byte
        STRB r0, [r4]
        B Fexit
DOWNup	CMP r0, #0x73			;check if 's' pressed
        BNE LEFTup	
        MOV r0, #2			;store 0 in movment byte
        STRB r0, [r4]
        B Fexit
LEFTup	CMP r0, #0x61			;check if 'a' pressed
        BNE RGHTup
        MOV r0, #3			;store 0 in movment byte
        STRB r0, [r4]
        B Fexit
RGHTup	CMP r0, #0x64			;check if 'd' pressed
        BNE	SPCEBR
        MOV r0, #4			;store 0 in movment byte
        STRB r0, [r4]

SPCEBR	LDR r4, =airpump
        CMP r0, #0x20
        BNE Fexit
        STRB r0, [r4]
        
Fexit	LDMFD SP!, {r0-r12, lr}        ; Restore registers
        
FIQ_Exit
        LDMFD SP!, {r0-r12, lr}
        SUBS pc, lr, #4



    END
    
    
    
        
        
        
        
