global _start           ; делаем метку метку _start видимой извне
 
section .bss
    buffer resb 16

; section .data   ; секция данных
; message: db "Hello METANIT.COM!",10  ; строка для вывода на консоль
 
section .text           ; объявление секции кода
_start:                 ; объявление метки _start - точки входа в программу
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 16
    syscall
    
    
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 16
    syscall

    mov rax, 60         ; 60 - номер системного вызова exit
    mov rdi, 0 
    syscall             ; выполняем системный вызов exi
