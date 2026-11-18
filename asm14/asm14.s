global _start

section .data
        msg db "Hello Universe!", 10
        msg_len equ $ - msg

section .text
_start:

        mov rbp, [rsp]
        cmp rbp, 2
        jne _error2
        mov rsi, [rsp + 16]

.open:
        mov rax, 257
        mov rdi, -100
        mov rdx, 64 + 1 + 512 
        mov r10, 0644o
        syscall
        cmp rax, 0
        jl _error1
        mov r8, rax

.write:
        mov rax, 1
        mov rdi, r8
        mov rsi, msg
        mov rdx, msg_len
        syscall
        cmp rax, msg_len
        jne _error1

.close:
        mov rax, 3
        mov rdi, r8
        syscall
        jmp _works

_works:
        mov rax, 60
        mov rdi, 0
        syscall

_error1:
        mov rax, 60
        mov rdi, 1
        syscall

_error2:
        mov rax, 60
        mov rdi, 2
        syscall
