global _start

section .data
        vowels db "aeiouAEIOU", 0

section .bss 
	output resb 32

section .text
_start:
	mov rbp, [rsp]
	cmp rbp, 2
	jne _error2
	mov rsi, [rsp + 16]
	mov r8, 0

.loop:
	mov cl, [rsi]
	cmp cl, 0
	je .prepare_print
	mov rdi, vowels

.check_vowel:
	mov dl, byte [rdi]
	cmp dl, 0
	je .next_char
	cmp cl, dl
	je .found
	add rdi, 1
	jmp .check_vowel

.found:
	add r8, 1
	
.next_char:
	add rsi, 1
	jmp .loop

.prepare_print:
        mov rax, r8
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
