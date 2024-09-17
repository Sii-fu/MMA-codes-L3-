.MODEL SMALL
.STACK 100H
.DATA
    VAR DB 0
    count DB 0
;STR_VAR DB "ENTER A LINE "
.CODE
MAIN PROC

    ;COUNT THE NUMBER OF CHARACTERS IN A INPUT STRING

    MOV AX,@DATA
    MOV DS,AX

    MOV count,0
     
    loop1:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE EXIT
        INC count
    LOOP loop1

    EXIT:
        MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H
        ADD count,30H
        MOV DL, count
        INT 21H  
    
  
MAIN ENDP
END