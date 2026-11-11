global _start


section .bss
	buffer resb 32

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
	jmp .first_arg

.three_args:
	mov r8, [rsp + 24]



.first_arg:

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
	cmp cl, '0' 
	jl _error1
	cmp cl, '9' 
	jg _error1

	sub rcx, '0'
	imul rax, rax, 10
	add rax, rcx
	add rsi, 1
	jmp .loop
			

.finish:
	
	cmp rdx, 1
	jne .keep_first
	neg rax

.keep_first:
	mov rbx, rax
	mov rsi, r8
	mov rax, 0
	mov rdx, 0
	cmp byte [rsi], "-"
	jne .loop2
	mov rdx, 1
	add rsi, 1 


.loop2:
	mov rcx, 0
	mov cl, byte [rsi]
	cmp rcx, 0
	je .finish2
	cmp cl, '0' 
	jl _error1
	cmp cl, '9' 
	jg _error1
	sub rcx, '0' 
	imul rax, rax, 10
	add rax, rcx
	add rsi, 1
	jmp .loop2


.finish2:
	cmp rdx, 1
	jne .addition
	neg rax

.addition:
	add rax, rbx
	mov rdi, buffer + 31
	mov byte [rdi], 10
	mov rcx, 10
	mov r8, 0

	cmp rax, 0
	jge .to_ascii
	mov r8, 1
	neg rax

.to_ascii:
        sub rdi, 1
        mov rdx, 0
        div rcx
        add dl, '0' 
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
	mov rdx, buffer + 32
	sub rdx, rsi
	syscall


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
