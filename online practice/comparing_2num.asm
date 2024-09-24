.model small
.stack 100h
.data
    EQUAL db 10,13,'Both numbers are equal$'
    LARGER db 10,13,'Larger number is $'
    NUM1 db 0
    NUM2 db 0 
.code
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH,01H
    INT 21H
    MOV NUM1,AL

    INT 21H
    MOV NUM2,AL

    MOV AL,NUM2

    LEA DX, LARGER
    MOV AH,09H
    INT 21H
    
    CMP AL, NUM1
    JE EQU
    JG L1

    

    L2:
    MOV AH,02H
    MOV DL,NUM2
    INT 21H
    JMP EXIT

    L1:
    MOV AH,02H
    MOV DL,NUM1
    INT 21H
    JMP EXIT

    EQU:
    LEA DX, EQUAL
    MOV AH,09H
    INT 21H
    JMP EXIT

    EXIT:
MAIN ENDP
END MAIN