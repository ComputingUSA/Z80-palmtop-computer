        .org h'00
        ld h,h'0f
loop:   ld a,h
        out (h'fF),A
        dec h
        jp nz,loop
        halt
        .end
