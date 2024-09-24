.MODEL SMALL
.STACK 100H
.DATA
    O DB 0
    I DB 0
.CODE

MAIN PROC

    MOV AX,@DATA
    MOV DS,AX


    MOV O,1
    
    OUT:
        CMP O, 6
        JE EXIT
        MOV I,0
        IN:
            INC I
            MOV DL,I
            MOV AH,02
            ADD DL, '0'
            INT 21H

            MOV AL,O
            CMP I,AL
            JNE IN
        INC O

        MOV AH, 02h
        MOV DL, 0DH
        INT 21H
        MOV DL,0AH
        INT 21H

        JMP OUT

    EXIT:



MAIN ENDP
END MAIN