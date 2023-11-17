%include "/Users/79276/Downloads/io64_float.inc"
%include "io64.inc"

;2) y = tg(a * x) + ctg(b * x)

section .data
    a: dd 2.0
    b: dd 2.0
    x: dd 2.0
    sin1: dd 0.0
    cosin1: dd 0.0
    cosin2: dd 0.0
    sin2: dd 0.0
    result2: dd 0.0
    result1: dd 0.0
    result: dd 0.0

global main
section .text
main:
    mov rbp, rsp; for correct debugging (ok)
    movss xmm0, [a]
    mulss xmm0, [x]
    movss [sin1], xmm0 ; sin(a * x)
    fld dword[sin1] 
    fsin
    fstp dword[sin1]
    movss xmm0, [sin1]
    
    movss xmm0, [a]
    mulss xmm0, [x]
    movss xmm1 , xmm0
    movss [cosin1], xmm1 ; cos(a * x)
    fld dword[cosin1] 
    fcos
    fstp dword[cosin1]
    movss xmm1, [cosin1]
    
    ;вычисляем тангенс
    movss xmm0,[sin1]
    divss xmm0, xmm1   
    movss [result1], xmm0
    fld dword[result1]
    PRINT_FLOAT [result1] ;tg(a*x)
    NEWLINE  

    
    movss xmm0, [b]
    mulss xmm0, [x]
    movss xmm1, xmm0
    movss [cosin2], xmm1 ; cos(b * x)
    fld dword[cosin2] 
    fcos
    fstp dword[cosin2]
    movss xmm2, [cosin2]

    
    movss xmm2, [b]
    mulss xmm2, [x]
    movss [sin2], xmm2 ; sin(b * x)
    fld dword[sin2] 
    fsin
    fstp dword[sin2]
    movss xmm3, [sin2]
    
    ;вычисляем котангенс
    movss xmm2,[cosin2]
    divss xmm2, xmm3   
    movss [result2], xmm2
    fld dword[result2]
    PRINT_FLOAT [result2]  ;ctg(b*x)
    NEWLINE
    
    
    movss xmm0,[result1]
    movss xmm1,[result2]
    addss xmm0, xmm1   
    movss [result], xmm0
    fld dword[result]
    PRINT_FLOAT [result]
    NEWLINE
    jmp exit
    
exit:
    xor eax, eax
    ret