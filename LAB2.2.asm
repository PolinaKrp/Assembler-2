%include "/Users/79276/Downloads/io64_float.inc"
%include "io64.inc"

;2) y = tg(a * x) + ctg(b * x)

section .data
    a: dd 2.0
    b: dd 2.0
    x: dd 2.0
    result: dd 0.0

section .text
    global main

main:
    fld dword[x]
    fld dword[a]
    fmul
    fsin
    fld dword[x]
    fld dword[a]
    fmul
    fcos
    fdiv
    fld dword[b]
    fld dword[x]
    fmul
    fcos
    fld dword [b]
    fld dword [x]
    fmul 
    fsin
    fdiv
    fadd
    fstp dword[result]
    PRINT_FLOAT [result]

exit:
    xor eax, eax
    ret