.MODEL small
.stack 100h
.data
    ; Variables and arrays
    CHAR DB 0
.code 
MAIN PROC

    ; PRINTING THE INPUT CHAR IN THE NEWLINE

    MOV AX,@Data
    MOV DS,AX
    ;code here
    MOV AH, 01H
    INT 21H
    MOV CHAR,AL

    MOV AH,02
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H

    MOV DL,CHAR
    INT 21H








MAIN ENDP
END MAIN
