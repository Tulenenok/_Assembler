; Примечания
; rDI - строка 1 (куда копируем), rSI - строка 2 (что копируем)
; movsb -- команда копирования из SI в DI и увеличивает/уменьшает каждый на 1 (в зависимости от флага DF)


section .text                          ; Объявили, что это секция кода (вспоминаем прошлый семестр сей: про bss, data, text...)

global strcopy

strcopy:
    mov rcx, rdx                       ; rdx -- передача третьего интеджер аргумента (то есть len)

    cmp rdi, rsi
    jl copy                            ; rdi ____ rsi -- идет простое копирование


    mov rax, rdi                       ; случай rsi ____ rdi
    sub rax, rsi                       ; получили в rax разницу между rdi и rsi

    cmp rax, rcx
    jge copy                           ; если области не перекрываются, то простое копирование

processing_overlap:                    ; если области перекрываются, то мы будем копировать с конца, чтобы не потерять информацию
    add rdi, rcx
    add rsi, rcx
    dec rsi
    dec rdi
    std                                ; Устанавливаем флаг направления DF

copy:
    rep movsb                          ; Повторяем копирование, пока rcx не обнулится (то есть мы не скопируем n байт) или пока zf != 0 
    cld                                ; Очищаем флаг направления DF

exit:
    ret
