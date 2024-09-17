.MODEL SMALL
.STACK 100H
.DATA
VAR DB '*'
;STR_VAR DB "ENTER A LINE "
.CODE
MAIN PROC

    ;loop to print 100 stars

    MOV AX,@DATA
    MOV DS,AX

    MOV CX,100D
    MOV AH,02H
    MOV DL,VAR
    MOV BH,0
    L1:
        INT 21H
    LOOP L1

    
    
  
MAIN ENDP
END