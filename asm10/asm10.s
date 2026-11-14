global _start

section .bss
	output resb 32

section .text
_start:
	mov rbp, [rsp]
        cmp rbp, 4
        jne _error2
        lea rbx, [rsp + 16]
        mov r13, 3
        mov r12, 0x8000000000000000

.next_arg:
        mov rsi, [rbx]
        mov r8, 0
        mov rax, 0
        mov r9, 0
        mov r11, 10
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
        mul r11
        jc _error1
        add rax, rcx
        jc _error1
        add r9, 1
        add rsi, 1
        jmp .loop

.check_valid:
        cmp r9, 0
        je _error1
        mov r11, 0x7FFFFFFFFFFFFFFF
        add r11, r8
        cmp rax, r11
        ja _error1
        cmp r8, 1
        jne .compare
        neg rax

.compare:
        cmp rax, r12
        jle .next
        mov r12, rax

.next:
        add rbx, 8
        sub r13, 1
        cmp r13, 0
        jne .next_arg

        mov rax, r12
        mov r8, 0
        cmp rax, 0
        jge .prepare_print
        mov r8, 1
        neg rax

.prepare_print:
        mov rdi, output + 31
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

        cmp r8, 1
        jne .print
        sub rdi, 1
        mov byte [rdi], '-'

.print:
        mov rax, 1
        mov rsi, rdi
        mov rdi, 1
        mov rdx, output + 32
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
