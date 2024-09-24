.MODEL SMALL
.STACK 100H
.DATA
    ARR DB 10 DUP(?)
    SUM DB 0
    MSG DB 10,13,'ENTER LESS THAN 10 NUMBERS(0-9): $'
.CODE

MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG
    MOV AH, 09h
    INT 21H

    LEA BX, ARR

    XOR DX,DX
    
    TAKEINP:
        MOV AH,01h
        INT 21H
        CMP AL,13
        JE OUT

        SUB AL,'0'
        ADD SUM,AL

        MOV [BX],AL
        INC BX

        MOV AH,02h
        MOV DL, '+'
        INT 21H

        JMP TAKEINP

    OUT:
    MOV AH,02h
    MOV DL, 0DH
    INT 21H
    MOV DL,0AH
    INT 21H

    ADD SUM,'0'
    MOV DL,SUM
    MOV AH,02H
    INT 21H

    


MAIN ENDP