.MODEL SMALL
.STACK 100h
.DATA
    ARR DB 10 DUP(?)
    MSG DB 10,13,'ENTER YOUR NAME: $'

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG
    MOV AH,09h
    INT 21h

    LEA BX,ARR

    TAKEINP:
        MOV AH,01h
        INT 21H
        MOV [BX],AL
        INC BX
        CMP AL,13
        JNE TAKEINP
    
    XOR BX,BX

    MOV AH,02h
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    

    LEA BX, ARR

    PRINT:
        MOV DL,[BX]
        MOV AH,02h
        INT 21H
        INC BX
        CMP AL,13
        JNE PRINT

    MOV AH,4CH
    INT 21H





MAIN ENDP
END MAIN