        .org 0
start:  ld sp, h'FFFF           ; stack at $ffff

        ld a,h'FF
        call wait

        ld a,h'88               ; init 8255 to all output except c4-c7
        out (h'03),a

        ld a,h'00
        out (h'01),A

        ld a,h'01               ; lcd clear display
        call cwrt

        ld a,h'38               ; lcd function set
        call cwrt

        ld a,h'0E               ; lcd display & cursor set
        call cwrt

        ld a,h'06               ; lcd entry mode set
        call cwrt

        ld e, h'00              ; scroll counter


; Init Ends ----------------------------------------------------------

        call titscr
        call clrscr

men1lp: call clrscr
        ld ix, menu1            ; menu1: 1) keypad 2) port menu
        call print

        call kp

        cp h'00
        jp z, documnt

        cp h'01
        jp z,kptest

        cp h'02
        jp nz,men1lp

men2lp: call clrscr
        ld ix, menu2            ; menu2: port 1) A  2) C  3) D
        call print

        call kp

        cp d'1
        jp z,porta

        cp d'2
        jp z,portc

        cp d'3
        jp z,portd

        cp d'0
        jp z, men1lp

        jp men2lp

porta:  ld c, h'00
        jp men3lp
portc:  ld c, h'02
        jp men3lp
portd:  ld c, h'03
        jp men3lp

men3lp: call clrscr
        ld ix, menu3            ; menu3: port 1) in  2) out
        call print

        call kp

        cp d'1
        jp z,prtin

        cp d'2
        jp z,prtout

        cp d'0
        jp z, men2lp

        jp men3lp



