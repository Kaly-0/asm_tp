global _start

section .data
    msg db 0x31, 0x33, 0x33, 0x37, 0x0A

section .bss
    input resb 256 "42", 0x0A

section .text 
_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 256
    syscall

    cmp 
    
    mov rax, 60
    mov rdi, 0
    syscall