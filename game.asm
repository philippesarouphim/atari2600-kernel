    processor 6502
    include "vcs.h"
    include "macro.h"

    SEG
    ORG $F000

    include "pointers.asm"
    include "finePositioning.asm"
    include "index.asm"
    include "playfield.asm"
    include "players.asm"

;---------------- POSITION OBJECT SUBROUTINE ----------------

PositionObject subroutine; 1 scanline
; IN: A=POS
; OUT: X=GROSS POSITION, A=FINE POSITION CORRECTION
    ; Jump to subroutine 6
    sta WSYNC
    sec             ; 2
DivideLoop:         ; Waste time (not accounting for 23 MC of WSYNC)
    sbc #15         ; 2
    bcs DivideLoop  ; 3

    tay                     ; 2
    lda fineAdjustTable,y   ; 4 + 1
    sta HMP0,x              ; 4

    sta RESP0,x
    rts             ; 6

;------------------------------------------------------------

    include "reset.asm"

    include "initialization.asm"

StartOfFrame:

    ;lda #%00000000
    ;sta VBLANK
    ; < END VBLANK

    ; > START VSYNC
    lda #%00000010
    sta VSYNC
    
    sta WSYNC
    sta WSYNC
    sta WSYNC

    lda #%00000000
    sta VSYNC
    ; < END VSYNC

    ; > START VBLANK
    lda #%00000010
    sta VBLANK
    sta WSYNC

    ; RESET PLAYERS GRPAHICS REGISTERS
    lda #%00000000
    sta GRP0
    sta GRP1
    sta WSYNC

    ; SET PLAYERS POSITION
    ldx PL0X
    inx
    stx PL0X
    cpx #150
    bne noreset0x
    ldx #0
    stx PL0X
noreset0x

    ldx PL0Y
    inx
    stx PL0Y
    cpx #228
    bne noreset0y
    ldx #0
    stx PL0Y
noreset0y

    ldx #108
    stx PL1X
    ldx #100
    stx PL1Y
    
    sta WSYNC

    ; SET MISSILE POSITIONS
    lda #80
    sta M0X
    lda #150
    sta M0Y
    sta WSYNC

    ; LOAD AND SET PLAYER 0 POSITION
    lda PL0X
    ldx #0
    jsr PositionObject
    sta WSYNC

    ; LOAD AND SET PLAYER 1 POSITION
    lda PL1X
    ldx #1
    jsr PositionObject
    sta WSYNC

    ; LOAD AND SET MISSILE 0 POSITION
    lda M0X
    ldx #2
    jsr PositionObject
    sta WSYNC
    
    ; TRIGGER HMOVE REGISTER
    sta HMOVE
    sta WSYNC

    ; CONTINUE VBLANK
    ldx #36

VerticalBlank:

    sta WSYNC
    dex
    bne VerticalBlank

    lda #%00000000
    sta VBLANK
    ; < END VBLANK


    include "kernel.asm"


    ; > START OVERSCAN
    lda #%00000010
    sta VBLANK
    ldx #33

Overscan:
    
    sta WSYNC
    dex
    bne Overscan
    ; < END OVERSCAN

    ; JUMP TO NEXT FRAME
    jmp StartOfFrame


    ; END OF PROGRAM
    ORG $FFFA

InterruptVectors:

    .word Reset
    .word Reset
    .word Reset

    END