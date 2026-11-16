global _start

section .bss
	input resb 4096
	output resb 4097

section .text
_start:
	mov rbp, [rsp]
	cmp rbp, 1
	jne _error2

.read:
	mov rax, 0
	mov rdi, 0
	mov rsi, input
	mov rdx, 4096
	syscall
	cmp rax, 0
	jl _error1
	je .print
	mov r9, rax
	cmp byte [input + r9 - 1], 0x0A
	jne .reverse
	sub r9, 1

.reverse:
	mov rsi, input
	mov rdi, output + 4096
	mov byte [rdi], 10	

.reverse_loop:
	cmp r9, 0
	je .print
	mov cl, [rsi]
	sub rdi, 1
	mov [rdi], cl
	add rsi, 1
	sub r9, 1
	jmp .reverse_loop

.print:
        mov rax, 1
        mov rsi, rdi
        mov rdi, 1
        mov rdx, output + 4097
        sub rdx, rsi
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
