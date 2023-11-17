%include "/Users/79276/Downloads/io64_float.inc"
%include "io64.inc"

;реализовать функцию, округляющую введенное пользователем вещественное число до ближайшего целого:
; 1) вверх

section .data
    input_number: dd 250.9
    mxcsr_value: dd 0
    int_elem: dq 0
section .text
    global main
    
main:
    mov rbp, rsp
    stmxcsr [mxcsr_value] 
    or qword[mxcsr_value], 0x00004000
    ldmxcsr [mxcsr_value]
    
    movss xmm0, [input_number]
    cvtss2si rbx, xmm0
    mov [int_elem], rbx
end:
    PRINT_DEC 8, int_elem
    finit
    xorps xmm0, xmm0
    xor rax, rax
    ret