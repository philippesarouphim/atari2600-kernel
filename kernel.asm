    ldy #228
    ldx PFD0,y
    tya

Picture:
    sta WSYNC
    ; LEFT SIDE     d: 24
    ; s: 0          f: 24
    ;ldx PFD0,y      ; 5 7 
    stx PF0         ; 3 11
    ldx PFD1,y      ; 5 15
    stx PF1         ; 3 19
    ldx PFD2,y      ; 5 23
    stx PF2         ; 3 27

    ; PL0 yPOS      d: 15
    ; s: 24         f: 39
    ; MUST finish at max: 41
    sbc PL0Y         ; 3
    bcc draw0    ; 2 (3)
    SLEEP 7
    jmp enddraw0
draw0
    tax             ; 2
    lda PL0,x       ; 5
    sta GRP0        ; 3
enddraw0

    ; RIGHT SIDE    d: 24
    ; s: 39         f: 63          
    ldx PFD3,y      ; 4 31
    stx PF0         ; 4 35
    ldx PFD4,y      ; 4 39
    stx PF1         ; 4 43
    ldx PFD5,y      ; 4 47
    stx PF2         ; 4 51

    dey
    ldx PFD0,y
    tya
    sta WSYNC       ; WSYNC


;--------------------- 2ND SCANLINE ---------------------


    ; LEFT SIDE     d: 24
    ; s: 3          f: 27
    ;ldx PFD0,y      ; 4 7 
    stx PF0         ; 4 11
    ldx PFD1,y      ; 4 15
    stx PF1         ; 4 19
    ldx PFD2,y      ; 4 23
    stx PF2         ; 4 27

    sbc PL1Y         ; 3
    bcc draw1    ; 2 (3)
    SLEEP 7
    jmp enddraw1
draw1
    tax             ; 2
    lda PL1,x       ; 5
    sta GRP1        ; 3
enddraw1

    ; RIGHT SIDE    d: 24
    ; s:            f:           
    ldx PFD3,y      ; 4 31
    stx PF0         ; 4 35
    ldx PFD4,y      ; 4 39
    stx PF1         ; 4 43
    ldx PFD5,y      ; 4 47
    stx PF2         ; 4 51
    
    dey             ; 2 53
    ldx PFD0,y
    tya
    bne Picture      ; 3 3
