global _start


section .bss
	input resb 32

section .text
_start:

	mov rax, 0
	mov rdi, 0
	mov rsi, input
	mov rdx, 32 
	syscall

	mov rcx, input
	mov al, byte [rcx]
	cmp al, '-'
	jne .tiret
	inc rcx

.tiret:
	mov al, byte [rcx]
	cmp al, '0'
	jl _nonumber
	cmp al, '9'
	jg _nonumber
	
	and al, 1
	cmp al, 0
	je _even
	jmp _odd

	
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

