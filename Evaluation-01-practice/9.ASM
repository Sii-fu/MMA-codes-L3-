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
    ;*****
    ;****
    ;***
    ;**
    ;*
    MOV AX,@DATA
    MOV DS,AX

    MOV O, 5
    MOV I, 5

    MOV DL,VAR
    MOV AH,2
    OUTER:
        INNER:
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
            DEC O
            MOV AL, O
            MOV I, AL
            CMP O, 0
            JE END
    JMP OUTER

    END:
    
  
MAIN ENDP
END