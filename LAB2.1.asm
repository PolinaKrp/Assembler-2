%include "/Users/79276/Downloads/io64_float.inc"
%include "io64.inc"

;реализовать функцию, округляющую введенное пользователем вещественное число до ближайшего целого:
; 1) вверх

section .data
    number: dd 0.0
    input_elem: dd 10.5
    result: dq 0
    
section .text
    global main
    
main:
    mov rbp, rsp; for correct debugging
    finit
    fnstcw [number] 
    mov ax, [number]
    or ax, 0x0800 ; устанавливаем бит 11
    and ax, 0xFBFF ; сбрасываем бит 10
    mov [number], ax
    fldcw [number]
    fld dword [input_elem]
    fistp qword [result]
    PRINT_DEC 8, result
    xor rax, rax
    ret