prtin:  call clrscr
        ld ix, prtinq           ; port reading program
        call print
        ld a,b'10011000         ; 8255 a input, port c4-c7 input, mode 0
        out (h'03),a
pilp:   call crlf
        in b,(c)
        bit 7,b
        call digit
        bit 6,b
        call digit
        bit 5,b
        call digit
        bit 4,b
        call digit
        ld a,' '
        call dwrt
        bit 3,b
        call digit
        bit 2,b
        call digit
        bit 1,b
        call digit
        bit 0,b
        call digit
        jp pilp
        jp men1lp

digit:  jp z, zero
        ld a,'1'
        call dwrt
        ret
zero:   ld a,'0'
        call dwrt
        ret



prtout: call clrscr
        ld ix, prtoutq          ; port writing program
        call print
        ld a,b'10001000         ; 8255 port c4-c7 input, a output, mode 0
        out (h'03),a
        call crlf
        ld b, h'00              ; init as h'00
polp:   call crlf               ; show binary string
        out (c),b
        bit 7,b
        call digit
        bit 6,b
        call digit
        bit 5,b
        call digit
        bit 4,b
        call digit
        ld a,' '
        call dwrt
        bit 3,b
        call digit
        bit 2,b
        call digit
        bit 1,b
        call digit
        bit 0,b
        call digit
polp2:  call kp                 ; wait for a number
        cp d'0                  ; escape menu
        jp z, men1lp
        cp d'8                  ; alter bits
        jp z, bit8
        cp d'7
        jp z, bit7
        cp d'6
        jp z, bit6
        cp d'5
        jp z, bit5
        cp d'4
        jp z, bit4
        cp d'3
        jp z, bit3
        cp d'2
        jp z, bit2
        cp d'1
        jp z, bit1
        jp polp2
bit1:   ld a,b
        xor h'01
        ld b,a
        jp polp
bit2:   ld a,b
        xor h'02
        ld b,a
        jp polp
bit3:   ld a,b
        xor h'04
        ld b,a
        jp polp
bit4:   ld a,b
        xor h'08
        ld b,a
        jp polp
bit5:   ld a,b
        xor h'10
        ld b,a
        jp polp
bit6:   ld a,b
        xor h'20
        ld b,a
        jp polp
bit7:   ld a,b
        xor h'40
        ld b,a
        jp polp
bit8:   ld a,b
        xor h'80
        ld b,a
        jp polp

; End of main routine   ----------------------------------------------



cwrt:   push af                 ; write control word in (a) to lcd
        out (h'01),a            ; send (a) to b0-b7
        ld a,h'01               ; send %001 to c0-c3 (c0: E, c2: RE)
        out (h'02),a
        ld a,h'00               ; send %000 to c0-c3
        out (h'02),a
        out (h'01),a
        pop af
        ret



dwrt:   push af                 ; write data word in (a) to lcd
        out (h'01),a            ; & send (a) to b0-b7
        ld a,h'05               ; send %101 to c0-c3 (c0: E, c2: RE)
        out (h'02),a
        ld a,h'04               ; send %100 to c0-c3
        out (h'02),a
        ld a,h'00
        out (h'01),a
        out (h'02),a
        pop af
        ret



write:  push af                 ; write a string
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



print:  push af                 ; write a long string
        push bc
        push ix
pagelp: call wrln
        call crlf
        call wrln
        call home
        call kp
        call clrscr
        jp pagelp
ex1b:   pop af
        pop ix
        pop bc
        pop af
        ret
wrln:   ld b,h'10
sl1b:   ld a,(IX+0)
        cp '$'                  ; $ is the end of string character
        jr z,ex1b
        call dwrt
        inc ix
        dec b
        jp z,ex2b
        jp sl1b
ex2b:   ret



kp:     push bc                 ; returns # in a
rdkp1:  in a,(h'02)
        and h'F0
        cp h'F0
        jp z,rdkp1
        cp h'a0                 ; screen out * & #
        jp z,star
        cp h'b0
        jp z,num
        srl a                   ; change nibble
        srl a
        srl a
        srl a
        push af
rdkp2:  in a,(h'02)             ; debouncing
        cp h'f0
        jp nz,rdkp2
        pop af
        pop bc
        ret
star:   ld a,e
        cp h'00
        jp z,rdkp1
        dec e
        ld a,h'08               ;delay
        call wait
        ld a,h'1C               ;screen shift left
        call cwrt
        jp rdkp1
num:    ld a,e
        cp d'24
        jp z,rdkp1
        inc e
        ld a,h'08               ;delay
        call wait
        ld a,h'18               ;screen shift right
        call cwrt
        jp rdkp1



pause:  push ix
        ld ix, pauseq           ; print needs string addr in ix
        call write
        call kp
        pop ix
        ret



kptest: call clrscr
        ld ix, kpq              ; print needs string addr in ix
        call write
kplp:   call kp
        add a,h'30              ; convert binary # to ascii
        call dwrt
        jp kplp



titscr: ld ix, title            ; print needs string addr in ix
        call write
        call pause
        ret



clrscr: push af
        ld a,h'01               ; lcd clear display
        call cwrt
        ld e,h'00
        pop af
        ret



crlf:   push af
        ld a,h'C0               ; lcd lf & cr
        call cwrt
        pop af
        ret



home:   push af
        ld a,h'80               ; lcd cursor home
        call cwrt
        pop af
        ret



documnt: push af
        call clrscr
        ld ix, docq
        call print
        call pause
        pop af
        jp men1lp



title:  .db "Z80 64k Circuit. Design & OS (c)1993 by Peter Ungsunan.            $"
kpq:    .db "Keypad test: $"
pauseq: .db "(paused)$"
menu1:  .db "Tests: 1) keypad"
        .db "0) doc 2) ports$"
menu2:  .db "Ports:   2) C   "
        .db "  1) A   3) D  $"
menu3:  .db "Direction:      "
        .db "  1) In  2) Out$"
prtinq: .db "Reading port:$"
prtoutq: .db "Toggle bits 8-1:$"
docq:   .db "This operating system is meant to provide a kernal of routines to support the IO from this computer device. "
        .db "IO is based around an 8255 PPI. The LCD uses port pins b0-b7, c0, and c2. The keypad, with an onboard EPROM "
        .db "keymap, uses c4-c7 of the PPI. The 8255 is based at control ports 00h-03h. Port A is freely available for "
        .db "any use. Left and right LCD scrolling is availiable through * and # keys - Peter Ungsunan 1993. $"
        .end

