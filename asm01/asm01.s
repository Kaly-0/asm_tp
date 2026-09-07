global _start

section .data

msg db "49", "51", "51", "55", 0

section .text
_start:

    mov rax, 1
    mov rdi, 0
    syscall 

    mov rax, 60
    mov rdi, 0
    syscall