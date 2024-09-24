.MODEL SMALL
.STACK 100H
.DATA
    ARR DB 10 DUP(?)
    TMP DB 0
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
        MOV TMP, AL
        AND TMP,1

        CMP TMP,0
        JNE TAKEINP

        INC SUM
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