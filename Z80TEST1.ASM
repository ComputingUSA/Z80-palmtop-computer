
        .org h'00
start:  ld a,h'80
        out (h'03),a

        ld a,h'0f
        out (h'00),A

        ld a,h'00
        out (h'01),A

        ld a,h'00             ; clear port c
        out (h'02),A

        ld a,h'01             ; data to port b
        out (h'01),a

        ld a,h'01             ; 0000 0001 to port c
        out (h'02),a

        ld a,h'00             ; clear port c
        out (h'02),A

        ld a,h'38             ; data to port b
        out (h'01),a

        ld a,h'01             ; 0000 0001 to port c
        out (h'02),a

        ld a,h'00             ; clear port c
        out (h'02),A

        ld a,h'0F             ; data to port b
        out (h'01),a

        ld a,h'01             ; 0000 0001 to port c
        out (h'02),a

        ld a,h'00             ; clear port c
        out (h'02),A

        ld a,h'06             ; data to port b
        out (h'01),a

        ld a,h'01             ; 0000 0001 to port c
        out (h'02),a

        ld a,h'00             ; clear port c
        out (h'02),A

        ld a,h'04             ; 0000 0100 to port c
        out (h'02),A

        ld a,73               ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; 0000 0100 to port c
        out (h'02),A

        ld a,116              ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,32               ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,h'57             ; data to port b ("W")
        ld (h'8000),a         ;test ram
        ld a,h'58             ;("X")
        ld a,(h'8000)
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,h'6F             ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,h'72             ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,h'6b             ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,h'73             ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,h'21             ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,h'21             ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

        ld a,h'21             ; data to port b
        out (h'01),a

        ld a,h'05             ; 0000 0101 to port c
        out (h'02),a

        ld a,h'04             ; clear port c
        out (h'02),A

loop:   jp loop
        .end
