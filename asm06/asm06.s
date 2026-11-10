global _start

section .text
_start:
	mov rbp, [rsp]

	cmp rbp, 3
	je .three_args
	cmp rbp, 4
	je .four_args
	jmp _error2


.four_args:
	mov rsi, [rsp + 24]
	cmp byte [rsi], '+' 
	jne _error2
	cmp byte [rsi + 1], 0
	jne _error2

	mov r8, [rsp + 32]
	jmp .next

.three_args:
	mov r8, [rsp + 24]

.next:
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
	mov rsi, r8


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
