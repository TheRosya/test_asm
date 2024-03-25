section .data
    prompt db 'Enter two numbers (space separated): ', 0
    promptLen equ $-prompt
    result db 'Result: ', 0
    resultLen equ $-result

section .bss
    num1 resb 2
    num2 resb 2
    resultNum resb 2

section .text
    global _start

_start:
    ; Вывод приглашения к вводу
    mov eax, 1
    mov edi, 1
    mov rsi, prompt
    mov edx, promptLen
    syscall

    ; Чтение первого числа
    mov eax, 0
    mov edi, 0
    mov rsi, num1
    mov edx, 2
    syscall

    ; Чтение второго числа
    mov eax, 0
    mov edi, 0
    mov rsi, num2
    mov edx, 2
    syscall

    ; Преобразование ASCII в числа
    movzx eax, byte [num1]
    sub eax, '0'
    movzx ebx, byte [num2]
    sub ebx, '0'

    ; Умножение чисел
    imul eax, ebx
    add eax, '0' ; Преобразование результата обратно в ASCII
    mov [resultNum], al

    ; Вывод результата
    mov eax, 1
    mov edi, 1
    mov rsi, result
    mov edx, resultLen
    syscall

    mov eax, 1
    mov edi, 1
    mov rsi, resultNum
    mov edx, 1
    syscall

    ; Выход из программы
    mov eax, 60
    xor edi, edi
    syscall

