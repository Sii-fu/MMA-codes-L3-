.MODEL small
.stack 100h
.data
str db "enter a line $"
first db ?
last db ?


.code
MAIN PROC

    mov AX,@data
    mov ds, AX

    mov ah, 09h
    lea dx, str
    int 21h

    mov first, 0
    mov last, 0
    mov ah, 01h
    
l:
    int 21h
    cmp al, 0DH
    je e

    cmp al, 'a'
    jl update
    jge l
    update:
        cmp first, 0
        je update1
        mov last, al
        jmp l
    update1:
        mov first, al
        mov last, al
        jmp l

e:
    mov ah, 02h
    mov dl, first
    int 21h

    call newl

    mov dl, last
    int 21h


    call newl

ENDP Main

newl PROC
    mov ah, 02h
    mov dl, 0ah
    int 21h

    mov dl, 0dh
    int 21h
ret

END MAIN