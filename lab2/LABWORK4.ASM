.MODEL SMALL
.STACK 100H
.DATA
;VAR DB 0
;STR_VAR DB "ENTER A LINE "
MSG1 DB 0AH, 0DH, " "
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV DL,'*'
    MOV CX,5

    OUTER:
        MOV DL,'#'
        INT 21H
        INNER:
            MOV DL,'&'
            INT 21H
        LOOP INNER
    LOOP OUTER
MAIN ENDP
END