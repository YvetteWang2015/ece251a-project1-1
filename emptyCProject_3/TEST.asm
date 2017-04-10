$NOMOD51
;-----------------------------------------------------------------------------
; SB1_blinky.ASM
;-----------------------------------------------------------------------------
;  TARGET MCU  :  EFM8SB1
;  DESCRIPTION :  This program illustrates how to disable the watchdog timer,
;                 configure the Crossbar, configure a port and write to a port
;                 I/O pin.
;
; 	NOTES:
;
;-----------------------------------------------------------------------------

$include (SI_EFM8BB3_Defs.inc)            ; Include register definition file.

;-----------------------------------------------------------------------------
; EQUATES
;-----------------------------------------------------------------------------

GREEN_LED   equ   P1.4
RED_LED		equ   P1.6
BLUE_LED	equ	  P1.5
DISP_EN      equ   P2.7                    ; Display Enable:
                                           ;   '0' is Board Contoller driven
                                           ;   '1' is EFM8 driven

JMP Main;jump to main function
            ; Simple delay loop.
DEL: MOV R5,#40
DEL1: MOV R6,#100
DEL2: MOV R7,#99
DEL3: DJNZ R7,DEL3
	  DJNZ R6,DEL2
	  DJNZ R5,DEL1
	RET

Main:
            ; Disable the WDT.
            anl   PCA0MD, #NOT(040h)      ; clear Watchdog Enable bit

            ; Enable the Port I/O Crossbar
            orl   P1SKIP, #02h            ; skip LED pin in crossbar
                                          ; assignments
            mov   XBR2, #40h
            orl   P1MDOUT, #02h           ; make LED pin output push-pull
            orl   P2MDOUT, #80h           ; make DISP_EN pin output push-pull


            ; Set Display Enable pin to Board Controller driven
            clr   DISP_EN
			;red 1
			lcall DEL
			clr	RED_LED
			lcall DEL
			cpl RED_LED
			lcall DEL
			;red 2
			clr	RED_LED
			lcall DEL
			cpl RED_LED
			lcall DEL
			;yellow
			clr RED_LED
			clr GREEN_LED
			lcall DEL
			cpl RED_LED
			cpl GREEN_LED
			lcall DEL
			;green
			clr GREEN_LED
			lcall DEL
			cpl GREEN_LED
			lcall DEL


;-----------------------------------------------------------------------------
; End of file.

END

