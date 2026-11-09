global _start

section .text
_start:
	cmp qword [rsp], 3
	jne _error2

	mov rsi, [rsp + 16]
	mov rax, 0
	mov rdx, 0
	cmp byte [rsi], '-' 
	jne .loop
	mov rdx, 1
	add rsi, 1

.loop:
	mov rcx, 0
	mov cl, byte [rsi]
	cmp rcx, 0
	je .finish
	sub rcx, '0' 
	imul rax, rax, 10
	add rax, rcx
	add rsi, 1
	jmp .loop
			

.finish:
	mov rbx, rax
	mov rax, 0
	mov rsi, [rsp + 24]

.loop2:
	mov rcx, 0
	mov cl, byte [rsi]
	cmp rcx, 0
	je .finish2
	sub rcx, '0'
	imul rax, rax, 10
	add rax, rcx
	add rsi, 1
	jmp .loop2


.finish2:
	add rax, rbx
	mov rdi, rax
	mov rax, 60
	syscall

	
_error1:
	mov rax, 60
	mov rdi, 1
	syscall

_error2:
	mov rax, 60
	mov rdi, 2
	syscall
