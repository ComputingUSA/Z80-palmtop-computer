        .org 0
start:  ld sp, h'FFFF           ; stack at $ffff

        ld a,h'80               ; init 8255 to all output
        out (h'03),a

        ld a,h'00
        out (h'01),A

        ld a,h'01               ; lcd clear display
        call cwrt

        ld a,h'38               ; lcd function set
        call cwrt

        ld a,h'0F               ; lcd display & cursor set
        call cwrt

        ld a,h'06               ; lcd entry mode set
        call cwrt

; Init Ends

        ld ix, init0            ; print needs string addr in ix
        call print

loop2:  ld a,h'8c               ; init 8255 to all output except a & c4-c7
        out (h'03),a
        in a,(h'02)
        push af
        ld a,h'80               ; init 8255 to all output
        out (h'03),a
        pop af
        and h'F0
        srl a
        srl a
        srl a
        srl a
        cp h'0f
        jp z,loop2
        
        ld a,h'01               ; lcd clear display
        call cwrt

        ld ix, init1            ; print needs string addr in ix
        call print

        ld b,h'FF
loop1:  ld a,h'8c               ; init 8255 to all output except a & c4-c7
        out (h'03),a
        in a,(h'02)
        push af
        ld a,h'80               ; init 8255 to all output
        out (h'03),a
        pop af
        and h'F0
        srl a
        srl a
        srl a
        srl a
        cp b
        jp z,loop1
        ld b,a
        cp h'0f                 ; dont print if there's no key pressed
        jp z,loop1
        cp h'0a
        jp z,star
        cp h'0b
        jp z,num
        add a,h'30
        call dwrt
        jp loop1
star:   ld a,'*'
        call dwrt
        jp loop1
num:    ld a,'#'
        call dwrt
        jp loop1

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

init0:  .db "Z80 64k Circuit. Designed & built by    Peter Ungsunan, 1993.       (paused)$"
init1:  .db "Keypad test: $"
        .end
 
