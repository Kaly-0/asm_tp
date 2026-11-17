global _start

section .bss 
	input resb 64

section .text
_start:
	mov rbp, [rsp]
	cmp rbp, 1
	jne _error2

.read:
        mov rdx, 4096
        sub rdx, r9
        je .strip
        mov rax, 0
        mov rdi, 0
        mov rsi, input
        add rsi, r9
        syscall
        cmp rax, 0
        jl _error2
        je .strip
        add r9, rax
        jmp .read

.strip:
        cmp r9, 0
        je .check
        cmp byte [input + r9 - 1], 10
        jne .check
        sub r9, 1

.check:
        mov rsi, input
        mov rdi, input
        add rdi, r9
        sub rdi, 1

.loop:
        cmp rsi, rdi 
        jae _works
        mov cl, [rsi]
        cmp cl, [rdi]
        jne _error1
        add rsi, 1
        sub rdi, 1
        jmp .loop

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
