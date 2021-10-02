    ldx #228
    ldy PFD0,x
    txa

Picture:
    sta WSYNC
    ; LEFT SIDE     d: 24
    ; s: 0          f: 24
    ;ldy PFD0,x      ; 5 7 
    sty PF0         ; 3 11
    ldy PFD1,x      ; 5 15
    sty PF1         ; 3 19
    ldy PFD2,x      ; 5 23
    sty PF2         ; 3 27

    ; PL0 XPOS      d: 15
    ; s: 24         f: 39
    ; MUST finish at max: 41
    sbc $81         ; 3
    bcc draw0    ; 2 (3)
    nop
    jmp enddraw0
draw0
    tay             ; 2
    lda PL0,y       ; 5
    sta GRP0        ; 3
enddraw0

    ; RIGHT SIDE    d: 24
    ; s: 39         f: 63          
    ldy PFD3,x      ; 4 31
    sty PF0         ; 4 35
    ldy PFD4,x      ; 4 39
    sty PF1         ; 4 43
    ldy PFD5,x      ; 4 47
    sty PF2         ; 4 51
    
    dex
    ldy PFD0,x
    txa
    sta WSYNC       ; WSYNC


;--------------------- 2ND SCANLINE ---------------------


    ; LEFT SIDE     d: 24
    ; s: 3          f: 27
    ;ldy PFD0,x      ; 4 7 
    sty PF0         ; 4 11
    ldy PFD1,x      ; 4 15
    sty PF1         ; 4 19
    ldy PFD2,x      ; 4 23
    sty PF2         ; 4 27

    sbc $83         ; 3
    bcc draw1    ; 2 (3)
    nop
    jmp enddraw1
draw1
    tay             ; 2
    lda PL1,y       ; 5
    sta GRP1        ; 3
enddraw1

    ; RIGHT SIDE    d: 24
    ; s:            f:           
    ldy PFD3,x      ; 4 31
    sty PF0         ; 4 35
    ldy PFD4,x      ; 4 39
    sty PF1         ; 4 43
    ldy PFD5,x      ; 4 47
    sty PF2         ; 4 51
    
    dex             ; 2 53
    ldy PFD0,x
    txa
    bne Picture      ; 3 3
