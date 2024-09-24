.model small
.STACK 100H
.DATA
    VAR DB 0
    SMALL DB "SMALL LETTER$"
    CAPITAL DB "CAPITAL LETTER$"

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS,AX

;CODE for identifiying the case of the character

    MOV AH, 01H
    INT 21H

    MOV VAR, AL


    mov ah, 02
    mov dl, 0AH
    int 21h

    mov dl, 0DH
    int 21h

    CMP VAR, 61H
    JL UPPER_CASE



NOT_UPPER_CASE:
    MOV AH,09H
    LEA DX,SMALL
    INT 21H
    JMP EXIT

UPPER_CASE:
    MOV AH,09H
    LEA DX,CAPITAL
    INT 21H
    JMP EXIT

EXIT:

MAIN ENDP
END MAIN

