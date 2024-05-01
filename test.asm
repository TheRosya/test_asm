model small ; задание модели памяти
.stack 100h ; размер выделенной памяти
.data ; начало блока описания переменных
    str0 db 13,10,'$' ; строка переноса
    str1 db 'Enter a: $'
    str2 db 'Enter b: $'
    str3 db 'Enter c: $'
    str4 db 'Enter e: $'
    str5 db 'Enter d: $'
    str6 db 'Result:y= $'
    str7 db 'Enter X: $'
    str8 db 'Enter Y: $'
    str10 db 'Point to the left of the line $' ; точка слева от линии
    str20 db 'Point to the right of the line $' ; точка справа от линии
    str30 db 'Point hit the circle $' ; точка попала в круг
    str40 db 'Point hit the rectangle $' ; точка попала в прямоугольник
    a db ?
    b db ?
    c db ?
    e db ?
    d db ? 
    X db ?
    Y db ?

.code
start:
    mov ax,@data ; идентификатор доступа к регистру данных ds
    mov ds,ax
    ; вывод строки "Enter a:"
    mov ah,09h ; поместить в регистр ah номер функции прерывания 21h
    lea dx,str1 ; в регистр dx помещается указатель на строку
    int 21h ; вызов прерывания 21h
    ; ввод числа a
    mov ah,01h
    int 21h
    sub al,48d ; преобразование символа в соответствующее десятичное число
    mov a, al ; перенос введенного значения в переменную a
    push ax
    mov ah,09h ;перенос строки
    lea dx,str0
    int 21h

    

    mov ah,09h ; вывод строки "Enter b:"
    lea dx,str2
    int 21h
    ; ввод числа b
    mov ah,01h
    int 21h
    sub al,48d ; преобразование символа в соответствующее число
    mov b, al ; перенос введенного значения в переменную b
    push ax
    mov ah,09h ; вывод строки "Enter c:"
    lea dx,str0
    int 21h
    mov ah,09h
    lea dx,str3
    int 21h
    mov ah,01h ; ввод числа c
    int 21h
    sub al,48d
    mov c, al;
    ; вывод строки "Enter d:"
    mov ah,09h
    lea dx,str0
    int 21h
    mov ah,09h
    lea dx,str4
    int 21h
    ; ввод числа d
    mov ah,01h
    int 21h
    sub al,48d
    ; вывод строки "Enter e:"
    mov ah,09h
    lea dx,str0
    int 21h
    mov ah,09h
    lea dx,str5
    int 21h
    ; ввод числа e
    mov ah,01h
    int 21h
    sub al,48d
    mov e, al
    ; начало блока арифметических действий
    mov al, a ; Загружаем значение a в регистр al
    add al, b ; al=al+b, т.е складываем a+b
    mov ah, 0 ; обнуление ah, регистр остатка от деления должен быть пуст
    div c ; al=al/c, т.е. (a+b)/с и результат деления записывается в al
    add al, d ; al=al+d, т.е. (a+b)/c+d
    add al, e ; al=al+e, т.е. (a+b)/c+a+e

; ---------------------------
    ; вывод строки "Result:y="
    mov ah, 09h
    lea dx, str0
    int 21h
    mov ah, 09h
    lea dx, str6
    int 21h
    mov dl, al ; перенос значения из al в dl для последующего вывода
    add dl, 13d ; преобразование числа в соответствующий десятичный символ
    ;вывод результата на экран
    mov ah, 02h
    int 21h

    call main
    
    main:
        pop ax
        mov Y, al
        pop ax
        mov X, al

        mov ah,09h
        lea dx,str0
        int 21h
        cmp X, 3 ; сравнение X и 3
        ja Hit_the_right ; если x>3, перейти на Hit_the_right (точка справа от линии)
        jb Hit_the_left ; если x<3, перейти на Hit_the_left (точка слева от линии)
        call Rectangle

    Hit_the_left:
        ; вывод строки «Point to the left of the line»
        mov ah,09h
        lea dx,str10
        int 21h
        ; переход на новую строку
        mov ah,09h
        lea dx,str0
        int 21h
        call Circle

    Hit_the_right:
        ; вывод строки «Point to the right of the line»
        mov ah,09h
        lea dx,str20
        int 21h
        ; переход на новую строку
        mov ah,09h
        lea dx,str0
        int 21h
        call Rectangle

    Rectangle:
        ; проверяем, попала ли точка в прямоугольник
        cmp X, 8
        ja exit ; если X>8 (точка не попала ни в прямоуг., ни в круг)
        cmp Y, 5
        ja Circle ; если Y>5 (точка не попала в прямоугольник)
        cmp X, 5
        jae Hit_the_rectangle ; если X>5 или X=5 (точка попала в прямоугольник)
        call Circle 

    Hit_the_rectangle:
        ; вывод строки
        ; «Point hit the rectangle»
        mov ah,09h
        lea dx,str40
        int 21h
        mov ah,09h
        lea dx,str0
        int 21h
        call Circle

    Circle: ; проверяем, попала ли точка в круг
        ; решение уравнения окружности
        xor al, al
        mov al, X ; al=X
        sub al,4 ; al=al-4=X-4
        mov dl, al
        mul dl ; al=dl^2=(X-4)^2
        mov X, al ; X=al=(X-4)^2
        mov al, Y
        sub al, 5 ; al=al-5=Y-5
        mov dl, al
        mul dl ; al=dl^2=(Y-5)^2
        add al, X ; al=al+X=(Y-5)^2+(X-4)^2
        mov Y, al ; Y=(Y-5)^2+(X-4)^2
        cmp Y, 9
        jbe Hit_the_circle ; если Y<9 или Y=9 (точка попала в круг)
        call exit

    Hit_the_circle:
        ; вывод строки «Point hit the circle»
        mov ah,09h
        lea dx,str30
        int 21h
        call exit

    exit: ; завершение программы
        mov ah,4ch
        int 21h
end start
