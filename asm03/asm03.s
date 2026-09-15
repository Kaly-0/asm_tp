global _start

section .data
    msg db 0x31, 0x33, 0x33, 0x37, 0x0A


section .bss

section .text
_start:

    pop rax
    pop rax
    pop rax

    mov rsi, rax

    cmp byte [rsi], 0x34
    jne _error

    cmp byte [rsi +1], 0x32
    jne _error

    cmp byte [rsi +2], 0x0A
    jne _error

_succes:

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 5
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

_error:
    mov rax, 60
    mov rdi, 1
    syscall 
