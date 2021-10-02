Reset:

    ; RESET REGISTERS
    lda #0
    ldx #0
    ldy #0

Clear:

    ; CLEAR MEMORY
    sta 0,x
    inx
    bne Clear

    ; RESET STACK POINTER TO TOP OF RAM
    ldx #$FF
    txs
    ldx #0