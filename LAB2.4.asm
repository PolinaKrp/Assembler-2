%include "/Users/79276/Downloads/io64_float.inc"
%include "io64.inc"

; 6) y ≠cth (x*a)
; cthx=(chx)/(shx)=1/(thx)=(e^x+e^-x)/(e^x-e^-x)
; полиз e^x e^-x+e^x e^-x-/

section .data
    tmp_4_res: dd 0.0
    x: dd 2.0
 
section .rodata
    y: dd 2.0
    e: dd 2.71828

section .text
    global main

;Задание 4 - y ≠ cth (x*a)
e_x:
    fld dword[e]
    fyl2x ;вычисляем показатель
    fld1 ;загружаем +1.0 в стек
    fld st1 ;дублируем показатель в стек
    fprem ;получаем дробную часть
    f2xm1 ;возводим в дробную часть показателя
    fadd ;прибавляем 1 из стека
    fscale ;возводим в целую часть и умножаем
    fstp st1 ; выталкиваем лишнее из вершины
    ret

cth:
    fld dword[x]
    call e_x ;e^x
    fldz
    fld dword[x]
    fsubp
    call e_x ;e^-x
    fadd ; e^x + e^-x
    fld dword[x]
    call e_x ;e^x
    fldz
    fld dword[x]
    fsubp
    call e_x ;e^-x
    fsub ; e^x - e^-x
    fdiv
    fst dword[tmp_4_res]
    PRINT_FLOAT tmp_4_res
    fld dword[y]
    fcomip
    jne skip ;неравны, то есть удовлетворяет условию
    PRINT_STRING " => no"
    jmp end
skip:
    PRINT_STRING " => yes"
end:
    ret

main:
    mov rbp, rsp; for correct debugging
    NEWLINE
    PRINT_STRING "4) "
    PRINT_FLOAT y
    PRINT_STRING " and "
    call cth
    xor rax, rax
    ret