global _start


section .bss
	input resb 65536

section .text
_start:

.read:
	mov rdx, 65536
	sub rdx, r9
	je .strip
	mov rax, 0
	mov rdi, 0
	mov rsi, input
	add rsi, r9
	syscall
	cmp rax, 0
        jl _nonumber
        je .strip
        add r9, rax
        jmp .read

.strip:
        cmp r9, 0
        je _nonumber
        cmp byte [input + r9 - 1], 10
        jne .sign
        sub r9, 1

.sign:
        mov rsi, input
        cmp r9, 0
        je _nonumber
        cmp byte [rsi], '-'
        jne .check_number
        add rsi, 1
        sub r9, 1
        cmp r9, 0
        je _nonumber


.check_number:
        mov al, byte [rsi]
        cmp al, '0'
        jl _nonumber
        cmp al, '9'
        jg _nonumber
        add rsi, 1
        sub r9, 1
        cmp r9, 0
        jne .check_number

.parity:
        and al, 1
        cmp al, 0
        je _even

	
_odd:
	mov rax, 60
	mov rdi, 1
	syscall

_even:

	mov rax, 60
	mov rdi, 0
	syscall

_nonumber:

	mov rax, 60
	mov rdi, 2
	syscall

