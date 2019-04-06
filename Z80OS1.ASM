        .org 0
start:  ld sp, h'FFFF           ; stack at $ffff

        ld a,h'80               ; init 8255 to all output
        out (h'03),a

        ld a,h'00               ; clear port a, b, &c
        out (h'00),A

        ld a,h'00
        out (h'01),A

        ld a,h'00
        out (h'02),A

        ld a,h'01               ; lcd clear display
        call cwrt

        ld a,h'38               ; lcd function set
        call cwrt

        ld a,h'0F               ; lcd display & cursor set
        call cwrt

        ld a,h'06               ; lcd entry mode set
        call cwrt

; Init Ends

        ld ix, k                ; print needs string addr in ix
        call print

        ld a, h'40              ; wait for 40 wait loops
        call wait

        ld a,h'04               ; lcd entry mode set
        call cwrt

        ld a, h'10
sl:     inc a
        call dwrt
        cp 'þ'
        jp z, loop
        push af
        ld a, h'80
        call wait
        pop af
        jp sl

loop:   jp start                ; forever

; End of main routine   ----------------------------------------------


cwrt:   push af                 ; write control word in (a) to lcd
        push af
        ld a,h'00               ; send %000 to c0-c3
        out (h'02),A
        pop af                  ; restore A
        out (h'01),a            ; & send it to b0-b7
        ld a,h'01               ; send %001 to c0-c3
        out (h'02),a
        ld a,h'00               ; send %000 to c0-c3
        out (h'02),a
        pop af
        ret

dwrt:   push af                 ; write control word in (a) to lcd
        push af
        ld a,h'04               ; send %100 to c0-c3
        out (h'02),A
        pop af                  ; restore A
        out (h'01),a            ; & send it to b0-b7
        ld a,h'05               ; send %101 to c0-c3
        out (h'02),a
        ld a,h'04               ; send %100 to c0-c3
        out (h'02),a
        pop af
        ret

print:  push af                 ; write a string
        push ix
sl1:    ld a,(IX+0)
        cp '$'                  ; $ is the end of string character
        jr z,ex1
        call dwrt
        inc ix
        jp sl1
ex1:    pop ix
        pop af
        ret

wait:   push af                 ; loop around (a) times
        push bc
        ld b, h'00
sl2:    cp b
        jp z, ex2
        inc b
        nop
        jp sl2
ex2:    pop bc
        pop af
        ret

monitr: push af
        ld ix, str1
        call print
        pop af
        call dwrt
        ret

str1:   .db "A: $"

k:      .db "Z80 64k Computer Test Run in progress.  Peter Ungsunan 7/29/93. $"
        .end
