.MODEL SMALL
.STACK 100H
.DATA
    VAR DB 7
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

        INNER:
            
        JMP INNER

    JMP OUTER

    END:
    
  
MAIN ENDP
END