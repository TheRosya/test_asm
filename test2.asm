.model small
.stack 100h
.data
    str0 db 13,10,'$'
    str1 db 'Enter a: $'
    str2 db 'Enter b: $'
    str3 db 'Enter c: $'
    str4 db 'Enter d: $'
    str5 db 'Enter e: $'
    str6 db 'Result: y= $'
    a db ?
    b db ?
    c db ?
    d db ?
    e db ?
    result db ?

.code
start:
    mov ax,@data
    mov ds,ax

    ; Ввод чисел a, b, c, d, e
    call inputNumber
    mov a, al
    call inputNumber
    mov b, al
    call inputNumber
    mov c, al
    call inputNumber
    mov d, al
    call inputNumber
    mov e, al

    ; Вычисление y = (a+b)/c + d + e
    mov al, a
    add al, b
    div c
    add al, d
    add al, e
    mov result, al

    ; Вывод результата
    mov ah, 09h
    lea dx, str0
    int 21h
    mov ah, 09h
    lea dx, str6
    int 21h
    mov dl, result
    add dl, 13d
    mov ah, 02h
    int 21h

    ; Завершение программы
    mov ah, 4Ch
    int 21h

inputNumber proc
    mov ah, 01h
    int 21h
    sub al, 48d
    ret
inputNumber endp

end start