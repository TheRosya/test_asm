global _start           ; делаем метку метку _start видимой извне

section .bss
    x1 resb 3
    x2 resb 3
    x3 resb 3
 
section .text           ; объявление секции кода
_start:

    ; mov rax, 1          ; 1 - номер системного вызова функции write
    ; mov rdi, 1          ; 1 - дескриптор файла стандартного вызова stdout
    ; mov rsi, message    ; адрес строки для вывод
    ; mov rdx, messageLen    
    ; syscall             ; выполняем системный вызов write

    mov rax, 0
    mov rdi, 0
    mov rsi, x1
    mov rdx, 3
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, x2
    mov rdx, 3
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, x3
    mov rdx, 3
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, x3
    mov rdx, 3
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, x2
    mov rdx, 3
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, x1
    mov rdx, 3
    syscall

    mov rax, 60         ; 60 - номер системного вызова exit
    mov rdi, 0 
    syscall             ; выполняем системный вызов exit
