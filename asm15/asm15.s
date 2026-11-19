global _start

section .bss
        input resb 4096

section .text
_start:

        mov rbp, [rsp]
        cmp rbp, 2
        jne _error2
        mov rsi, [rsp + 16]

.check_sign:
        mov r8, 0
        mov rax, 0
        mov r9, 0
        mov r11, 10
        cmp byte [rsi], '-'
        jne .loop
        mov r8, 1
        add rsi, 1

.loop:
        mov rcx, 0
        mov cl, byte [rsi]
        cmp cl, 0
        je .check_valid
        cmp cl, '0'
        jb _error1
        cmp cl, '9'
        ja _error1
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

.modulo:
        mov rdx, 0
        mov rcx, 26
        div rcx
        mov r12, rdx
        cmp r8, 1
        jne .read
        cmp r12, 0
        je .read
        mov rax, 26
        sub rax, r12
        mov r12, rax

.read:
        mov rax, 0
        mov rdi, 0
        mov rsi, input
        mov rdx, 4096
        syscall
        cmp rax, 0
        jl _error1
        je _works
        mov r13, rax
        mov rsi, input
        mov r9, rax

.shift_loop:
        cmp r9, 0
        je .write
        mov al, byte [rsi]
        cmp al, 'a'
        jb .upper_case
        cmp al, 'z'
        ja .next
        mov bl, 'a'
        jmp .rotate

.upper_case:
        cmp al, 'A'
        jb .next
        cmp al, 'Z'
        ja .next
        mov bl, 'A'

.rotate:
        sub al, bl
        add al, r12b
        cmp al, 26
        jb .keep
        sub al, 26
.keep:
        add al, bl
        mov byte [rsi], al

.next:
        add rsi, 1
        sub r9, 1
        jmp .shift_loop

.write:
        mov rax, 1
        mov rdi, 1
        mov rsi, input
        mov rdx, r13
        syscall
        cmp rax, r13
        jne _error1
        jmp .read

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
