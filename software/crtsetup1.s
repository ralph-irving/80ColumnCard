; Videoterm Interface                                                          *
; Firmware v. 2.4                                                              *
;
; Written by Ralph Irving                                                      *
; (c) 2024 Home Use Inc.

; Created:    2024-01-30 08:54:28

.setcpu    "6502"
.org       $0300
.listbytes unlimited

SLOT             = $01
ROMSTARTH        = $C0 + SLOT

; Zero Page

CH              := $0024
CV              := $0025
BASL            := $0028        ; base address for text output (lo)
XSAVE           := $0035
CSWL            := $0036
CSWH            := $0037
KSWL            := $0038
KSWH            := $0039
RNDL            := $004E
RNDH            := $004F

; Input prompt 256 byte character buffer

IN              := $0200

; Temporaries

CRFLAG          := $0478        ; dos saves track numbers associated with the drives here
ASAV1           := $04F8	; and here
TEMPX           := $05F8        ; slot number of the disk controller card from which DOS was booted
OLDCHAR         := $0678        ; 
N0              := $06F8	; dos saves number of recalibration tries here

; Slot N Permanents

BASEL           := $0478 + SLOT ; screen base address low
BASEH           := $04F8 + SLOT ; screen base address high
CHORZ           := $0578 + SLOT ; cursor horizontal position
CVERT           := $05F8 + SLOT ; cursor vertical position
BYTE            := $0678 + SLOT ; pascal character write location
START           := $06F8 + SLOT ; first line on the screen
POFF            := $0778 + SLOT ; power off and lead in counter

; Video Flags Setup
;
; B0 - Alternate character set flag
;    0 - select standard character rom
;    1 - select alternate character rom
; B1 - N/A
; B2 - N/A
; B3 - N/A
; B4 - Display 18/24 lines of text flag
;    0 - 18 lines
;    1 - 24 lines 
; B5 - N/A
; B6 - Upper/Lower case flag - CTRL-A to toggle
;    0 - Upper case
;    1 - Lower case
; B7 - Get line flag
;    0 - Input came from a videoterm "GET" statement
;    1 - Input came from Apple GETLN routine. See Apple II Reference Manual, pages 33-34.

FLAGS           := $07F8 + SLOT

; IO Devices

KBD             := $C000
KBDSTRB         := $C010
SPKR            := $C030
SETAN0          := $C058
RESETAN0        := $C059
BUTN2           := $C063
DEV0            := $C080 + $10 * SLOT
DEV1            := $C081 + $10 * SLOT
DISP0           := $CC00
DISP1           := $CD00

MON_VTAB        := $FC22
MON_SETKBD      := $FE89
MON_SETVID      := $FE93
IORTS           := $FFCB

; Set up 6545 CRTC (6845 is not 100% compatible) and enable card with.

BEGIN:	pha			; Save registers
	txa
	pha
	tya
	pha
SETUP:  sta	$cfff		; Turn off co-resident ROMs
        sta	$c100		; Select co-resident ROM in SLOT
RESTART:lda     #$30
        sta     POFF            ; Set defaults for flags
        sta     FLAGS
        lda     #$00
        sta     START
;       jsr     CLSCRN
        ldx     #$00
LOOP:   txa
        sta     DEV0            ; For the CRTC address
        lda     FONT8X8,x       ; Get parameter
        sta     DEV1            ; Store into CRTC
        inx
        cpx     #$10
        bne     LOOP            ; Continue loop until done
LC82A:  sta     RESETAN0
;       rts

EXIT:   lda     FLAGS
        and     #$08
        beq     NORMOUT
;       jsr     MON_SETVID
;       jsr     MON_VTAB
;       jsr     MON_SETKBD
NORMOUT:pla                     ; Recover registers
        tay
        pla
        tax
        pla
        rts

; CRTC timing tables
FONT8X8:  
    .byte   $7b     ; R0 - Horizontal Total Register
    .byte   $50     ; R1 - Horizontal Displayed Register (80 columns)
    .byte   $5f     ; R2 - Horizontal Sync Position Register
    .byte   $19     ; R3 - Horizontal Sync Width Register

    .byte   $1f     ; R4 - Vertical Total Register
    .byte   $08     ; R5 - Vertical Total Adjust Register
    .byte   $18     ; R6 - Vertical Displayed Register (24 lines)
    .byte   $1c     ; R7 - Vertical Sync Position Register

    .byte   $00     ; R8 - Interlace Mode Register (normal sync mode)
    .byte   $07     ; R9 - Maximum Scan Line Register
    .byte   $c0     ; R10 - Cursor End Register (H)
    .byte   $08     ; R11 - Cursor End Register (L)
    .byte   $00     ; R12 - Start Address Register (H)
    .byte   $00     ; R13 - Start Address Register (L)
    .byte   $00     ; R14 - Cursor Register (H)
    .byte   $00     ; R15 - Cursor Register (L)

.end

FONT7X9:
    .byte   $7b     ; R0 - Horizontal Total Register
    .byte   $50     ; R1 - Horizontal Displayed Register (80 columns)
    .byte   $62     ; R2 - Horizontal Sync Position Register
    .byte   $29     ; R3 - Horizontal Sync Width Register

    .byte   $1b     ; R4 - Vertical Total Register
    .byte   $08     ; R5 - Vertical Total Adjust Register
    .byte   $18     ; R6 - Vertical Displayed Register (24 lines)
    .byte   $19     ; R7 - Vertical Sync Position Register

    .byte   $00     ; R8 - Interlace Mode Register (normal sync mode)
    .byte   $08     ; R9 - Maximum Scan Line Register
    .byte   $e8     ; R10 - Cursor End Register (H)
    .byte   $09     ; R11 - Cursor End Register (L)
    .byte   $00     ; R12 - Start Address Register (H)
    .byte   $00     ; R13 - Start Address Register (L)
    .byte   $00     ; R14 - Cursor Register (H)
    .byte   $00     ; R15 - Cursor Register (L)

