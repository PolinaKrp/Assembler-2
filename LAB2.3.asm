%include "/Users/79276/Downloads/io64_float.inc"
%include "io64.inc"

;2) log2(tg(x + a)) = b
;x = arctg(2^b) - a

section .rodata
    a: dd 8.9
    b: dd 7.5
    const_two: dd 2.0
    
section .data
    e: dd 0.0
    x: dd 0.0
    result: dd 0.0
    
section .text
    global main
    
main:
    mov rbp, rsp; for correct debugging
    finit ;инициализирует сопроцессор FPU
    fldz
    fld1
    fld dword [b]
    fabs ; выполняет модуль числа в стеке FPU
    fsub 
    fstp dword [e]
    fldz
    fld dword [e]
    fcomi ;выполняет сравнение значения в стеке FPU со значением 0, st0 и st1
    ja less ; 1-|b| > 0
    jbe more ; 1-|b| <= 0
    
less:
    fstp dword [e]
    fld1
    fld dword [b]
    fprem  ;находит остаток от деления числа в вершине стека на число, находящееся под ним в стеке
    f2xm1  ;вычисляет 2 в степени (x-1), где x - значение в вершине стека, st0 = (2^st0)-1
    fadd st0, st1 ;складывает значения, находящиеся в вершине и следующем за ним элементе стека, +1
    jmp output_of_the_result
more:
    fstp dword [e]
    fld1
    fld dword [b]
    fprem
    fstp dword [e] ;извлекли остаток
    fld dword [b] 
    fld dword [e] ;загружает значение переменной elem в стек FPU, st1 = b, st0 = остаток
    fsub ; вычитает значение, находящееся под вершиной стека, из значения в вершине стека, st1-st0 = целое число 
    fld1
    fscale ;умножает значение, находящееся в вершине стека, на 2 в степени, равной значению, находящемуся под ним в стеке, st0 = st0 * 2 ^ st1 - возвели в степень 
    fstp dword [result]
    finit
    fld1
    fld dword [e] ;положили остаток
    f2xm1  ;вычисляет 2 в степени (x-1), где x - значение в вершине стека, st0 = (2^st0)-1
    fadd st0, st1
    fld dword [result] ;положили 2 в степени целой части
    fmul st1 
    jmp output_of_the_result
output_of_the_result:
    fld1
    fpatan; st0 = arctg(st1/st0)
    fld dword [a]
    fsub ; st0 = arctg(2^b) - a
    fstp dword [result]
    PRINT_STRING "x = "
    PRINT_FLOAT [result]
    PRINT_STRING " + pi * k"
    frndint
    xor rax, rax
    ret