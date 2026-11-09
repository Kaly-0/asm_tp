global _start

section .data
    msg db 0x31, 0x33, 0x33, 0x37, 0x0A


section .bss

section .text
_start:

	pop rax
	cmp rax, 2
	jne _error2
	pop rax
	pop rax
	pop rsi

    	mov rsi, 0
    	mov rsi, rax

    	cmp byte [rsi], 0x34
    	jne _error

    	cmp byte [rsi +1], 0x32
    	jne _error

    	cmp byte [rsi +2], 0
    	jne _error 
 

_success:

    	mov rax, 1
    	mov rdi, 1
    	mov rsi, msg
    	mov rdx, 5
    	syscall

    	mov rax, 60
    	mov rdi, 0
    	syscall

_error:
    	mov rax, 60
    	mov rdi, 1
    	syscall

_error2:
	mov rax, 60
	mov rdi, 2
	syscall 
