global _start

section .data
    msg db 0x31, 0x33, 0x33, 0x37, 0x0A

section .bss
    input resb 256

_error:
    mov rax, 60
    mov rdi, 1
    syscall

section .text 
_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 256
    syscall

    cmp byte [input], 0x34
    jne _error

    cmp byte [input +1], 0x32
    jne _error

    je msg
    mov rax, 60
    mov rdi, 0
    syscall

    mov rax, 60
    mov rdi, 1
    syscall