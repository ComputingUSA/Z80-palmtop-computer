        .org h'00
start:  ld a,h'80
        out (h'03),a
        ld h,h'0f
loop:   ld a,h
        out (h'00),A
        dec h
        jp nz,loop
        jp start
        .end
