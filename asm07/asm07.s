global _start

section .bss
	input resb 64

section .text
_start:

	mov rax, 0
	mov rdi, 0
	mov rsi, input
	mov rdx, 64
	syscall

	cmp rax, 0
	jle _error2
	mov rsi, input

	mov r8, 0
	cmp byte [rsi], '-' 
	jne .loop
	mov r8, 1
	add rsi, 1
	
		
.loop:
	mov rcx, 0
	mov cl, byte [rsi]
	cmp cl, 10
        je .check_if_empty
        cmp cl, 0
        je .check_if_empty

	cmp cl, '0'
	jl _error2
	cmp cl, '9'
	jg _error2

	sub rcx, '0'
        imul rax, rax, 10
        add rax, rcx
        add rsi, 1
        jmp .loop


.check_if_empty:
	cmp r9, 1
	je _error1
	
	cmp rax, 2
        jl _error1
        je _works
	mov rcx, rax
        and rcx, 1
        cmp rcx, 0
        je _error1
	mov rbx, 3

.loop_prime:
	mov rcx, rbx
        imul rcx, rbx
        cmp rcx, rax
        jg _works

        push rax
        mov rdx, 0
        div rbx
        mov rcx, rdx
        pop rax

        cmp rcx, 0
        je _error1

        add rbx, 1
        jmp .loop_prime

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
