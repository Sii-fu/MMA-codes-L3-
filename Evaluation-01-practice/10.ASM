.MODEL SMALL
.STACK 100H
.DATA
    VAR DB '*'
    O DB 0
    I DB 0
;STR_VAR DB "ENTER A LINE "
.CODE
MAIN PROC

    ; pattern printing

    MOV AX,@DATA
    MOV DS,AX

    MOV O, 1
    MOV I, 1

    MOV DL,VAR
    MOV AH,2
    OUTER:
        CMP O, 6
        JE END
        INNER:
            MOV DL, I
            ADD DL, 30H
            INT 21H
            DEC I
            CMP I, 0
            JE next
        JMP INNER
        next:
            MOV DL, 0DH
            INT 21H

            MOV DL, 0AH
            INT 21H
            MOV DL, '*'
            INC O
            MOV AL, O
            MOV I, AL
    JMP OUTER

    END:
    
  
MAIN ENDP
END