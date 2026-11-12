global _start

section .bss
        input resb 32

section .text
_start:
	
	mov rbp, [rsp]
        cmp rbp, 2
        jne _error2
	mov rsi, [rsp + 16]
        mov r8, 0
        mov rax, 0
        mov r9, 0
	cmp byte [rsi], '-'
        jne .check_plus
        mov r8, 1
        add rsi, 1
        jmp .loop

.check_plus:
	cmp byte [rsi], '+'
        jne .loop
        add rsi, 1

.loop:
	mov rcx, 0
        mov cl, byte [rsi]
        cmp cl, 0
        je .check_valid
        cmp cl, '0'
        jl _error1
        cmp cl, '9'
        jg _error1
        sub rcx, '0'
        imul rax, rax, 10
        add rax, rcx
        add r9, 1
        add rsi, 1
        jmp .loop

.check_valid:
        cmp r9, 0
        je _error1

        cmp r8, 1
        je .sum_is_zero

        cmp rax, 1
        jle .sum_is_zero
        mov rbx, rax
        sub rbx, 1
        imul rax, rbx
        mov rdx, 0
        mov rcx, 2
        div rcx
        jmp .prepare_print

.sum_is_zero:
        mov rax, 0

.prepare_print:
        mov rdi, input + 31
        mov byte [rdi], 10
        mov rcx, 10

.to_ascii:
        sub rdi, 1
        mov rdx, 0
        div rcx
        add dl, '0'
        mov [rdi], dl
        cmp rax, 0
        jne .to_ascii

.print:
        mov rax, 1
        mov rsi, rdi
        mov rdi, 1
        mov rdx, input + 32
        sub rdx, rsi
        syscall

        mov rax, 60
        mov rdi, 0
        syscall

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
