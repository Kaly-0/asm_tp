global _start

section .bss
	input resb 66

section .text
_start:
	mov rbp, [rsp]
	mov r10, 16
	cmp rbp, 2
	je .get_number
	cmp rbp, 3
	jne _error2
	mov rsi, [rsp + 16]
        cmp byte [rsi], '-'
        jne _error2
        cmp byte [rsi + 1], 'b'
        jne _error2
        cmp byte [rsi + 2], 0
        jne _error2
        mov r10, 2
        mov rsi, [rsp + 24]
        jmp .check_sign

	
.get_number:
        mov rsi, [rsp + 16]

.check_sign:
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
        jo _error1
        add rax, rcx
        jo _error1
        add r9, 1
        add rsi, 1
        jmp .loop

.check_valid:
        cmp r9, 0
        je _error1
        cmp rax, 0
        jne .prepare_print
        mov r8, 0
	
.prepare_print:
        mov rdi, input + 71
        mov byte [rdi], 10

.to_ascii:
        sub rdi, 1
        mov rdx, 0
        div r10
        add dl, '0'
        cmp dl, '9'
        jle .keep
        add dl, 7

.keep:
        mov [rdi], dl
        cmp rax, 0
        jne .to_ascii

        cmp r8, 1
        jne .print
        sub rdi, 1
        mov byte [rdi], '-'

.print:
        mov rax, 1
        mov rsi, rdi
        mov rdi, 1
        mov rdx, input + 72
        sub rdx, rsi
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









